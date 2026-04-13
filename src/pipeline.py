"""
pipeline.py — Main pipeline that wires all components together.

What this does:
  Takes a question + database path and returns a final answer
  by routing through the 3 agentic components in order:

    1. Router  → decide SQL / VECTOR / HYBRID
    2. Retriever → get few-shot examples (SQL path) or doc chunks (VECTOR path)
    3. Generator + Self-Correction → generate SQL, execute, fix if needed

  Also supports a "baseline" mode that skips all agentic features
  (no few-shot, no correction) for the comparison experiment.
"""

import logging
from src.few_shot_retriever import retrieve, format_examples_for_prompt
from src.self_correction import generate_and_correct
from src.utils import load_schema, extract_sql

log = logging.getLogger(__name__)


def run(question: str, db_path: str, config: dict, mode: str = "agentic", dataset: str = "spider") -> dict:
    """
    Runs the full pipeline for one question.

    Args:
        question: natural language question
        db_path:  path to the SQLite database for this question
        config:   loaded config dict
        mode:     "agentic"  → full pipeline (router + few-shot + self-correction)
                  "baseline" → just the LLM, no agentic features
                  "gpt4"     → call GPT-4 instead (for upper bound comparison)

    Returns a dict with:
        route:     SQL / VECTOR / HYBRID (or "SQL" for baseline)
        sql:       generated SQL query
        success:   whether the SQL executed without error
        result:    query result rows (or document answer text)
        attempts:  how many correction attempts were made
        mode:      which mode was used
    """
    schema = load_schema(db_path)

    if mode == "baseline":
        return _run_baseline(question, schema, db_path, config)
    elif mode == "gpt4":
        return _run_gpt4(question, schema, db_path, config)
    else:
        return _run_agentic(question, schema, db_path, config, dataset)


# ─────────────────────────────────────────────
# AGENTIC mode (full pipeline)
# ─────────────────────────────────────────────

def _run_agentic(question: str, schema: str, db_path: str, config: dict, dataset: str) -> dict:
    """Full agentic pipeline: route → retrieve → generate → self-correct."""

    if dataset == "spider":
        route_label = "SQL"
    elif dataset == "nawa":
        route_label = "SQL" # will introduce Vector and Hybrid routes for NAWA later
    else:
        raise ValueError(f"Unknown dataset: {dataset}")

    examples        = retrieve(question, schema, config)
    few_shot_prompt = format_examples_for_prompt(examples)


    result = generate_and_correct(
        question=question,
        schema=schema,
        db_path=db_path,
        few_shot_prompt=few_shot_prompt,
        config=config,
    )

    result["route"] = route_label
    result["mode"]  = "agentic"
    return result


# ─────────────────────────────────────────────
# BASELINE mode (no agentic features)
# ─────────────────────────────────────────────

def _run_baseline(question: str, schema: str, db_path: str, config: dict) -> dict:
    """
    Baseline: just the raw LLM, no router, no few-shot, no correction.
    This is what a plain SLM looks like without any augmentation.
    Used as the lower-bound comparison in the evaluation.
    """
    from src.self_correction import _build_generation_prompt, _call_and_extract
    from src.utils import execute_sql

    prompt  = _build_generation_prompt(question, schema, few_shot_prompt="")
    raw_sql = _call_and_extract(prompt, config["model"], config["ollama_base_url"])
    success, result = execute_sql(db_path, raw_sql)

    return {
        "route":    "SQL",
        "sql":      raw_sql,
        "success":  success,
        "result":   result,
        "attempts": 1,
        "mode":     "baseline",
    }


# ─────────────────────────────────────────────
# GPT-4 mode (cloud upper bound)
# ─────────────────────────────────────────────

def _run_gpt4(question: str, schema: str, db_path: str, config: dict) -> dict:
    """
    Calls GPT-4o via OpenAI API as the upper-bound reference.
    Requires OPENAI_API_KEY environment variable.
    No agentic features — pure GPT-4 performance.
    """
    import os
    import json
    import urllib.request

    api_key = os.environ.get("OPENAI_API_KEY", "")
    if not api_key:
        raise EnvironmentError("OPENAI_API_KEY not set. Export it before running GPT-4 eval.")

    from src.self_correction import _build_generation_prompt
    from src.utils import execute_sql

    prompt = _build_generation_prompt(question, schema, few_shot_prompt="")

    payload = json.dumps({
        "model": config.get("gpt4_model", "gpt-4o"),
        "messages": [
            {"role": "system", "content": "You are an expert SQL generator. Output ONLY the SQL query."},
            {"role": "user",   "content": prompt}
        ],
        "temperature": 0,
    }).encode("utf-8")

    req = urllib.request.Request(
        "https://api.openai.com/v1/chat/completions",
        data=payload,
        headers={
            "Content-Type":  "application/json",
            "Authorization": f"Bearer {api_key}",
        },
        method="POST"
    )

    with urllib.request.urlopen(req, timeout=60) as resp:
        data    = json.loads(resp.read().decode("utf-8"))
        raw_sql = data["choices"][0]["message"]["content"]

    raw_sql         = extract_sql(raw_sql)
    success, result = execute_sql(db_path, raw_sql)

    return {
        "route":    "SQL",
        "sql":      raw_sql,
        "success":  success,
        "result":   result,
        "attempts": 1,
        "mode":     "gpt4",
    }
