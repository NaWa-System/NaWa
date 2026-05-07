"""
indexing/index_few_shots.py — Builds the few-shot example bank.

Run this ONCE before any evaluation:
    python indexing/index_few_shots.py

What it does:
  1. Loads all training examples from Spider / NaWa
  2. Embeds each question using embedding model in set config.yaml
  3. Stores question + SQL + db_id in a ChromaDB collection

After this runs, the few_shot_retriever can query it at inference time.
This takes ~5-10 minutes depending on how many examples you index.
"""

import os
import sys
import logging

sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

from src.utils import load_config, load_spider_train, load_nawa_train
from src.embeddings import load_embedding_model
import chromadb

logging.basicConfig(level=logging.INFO, format="%(levelname)s: %(message)s")
log = logging.getLogger(__name__)

BATCH_SIZE = 256   # how many examples to embed and insert at once


def build_few_shot_bank(config: dict):
    store_path   = config.get("few_shot_store", "vector_stores/few_shot_bank")
    model_name   = config.get("embedding_model", "all-MiniLM-L6-v2")
    spider_dir   = config.get("spider_dir", "data/spider")
    nawa_dir     = config.get("nawa_dir", "data/nawa")

    os.makedirs(store_path, exist_ok=True)

    # Load training examples
    examples = []
    examples += load_spider_train(spider_dir)
    # examples += load_nawa_train(nawa_dir)

    if not examples:
        log.error("No training examples found. Download the datasets first.")
        log.error("Run: python setup/download_data.py")
        return

    log.info(f"Total training examples to index: {len(examples)}")

    # Set up ChromaDB
    client     = chromadb.PersistentClient(path=store_path)
    collection = client.get_or_create_collection(
        name="few_shot_bank",
        metadata={"hnsw:space": "cosine"}
    )

    # Clear existing data so we don't get duplicates on re-run
    existing = collection.count()
    if existing > 0:
        log.info(f"Found {existing} existing entries. Clearing and rebuilding...")
        client.delete_collection("few_shot_bank")
        collection = client.get_or_create_collection(
            name="few_shot_bank",
            metadata={"hnsw:space": "cosine"}
        )

    # Load embedding model
    log.info(f"Loading embedding model: {model_name}")
    model = load_embedding_model(config)

    # Embed and insert in batches
    total = len(examples)
    for start in range(0, total, BATCH_SIZE):
        batch = examples[start : start + BATCH_SIZE]

        questions  = [ex["question"] for ex in batch]
        embeddings = model.encode(questions, show_progress_bar=False).tolist()
        ids        = [f"ex_{start + i}" for i in range(len(batch))]
        metadatas  = [{"sql": ex["gold_sql"], "db_id": ex["db_id"], "dataset": ex.get("dataset", "")}
                      for ex in batch]

        collection.add(
            ids=ids,
            embeddings=embeddings,
            documents=questions,
            metadatas=metadatas,
        )

        log.info(f"Indexed {min(start + BATCH_SIZE, total)} / {total}")

    log.info(f"✓ Few-shot bank ready: {collection.count()} examples at {store_path}")


if __name__ == "__main__":
    config = load_config()
    build_few_shot_bank(config)