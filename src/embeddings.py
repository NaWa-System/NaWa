"""
embeddings.py — Shared helpers for loading sentence-transformer models.

Goals:
  - Support one-time predownload, then local-only loading.
  - Keep runtime logs quiet (no download progress bars in normal runs).
  - Reuse model instances across calls.
"""

from __future__ import annotations

import logging
import os
from pathlib import Path

from sentence_transformers import SentenceTransformer

log = logging.getLogger(__name__)

_MODEL_CACHE: dict[str, SentenceTransformer] = {}


def _resolve_repo_id(model_name: str) -> str:
    model_name = (model_name or "").strip()
    if "/" in model_name:
        return model_name
    return f"sentence-transformers/{model_name}"


def _resolve_model_source(config: dict) -> str:
    model_name = config.get("embedding_model", "all-MiniLM-L6-v2")
    local_path = config.get("embedding_local_path", "models/all-MiniLM-L6-v2")
    local_dir = Path(local_path)

    if local_dir.exists() and any(local_dir.iterdir()):
        return str(local_dir)

    return model_name


def load_embedding_model(config: dict) -> SentenceTransformer:
    """
    Load and cache the embedding model.

    Config knobs:
      - embedding_model: model id (e.g. all-MiniLM-L6-v2)
      - embedding_local_path: local directory with predownloaded model files
      - embedding_local_only: if True, never fetch from network
      - embedding_quiet: if True, suppress progress bars
    """
    model_source = _resolve_model_source(config)
    local_only = bool(config.get("embedding_local_only", False))
    quiet = bool(config.get("embedding_quiet", True))

    cache_key = f"{model_source}|local_only={local_only}|quiet={quiet}"
    if cache_key in _MODEL_CACHE:
        return _MODEL_CACHE[cache_key]

    # Reduce tokenizer thread warning noise in terminals.
    os.environ.setdefault("TOKENIZERS_PARALLELISM", "false")
    if quiet:
        os.environ.setdefault("HF_HUB_DISABLE_PROGRESS_BARS", "1")

    try:
        model = SentenceTransformer(model_source, local_files_only=local_only)
    except Exception as e:
        if local_only:
            raise RuntimeError(
                "Embedding model not available locally. "
                "Run: python setup/download_embedding_model.py"
            ) from e
        raise

    _MODEL_CACHE[cache_key] = model
    log.info(f"Embedding model ready: {model_source} (local_only={local_only})")
    return model


def resolve_embedding_repo_and_target(config: dict) -> tuple[str, str]:
    """
    Return (repo_id, local_path) for predownload scripts.
    """
    model_name = config.get("embedding_model", "all-MiniLM-L6-v2")
    repo_id = _resolve_repo_id(model_name)
    local_path = config.get("embedding_local_path", "models/all-MiniLM-L6-v2")
    return repo_id, local_path
