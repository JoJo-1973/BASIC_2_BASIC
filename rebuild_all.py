"""BASIC 2 BASIC - rebuilds everything from scratch.

Runs, in order:
    1. every data source in data/*.py   (each writes its own data/*.sql)
    2. build_database.py                 (rebuilds basic2basic.db from schema.sql and data/*.sql)
    3. build_site.py                     (rebuilds site/ from the database)

Usage:
    python rebuild_all.py            -> everything
    python rebuild_all.py --no-site  -> data and database only

Disconnect the database in Letos before running it: build_database.py empties
and refills basic2basic.db.
"""

import argparse
import subprocess
import sys
import time
from pathlib import Path

FOLDER = Path(__file__).resolve().parent


def run(label, script, *args):
    print(f"\n=== {label}", flush=True)
    start = time.time()
    result = subprocess.run([sys.executable, str(script), *args], cwd=FOLDER)
    if result.returncode != 0:
        print(f"\nStopped: {script.relative_to(FOLDER)} failed (exit code {result.returncode}).", file=sys.stderr)
        sys.exit(result.returncode)
    print(f"    done in {time.time() - start:.1f} s", flush=True)


def main():
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--no-site", action="store_true", help="do not rebuild the site")
    args = ap.parse_args()

    sources = sorted((FOLDER / "data").glob("*.py"))
    if not sources:
        print("No data sources found in data/.", file=sys.stderr)
    for source in sources:
        run(f"Data: {source.name}", source)

    run("Database", FOLDER / "build_database.py")
    if not args.no_site:
        run("Site", FOLDER / "build_site.py")

    print("\nEverything rebuilt.")
    return 0


if __name__ == "__main__":
    sys.exit(main())
