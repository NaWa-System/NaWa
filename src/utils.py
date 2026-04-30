"""
utils.py — Core utilities used by every other module.

What this file does:
  - Loads database schemas as CREATE TABLE strings (for the LLM prompt)
  - Executes SQL queries against SQLite databases safely
  - Loads Spider dev questions into a standard dict format
  - Loads YAML config
"""

import os
import json
import sqlite3
import yaml
import random
import logging
from pathlib import Path
from typing import Any, Optional

logging.basicConfig(level=logging.INFO, format="%(levelname)s: %(message)s")
log = logging.getLogger(__name__)


# ─────────────────────────────────────────────
# Config
# ─────────────────────────────────────────────

def load_config(path: str = "configs/config.yaml") -> dict:
    with open(path, "r") as f:
        return yaml.safe_load(f)


# ─────────────────────────────────────────────
# Schema loading
# ─────────────────────────────────────────────

def load_schema(db_path: str) -> str:
    """
    Opens the SQLite database and returns all CREATE TABLE statements
    as a single string. This string goes directly into the LLM prompt
    so the model knows the database structure before generating SQL.
    """
    try:
        conn = sqlite3.connect(db_path)
        cursor = conn.cursor()
        cursor.execute("SELECT sql FROM sqlite_master WHERE type='table' AND sql IS NOT NULL")
        rows = cursor.fetchall()
        conn.close()
        schema = "\n\n".join(row[0] for row in rows if row[0])
        return schema
    except Exception as e:
        log.error(f"Failed to load schema from {db_path}: {e}")
        return ""


def load_schema_filtered(db_path: str, question: str) -> str:
    """
    Same as load_schema, but only includes tables whose names appear
    as keywords in the question. This shortens the prompt for the SLM.
    Falls back to full schema if no tables match.
    """
    full_schema = load_schema(db_path)
    if not full_schema:
        return ""

    try:
        conn = sqlite3.connect(db_path)
        cursor = conn.cursor()
        cursor.execute("SELECT name FROM sqlite_master WHERE type='table'")
        all_tables = [row[0].lower() for row in cursor.fetchall()]
        conn.close()
    except Exception:
        return full_schema

    question_lower = question.lower()
    matched = [t for t in all_tables if t in question_lower]

    if not matched:
        return full_schema  # fall back to full schema

    # Return only CREATE TABLE blocks for matched tables
    blocks = []
    for block in full_schema.split("\n\n"):
        for table in matched:
            if f"CREATE TABLE {table}" in block.lower():
                blocks.append(block)
                break

    return "\n\n".join(blocks) if blocks else full_schema


# ─────────────────────────────────────────────
# SQL execution
# ─────────────────────────────────────────────

def execute_sql(db_path: str, query: str, timeout: int = 10) -> tuple[bool, Any]:
    """
    Executes a SQL query against a SQLite database.

    Returns:
        (True, result_rows)   — if query ran successfully
        (False, error_string) — if query failed

    result_rows is a list of tuples, e.g. [(42,), ('Alice',)]
    """
    try:
        conn = sqlite3.connect(db_path, timeout=timeout)
        conn.row_factory = sqlite3.Row
        cursor = conn.cursor()
        cursor.execute(query)
        rows = cursor.fetchall()
        conn.close()
        # Convert Row objects to plain tuples for easy comparison
        result = [tuple(row) for row in rows]
        return True, result
    except sqlite3.Error as e:
        return False, str(e)
    except Exception as e:
        return False, f"Unexpected error: {e}"


# ─────────────────────────────────────────────
# Spider dataset loader
# ─────────────────────────────────────────────

def load_spider_dev(spider_dir: str, sample_size: Optional[int] = None, seed: int = 42) -> list[dict]:
    """
    Loads Spider development questions.

    Each returned dict has:
      - question: natural language question
      - db_id:    database name (maps to a SQLite file)
      - gold_sql: the correct SQL query
      - db_path:  full path to the SQLite file
      - difficulty: easy / medium / hard / extra
    """
    dev_path = os.path.join(spider_dir, "dev.json")
    db_base  = os.path.join(spider_dir, "database")

    if not os.path.exists(dev_path):
        log.error(f"Spider dev.json not found at {dev_path}. Run setup/download_data.py first.")
        return []

    with open(dev_path, "r") as f:
        data = json.load(f)

    examples = []
    for item in data:
        db_path = os.path.join(db_base, item["db_id"], f"{item['db_id']}.sqlite")
        if not os.path.exists(db_path):
            continue
        examples.append({
            "question":   item["question"],
            "db_id":      item["db_id"],
            "gold_sql":   item["query"],
            "db_path":    db_path,
            "difficulty": item.get("query_complexity", "unknown"),
            "dataset":    "spider",
            "route":      "SQL",
            "relevant_documents": [],
        })

    if sample_size and sample_size < len(examples):
        random.seed(seed)
        examples = random.sample(examples, sample_size)

    log.info(f"Loaded {len(examples)} Spider dev examples")
    return examples


def load_spider_train(spider_dir: str) -> list[dict]:
    """
    Loads Spider training examples (used to build the few-shot bank).
    """
    train_path = os.path.join(spider_dir, "train_spider.json")
    db_base    = os.path.join(spider_dir, "database")

    if not os.path.exists(train_path):
        log.error(f"Spider train_spider.json not found at {train_path}")
        return []

    with open(train_path, "r") as f:
        data = json.load(f)

    examples = []
    for item in data:
        db_path = os.path.join(db_base, item["db_id"], f"{item['db_id']}.sqlite")
        examples.append({
            "question": item["question"],
            "db_id":    item["db_id"],
            "gold_sql": item["query"],
            "db_path":  db_path,
            "dataset":  "spider",
        })

    log.info(f"Loaded {len(examples)} Spider train examples")
    return examples

# ─────────────────────────────────────────────
# NAWA dataset loader
# ─────────────────────────────────────────────
def load_nawa_dev(nawa_dir: str, sample_size: Optional[int] = None, seed: int = 42) -> list[dict]:
    """
    Loads NAWA development questions.

    Same format as Spider examples.
    """
    dev_path = os.path.join(nawa_dir, "dev.json")
    db_base  = os.path.join(nawa_dir, "databases")

    if not os.path.exists(dev_path):
        log.error(f"NAWA dev.json not found at {dev_path}.")
        return []

    with open(dev_path, "r") as f:
        data = json.load(f)

    examples = []
    for item in data:
        gold_route = item.get("route", "SQL")
        db_id      = item.get("db_id")
        db_path    = None

        if db_id:
            candidate_db_path = os.path.join(db_base, db_id, f"{db_id}.db")
            if os.path.exists(candidate_db_path):
                db_path = candidate_db_path

        # SQL and HYBRID need a valid database path and gold SQL.
        if gold_route in ("SQL", "HYBRID") and (not db_path or "query" not in item):
            continue

        examples.append({
            "question":            item["question"],
            "db_id":               db_id,
            "gold_sql":            item.get("query"),
            "db_path":             db_path,
            "dataset":             "nawa",
            "route":               gold_route,
            "relevant_documents":  item.get("relevant_documents", []),
        })

    if sample_size and sample_size < len(examples):
        random.seed(seed)
        examples = random.sample(examples, sample_size)

    log.info(f"Loaded {len(examples)} NAWA dev examples")
    return examples

def load_nawa_train(nawa_dir: str) -> list[dict]:
    """
    Loads NAWA training examples (used to build the few-shot bank).
    """
    train_path = os.path.join(nawa_dir, "train.json")
    db_base    = os.path.join(nawa_dir, "databases")

    if not os.path.exists(train_path):
        log.error(f"NAWA train.json not found at {train_path}")
        return []

    with open(train_path, "r") as f:
        data = json.load(f)

    examples = []
    for item in data:
        try:
            db_id   = item["db_id"]
        except KeyError:
            log.warning(f"Skipping item without 'db_id': {item}")
            continue
        db_path = os.path.join(db_base, db_id, f"{db_id}.db")
        examples.append({
            "question": item["question"],
            "db_id":    item["db_id"],
            "gold_sql": item["query"],
            "db_path":  db_path,
            "dataset":  "nawa",
        })

    log.info(f"Loaded {len(examples)} NAWA train examples")
    print(f"NAWA train db_ids: {set(ex['db_id'] for ex in examples)}")
    return examples

# ─────────────────────────────────────────────
# SQL string extraction helper
# ─────────────────────────────────────────────

def extract_sql(text: str) -> str:
    """
    Pulls the first SQL query out of a free-text LLM response.

    The LLM might say:
        "Here is the SQL query:\n```sql\nSELECT ...\n```"
    or just:
        "SELECT * FROM table WHERE ..."

    This function always returns a clean SQL string.
    """
    import re

    # Try to extract from ```sql ... ``` code block
    match = re.search(r"```(?:sql)?\s*(SELECT.*?)```", text, re.DOTALL | re.IGNORECASE)
    if match:
        return match.group(1).strip()

    # Try to find SELECT statement directly
    match = re.search(r"(SELECT\s.+?)(?:;|\Z)", text, re.DOTALL | re.IGNORECASE)
    if match:
        return match.group(1).strip().rstrip(";")

    # Return the raw text as last resort
    return text.strip()