"""
indexing/index_documents.py — Builds the PDF document vector store.

Run this ONCE after adding PDF files to data/documents/:
    python indexing/index_documents.py

What it does:
  1. Reads all PDF files from data/documents/
  2. Splits each PDF into overlapping text chunks (512 tokens, 50 overlap)
  3. Embeds each chunk using all-MiniLM-L6-v2
  4. Stores in ChromaDB collection 'document_store'

At query time, the pipeline embeds the user question and retrieves
the top-k most similar chunks to use as context.
"""

import os
import sys
import re
import logging

sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

from src.utils import load_config
from src.embeddings import load_embedding_model
import chromadb
import pdfplumber

logging.basicConfig(level=logging.INFO, format="%(levelname)s: %(message)s")
log = logging.getLogger(__name__)


def read_pdf(pdf_path: str) -> str:
    """Extract all text from a PDF file."""
    text = ""
    try:
        with pdfplumber.open(pdf_path) as pdf:
            for page in pdf.pages:
                page_text = page.extract_text()
                if page_text:
                    text += page_text + "\n"
    except Exception as e:
        log.error(f"Failed to read {pdf_path}: {e}")
    return text


def chunk_text(text: str, chunk_size: int = 512, overlap: int = 50) -> list[str]:
    """
    Splits text into overlapping chunks of approximately chunk_size words.

    Why overlapping? To make sure important sentences at chunk boundaries
    are not lost — the overlap carries them into the next chunk.
    """
    words  = text.split()
    chunks = []
    start  = 0

    while start < len(words):
        end   = start + chunk_size
        chunk = " ".join(words[start:end])
        if chunk.strip():
            chunks.append(chunk)
        start += chunk_size - overlap  # move forward by (chunk_size - overlap)

    return chunks


def build_document_store(config: dict):
    store_path    = config.get("document_store", "vector_stores/document_store")
    model_name    = config.get("embedding_model", "all-MiniLM-L6-v2")
    docs_dir      = config.get("documents_dir", "data/documents")
    chunk_size    = config.get("chunk_size", 512)
    chunk_overlap = config.get("chunk_overlap", 50)

    os.makedirs(store_path, exist_ok=True)

    # Find all PDFs
    pdf_files = [f for f in os.listdir(docs_dir) if f.endswith(".pdf")]
    if not pdf_files:
        log.error(f"No PDF files found in {docs_dir}")
        return

    log.info(f"Found {len(pdf_files)} PDF(s): {pdf_files}")

    # Set up ChromaDB
    client     = chromadb.PersistentClient(path=store_path)

    # Clear and rebuild
    try:
        client.delete_collection("document_store")
    except Exception:
        pass

    collection = client.get_or_create_collection(
        name="document_store",
        metadata={"hnsw:space": "cosine"}
    )

    # Load embedding model
    log.info(f"Loading embedding model: {model_name}")
    model = load_embedding_model(config)

    chunk_id = 0
    for pdf_file in pdf_files:
        pdf_path = os.path.join(docs_dir, pdf_file)
        log.info(f"Processing: {pdf_file}")

        text   = read_pdf(pdf_path)
        chunks = chunk_text(text, chunk_size, chunk_overlap)
        log.info(f"  → {len(chunks)} chunks")

        if not chunks:
            continue

        embeddings = model.encode(chunks, show_progress_bar=False).tolist()
        ids        = [f"doc_{chunk_id + i}" for i in range(len(chunks))]
        metadatas: list[dict[str, str | int]] = [
            {"source": pdf_file, "chunk_index": i}
            for i in range(len(chunks))
        ]

        collection.add(
            ids=ids,
            embeddings=embeddings,
            documents=chunks,
            metadatas=metadatas,
        )

        chunk_id += len(chunks)

    log.info(f"✓ Document store ready: {collection.count()} chunks at {store_path}")


def query_documents(question: str, config: dict, k: int | None = None) -> list[dict]:
    """
    Retrieves the top-k most relevant document chunks for a question.
    Used by the pipeline at inference time.

    Returns list of dicts with 'text', 'source', 'score'.
    """
    store_path = config.get("document_store", "vector_stores/document_store")
    k          = k or config.get("top_k_docs", 5)

    client     = chromadb.PersistentClient(path=store_path)
    collection = client.get_or_create_collection(
        name="document_store",
        metadata={"hnsw:space": "cosine"}
    )

    if collection.count() == 0:
        log.warning("Document store is empty. Run: python indexing/index_documents.py")
        return []

    model     = load_embedding_model(config)
    embedding = model.encode(question).tolist()

    results = collection.query(
        query_embeddings=[embedding],
        n_results=min(k, collection.count()),
        include=["documents", "metadatas", "distances"]
    )

    docs = (results.get("documents") or [[]])[0]
    metas = (results.get("metadatas") or [[]])[0]
    dists = (results.get("distances") or [[]])[0]

    chunks = []
    for i in range(len(docs)):
        chunks.append({
            "text":   docs[i],
            "source": metas[i].get("source", "") if i < len(metas) else "",
            "score":  1 - dists[i] if i < len(dists) else 0,
        })

    return chunks


if __name__ == "__main__":
    config = load_config()
    build_document_store(config)