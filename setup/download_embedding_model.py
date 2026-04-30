"""
setup/download_embedding_model.py — Predownload embedding model locally.

Usage:
  python setup/download_embedding_model.py
"""

import os
import sys

sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

from huggingface_hub import snapshot_download

from src.utils import load_config
from src.embeddings import resolve_embedding_repo_and_target


def main() -> None:
    config = load_config()
    repo_id, local_path = resolve_embedding_repo_and_target(config)

    os.makedirs(local_path, exist_ok=True)

    print(f"Downloading {repo_id} to {local_path} ...")
    snapshot_download(
        repo_id=repo_id,
        local_dir=local_path,
    )
    print("Done.")


if __name__ == "__main__":
    main()
