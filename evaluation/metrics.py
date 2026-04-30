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
import math
from typing import Literal, overload
from src.utils import execute_sql

log = logging.getLogger(__name__)


def _is_null(value) -> bool:
    if value is None:
        return True
    return isinstance(value, float) and math.isnan(value)


def _normalize_value(value):
    """
    Normalize values for robust comparison.
    - Strings are trimmed + lowercased
    - Null-like values are kept as None
    - Other values are returned as-is
    """
    if _is_null(value):
        return None
    if isinstance(value, str):
        return value.strip().lower()
    return value


def _normalize_result_rows(rows: list[tuple]) -> list[tuple]:
    normalized: list[tuple] = []
    for row in rows or []:
        normalized.append(tuple(_normalize_value(v) for v in row))
    return normalized


def values_match(gold_val, pred_val, tolerance: float = 0.05) -> bool:
    """Compare two values with null handling and numeric tolerance."""
    # Both null
    if _is_null(gold_val) and _is_null(pred_val):
        return True
    # One null
    if _is_null(gold_val) or _is_null(pred_val):
        return False

    # Numeric comparison with relative tolerance
    try:
        g = float(gold_val)
        p = float(pred_val)
        if g == 0:
            return abs(p) < 0.01
        return abs(g - p) / abs(g) <= tolerance
    except (ValueError, TypeError):
        pass

    # String / fallback comparison
    return str(gold_val).strip().lower() == str(pred_val).strip().lower()


def cell_level_comparison(
    gold_rows: list[tuple],
    pred_rows: list[tuple],
    num_tolerance: float = 0.05,
) -> dict:
    """
    Compare SQL results cell-by-cell.

    Handles:
    - Shared columns only (extra columns ignored in matching score)
    - Numeric tolerance
    - String normalization
    - Row-order insensitivity via deterministic sorting
    """
    gold_n = _normalize_result_rows(gold_rows)
    pred_n = _normalize_result_rows(pred_rows)
    print(gold_n)
    print(pred_n)
    
    # If both results are empty, treat as perfect match.
    if not gold_n and not pred_n:
        return {
            "cell_accuracy": 1.0,
            "shared_columns": [],
            "missing_columns_in_pred": [],
            "extra_columns_in_pred": [],
            "details": {},
        }

    gold_col_count = max((len(r) for r in gold_n), default=0)
    pred_col_count = max((len(r) for r in pred_n), default=0)
    shared_col_count = min(gold_col_count, pred_col_count)

    if shared_col_count == 0:
        return {
            "cell_accuracy": 0.0,
            "shared_columns": [],
            "missing_columns_in_pred": [f"col_{i}" for i in range(gold_col_count)],
            "extra_columns_in_pred": [f"col_{i}" for i in range(pred_col_count)],
            "details": {},
        }

    # Sort rows so comparison is order-insensitive.
    gold_s = sorted(gold_n, key=lambda row: tuple(str(v) for v in row))
    pred_s = sorted(pred_n, key=lambda row: tuple(str(v) for v in row))

    details = {}
    total_cells = 0
    matching_cells = 0
    max_rows = max(len(gold_s), len(pred_s))

    for col_idx in range(shared_col_count):
        col_matches = 0
        col_total = max_rows

        for row_idx in range(min(len(gold_s), len(pred_s))):
            if values_match(gold_s[row_idx][col_idx], pred_s[row_idx][col_idx], num_tolerance):
                col_matches += 1

        col_name = f"col_{col_idx}"
        details[col_name] = {
            "matches": col_matches,
            "total": col_total,
            "accuracy": col_matches / col_total if col_total else 0.0,
        }

        matching_cells += col_matches
        total_cells += col_total

    return {
        "cell_accuracy": matching_cells / total_cells if total_cells else 0.0,
        "shared_columns": [f"col_{i}" for i in range(shared_col_count)],
        "missing_columns_in_pred": [f"col_{i}" for i in range(shared_col_count, gold_col_count)],
        "extra_columns_in_pred": [f"col_{i}" for i in range(shared_col_count, pred_col_count)],
        "details": details,
    }


@overload
def execution_accuracy(
    gold_sql: str,
    predicted_sql: str,
    db_path: str,
    similarity_threshold: float = 0.8,
    num_tolerance: float = 0.05,
    return_similarity: Literal[False] = False,
) -> bool: ...


@overload
def execution_accuracy(
    gold_sql: str,
    predicted_sql: str,
    db_path: str,
    similarity_threshold: float = 0.8,
    num_tolerance: float = 0.05,
    return_similarity: Literal[True] = True,
) -> tuple[bool, float]: ...


def execution_accuracy(
    gold_sql: str,
    predicted_sql: str,
    db_path: str,
    similarity_threshold: float = 0.8,
    num_tolerance: float = 0.05,
    return_similarity: bool = False,
) -> bool | tuple[bool, float]:
    """
    Returns True if predicted SQL is sufficiently similar to gold SQL at cell level.

    Handles edge cases:
    - If predicted SQL fails to execute → False
    - If gold SQL fails to execute → skip (log warning), return False
    - Result comparison is row-order-insensitive
    - Uses tolerant cell-level matching with a similarity threshold
    - Optionally returns (is_correct, similarity)
    """
    # Run gold SQL
    gold_ok, gold_result = execute_sql(db_path, gold_sql)
    if not gold_ok:
        log.warning(f"Gold SQL failed: {gold_result}")
        if return_similarity:
            return False, 0.0
        return False

    # Run predicted SQL
    pred_ok, pred_result = execute_sql(db_path, predicted_sql)
    if not pred_ok:
        if return_similarity:
            return False, 0.0
        return False

    comparison = cell_level_comparison(gold_result, pred_result, num_tolerance=num_tolerance)
    similarity = comparison.get("cell_accuracy", 0.0)
    is_correct = similarity >= similarity_threshold
    if return_similarity:
        return is_correct, similarity
    return is_correct


def _normalize_doc_name(name: str) -> str:
    name = (name or "").strip().lower()
    if name.endswith(".pdf"):
        name = name[:-4]
    return name


def document_retrieval_hit(retrieved_chunks: list[dict], relevant_documents: list[str]) -> bool:
    """
    Relaxed document matching:
    returns True if at least one retrieved chunk source matches one gold relevant document.
    """
    if not retrieved_chunks or not relevant_documents:
        return False

    gold_docs = {_normalize_doc_name(doc) for doc in relevant_documents if doc}
    if not gold_docs:
        return False

    for chunk in retrieved_chunks:
        source = _normalize_doc_name(chunk.get("source", ""))
        if source in gold_docs:
            return True
    return False


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
    total = len(results)
    total_attempts = sum(r.get("attempts", 1) for r in results)

    route_scored = [r for r in results if r.get("route_correct") is not None]
    query_scored = [r for r in results if r.get("query_correct") is not None]
    docs_scored  = [r for r in results if r.get("docs_correct") is not None]

    route_correct = sum(1 for r in route_scored if r.get("route_correct"))
    query_correct = sum(1 for r in query_scored if r.get("query_correct"))
    docs_correct  = sum(1 for r in docs_scored if r.get("docs_correct"))
    query_similarity_scored: list[float] = []
    for r in results:
        sim_val = r.get("query_similarity")
        if isinstance(sim_val, (int, float)):
            query_similarity_scored.append(float(sim_val))
    avg_query_similarity = (
        round(sum(query_similarity_scored) / len(query_similarity_scored), 4)
        if query_similarity_scored
        else None
    )

    points_earned = sum(r.get("points_earned", 0) for r in results)
    max_points    = sum(r.get("max_points", 0) for r in results)
    route_only_correct = sum(1 for r in results if r.get("correct", False))
    failed_exec = sum(1 for r in results if r.get("query_correct") is False and r.get("success") is False)

    return {
        "overall_score_pct": round(points_earned / max_points * 100, 2) if max_points else 0,
        "points_earned": points_earned,
        "max_points": max_points,
        "total": total,
        "route_accuracy": round(route_correct / len(route_scored) * 100, 2) if route_scored else 0,
        "route_correct": route_correct,
        "route_total": len(route_scored),
        "query_accuracy": round(query_correct / len(query_scored) * 100, 2) if query_scored else 0,
        "query_correct": query_correct,
        "query_total": len(query_scored),
        "avg_query_similarity": avg_query_similarity,
        "query_similarity_total": len(query_similarity_scored),
        "docs_accuracy": round(docs_correct / len(docs_scored) * 100, 2) if docs_scored else 0,
        "docs_correct": docs_correct,
        "docs_total": len(docs_scored),
        "failed_execution": failed_exec,
        "avg_attempts": round(total_attempts / total, 2) if total else 1,
        # Backward-compatible field name now maps to route+query+docs point correctness.
        "execution_accuracy": round(points_earned / max_points * 100, 2) if max_points else 0,
        "correct": route_only_correct,
    }