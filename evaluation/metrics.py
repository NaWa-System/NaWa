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
from scipy.optimize import linear_sum_assignment
import numpy as np
import sqlite3
from collections import Counter
import logging
import math
from typing import Literal, overload, Any, Iterable
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
    print(f"Gold columns: {gold_col_count}, Predicted columns: {pred_col_count}, Shared columns: {shared_col_count}")

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
    # print("\n===========================================")    
    # print(f"Normalized & sorted gold result: {gold_s}")
    # print(" ")
    # print(f"Normalized & sorted predicted result: {pred_s}")
    # print("===========================================\n")    
    
     # ------------------------------------------------------------------
    # BUILD a similarity matrix  (gold_rows x pred_rows)
    # Each cell = number of shared-column values that match between
    # gold row i and predicted row j.
    # ------------------------------------------------------------------
    n_gold = len(gold_s)
    n_pred = len(pred_s)
    sim_matrix = np.zeros((n_gold, n_pred), dtype=float)

    for i, g_row in enumerate(gold_s):
        for j, p_row in enumerate(pred_s):
            matches = sum(
                1 for c in range(shared_col_count)
                if values_match(g_row[c], p_row[c], num_tolerance)
            )
            sim_matrix[i, j] = matches

    # ------------------------------------------------------------------
    # HUNGARIAN ALGORITHM — finds the assignment of pred rows to gold
    # rows that maximises total cell matches (overlap-aware).
    # linear_sum_assignment minimises cost, so we negate the matrix.
    # ------------------------------------------------------------------
    cost_matrix = -sim_matrix
    gold_indices, pred_indices = linear_sum_assignment(cost_matrix)

    # ------------------------------------------------------------------
    # ACCUMULATE per-column stats from the optimal row pairing
    # ------------------------------------------------------------------
    # Track per-column matches from matched pairs
    col_matches = {c: 0 for c in range(shared_col_count)}

    for gi, pi in zip(gold_indices, pred_indices):
        for c in range(shared_col_count):
            if values_match(gold_s[gi][c], pred_s[pi][c], num_tolerance):
                col_matches[c] += 1

    # Total rows considered = max(gold, pred) to penalise missing/extra rows
    max_rows = max(n_gold, n_pred)
    details = {}
    total_cells = 0
    matching_cells = 0
    
    # details = {}
    # total_cells = 0
    # matching_cells = 0
    # max_rows = max(len(gold_s), len(pred_s))
    for c in range(shared_col_count):
        col_name = f"col_{c}"
        details[col_name] = {
            "matches": col_matches[c],
            "total": max_rows,
            "accuracy": col_matches[c] / max_rows if max_rows else 0.0,
        }
        matching_cells += col_matches[c]
        total_cells += max_rows

    # for col_idx in range(shared_col_count):
    #     col_matches = 0
    #     col_total = max_rows

    #     for row_idx in range(min(len(gold_s), len(pred_s))):
    #         if values_match(gold_s[row_idx][col_idx], pred_s[row_idx][col_idx], num_tolerance):
    #             col_matches += 1

    #     col_name = f"col_{col_idx}"
    #     details[col_name] = {
    #         "matches": col_matches,
    #         "total": col_total,
    #         "accuracy": col_matches / col_total if col_total else 0.0,
    #     }

    #     matching_cells += col_matches
    #     total_cells += col_total
    acc = {
        "cell_accuracy": matching_cells / total_cells if total_cells else 0.0,
        "shared_columns": [f"col_{i}" for i in range(shared_col_count)],
        "missing_columns_in_pred": [f"col_{i}" for i in range(shared_col_count, gold_col_count)],
        "extra_columns_in_pred": [f"col_{i}" for i in range(shared_col_count, pred_col_count)],
        "details": details,
    }
    # print each item in acc in a line for debugging
    # for k, v in acc.items():
    #     if k != "details":
    #         print(f"{k}: {v}")
    #     else:
    #         for col, stats in v.items():
    #             print(f"  {col}: {stats}")
    # print("===========================================")    

    return acc


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
    similarity_threshold: float = 1.0,
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
    gold_ok, gold_result = execute_query(db_path, gold_sql) #execute_sql(db_path, gold_sql)
    if not gold_ok:
        log.warning(f"Gold SQL failed: {gold_result}")
        if return_similarity:
            return False, 0.0
        return False

    # Run predicted SQL
    pred_ok, pred_result = execute_query(db_path, predicted_sql) #execute_sql(db_path, predicted_sql)
    if not pred_ok:
        if return_similarity:
            return False, 0.0
        return False

    # print("\n===========================================")
    # print("Gold result:", gold_result)
    # print(" ")
    # print("Predicted result:", pred_result)
    # print("===========================================\n")
    comparison = compare_results(gold_result, pred_result) # cell_level_comparison(gold_result, pred_result, num_tolerance=num_tolerance)
    print(f"Cell-level comparison details: {comparison}")
    similarity = comparison.get("query_similarity", 0.0)
    is_correct = similarity >= similarity_threshold
    if return_similarity:
        return is_correct, similarity
    return is_correct

# _____________________________________
# New accuracy 
# _____________________________________
def normalize_value(value: Any) -> Any:
    """Normalize SQLite values so they can be compared reliably."""
    if value is None:
        return "__NULL__"
    if isinstance(value, bytes):
        return value.hex()
    if isinstance(value, float):
        if math.isnan(value):
            return "__NAN__"
        if math.isinf(value):
            return "__INF__" if value > 0 else "__NEG_INF__"
    return value


def normalize_row(row: Iterable[Any]) -> tuple[Any, ...]:
    return tuple(normalize_value(v) for v in row)


def execute_query(db_path: str, query: str) -> tuple[bool, Any]:
    conn = sqlite3.connect(db_path)
    try:
        cur = conn.cursor()
        cur.execute(query)
        rows = cur.fetchall()
        columns = [desc[0] if desc and desc[0] is not None else "" for desc in (cur.description or [])]
        norm_rows = [normalize_row(r) for r in rows]
        return True, {
            "columns": columns,
            "rows": rows,
            "normalized_rows": norm_rows,
        }
    except sqlite3.Error as e:
        return False, str(e)
    except Exception as e:
        return False, f"Unexpected error: {e}"
    finally:
        conn.close()


def multiset_similarity(a: Counter, b: Counter) -> float:
    """Return overlap percentage between two multisets."""
    total_a = sum(a.values())
    total_b = sum(b.values())
    if total_a == 0 and total_b == 0:
        return 100.0
    overlap = sum((a & b).values())
    denom = max(total_a, total_b)
    return (overlap / denom) * 100.0


def flatten_rows(rows: list[tuple[Any, ...]]) -> list[Any]:
    values: list[Any] = []
    for row in rows:
        values.extend(row)
    return values


def compare_results(res1: dict[str, Any], res2: dict[str, Any]) -> dict[str, Any]:
    cols1 = res1["columns"]
    cols2 = res2["columns"]
    rows1 = res1["normalized_rows"]
    rows2 = res2["normalized_rows"]

    strict_same = cols1 == cols2 and rows1 == rows2

    row_counter_1 = Counter(rows1)
    row_counter_2 = Counter(rows2)
    row_similarity = multiset_similarity(row_counter_1, row_counter_2)

    cell_counter_1 = Counter(flatten_rows(rows1))
    cell_counter_2 = Counter(flatten_rows(rows2))
    cell_similarity = multiset_similarity(cell_counter_1, cell_counter_2)

    header_counter_1 = Counter(c.strip().lower() for c in cols1)
    header_counter_2 = Counter(c.strip().lower() for c in cols2)
    header_similarity = multiset_similarity(header_counter_1, header_counter_2)

    # Data should drive the score most, because headers can differ while values match.
    overall_similarity = round((0.8 * row_similarity) + (0.2 * cell_similarity), 2)

    same_data_different_headers = (
        not strict_same
        and row_similarity == 100.0
        and cell_similarity == 100.0
        and header_similarity < 100.0
    )
    return {
        "strictly_same": strict_same,
        "query_correct": same_data_different_headers,
        "query_similarity": overall_similarity,
        "query_details": {
            "row_similarity_percent": round(row_similarity, 2),
            "cell_similarity_percent": round(cell_similarity, 2),
            "header_similarity_percent": round(header_similarity, 2),
        },
    }
    
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
    # r["judge"]["score"] is faithfullness score from judge, we can also compute average faithfulness if needed.
    faithfulness_scored: list[float] = []
    avg_faithfulness = None
    if r.get("judge", None):
        for r in results:        
            judge = r.get("judge", {})
            score = judge.get("score")
            if isinstance(score, (int, float)):
                faithfulness_scored.append(float(score))
        avg_faithfulness = round(sum(faithfulness_scored) / len(faithfulness_scored), 4)
        
    
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
        "avg_faithfulness": avg_faithfulness,
    }