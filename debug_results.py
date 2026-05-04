"""
debug_results.py — Analyzes evaluation results to find what went wrong.

Usage:
    python debug_results.py results/agentic_spider_XXXXXX.json
    python debug_results.py results/agentic_spider_XXXXXX.json results/baseline_spider_XXXXXX.json
"""

import json
import sys
import os


def analyze(path: str):
    with open(path,encoding="utf-8") as f:
        data = json.load(f)

    metrics = data["metrics"]
    results = data["results"]

    print(f"\n{'='*60}")
    print(f"FILE: {os.path.basename(path)}")
    print(f"{'='*60}")
    print(f"  Execution Accuracy : {metrics['execution_accuracy']}%")
    print(f"  Correct            : {metrics['correct']} / {metrics['total']}")
    print(f"  Failed execution   : {metrics['failed_execution']}")
    print(f"  Avg attempts       : {metrics.get('avg_attempts', "")}")

    # Route breakdown
    routes = {}
    for r in results:
        route = r.get("route", "unknown")
        routes[route] = routes.get(route, 0) + 1

    print(f"\n  Route breakdown:")
    for route, count in sorted(routes.items()):
        pct = count / len(results) * 100
        print(f"    {route:<10} {count:>4}  ({pct:.1f}%)")

    # Accuracy per route
    print(f"\n  Accuracy per route:")
    for route in routes:
        route_results = [r for r in results if r.get("route") == route]
        correct = sum(1 for r in route_results if r.get("correct"))
        total   = len(route_results)
        print(f"    {route:<10} {correct}/{total}  ({correct/total*100:.1f}%)")

    # Attempt breakdown (agentic only)
    attempt_counts = {}
    for r in results:
        a = r.get("attempts", 1)
        attempt_counts[a] = attempt_counts.get(a, 0) + 1

    if any(a > 1 for a in attempt_counts):
        print(f"\n  Correction attempts breakdown:")
        for a, count in sorted(attempt_counts.items()):
            print(f"    {a} attempt(s): {count} questions")

        # How many were SAVED by correction?
        saved = [r for r in results if r.get("attempts", 1) > 1 and r.get("correct")]
        print(f"    Questions saved by self-correction: {len(saved)}")

    # Show 5 examples where agentic failed
    failures = [r for r in results if not r.get("correct") and r.get("sql")]
    print(f"\n  Sample failures (first 5 of {len(failures)}):")
    for r in failures[:5]:
        print(f"\n    Q:    {r['question'][:70]}")
        print(f"    Gold: {r['gold_sql'][:70]}")
        pred = r.get('predicted_sql', 'None')
        print(f"    Pred: {str(pred)[:70]}")
        print(f"    Route: {r.get('route')}  Attempts: {r.get('attempts', 1)}")


def compare(path_a: str, path_b: str):
    with open(path_a,encoding="utf-8") as f:
        a = json.load(f)
    with open(path_b,encoding="utf-8") as f:
        b = json.load(f)

    results_a = {r["question"]: r for r in a["results"]}
    results_b = {r["question"]: r for r in b["results"]}

    common = set(results_a.keys()) & set(results_b.keys())

    # Questions where A is wrong but B is correct (A got worse)
    a_worse = [q for q in common
               if not results_a[q].get("correct") and results_b[q].get("correct")]

    # Questions where A is correct but B is wrong (A got better)
    a_better = [q for q in common
                if results_a[q].get("correct") and not results_b[q].get("correct")]

    print(f"\n{'='*60}")
    print(f"COMPARISON: {os.path.basename(path_a)}  vs  {os.path.basename(path_b)}")
    print(f"{'='*60}")
    print(f"  {os.path.basename(path_a)} accuracy: {a['metrics']['execution_accuracy']}%")
    print(f"  {os.path.basename(path_b)} accuracy: {b['metrics']['execution_accuracy']}%")
    print(f"\n  Questions where FILE_A is WORSE than FILE_B: {len(a_worse)}")
    for r in a_worse[:5]:
        ra = results_a[r]
        rb = results_b[r]
        print(f"\n    Q:          {r[:65]}")
        print(f"    FILE_A SQL: {str(ra.get('predicted_sql',''))[:65]}  route={ra.get('route')}")
        print(f"    FILE_B SQL: {str(rb.get('predicted_sql',''))[:65]}")
        print(f"    Gold SQL:   {ra.get('gold_sql','')[:65]}")

    print(f"\n  Questions where FILE_A is BETTER than FILE_B: {len(a_better)}")
    for r in a_better[:5]:
        ra = results_a[r]
        rb = results_b[r]
        print(f"\n    Q:          {r[:65]}")
        print(f"    FILE_A SQL: {str(ra.get('predicted_sql',''))[:65]}")
        print(f"    FILE_B SQL: {str(rb.get('predicted_sql',''))[:65]}")


if __name__ == "__main__":
    if len(sys.argv) == 2:
        analyze(sys.argv[1])
    elif len(sys.argv) == 3:
        analyze(sys.argv[1])
        analyze(sys.argv[2])
        compare(sys.argv[1], sys.argv[2])
    else:
        print("Usage:")
        print("  python debug_results.py results/agentic_spider_XXX.json")
        print("  python debug_results.py results/agentic_spider_XXX.json results/baseline_spider_XXX.json")
