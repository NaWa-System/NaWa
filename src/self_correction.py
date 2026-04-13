"""
self_correction.py — Component 3: Self-Correction Feedback Loop.

What this does:
  After the LLM generates a SQL query, we immediately try to run it.
  If it fails (syntax error, wrong column name, empty result), we:
    1. Collect the error message from SQLite
    2. Build a new prompt: "Here is your broken SQL and the error. Fix it."
    3. Ask the LLM to generate a corrected query
    4. Try again — up to max_retries times (default: 3)

  Why this matters for SLMs:
  Small models frequently generate SQL with wrong column names or bad syntax.
  Without this loop, those failures are just wrong answers.
  With this loop, the model gets a chance to learn from the error and fix it
  — all within one query, with no model retraining needed.

  Example correction cycle (from thesis, Table 3.2):
    Attempt 1: SELECT SUM(revenue) FROM sales WHERE quarter = 'Q3 2024'
    Error:     no such column: quarter
    Attempt 2: SELECT SUM(revenue) FROM sales WHERE fiscal_quarter = 'Q3'
                 AND fiscal_year = 2024
    Result:    Executes successfully ✓
"""

import logging
from src.llm import call_llm
from src.utils import execute_sql, extract_sql

log = logging.getLogger(__name__)

CORRECTION_SYSTEM_PROMPT = """You are an expert SQL debugger.
You will be given a natural language question, a SQL query that failed,
and the error message it produced.

Your task: write a corrected SQL query that fixes the error and answers the question.

Rules:
- Output ONLY the SQL query, nothing else
- Do not explain the error, do not apologize
- The corrected query must be valid SQLite syntax
- Use only columns and tables that exist in the schema provided
"""


def generate_and_correct(
    question: str,
    schema: str,
    db_path: str,
    few_shot_prompt: str,
    config: dict,
) -> dict:
    """
    Generates a SQL query and applies self-correction if it fails.

    Returns a dict with:
      - sql:      the final SQL query (corrected or original)
      - success:  True if the query executed without error
      - result:   the result rows (or error string)
      - attempts: how many tries it took (1, 2, or 3)
    """
    model       = config["model"]
    base_url    = config["ollama_base_url"]
    max_retries = config.get("max_retries", 3)

    # ── First attempt ──────────────────────────────────────────────────────────
    prompt    = _build_generation_prompt(question, schema, few_shot_prompt)
    raw_sql   = _call_and_extract(prompt, model, base_url)
    success, result = execute_sql(db_path, raw_sql)

    if success:
        log.info(f"SQL succeeded on attempt 1")
        return {"sql": raw_sql, "success": True, "result": result, "attempts": 1}

    log.info(f"Attempt 1 failed: {result}")

    # ── Correction loop ────────────────────────────────────────────────────────
    current_sql   = raw_sql
    current_error = result

    for attempt in range(2, max_retries + 2):
        log.info(f"Correction attempt {attempt}...")

        correction_prompt = _build_correction_prompt(
            question, schema, current_sql, current_error
        )
        corrected_sql           = _call_and_extract(correction_prompt, model, base_url)
        success, result         = execute_sql(db_path, corrected_sql)

        if success:
            log.info(f"SQL succeeded on attempt {attempt}")
            return {
                "sql":      corrected_sql,
                "success":  True,
                "result":   result,
                "attempts": attempt,
            }

        log.info(f"Attempt {attempt} failed: {result}")
        current_sql   = corrected_sql
        current_error = result

        if attempt >= max_retries + 1:
            break

    # All retries exhausted
    log.warning(f"All {max_retries} retries exhausted. Returning last failed query.")
    return {
        "sql":      current_sql,
        "success":  False,
        "result":   current_error,
        "attempts": max_retries + 1,
    }


def _build_generation_prompt(question: str, schema: str, few_shot_prompt: str) -> str:
    """
    Assembles the initial SQL generation prompt.

    Structure:
      1. Database schema
      2. Few-shot examples
      3. User question
    """
    parts = [
        "/no_think",
        "=== Model Objective/Context ===",
        "You are an expert at translating questions into SQLite SQL.",
        "",
        "=== Critical rules (must follow) ===",
        "1) Use ONLY table and column names that appear in the schema below.",
        "2) Generate a SQLite SQL query that answers the question under User Question.",
        "3) Make sure to understand the User Question.",
        "4) Output ONLY the SQL query, nothing else.",
        "",
        "=== Database Schema ===",
        schema,
        "",
    ]

    if few_shot_prompt:
        parts += [
            "=== Examples ===",
            few_shot_prompt,
        ]

    parts += [
        "=== Question to Answer ===",
        f"Question: {question}",
        "",
        "=== SQL Query ===",
    ]
    return "\n".join(parts)


def _build_correction_prompt(
    question: str,
    schema: str,
    failed_sql: str,
    error_message: str,
) -> str:
    """
    Builds the correction prompt: original question + broken SQL + error.
    This is what gives the model the feedback it needs to fix its mistake.
    """
    return f"""=== Database Schema ===
{schema}

=== Question ===
{question}

=== Your Previous SQL (FAILED) ===
{failed_sql}

=== Error Message ===
{error_message}

Fix the SQL query so it runs correctly. Output ONLY the corrected SQL."""


def _call_and_extract(prompt: str, model: str, base_url: str) -> str:
    """
    Calls the LLM and extracts the SQL from the response.
    """
    response = call_llm(
        prompt=prompt,
        system=CORRECTION_SYSTEM_PROMPT,
        model=model,
        base_url=base_url,
        stream=True,
        temperature=0.0,
    )
    return extract_sql(response)