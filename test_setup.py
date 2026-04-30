"""
test_setup.py — Quick sanity checks before running the full evaluation.

Run this first to catch any issues:
    python test_setup.py

Tests:
  1. Ollama is running and models are available
  2. Config loads correctly
  3. SQL executor works on a simple in-memory database
  4. Embedding model loads
  5. ChromaDB can be created and queried
  6. Document PDF can be read
  7. Router gives sensible labels on 3 test questions
  8. Document store retrieval works (if indexed)
"""

import sys
import os
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

OK   = "✓"
FAIL = "✗"
SKIP = "○"


def test_config():
    from src.utils import load_config
    config = load_config()
    assert "model" in config
    assert "k_few_shot" in config
    print(f"  {OK} Config loaded — model={config['model']}, k={config['k_few_shot']}")
    return config

def test_sql_executor():
    from src.utils import execute_sql
    import sqlite3
    import tempfile
    import os

    fd, tmp = tempfile.mkstemp(suffix=".sqlite")
    os.close(fd) 

    try:
        conn = sqlite3.connect(tmp)
        cursor = conn.cursor()
        cursor.execute("CREATE TABLE employees (id INTEGER, name TEXT, dept TEXT, salary REAL)")
        cursor.execute("INSERT INTO employees VALUES (1, 'Alice', 'Sales', 60000)")
        cursor.execute("INSERT INTO employees VALUES (2, 'Bob', 'Sales', 55000)")
        cursor.execute("INSERT INTO employees VALUES (3, 'Carol', 'Engineering', 80000)")
        conn.commit()
        conn.close()

        ok, result = execute_sql(tmp, "SELECT COUNT(*) FROM employees WHERE dept = 'Sales'")
        assert ok
        assert result == [(2,)]
        print(f"  {OK} SQL executor works — got {result}")

        ok, err = execute_sql(tmp, "SELECT * FROM nonexistent_table")
        assert not ok
        print(f"  {OK} SQL executor catches errors correctly — {err[:40]}...")

    finally:
        try:
            if os.path.exists(tmp):
                os.remove(tmp)
        except PermissionError:
            pass
    
    return tmp

def test_schema_loader():
    from src.utils import load_schema
    import sqlite3, tempfile, os

    tmp = tempfile.mktemp(suffix=".sqlite")
    conn = sqlite3.connect(tmp)
    conn.execute("CREATE TABLE products (id INTEGER PRIMARY KEY, name TEXT, price REAL)")
    conn.commit()
    conn.close()

    schema = load_schema(tmp)
    assert "products" in schema.lower()
    assert "price" in schema.lower()
    print(f"  {OK} Schema loader works — found: {schema[:60]}...")
    os.remove(tmp)

def test_embedding_model(config):
    from sentence_transformers import SentenceTransformer
    model = SentenceTransformer(config["embedding_model"])
    vec = model.encode("How many employees work in Sales?")
    assert len(vec) == 384, f"Expected 384 dims, got {len(vec)}"
    print(f"  {OK} Embedding model loaded — vector dim={len(vec)}")

def test_chromadb():
    import chromadb, tempfile, shutil, os
    tmp_dir = tempfile.mkdtemp()
    try:
        client = chromadb.PersistentClient(path=tmp_dir)
        collection = client.create_collection("test")
        collection.add(ids=["1"], embeddings=[[0.1]*384], documents=["test document"])
        result = collection.query(query_embeddings=[[0.1]*384], n_results=1)
        assert result["documents"][0][0] == "test document"
        print(f"  {OK} ChromaDB works — stored and retrieved 1 document")
    finally:
        try:
            shutil.rmtree(tmp_dir)
        except PermissionError:
            pass

def test_pdf_readable():
    import pdfplumber
    pdf_path = "data/documents/acme_q3_2024_report.pdf"
    if not os.path.exists(pdf_path):
        print(f"  {SKIP} Test PDF not found at {pdf_path} (create it with indexing/index_documents.py)")
        return
    with pdfplumber.open(pdf_path) as pdf:
        text = pdf.pages[0].extract_text()
    assert text and len(text) > 50
    print(f"  {OK} PDF readable — first 80 chars: {text[:80]}")

def test_ollama(config):
    from src.llm import check_ollama, list_models
    if not check_ollama(config["ollama_base_url"]):
        print(f"  {FAIL} Ollama not running! Start it with:  ollama serve")
        return False
    models = list_models(config["ollama_base_url"])
    print(f"  {OK} Ollama running — available models: {models}")

    if config["model"] not in " ".join(models):
        print(f"  {FAIL} Model '{config['model']}' not pulled. Run:  ollama pull {config['model']}")
        return False
    print(f"  {OK} Model '{config['model']}' is available")
    return True

def test_router(config):
    from src.router import route, ROUTE_SQL, ROUTE_VECTOR, ROUTE_HYBRID

    test_cases = [
        ("How many employees work in the Sales department?",        ROUTE_SQL),
        ("Why did sales decline in Q3?",                            ROUTE_VECTOR),
        ("What was the total revenue in Q3 and why did it change?", ROUTE_HYBRID),
    ]

    for question, expected in test_cases:
        result = route(question, config)
        icon   = OK if result == expected else f"≈ (got {result}, expected {expected})"
        print(f"  {icon}  '{question[:55]}...' → {result}")

def test_few_shot_bank(config):
    import chromadb
    store_path = config.get("few_shot_store", "vector_stores/few_shot_bank")
    if not os.path.exists(store_path):
        print(f"  {SKIP} Few-shot bank not built yet. Run: python indexing/index_few_shots.py")
        return
    client     = chromadb.PersistentClient(path=store_path)
    collection = client.get_collection("few_shot_bank")
    count      = collection.count()
    print(f"  {OK} Few-shot bank exists — {count} examples indexed")

def test_document_store(config):
    import chromadb
    store_path = config.get("document_store", "vector_stores/document_store")
    if not os.path.exists(store_path):
        print(f"  {SKIP} Document store not built yet. Run: python indexing/index_documents.py")
        return
    client     = chromadb.PersistentClient(path=store_path)
    try:
        collection = client.get_collection("document_store")
        print(f"  {OK} Document store exists — {collection.count()} chunks indexed")
    except Exception:
        print(f"  {SKIP} Document store collection not found. Run: python indexing/index_documents.py")
        
# ─────────────────────────────────────────────
# Run all tests
# ─────────────────────────────────────────────

if __name__ == "__main__":
    print("\n=== Agentic Hybrid RAG — Setup Test ===\n")

    print("1. Config")
    config = test_config()

    print("\n2. SQL utilities")
    test_sql_executor()
    test_schema_loader()

    print("\n3. Embedding model")
    test_embedding_model(config)

    print("\n4. ChromaDB")
    test_chromadb()

    print("\n5. Test PDF")
    test_pdf_readable()

    print("\n6. Ollama + model (requires Ollama running)")
    ollama_ok = test_ollama(config)

    if ollama_ok:
        print("\n7. Router (requires Ollama)")
        test_router(config)

    print("\n8. Vector stores (optional — built separately)")
    test_few_shot_bank(config)
    test_document_store(config)

    print("\n=== Done ===\n")
    print("If all tests pass (or are marked ○ for optional), you're ready to run:")
    print("  python evaluation/run_eval.py --mode baseline --dataset spider --sample 5\n")