"""
setup/download_data.py — Downloads Spider benchmark dataset.

Run this once before anything else:
    python setup/download_data.py

What it does:
  - Downloads Spider dataset (dev + train + SQLite databases)
  - Extracts everything into data/spider/
"""

import os
import zipfile
import urllib.request
import sys

SPIDER_URL = "https://drive.google.com/uc?export=download&id=1403EGqzIDoHMdQF4c9Bkyl7dZLZ5Wt6J"


DATA_DIR    = "data"
SPIDER_DIR  = os.path.join(DATA_DIR, "spider")


def download_file(url: str, dest: str):
    print(f"  Downloading {url[:60]}...")
    try:
        urllib.request.urlretrieve(url, dest)
        print(f"  Saved to {dest}")
    except Exception as e:
        print(f"  ERROR: {e}")
        print("  Please download manually. See instructions below.")
        return False
    return True


def extract_zip(zip_path: str, extract_to: str):
    print(f"  Extracting {zip_path} → {extract_to}")
    with zipfile.ZipFile(zip_path, "r") as z:
        z.extractall(extract_to)
    os.remove(zip_path)
    print("  Done.")


def check_spider():
    dev_path = os.path.join(SPIDER_DIR, "dev.json")
    train_path = os.path.join(SPIDER_DIR, "train_spider.json")
    db_path = os.path.join(SPIDER_DIR, "database")
    return os.path.exists(dev_path) and os.path.exists(train_path) and os.path.exists(db_path)

def print_manual_instructions():
    print("""
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
MANUAL DOWNLOAD INSTRUCTIONS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

SPIDER:
  1. Go to https://yale-lily.github.io/spider
  2. Download the full dataset ZIP
  3. Extract so you get:
       data/spider/dev.json
       data/spider/train_spider.json
       data/spider/database/   ← folder of SQLite files

After placing the files, re-run:
  python setup/download_data.py
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
""")


def main():
    os.makedirs(SPIDER_DIR, exist_ok=True)

    print("\n=== Spider ===")
    if check_spider():
        print("  Already present, skipping.")
    else:
        print("  Spider not found. Attempting download...")
        zip_path = os.path.join(DATA_DIR, "spider.zip")
        ok = download_file(SPIDER_URL, zip_path)
        if ok and os.path.exists(zip_path):
            extract_zip(zip_path, SPIDER_DIR)
        if not check_spider():
            print("  Auto-download failed for Spider (Google Drive requires browser auth).")
            print_manual_instructions()

    # Final status
    print("\n=== Status ===")
    print(f"  Spider:   {'✓ READY' if check_spider() else '✗ missing'}")
    print()


if __name__ == "__main__":
    main()