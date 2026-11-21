"""BASIC 2 BASIC - rebuilds the syntax of the entries from their syntax trees.

Notation produced:
    [ ]      optional part
    < | >    choices (exactly one)
    ...      the preceding expression can be repeated
    everything else is literal

Usage:
    python render_syntax.py basic2basic.db
    python render_syntax.py basic2basic.db --dialect CBM_BASIC_7.0
    python render_syntax.py basic2basic.db --entry BOX --expand

--expand replaces the parameters whose type is a construct with its grammar.
"""

import argparse
import sqlite3
import sys

ATTACHED_PUNCTUATION = (",", ";", ")")


class Renderer:
    def __init__(self, conn, expand=False):
        self.expand = expand
        conn.row_factory = sqlite3.Row
        self.nodes = {r["id"]: r for r in conn.execute("SELECT * FROM syntax_node")}
        self.children = {}
        for r in sorted(self.nodes.values(), key=lambda r: r["position"]):
            self.children.setdefault(r["parent_id"], []).append(r)
        self.keywords = {r["id"]: r["text"] for r in conn.execute("SELECT id, text FROM keyword")}
        self.parameters = {r["id"]: r for r in conn.execute("SELECT * FROM parameter")}
        self.construct_root = {
            r["construct_id"]: r for r in self.nodes.values()
            if r["construct_id"] is not None and r["parent_id"] is None
        }
        self.form_root = {
            r["form_id"]: r for r in self.nodes.values()
            if r["form_id"] is not None and r["parent_id"] is None
        }
        self.constructs_used = set()

    # --- helpers -----------------------------------------------------
    def _join(self, pieces):
        """pieces: list of (text, attached). Inserts the spaces."""
        out = ""
        for text, attached in pieces:
            if not text:
                continue
            needs_space = (
                out
                and not attached
                and not text.startswith(ATTACHED_PUNCTUATION)
                and not out.endswith("(")
            )
            out += (" " if needs_space else "") + text
        return out

    def _has_own_separator(self, node):
        if node["only_if_preceded"]:
            return True
        children = self.children.get(node["id"], [])
        return bool(children) and children[0]["only_if_preceded"] == 1

    def _options(self, children):
        """Rendered choices without repetitions: choices that differ only in the
        parameter type (e.g. numeric or string expression) are written once."""
        out = []
        for c in children:
            text = self.render(c)
            if text not in out:
                out.append(text)
        return out

    # --- rendering ---------------------------------------------------
    def render(self, node):
        kind = node["kind"]
        children = self.children.get(node["id"], [])

        if kind == "SEQUENCE":
            return self._join([(self.render(c), c["attached"]) for c in children])

        if kind == "CHOICE":
            options = self._options(children)
            return options[0] if len(options) == 1 else "<" + " | ".join(options) + ">"

        if kind == "OPTIONAL":
            child = children[0]
            if child["kind"] == "CHOICE":
                options = self._options(self.children.get(child["id"], []))
                return "[" + " | ".join(options) + "]"
            return "[" + self.render(child) + "]"

        if kind == "REPEAT":
            item = self.render(children[0])
            sep = node["separator"] or ""
            if (node["min_occ"] or 0) >= 1:
                return f"{item}[{sep}{item}]..."
            if sep:
                return f"[{item}[{sep}{item}]...]"
            return f"[{item}]..."

        if kind == "LIST":
            pieces = []
            for i, c in enumerate(children):
                body = self.render(c)
                if i > 0 and not self._has_own_separator(c):
                    body = (node["separator"] or "") + body
                pieces.append("[" + body + "]")
            return "".join(pieces)

        if kind == "LITERAL":
            return node["text"]

        if kind == "KEYWORD":
            return self.keywords[node["keyword_id"]]

        if kind == "PARAMETER":
            p = self.parameters[node["parameter_id"]]
            if p["construct_type_id"] is not None:
                self.constructs_used.add(p["construct_type_id"])
                if self.expand:
                    return self.render(self.construct_root[p["construct_type_id"]])
            return p["name"]

        if kind == "CONSTRUCT":
            self.constructs_used.add(node["construct_ref_id"])
            return self.render(self.construct_root[node["construct_ref_id"]])

        raise ValueError(f"Unknown node kind: {kind} (node {node['id']})")

    def render_form(self, form_id):
        root = self.form_root.get(form_id)
        return None if root is None else self.render(root)

    def render_construct(self, construct_id):
        return self.render(self.construct_root[construct_id])


def main():
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("database")
    ap.add_argument("--dialect", help="dialect code (e.g. CBM_BASIC_7.0)")
    ap.add_argument("--entry", help="entry name (e.g. BOX)")
    ap.add_argument("--expand", action="store_true", help="expand the constructs")
    args = ap.parse_args()

    conn = sqlite3.connect(args.database)
    renderer = Renderer(conn, expand=args.expand)

    sql = """
        SELECT DISTINCT d.code AS dialect, e.name AS entry, f.id AS form_id,
               f.position, f.title, f.original_syntax
        FROM v_dialect_entry de
        JOIN dialect d     ON d.id = de.dialect_id
        JOIN entry e       ON e.id = de.entry_id
        JOIN syntax_form f ON f.entry_id = e.id
        WHERE (:dialect IS NULL OR d.code = :dialect)
          AND (:entry IS NULL OR e.name = :entry COLLATE NOCASE)
        ORDER BY d.code, e.name, f.position
    """
    rows = conn.execute(sql, {"dialect": args.dialect, "entry": args.entry}).fetchall()
    if not rows:
        print("No form found.", file=sys.stderr)
        return 1

    for r in rows:
        rendered = renderer.render_form(r["form_id"])
        title = f" ({r['title']})" if r["title"] else ""
        print(f"[{r['dialect']}] {r['entry']}{title}")
        print(f"  rendered : {rendered if rendered else '(syntax tree not entered yet)'}")
        if r["original_syntax"]:
            print(f"  manual   : {r['original_syntax']}")
        print()

    if renderer.constructs_used and not args.expand:
        conn.row_factory = sqlite3.Row
        for cid in sorted(renderer.constructs_used):
            c = conn.execute("SELECT code, name FROM construct WHERE id = ?", (cid,)).fetchone()
            print(f"Construct {c['code']} ({c['name']}):")
            print(f"  {renderer.render_construct(cid)}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
