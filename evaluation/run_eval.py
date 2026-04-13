"""
evaluation/run_eval.py — Main evaluation runner (CLI entry point).

Usage:
    # Test with 5 questions first (quick sanity check)
    python evaluation/run_eval.py --mode baseline --dataset spider --sample 5

    # Full evaluation run
    python evaluation/run_eval.py --mode baseline --dataset spider
    python evaluation/run_eval.py --mode agentic  --dataset spider
    python evaluation/run_eval.py --mode gpt4     --dataset spider

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
from datetime import datetime

sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

from src.utils import load_config, load_spider_dev, load_nawa_dev
from src.pipeline import run
from evaluation.metrics import execution_accuracy, compute_metrics

logging.basicConfig(level=logging.INFO, format="%(levelname)s: %(message)s")
log = logging.getLogger(__name__)

DATASET = ""

def main():
    parser = argparse.ArgumentParser(description="Agentic Hybrid RAG Evaluation")
    parser.add_argument("--mode",    choices=["baseline", "agentic", "gpt4"], required=True,
                        help="Which system configuration to evaluate")
    parser.add_argument("--dataset", choices=["spider", "nawa"], default="spider",
                        help="Which benchmark dataset to use")
    parser.add_argument("--sample",  type=int, default=None,
                        help="Override sample size (useful for quick tests, e.g. --sample 5)")
    parser.add_argument("--model",   type=str, default=None,
                        help="Override the model name (e.g. qwen3:8b)")
    parser.add_argument("--config",  type=str, default="configs/config.yaml",
                        help="Path to config file")
    args = parser.parse_args()

    config = load_config(args.config)

    # Apply overrides
    if args.model:
        config["model"] = args.model
        log.info(f"Model override: {args.model}")

    sample_size = args.sample or config.get("eval_sample_size", 200)
    seed        = config.get("eval_random_seed", 42)

    # Load questions
    if args.dataset == "spider":
        examples = load_spider_dev(config["spider_dir"], sample_size=sample_size, seed=seed)
    elif args.dataset == "nawa":
        examples = load_nawa_dev(config["nawa_dir"], sample_size=sample_size, seed=seed)
    else:
        log.error(f"Unknown dataset: {args.dataset}")
        sys.exit(1)
                
    if not examples:
        log.error("No examples loaded. Have you downloaded the datasets?")
        log.error("Run: python setup/download_data.py")
        sys.exit(1)

    log.info(f"\n{'='*50}")
    log.info(f"Mode:    {args.mode}")
    log.info(f"Dataset: {args.dataset}")
    log.info(f"Model:   {config['model']}")
    log.info(f"Sample:  {len(examples)} questions")
    log.info(f"{'='*50}\n")

    results = []

    for i, ex in enumerate(examples):
        log.info(f"\n[{i+1}/{len(examples)}] {ex['question']}")
        log.info(f"  DB: {ex['db_id']}")

        try:
            output = run(
                question = ex["question"],
                db_path  = ex["db_path"],
                config   = config,
                mode     = args.mode,
                dataset  = args.dataset,
            )

            # Compute execution accuracy for SQL questions
            correct = False
            if output.get("sql") is not None:
                correct = execution_accuracy(
                    gold_sql      = ex["gold_sql"],
                    predicted_sql = output["sql"],
                    db_path       = ex["db_path"],
                )

            record = {
                "question":     ex["question"],
                "db_id":        ex["db_id"],
                "gold_sql":     ex["gold_sql"],
                "predicted_sql":output.get("sql"),
                "route":        output.get("route"),
                "success":      output.get("success"),
                "attempts":     output.get("attempts", 1),
                "correct":      correct,
                "mode":         args.mode,
                "dataset":      args.dataset,
            }
            results.append(record)

            status = "✓" if correct else "✗"
            log.info(f"  {status} Success={output.get('success')} Correct={correct}  Attempts={output.get('attempts',1)}  Route={output.get('route')}")

        except Exception as e:
            log.error(f"  ERROR on question {i+1}: {e}")
            results.append({
                "question": ex["question"],
                "db_id":    ex["db_id"],
                "gold_sql": ex["gold_sql"],
                "error":    str(e),
                "correct":  False,
                "mode":     args.mode,
                "dataset":  args.dataset,
            })

    # Compute and print final metrics
    metrics = compute_metrics(results)
    timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")

    print(f"\n{'='*50}")
    print(f"RESULTS — {args.mode.upper()} on {args.dataset.upper()}")
    print(f"{'='*50}")
    print(f"  Execution Accuracy: {metrics['execution_accuracy']}%")
    print(f"  Correct:            {metrics['correct']} / {metrics['total']}")
    print(f"  Failed execution:   {metrics['failed_execution']}")
    print(f"  Avg attempts:       {metrics['avg_attempts']}")
    print(f"{'='*50}\n")

    # Save results
    os.makedirs(config["results_dir"], exist_ok=True)
    outfile = os.path.join(
        config["results_dir"],
        f"{args.mode}_{args.dataset}_{timestamp}.json"
    )

    with open(outfile, "w") as f:
        json.dump({"metrics": metrics, "results": results}, f, indent=2)

    log.info(f"Full results saved to: {outfile}")


if __name__ == "__main__":
    main()