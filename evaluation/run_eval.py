"""
evaluation/run_eval.py — Main evaluation runner (CLI entry point).

Usage:
    # Test with 5 questions first (quick sanity check)
    python evaluation/run_eval.py --mode baseline --dataset spider --sample 5

    # Full evaluation run
    python evaluation/run_eval.py --mode baseline --dataset spider
    python evaluation/run_eval.py --mode agentic  --dataset spider
    python evaluation/run_eval.py --mode cloud    --dataset spider

    # Use the second model
    python evaluation/run_eval.py --mode agentic  --dataset spider --model qwen3:8b

Outputs:
    results/{mode}_{dataset}_{timestamp}.json  — full per-question results
    Prints a summary table at the end.
"""

import os
import sys
import json
import argparse
import logging
import time
from datetime import datetime

sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

from src.judge import faithfulness_judge
from src.utils import load_config, load_spider_dev, load_nawa_dev
from src.pipeline import run
from src.router import MODE_BOTH, ROUTE_SQL, ROUTE_VECTOR, ROUTE_HYBRID, MODE_BASELINE, MODE_AGENTIC, MODE_CLOUD
from evaluation.metrics import execution_accuracy, compute_metrics, document_retrieval_hit

logging.basicConfig(level=logging.INFO, format="%(levelname)s: %(message)s")
log = logging.getLogger(__name__)

def main():
    start = time.perf_counter()
    parser = argparse.ArgumentParser(description="Agentic Hybrid RAG Evaluation")
    parser.add_argument("--mode",    choices=[MODE_BASELINE, MODE_AGENTIC, MODE_CLOUD, MODE_BOTH], required=True,
                        help="Which system configuration to evaluate")
    parser.add_argument("--dataset", choices=["spider", "nawa"], default="spider",
                        help="Which benchmark dataset to use")
    parser.add_argument("--sample",  type=int, default=None,
                        help="Override sample size (useful for quick tests, e.g. --sample 5)")
    parser.add_argument("--index",  type=int, default=-1,
                        help="Starting index (useful for resuming partial runs)")
    parser.add_argument("--model",   type=str, default=None,
                        help="Override the model name (e.g. qwen3.5:9b)")
    parser.add_argument("--config",  type=str, default="configs/config.yaml",
                        help="Path to config file")
    parser.add_argument("--judge",  type=bool, default=False,
                        help="Whether to run faithfulness judge (only for agentic/cloud modes and when route is correct)")
    args = parser.parse_args()

    config = load_config(args.config)

    # Apply model overrides
    if args.model:
        if args.mode == MODE_CLOUD:
            config["copilot_model"] = args.model
        else:
            config["model"] = args.model
        log.info(f"Model override: {args.model}")

    sample_size = args.sample or config.get("eval_sample_size", 200)
    seed        = config.get("eval_random_seed", 42)
    start_index = args.index
    print(f"index: {start_index}")

    # Load questions
    if args.dataset == "spider":
        examples = load_spider_dev(config["spider_dir"], sample_size=sample_size, seed=seed)
    elif args.dataset == "nawa":
        examples = load_nawa_dev(config["nawa_dir"], sample_size=sample_size, seed=seed, start_index=start_index)
    else:
        log.error(f"Unknown dataset: {args.dataset}")
        sys.exit(1)
   
    if not examples:
        log.error("No examples loaded. Have you downloaded the datasets?")
        log.error("Run: python setup/download_data.py")
        sys.exit(1)

    active_model = config.get("copilot_model") if args.mode == MODE_CLOUD else config.get("model")

    log.info(f"\n{'='*50}")
    log.info(f"Mode:    {args.mode}")
    log.info(f"Dataset: {args.dataset}")
    log.info(f"Model:   {active_model}")
    log.info(f"Sample:  {len(examples)} questions")
    log.info(f"{'='*50}\n")

    results = []
    scanned = ['What are the first names of all players, and their total ranking points?',"List the first and last name of all players in the order of birth date."]
    filtered = [
        "How much warranty revenue did LumenForge Displayworks generate in Q1 2026, and which report discusses that warranty revenue is concentrated in Direct Online transactions?", 
        "For Nordhaven RockTech Industries, what was shipped revenue in Q1 2026 by channel (Direct vs Distributor)?",
        "For Nordhaven RockTech Industries, which product categories generated the most shipped revenue in Q1 2026?",
        "For Nordhaven RockTech Industries, what was total shipped revenue in Q1 2026, and what explanations does the Q1 sales report provide for the quarter\u2019s performance and risks?",
        "For NordHearth Scania Fleet Services, what is the transport margin (revenue minus fuel_cost) in Q1 2026?",
        "Which parts categories have the highest total extended_price for NordHearth Scania Fleet Services (all work orders)?",
        "Which parts category has the highest extended spend in the database, and which NordHearth Scania Fleet Services report discusses that category as a key cost driver?",
        "For NordVigil Aeronautics & Secure Systems (NVASS), how many deliveries have status Delivered?",
                ]
    stopped_at = 0
    breakit = False
    for i, ex in enumerate(examples):
        if ex.get("question") in scanned: 
            continue
        # if ex.get("question") not in filtered:
        #     continue
        # if ex.get("question") not in scanned and breakit == False:
        #     # stopped_at += 1
        #     continue
        # elif ex.get("question") in scanned and breakit == False:
        #     # stopped_at += 1
        #     breakit = True
        #     continue
  
        log.info(f"\n[{i+1}/{len(examples)}] {ex['question']}")
        log.info(f"DB: {ex['db_id']}")
        # exit(0)
        try:
            judge = {}
            output = run(
                ex = ex,
                question = ex["question"],
                db_path  = ex["db_path"],
                config   = config,
                mode     = args.mode,
                dataset  = args.dataset,
                evaluate = True,
            )
            # for k,output in moutput.items():     
                # if args.mode == MODE_BASELINE:
                #     outputs_to_evaluate = list(mainoutput.items())
                # else:
                #     outputs_to_evaluate = [(args.mode, mainoutput)]    
                    
                # for label, output in outputs_to_evaluate:

            predicted_route = output.get("route")
            gold_route      = ex.get("route", ROUTE_SQL)

            route_correct = (predicted_route == gold_route)

            # Evaluate SQL only when router selected SQL/HYBRID and a SQL gold answer exists.
            query_correct = None
            query_similarity = None
            if predicted_route in (ROUTE_SQL, ROUTE_HYBRID) and ex.get("gold_sql") and ex.get("db_path"):
                query_correct, query_similarity = execution_accuracy(
                    gold_sql      = ex["gold_sql"],
                    predicted_sql = output.get("sql", ""),
                    db_path       = ex["db_path"],
                    return_similarity=True,
                )

            # Evaluate retrieved sources only when router selected VECTOR/HYBRID.
            docs_correct = None
            retrieved_chunks = output.get("retrieved_chunks", []) or []
            if predicted_route in (ROUTE_VECTOR, ROUTE_HYBRID):
                docs_correct = document_retrieval_hit(
                    retrieved_chunks=retrieved_chunks,
                    relevant_documents=ex.get("relevant_documents", []),
                )

            # Route-dependent max points based on gold route.
            route_point = 1 if route_correct else 0
            query_point = 0
            docs_point  = 0

            if gold_route in (ROUTE_SQL, ROUTE_HYBRID) and query_correct is True:
                query_point = 1
            if gold_route in (ROUTE_VECTOR, ROUTE_HYBRID) and docs_correct is True:
                docs_point = 1

            if gold_route == ROUTE_HYBRID:
                max_points = 3
            elif gold_route in (ROUTE_SQL, ROUTE_VECTOR):
                max_points = 2
            else:
                max_points = 1

            points_earned = route_point + query_point + docs_point
            correct = (points_earned == max_points)
            # exit(0) # for quick testing of metrics calculation and result saving without running the full evaluation.
            if route_correct and args.mode != MODE_BASELINE and args.judge:
                ctx = output.get("context", "") + "\n\n" + str(output.get("result", []))
                judge = faithfulness_judge(ctx, output.get("answer", ""),model="gpt-4.1", timeout=60)
                
            record = {
                "question":             ex["question"],
                "db_id":                ex["db_id"],
                "gold_sql":             ex["gold_sql"],
                "predicted_sql":        output.get("sql"),
                "route":                predicted_route,
                "gold_route":           gold_route,
                "route_correct":        route_correct,
                "query_correct":        query_correct,
                "query_similarity":     query_similarity,
                "docs_correct":         docs_correct,
                "relevant_documents":   ex.get("relevant_documents", []),
                "retrieved_sources":    [c.get("source", "") for c in retrieved_chunks],
                "success":              output.get("success"),
                "attempts":             output.get("attempts", 1),
                "correct":              correct,
                "points_earned":        points_earned,
                "max_points":           max_points,
                "mode":                 output.get("mode"),
                "dataset":              args.dataset,
                "latency":              output.get("latency", {}),
                "judge":                judge,
                "answer":               output.get("answer", ""),
                "context":              output.get("context", ""),
                "db_data":              [list(row) for row in output.get("result", [])],
            }
            results.append(record)
            stopped_at += 1

            status = "✓" if correct else "✗"
            log.info(
                f"  {status} Route={predicted_route} (gold={gold_route}) "
                f"RouteOK={route_correct} QueryOK={query_correct} QuerySim={query_similarity} DocsOK={docs_correct} "
                f"Points={points_earned}/{max_points} Attempts={output.get('attempts',1)}"
            )

        except Exception as e:
            log.error(f"  ERROR on question {i+1} ({start_index+i+1}): {e}")
            gold_route = ex.get("route", ROUTE_SQL)
            max_points = 3 if gold_route == ROUTE_HYBRID else 2
            predicted_route = "ERROR"
            results.append({
                "flag" :            "error",
                "question":         ex["question"],
                "db_id":            ex["db_id"],
                "gold_sql":         ex["gold_sql"],
                "route":            predicted_route,
                "gold_route":       gold_route,
                "route_correct":    False,
                "query_correct":    False if gold_route in (ROUTE_SQL, ROUTE_HYBRID) else None,
                "query_similarity": 0.0 if gold_route in (ROUTE_SQL, ROUTE_HYBRID) else None,
                "docs_correct":     False if gold_route in (ROUTE_VECTOR, ROUTE_HYBRID) else None,
                "error":            str(e),
                "correct":          False,
                "points_earned":    0,
                "max_points":       max_points,
                "mode":             args.mode,
                "dataset":          args.dataset,
                "latency":          output.get("latency", {}),
                "judge":            judge,
                "answer":           output.get("answer", ""),
                "context":          output.get("context", ""),
                "db_data":          [list(row) for row in output.get("result", [])],
            })
            break

    # Compute and print final metrics
    # if args.mode == MODE_BOTH:
    #     res1 = [r for r in results if r["mode"] == MODE_AGENTIC]
    #     res2 = [r for r in results if r["mode"] == MODE_BASELINE]
    #     metrics = compute_metrics(res1)
    #     metrics["seed"] = seed  # include seed in metrics for reproducibility
    #     metrics["start_index"] = start_index
    #     metrics["sample_size"] = len(examples)
    #     metrics["stopped_at"] = stopped_at
    #     metrics["exec_time"] = time.perf_counter() - start
    #     timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
    #     # Save results
    #     os.makedirs(config["results_dir"], exist_ok=True)
    #     outfile = os.path.join(
    #         config["results_dir"],
    #         f"{MODE_AGENTIC}_{args.dataset}_{timestamp}.json"
    #     )

    #     with open(outfile, "w",encoding="utf-8") as f:
    #         json.dump({"metrics": metrics, "results": results}, f, indent=2)
    #     log.info(f"Full results saved to: {outfile}")
        
    #     metrics = compute_metrics(res2)
    #     metrics["seed"] = seed  # include seed in metrics for reproducibility
    #     metrics["start_index"] = start_index
    #     metrics["sample_size"] = len(examples)
    #     metrics["stopped_at"] = stopped_at
    #     metrics["exec_time"] = time.perf_counter() - start
    #     timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
    #     # Save results
    #     os.makedirs(config["results_dir"], exist_ok=True)
    #     outfile = os.path.join(
    #         config["results_dir"],
    #         f"{MODE_BASELINE}_{args.dataset}_{timestamp}.json"
    #     )

    #     with open(outfile, "w",encoding="utf-8") as f:
    #         json.dump({"metrics": metrics, "results": results}, f, indent=2)

    #     log.info(f"Full results saved to: {outfile}")
    #     exit(0)
    
    metrics = compute_metrics(results)
    metrics["seed"] = seed  # include seed in metrics for reproducibility
    metrics["start_index"] = start_index
    metrics["sample_size"] = len(examples)
    metrics["stopped_at"] = stopped_at
    metrics["exec_time"] = time.perf_counter() - start
    timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")

    print(f"\n{'='*50}")
    print(f"RESULTS — {args.mode.upper()} on {args.dataset.upper()}")
    print(f"{'='*50}")
    print(f"  Overall Score:      {metrics['overall_score_pct']}% ({metrics['points_earned']}/{metrics['max_points']})")
    print(f"  Route Accuracy:     {metrics['route_accuracy']}% ({metrics['route_correct']}/{metrics['route_total']})")
    print(f"  Query Accuracy:     {metrics['query_accuracy']}% ({metrics['query_correct']}/{metrics['query_total']})")
    print(f"  Avg Query Similarity: {metrics['avg_query_similarity']} (n={metrics['query_similarity_total']})")
    print(f"  Docs Accuracy:      {metrics['docs_accuracy']}% ({metrics['docs_correct']}/{metrics['docs_total']})")
    print(f"  Fully Correct:      {metrics['correct']} / {metrics['total']}")
    print(f"  Failed execution:   {metrics['failed_execution']}")
    print(f"  Avg attempts:       {metrics['avg_attempts']}")
    print(f"{'='*50}\n")

    # Save results
    os.makedirs(config["results_dir"], exist_ok=True)
    outfile = os.path.join(
        config["results_dir"],
        f"{args.mode}_{args.dataset}_{timestamp}.json"
    )

    with open(outfile, "w",encoding="utf-8") as f:
        json.dump({"metrics": metrics, "results": results}, f, indent=2)

    log.info(f"Full results saved to: {outfile}")


if __name__ == "__main__":
    main()
