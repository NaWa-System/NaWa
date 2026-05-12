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
from pathlib import Path
from src.llm import call_copilot, call_llm
from src.utils import execute_sql, extract_sql, replace_equals_with_like
from src.prompts import CORRECTION_SYSTEM_PROMPT

log = logging.getLogger(__name__)

def generate_sql_gpt4(
    question: str,
    schema: str,
    db_path: str,
    few_shot_prompt: str = '',
    model: str = "gpt-4.1",
) -> dict:
    """
    Generates a SQL query using GPT-4.

    Returns a dict with:
      - sql:      the final SQL query
      - success:  True if the query executed without error
      - result:   the result rows (or error string)
    """
    company_name = _extract_company_name(db_path)

    prompt    = _build_generation_prompt(question, schema, few_shot_prompt, company_name=company_name)
    raw_sql   = _call_and_extract_gpt4(prompt, model)
    success, result = execute_sql(db_path, raw_sql)

    return {"sql": raw_sql, "success": success, "result": result, "attempts": 1}
    

def generate_and_correct(
    route_label : str,
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
    company_name = _extract_company_name(db_path)

    # ── First attempt ──────────────────────────────────────────────────────────
    prompt    = _build_generation_prompt(question, schema, few_shot_prompt, company_name, route_label)
    raw_sql   = _call_and_extract(prompt, model, base_url)
    refined_sql = replace_equals_with_like(raw_sql)
    success, result = execute_sql(db_path, raw_sql)

    if success:
        log.info(f"SQL succeeded on attempt 1")
        return {"sql": refined_sql, "success": True, "result": result, "attempts": 1}

    log.info(f"Attempt 1 failed: {result}")

    # ── Correction loop ────────────────────────────────────────────────────────
    current_sql   = refined_sql
    current_error = result

    for attempt in range(2, max_retries + 2):
        log.info(f"Correction attempt {attempt}...")

        correction_prompt = _build_correction_prompt(
            question, schema, current_sql, current_error, company_name=company_name
        )
        corrected_sql           = _call_and_extract(correction_prompt, model, base_url, system_prompt=CORRECTION_SYSTEM_PROMPT)
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


def _extract_company_name(db_path: str) -> str:
    """
    Derive company/database context from the DB path.

    NAWA paths usually look like: .../databases/<company>/<company>.db
    Spider paths usually look like: .../database/<db_id>/<db_id>.sqlite
    """
    if not db_path:
        return ""

    p = Path(db_path)
    if p.parent and p.parent.name:
        return p.parent.name
    return p.stem


def _build_company_context(company_name: str) -> list[str]:
    if company_name and ("/" in company_name or "\\" in company_name):
        company_name = _extract_company_name(company_name)

    if not company_name:
        return []

    return [
        "=== Company Context ===",
        f"Question context/company: {company_name}",
        (
            "Important: this company name is contextual metadata for the question source. "
            "Do NOT automatically add a WHERE filter on company name just because it appears in the question."
        ),
        (
            "Only apply a company-name filter if the user explicitly asks to restrict results to a company "
            "and the schema has a matching column/table for that filter."
        ),
        "",
    ]


def _build_generation_prompt(
    question: str,
    schema: str,
    few_shot_prompt: str,
    company_name: str = "",
    route_label :str = ""
) -> str:
    """
    Assembles the initial SQL generation prompt.

    Structure:
      1. Database schema
      2. Few-shot examples
      3. User question
    """
    parts = [
        "=== Model Objective/Context ===",
        "You are an expert at translating questions into SQLite SQL.",
        "",
        "=== Critical rules (must follow) ===",
        "1) Use ONLY table and column names that appear in the schema below.",
        "2) Generate a SQLite SQL query that answers the question under User Question.",
        "3) Make sure to understand the User Question.",
        "4) Output ONLY the SQL query, nothing else.",
        "5) Give meaningful column aliases, so that the output is easy to understand.",
    ]
    
    if route_label.strip() == "HYBRID":
            parts += ["6) The question is a HYBRID question:",
                    'SQL - The question asks for structured data that lives in a database: counts, totals, filtering records, rankings, averages, finding specific entries, listing items.ANY question that can be answered by querying a table belongs here.Examples: "How many X", "Which X has the highest Y", "List all X where Y","What is the total X", "Find the X with Y", "How old is X", "What is the name of X"',
                    'VECTOR - ONLY use this when the question EXPLICITLY asks for explanations, reasons, summaries or context from written documents or reports. Examples:  "According to the report...", "What does the policy say about...","Summarize the document about...", "What is the reason described in..."',
                    'HYBRID - ONLY use this when the question EXPLICITLY needs BOTH a database query AND a document explanation in the same answer. Example: "What were Q3 sales numbers AND why did they change according to the report?"'
    ]
        
    parts += ["",
        "=== Database Schema ===",
        schema,
        "",]

    parts += _build_company_context(company_name)

    if few_shot_prompt and few_shot_prompt.strip() != "":
        parts += [
            "=== Few-Shot Examples ===",
            "Study these examples carefully. Each shows a question and the correct SQL - notice that the SQL answers ONLY the database/numeric part of the question and does NOT import filters or conditions that belong to the vector/document part.",
            few_shot_prompt,
        ]

    parts += [
        "=== Question to Answer ===",
        f"Question: {question}",
        "",
        "SQL:",
    ]
    print("\n".join(parts))
    return "\n".join(parts)


def _build_correction_prompt(
    question: str,
    schema: str,
    failed_sql: str,
    error_message: str,
    company_name: str = "",
) -> str:
    """
    Builds the correction prompt: original question + broken SQL + error.
    This is what gives the model the feedback it needs to fix its mistake.
    """
    company_context = ""
    if company_name:
        company_context = (
            "=== Company Context ===\n"
            f"Question context/company: {company_name}\n"
            "Important: this may be metadata context and is not always a SQL filter.\n"
            "Only use company-name filtering when explicitly requested and supported by schema.\n\n"
        )

    return f"""=== Database Schema ===
{schema}

{company_context}

=== Question ===
{question}

=== Your Previous SQL (FAILED) ===
{failed_sql}

=== Error Message ===
{error_message}

Fix the SQL query so it runs correctly. Output ONLY the corrected SQL."""


def _call_and_extract(prompt: str, model: str, base_url: str, system_prompt: str = "") -> str:
    """
    Calls the LLM and extracts the SQL from the response.
    """

    response = call_llm(
        prompt=prompt,
        system=system_prompt,
        model=model,
        base_url=base_url,
        stream=True,
        temperature=0.0,
    )
    return extract_sql(response)

def _call_and_extract_gpt4(prompt: str, model: str, system_prompt: str = "") -> str:
    """
    Calls the GPT-4 model and extracts the SQL from the response.
    """
    response = call_copilot(
        prompt=prompt,
        model=model
    )
    return extract_sql(response)