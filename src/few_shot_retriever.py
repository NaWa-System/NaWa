"""
few_shot_retriever.py — Component 2: Dynamic Few-Shot Retriever.

What this does:
  Before the LLM generates a SQL query, this component finds the 3 most
  structurally similar question→SQL pairs from the training set.

  These examples are injected into the prompt so the model can see:
    "Here is a similar question and how it was solved" × 3

  Why this helps:
  - Small models are much better at following examples than working from scratch
  - Dynamic selection (instead of fixed examples) ensures relevance every time

  The trick — "Question Masking":
  Before searching for similar examples, we strip out schema-specific terms
  (table names, column names) from the question. This forces similarity to be
  based on STRUCTURE ("how many X per Y") rather than vocabulary ("how many
  employees per department"). This makes retrieved examples useful even for
  questions on totally different databases.
"""

import re
import logging
import chromadb
from src.embeddings import load_embedding_model

log = logging.getLogger(__name__)


def mask_question(question: str, schema: str) -> str:
    """
    Replaces schema-specific terms (table names, column names) in the question
    with generic placeholders.

    Example:
      Input:  "How many employees work in the Sales department?"
      Schema: CREATE TABLE employees (...), CREATE TABLE departments (...)
      Output: "How many [entity] work in the [value] [entity]?"

    This makes the similarity search match on query STRUCTURE,
    not surface vocabulary.
    """
    masked = question

    # Extract table and column names from the schema
    table_names  = re.findall(r"CREATE TABLE\s+[`\"]?(\w+)[`\"]?", schema, re.IGNORECASE)
    column_names = re.findall(r"\n\s+[`\"]?(\w+)[`\"]?\s+\w+", schema)

    terms = sorted(set(table_names + column_names), key=len, reverse=True)

    for term in terms:
        if len(term) < 3:
            continue
        pattern = re.compile(r'\b' + re.escape(term) + r'\b', re.IGNORECASE)
        masked = pattern.sub("[entity]", masked)

    return masked


def retrieve(
    question: str,
    schema: str,
    config: dict,
    store_path: str = None,
) -> list[dict]:
    """
    Retrieves the k most similar question→SQL examples from the few-shot bank.

    Returns a list of dicts, each with:
      - question: the similar training question
      - sql:      its correct SQL query
      - db_id:    database it came from

    These are injected into the generation prompt as examples.
    """
    k          = config.get("k_few_shot", 3)
    store_path = store_path or config.get("few_shot_store", "vector_stores/few_shot_bank")

    # Connect to ChromaDB
    client     = chromadb.PersistentClient(path=store_path)
    collection = client.get_or_create_collection(
        name="few_shot_bank",
        metadata={"hnsw:space": "cosine"}
    )

    if collection.count() == 0:
        log.warning("Few-shot bank is empty. Run: python indexing/index_few_shots.py")
        return []

    # Mask the question before embedding
    masked_question = question #mask_question(question, schema)

    # Embed and search
    model = load_embedding_model(config)
    embedding = model.encode(masked_question, show_progress_bar=False).tolist()

    results = collection.query(
        query_embeddings=[embedding],
        n_results=min(k, collection.count()),
        include=["documents", "metadatas", "distances"]
    )

    examples = []
    for i in range(len(results["documents"][0])):
        examples.append({
            "question": results["documents"][0][i],
            "sql":      results["metadatas"][0][i].get("sql", ""),
            "db_id":    results["metadatas"][0][i].get("db_id", ""),
            "score":    1 - results["distances"][0][i],  # convert distance to similarity
        })

    log.info(f"Retrieved {len(examples)} few-shot examples (top score: {examples[0]['score']:.3f})")
    return examples

def retrieve_routes(
    question: str,
    config: dict,
    store_path: str = None,
) -> list[dict]:
    """
    Retrieves the k most similar question→SQL examples from the few-shot bank.

    Returns a list of dicts, each with:
      - question: the similar training question
      - sql:      its correct SQL query
      - db_id:    database it came from

    These are injected into the generation prompt as examples.
    """
    k          = config.get("k_few_shot", 3)
    store_path = store_path or config.get("few_shot_routes_store", "vector_stores/few_shot_routes_bank")

    # Connect to ChromaDB
    client     = chromadb.PersistentClient(path=store_path)
    collection = client.get_or_create_collection(
        name="few_shot_routes_bank",
        metadata={"hnsw:space": "cosine"}
    )

    if collection.count() == 0:
        log.warning("Few-shot routes bank is empty. Run: python indexing/index_few_shots.py")
        return []

    # Mask the question before embedding
    masked_question = question #mask_question(question, schema)

    # Embed and search
    model = load_embedding_model(config)
    embedding = model.encode(masked_question, show_progress_bar=False).tolist()

    results = collection.query(
        query_embeddings=[embedding],
        n_results=min(k, collection.count()),
        include=["documents", "metadatas", "distances"]
    )

    examples = []
    for i in range(len(results["documents"][0])):
        examples.append({
            "question": results["documents"][0][i],
            "route":      results["metadatas"][0][i].get("route", ""),
            "db_id":    results["metadatas"][0][i].get("db_id", ""),
            "score":    1 - results["distances"][0][i],  # convert distance to similarity
        })

    log.info(f"Retrieved {len(examples)} few-shot routes (top score: {examples[0]['score']:.3f})")
    return examples


def format_examples_for_prompt(examples: list[dict]) -> str:
    """
    Formats retrieved examples into the string that goes into the LLM prompt.

    Output looks like:
        Example 1:
        Question: How many students are enrolled in each department?
        SQL: SELECT department, COUNT(*) FROM students GROUP BY department

        Example 2:
        ...
    """
    if not examples:
        return ""

    lines = []
    for i, ex in enumerate(examples, 1):
        lines.append(f"Example {i}:")
        lines.append(f"Question: {ex['question']}")
        lines.append(f"SQL: {ex['sql']}")
        lines.append("")
    # print(f"Formatted few-shot prompt:\n{lines}")
    return "\n".join(lines)

def format_routes_for_prompt(examples: list[dict]) -> str:
    """
    Formats retrieved examples into the string that goes into the LLM prompt.

    Output looks like:
        Example 1:
        Question: How many students are enrolled in each department?
        Route: SQL

        Example 2:
        ...
    """
    if not examples:
        return ""

    lines = []
    for i, ex in enumerate(examples, 1):
        lines.append(f"Example {i}:")
        lines.append(f"Question: {ex['question']}")
        lines.append(f"Route: {ex['route']}")
        lines.append("")
    return "\n".join(lines)