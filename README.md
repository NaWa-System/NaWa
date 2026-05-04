# Hybrid-Agentic-RAG

An agentic RAG framework for Text-to-SQL that combines:

- Dynamic few-shot retrieval from benchmark training examples
- SQL generation with an iterative self-correction loop
- Multi-mode evaluation (`baseline`, `agentic`, `cloud`) on Spider and NAWA

The current code in this repository is focused on SQL generation and correction. The `agentic` mode currently routes SQL-only for both Spider and NAWA.

## Features

- Local inference via Ollama (`qwen3.5:9b`, `qwen3:8b`, or other compatible models)
- Dynamic few-shot retrieval using ChromaDB + SentenceTransformers
- Self-correction loop that retries failed SQL using SQLite error feedback
- Execution-accuracy evaluation with JSON result export
- Optional GPT-4 reference mode for upper-bound comparison

## Repository Layout

```text
Hybrid-Agentic-RAG/
|- configs/config.yaml          # Runtime configuration
|- setup/download_data.py       # Dataset download/setup helper (Spider)
|- indexing/index_few_shots.py  # Builds few-shot vector store
|- evaluation/run_eval.py       # Main evaluation CLI
|- evaluation/metrics.py        # Execution accuracy metrics
|- src/pipeline.py              # Core pipeline (baseline/agentic/cloud)
|- src/few_shot_retriever.py    # Few-shot retrieval + prompt formatting
|- src/self_correction.py       # Generation + correction loop
|- src/llm.py                   # Ollama API wrapper
|- src/utils.py                 # Config/schema/sql/data loaders
|- test_setup.py                # Environment sanity checks
|- debug_results.py             # Result analysis helper
|- data/                        # Datasets and documents
|- vector_stores/               # Persistent ChromaDB stores
|- results/                     # Saved evaluation outputs
```

## Prerequisites

- Python 3.10+ (3.11/3.12 recommended)
- Ollama installed and running for local model modes (`baseline` and `agentic`)
- (Optional) OpenAI API key for `cloud` mode

## Installation

### 1) Clone the repository

```bash
git clone <your-repo-url>
cd Hybrid-Agentic-RAG
```

### 2) Create and activate a virtual environment

Windows PowerShell:

```powershell
python -m venv .venv
Set-ExecutionPolicy -Scope Process -ExecutionPolicy RemoteSigned
.\.venv\Scripts\Activate.ps1
```

macOS/Linux:

```bash
python3 -m venv .venv
source .venv/bin/activate
```

### 3) Install dependencies

```bash
pip install -r requirements.txt
```

## Model Setup (Ollama)

Start Ollama:

```bash
ollama serve
```

Pull models used by default config:

```bash
ollama pull qwen3.5:9b
ollama pull qwen3:8b
```

If you use another model, update `configs/config.yaml` or pass `--model` at runtime.

## Data Setup

### 1) Download Spider data

```bash
python setup/download_data.py
```

If automatic download fails (common with Google Drive), follow the manual instructions printed by the script.

### 2) NAWA data

NAWA files are expected under `data/nawa` (already present in this workspace). Expected files include:

- `data/nawa/dev.json`
- `data/nawa/train.json`
- `data/nawa/databases/<db_id>/<db_id>.db`

## Build the Few-Shot Vector Store

Run once before evaluation:

```bash
python indexing/index_few_shots.py
```

This creates/refreshes `vector_stores/few_shot_bank` with embedded training examples. Edit `index_few_shots.py` to choose which dataset to index.

## Quick Sanity Check

Before running long evaluations:

```bash
python test_setup.py
```

This checks config loading, SQL execution utilities, embeddings, ChromaDB, and Ollama/model availability.

## Usage

Main CLI:

```bash
python evaluation/run_eval.py --mode <baseline|agentic|cloud> --dataset <spider|nawa> [--sample N] [--model MODEL]
```

### Example commands

Quick smoke tests:

```bash
python evaluation/run_eval.py --mode baseline --dataset spider --sample 5
python evaluation/run_eval.py --mode agentic --dataset spider --sample 5
```

Full/default sample-size run (uses `eval_sample_size` from config):

```bash
python evaluation/run_eval.py --mode baseline --dataset spider
python evaluation/run_eval.py --mode agentic --dataset spider
python evaluation/run_eval.py --mode agentic --dataset nawa
```

Run with alternate local model:

```bash
python evaluation/run_eval.py --mode agentic --dataset spider --model qwen3:8b
```

Use `cloud` mode (Copilot CLI-backed, model from config):

```bash
python evaluation/run_eval.py --mode cloud --dataset spider --sample 20
```

Override the Copilot model for this run:

```bash
python evaluation/run_eval.py --mode cloud --dataset spider --sample 20 --model gpt-5.2
```

## Output Files

Each run saves a JSON file in `results/`:

```text
results/{mode}_{dataset}_{timestamp}.json
```

Each output contains:

- `metrics`: aggregate execution accuracy and summary stats
- `results`: per-question records (question, SQL, correctness, route, attempts, etc.)

## Analyze Results

Single file analysis:

```bash
python debug_results.py results/agentic_spider_YYYYMMDD_HHMMSS.json
```

Compare two files:

```bash
python debug_results.py results/agentic_spider_YYYYMMDD_HHMMSS.json results/baseline_spider_YYYYMMDD_HHMMSS.json
```

## Configuration

Main config file: `configs/config.yaml`

Important fields:

- `model`: default local model for generation
- `model_alt`: secondary model label for manual comparisons
- `copilot_model`: model used in `cloud` mode (via Copilot CLI)
- `embedding_model`: sentence-transformers model for retrieval
- `k_few_shot`: number of retrieved examples per question
- `max_retries`: correction retries (`attempts = max_retries + 1` max total)
- `eval_sample_size`, `eval_random_seed`: evaluation sampling controls
- `ollama_base_url`, `ollama_timeout`: local model endpoint settings
- Path settings: `spider_dir`, `nawa_dir`, `few_shot_store`, `results_dir`, etc.

## Typical End-to-End Workflow

1. Install dependencies in a virtual environment.
2. Start Ollama and pull model(s).
3. Prepare datasets (`setup/download_data.py` for Spider, ensure NAWA files exist).
4. Build few-shot store (`python indexing/index_few_shots.py`).
5. Run sanity checks (`python test_setup.py`).
6. Run evaluation (`python evaluation/run_eval.py ...`).
7. Inspect JSON outputs and compare with `debug_results.py`.

## Troubleshooting

### Ollama connection failed

- Symptom: connection errors from `src/llm.py`
- Fix: ensure Ollama is running with `ollama serve`
- Verify model exists with `ollama pull <model_name>`

### Few-shot bank is empty

- Symptom: warnings from retriever about empty collection
- Fix: run `python indexing/index_few_shots.py`

### No examples loaded during eval

- Symptom: `No examples loaded. Have you downloaded the datasets?`
- Fix: verify `data/spider` or `data/nawa` paths and expected files

### Copilot CLI not available in gpt4 mode

- Symptom: `Copilot CLI failed ...`
- Fix: install/login to Copilot CLI and retry

## Current Scope and Notes

- `agentic` mode currently executes SQL route for both Spider and NAWA.
- Few-shot retrieval and self-correction are active in `agentic` mode and partially in `baseline`.
- `cloud` mode run without the agentic retrieval/correction pipeline.

## License

See `LICENSE`.
