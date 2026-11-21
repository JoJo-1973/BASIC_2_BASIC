"""BASIC 2 BASIC - rebuilds the database from the SQL scripts.

Usage:
    python build_database.py            -> schema + data/base.sql + all the other data/*.sql
    python build_database.py --empty    -> schema + data/base.sql
    python build_database.py --test     -> schema + data/base.sql + test_data.sql
    python build_database.py --file other.db

WARNING: if the file exists, all its contents are erased and rebuilt from the
scripts. Changes made by hand in Letos and not copied into the scripts are lost.

The file is not deleted but emptied (tables, views, indexes, triggers), so no
delete permission is needed. Disconnect the database in Letos before running
the script and reconnect it afterwards.
"""

import argparse
import os
import sqlite3
import sys

FOLDER = os.path.dirname(os.path.abspath(__file__))
DATA = os.path.join(FOLDER, "data")


def empty(conn):
    """Drops every object in the database without deleting the file."""
    conn.execute("PRAGMA foreign_keys = OFF")
    objects = conn.execute(
        "SELECT type, name FROM sqlite_master "
        "WHERE name NOT LIKE 'sqlite_%' AND type IN ('view','trigger','table')"
    ).fetchall()
    order = {"view": 0, "trigger": 1, "table": 2}
    for kind, name in sorted(objects, key=lambda o: order[o[0]]):
        conn.execute(f'DROP {kind.upper()} IF EXISTS "{name}"')
    conn.commit()
    conn.execute("VACUUM")


def scripts_to_load(args):
    scripts = [os.path.join(FOLDER, "schema.sql"), os.path.join(DATA, "base.sql")]
    if args.test:
        scripts.append(os.path.join(FOLDER, "test_data.sql"))
    elif not args.empty:
        others = sorted(f for f in os.listdir(DATA)
                        if f.endswith(".sql") and f != "base.sql")
        scripts += [os.path.join(DATA, f) for f in others]
    return scripts


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--file", default=os.path.join(FOLDER, "basic2basic.db"))
    group = ap.add_mutually_exclusive_group()
    group.add_argument("--empty", action="store_true", help="schema and base data only")
    group.add_argument("--test", action="store_true", help="test data instead of the dialects")
    args = ap.parse_args()

    conn = sqlite3.connect(args.file)
    empty(conn)
    conn.execute("PRAGMA foreign_keys = ON")
    for path in scripts_to_load(args):
        with open(path, encoding="utf-8") as f:
            conn.executescript(f.read())
        print(f"loaded {os.path.relpath(path, FOLDER)}")

    errors = conn.execute("PRAGMA foreign_key_check").fetchall()
    if errors:
        print("Invalid foreign keys:", errors, file=sys.stderr)
        return 1
    conn.close()
    print(f"created {args.file}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
