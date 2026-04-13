"""
evaluation/metrics.py — Execution accuracy calculation.

What this does:
  Execution accuracy is the main metric for this thesis.
  Instead of checking if the generated SQL LOOKS like the gold SQL
  (which can be misleading — many queries produce the same result),
  we check if the generated SQL PRODUCES THE SAME RESULT as the gold SQL.

  For each question:
    1. Run gold SQL → gold result set
    2. Run predicted SQL → predicted result set
    3. If result sets match → correct (1), else wrong (0)
    4. Execution accuracy = correct / total questions
"""

import logging
from src.utils import execute_sql

log = logging.getLogger(__name__)


def execution_accuracy(gold_sql: str, predicted_sql: str, db_path: str) -> bool:
    """
    Returns True if predicted SQL produces the same result as gold SQL.

    Handles edge cases:
    - If predicted SQL fails to execute → False
    - If gold SQL fails to execute → skip (log warning), return False
    - Result comparison is order-insensitive (sorted comparison)
    """
    # Run gold SQL
    gold_ok, gold_result = execute_sql(db_path, gold_sql)
    if not gold_ok:
        log.warning(f"Gold SQL failed: {gold_result}")
        return False

    # Run predicted SQL
    pred_ok, pred_result = execute_sql(db_path, predicted_sql)
    if not pred_ok:
        return False

    # Compare result sets (order-insensitive)
    # Convert each row to a comparable string for robust comparison
    gold_set = set(str(row) for row in gold_result)
    pred_set = set(str(row) for row in pred_result)

    return gold_set == pred_set


def compute_metrics(results: list[dict]) -> dict:
    """
    Given a list of per-question results, computes aggregate metrics.

    Returns dict with:
      - execution_accuracy: percentage of correct answers
      - total: number of questions evaluated
      - correct: number of correct answers
      - failed_execution: number that failed SQL execution entirely
      - avg_attempts: average number of correction attempts (agentic mode only)
    """
    total           = len(results)
    correct         = sum(1 for r in results if r.get("correct", False))
    failed_exec     = sum(1 for r in results if not r.get("success", True))
    total_attempts  = sum(r.get("attempts", 1) for r in results)

    return {
        "execution_accuracy": round(correct / total * 100, 2) if total else 0,
        "total":              total,
        "correct":            correct,
        "failed_execution":   failed_exec,
        "avg_attempts":       round(total_attempts / total, 2) if total else 1,
    }