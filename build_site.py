"""BASIC 2 BASIC - builds the static reference site from the database.

The site is made only of HTML, CSS and JavaScript files: it opens with a
double click on site/index.html (no server needed) and can be published
as it is on any web space.

Usage:
    python build_site.py                       (basic2basic.db -> site/)
    python build_site.py basic2basic.db --output site

Requires Jinja2:  python -m pip install jinja2
"""

import argparse
import json
import re
import shutil
import sqlite3
import sys
from collections import defaultdict
from pathlib import Path

try:
    from jinja2 import Environment, FileSystemLoader, select_autoescape
    from markupsafe import Markup, escape
except ImportError:
    sys.exit("Jinja2 is missing: run  python -m pip install jinja2")

from render_syntax import Renderer

FOLDER = Path(__file__).resolve().parent

# ---------------------------------------------------------------------
# Syntax as HTML: keywords, parameters, literals and notation symbols get
# different classes. The pieces are marked with control characters while
# rendering and turned into <span> at the end, so the spacing logic stays
# the one of render_syntax.
# ---------------------------------------------------------------------
MARKS = {"\x01": "kw", "\x03": "par", "\x05": "lit"}
CLOSERS = {"\x01": "\x02", "\x03": "\x04", "\x05": "\x06"}
ALL_MARKS = "".join(MARKS) + "".join(CLOSERS.values())


def _plain(text):
    return text.translate({ord(c): None for c in ALL_MARKS})


class HtmlRenderer(Renderer):
    def render(self, node):
        kind = node["kind"]
        if kind == "LITERAL":
            return "\x05" + node["text"] + "\x06"
        if kind == "KEYWORD":
            return "\x01" + self.keywords[node["keyword_id"]] + "\x02"
        if kind == "PARAMETER":
            p = self.parameters[node["parameter_id"]]
            if p["construct_type_id"] is None or not self.expand:
                if p["construct_type_id"] is not None:
                    self.constructs_used.add(p["construct_type_id"])
                return "\x03" + p["name"] + "\x04"
        return super().render(node)

    def _join(self, pieces):
        out = ""
        for text, attached in pieces:
            if not text:
                continue
            bare, tail = _plain(text), _plain(out)
            needs_space = (
                tail
                and not attached
                and not bare.startswith((",", ";", ")"))
                and not tail.endswith("(")
            )
            out += (" " if needs_space else "") + text
        return out


def syntax_html(text):
    """Turns the marked string into HTML."""
    if text is None:
        return None
    out, i = [], 0
    while i < len(text):
        c = text[i]
        if c in MARKS:
            j = text.index(CLOSERS[c], i)
            out.append(f'<span class="{MARKS[c]}">{escape(text[i + 1:j])}</span>')
            i = j + 1
        elif text.startswith("...", i):
            out.append('<span class="meta">...</span>')
            i += 3
        elif c in "[]<>|":
            out.append(f'<span class="meta">{escape(c)}</span>')
            i += 1
        else:
            out.append(str(escape(c)))
            i += 1
    return Markup("".join(out))


def same_syntax(rendered, original):
    """True if the rendered syntax and the manual's one match (spaces ignored)."""
    if not rendered or not original:
        return None
    norm = lambda s: re.sub(r"\s+", "", s).upper()
    return norm(_plain(rendered)) == norm(original)


# ---------------------------------------------------------------------
# Page addresses (relative to the site root)
# ---------------------------------------------------------------------
SYMBOLS = {"$": "S", "*": "-star-", "/": "-slash-", "+": "-plus-", "-": "-minus-", "=": "-eq-",
           "<": "-lt-", ">": "-gt-", "(": "-lparen-", ")": "-rparen-", '"': "-quote-", ";": "-semicolon-",
           ",": "-comma-", ":": "-colon-", "?": "-question-", "!": "-excl-", "'": "-apos-", ".": "-dot-",
           "^": "-caret-", "\\": "-bslash-", "&": "-amp-", "#": "-hash-"}


def slug(text):
    if not re.search(r"[A-Za-z0-9]", text):          # operators: ** -> star-star
        text = "".join(SYMBOLS.get(c, "-") for c in text)
    else:
        text = text.replace("$", "S")
    return re.sub(r"[^A-Za-z0-9]+", "-", text).strip("-") or "x"


def entry_url(e):
    return f"entries/{slug(e['name'])}-{e['id']}.html"


def keyword_url(k):
    return f"keywords/{slug(k['text'])}-{k['id']}.html"


def dialect_url(d):
    return f"dialects/{d['code']}.html"


def machine_url(m):
    return f"machines/{m['code']}.html"


# ---------------------------------------------------------------------
# Reading the database
# ---------------------------------------------------------------------
class SiteData:
    def __init__(self, conn):
        conn.row_factory = sqlite3.Row
        self.conn = conn
        q = lambda sql, *a: [dict(r) for r in conn.execute(sql, a)]
        by_id = lambda rows: {r["id"]: r for r in rows}
        self.q = q

        self.machines = by_id(q("SELECT * FROM machine ORDER BY manufacturer, year, name"))
        self.dialects = by_id(q("SELECT * FROM dialect ORDER BY name, version"))
        self.layers = by_id(q("SELECT * FROM layer"))
        self.categories = by_id(q("SELECT * FROM category ORDER BY id"))
        try:
            self.operator_classes = by_id(q("SELECT * FROM operator_class ORDER BY position, id"))
        except sqlite3.OperationalError:      # database without operator classes
            self.operator_classes = {}
        self.type_classes = by_id(q("SELECT * FROM type_class"))
        self.table_kinds = by_id(q("SELECT * FROM table_kind"))
        self.data_types = by_id(q("SELECT * FROM data_type"))
        self.sources = by_id(q("SELECT * FROM source"))
        self.groups = by_id(q("SELECT * FROM action_group ORDER BY name"))
        self.actions = by_id(q("SELECT * FROM action ORDER BY code"))
        self.constructs = by_id(q("SELECT * FROM construct"))
        self.keywords = by_id(q("SELECT * FROM keyword"))
        self.entries = by_id(q("SELECT * FROM entry"))
        self.forms = by_id(q("SELECT * FROM syntax_form ORDER BY entry_id, position"))
        self.parameters = by_id(q("SELECT * FROM parameter ORDER BY id"))
        self.variable_kinds = by_id(q("SELECT * FROM variable_kind"))
        self.parameter_kinds = by_id(q("SELECT * FROM parameter_kind"))
        # parameter types accepted by each parameter (from its nodes, in tree order)
        self.parameter_node_kinds = defaultdict(list)
        for r in q("SELECT parameter_id, parameter_kind_id FROM syntax_node "
                   "WHERE parameter_id IS NOT NULL AND parameter_kind_id IS NOT NULL ORDER BY id"):
            if r["parameter_kind_id"] not in self.parameter_node_kinds[r["parameter_id"]]:
                self.parameter_node_kinds[r["parameter_id"]].append(r["parameter_kind_id"])

        self.machine_dialect = q("SELECT * FROM machine_dialect")
        self.stacks = defaultdict(list)        # dialect -> layers in order
        for r in q("SELECT * FROM dialect_layer ORDER BY position"):
            self.stacks[r["dialect_id"]].append(r)

        # active entries per dialect (layer view)
        self.dialect_entries = defaultdict(list)
        self.entry_dialects = defaultdict(list)
        for r in q("SELECT * FROM v_dialect_entry"):
            self.dialect_entries[r["dialect_id"]].append(r)
            self.entry_dialects[r["entry_id"]].append(r["dialect_id"])

        self.entry_forms = defaultdict(list)
        for f in self.forms.values():
            self.entry_forms[f["entry_id"]].append(f)
        self.form_parameters = defaultdict(list)
        for p in self.parameters.values():
            if p["form_id"] is not None:
                self.form_parameters[p["form_id"]].append(p)

        self.limits = defaultdict(list)
        for r in q("SELECT * FROM parameter_limit ORDER BY machine_id IS NOT NULL, id"):
            self.limits[r["parameter_id"]].append(r)
        self.allowed_values = defaultdict(list)
        for r in q("SELECT * FROM allowed_value ORDER BY id"):
            self.allowed_values[r["parameter_id"]].append(r)

        self.form_actions = defaultdict(list)
        self.action_forms = defaultdict(list)
        for r in q("SELECT * FROM form_action"):
            self.form_actions[r["form_id"]].append(r)
            self.action_forms[r["action_id"]].append(r)

        self.tokens = defaultdict(list)
        for r in q("SELECT * FROM token ORDER BY machine_id IS NOT NULL, machine_id"):
            self.tokens[r["keyword_id"]].append(r)
        self.abbreviations = defaultdict(list)
        for r in q("SELECT * FROM abbreviation ORDER BY machine_id IS NOT NULL, machine_id"):
            self.abbreviations[r["keyword_id"]].append(r)

        self.examples = defaultdict(list)
        for r in q("SELECT * FROM example ORDER BY entry_id, position"):
            self.examples[r["entry_id"]].append(r)
        self.references = q("SELECT * FROM reference")
        self.entry_sources = defaultdict(list)
        for r in q("SELECT * FROM entry_source"):
            self.entry_sources[r["entry_id"]].append(r)
        self.colors = defaultdict(list)
        for r in q("SELECT * FROM color ORDER BY code"):
            self.colors[r["machine_id"]].append(r)
        self.attributes = defaultdict(list)
        for r in q("SELECT * FROM attribute ORDER BY position, id"):
            self.attributes[r["machine_id"]].append(r)

        # tables that always exist, their state, and the one-off tables
        self.table_kinds_ordered = q("SELECT * FROM table_kind ORDER BY position, id")
        self.table_status = {}
        for r in q("SELECT * FROM table_status"):
            owner = ("L", r["layer_id"]) if r["layer_id"] is not None else ("M", r["machine_id"])
            self.table_status[(r["table_kind_id"],) + owner] = r
        self.custom_tables = q("SELECT * FROM custom_table ORDER BY position, id")
        self.custom_columns = defaultdict(list)
        for r in q("SELECT * FROM custom_column ORDER BY table_id, position"):
            self.custom_columns[r["table_id"]].append(r["header"])
        cells = defaultdict(dict)
        for r in q("SELECT * FROM custom_cell"):
            cells[r["row_id"]][r["column_position"]] = r["value"]
        self.custom_rows = defaultdict(list)
        for r in q("SELECT * FROM custom_row ORDER BY table_id, position"):
            n = len(self.custom_columns[r["table_id"]])
            self.custom_rows[r["table_id"]].append([cells[r["id"]].get(i + 1) for i in range(n)])

        # keywords of each dialect, and keywords used by each form (from the nodes)
        self.dialect_keywords = defaultdict(list)
        for r in q("SELECT * FROM v_dialect_keyword"):
            self.dialect_keywords[r["dialect_id"]].append(r["keyword_id"])
        self.form_keywords = defaultdict(list)
        for r in q("SELECT form_id, keyword_id FROM syntax_node "
                   "WHERE form_id IS NOT NULL AND keyword_id IS NOT NULL ORDER BY id"):
            if r["keyword_id"] not in self.form_keywords[r["form_id"]]:
                self.form_keywords[r["form_id"]].append(r["keyword_id"])

        self.renderer = HtmlRenderer(conn)
        self.renderer_expanded = HtmlRenderer(conn, expand=True)

    # --- layers ------------------------------------------------------
    def winning_entry(self, dialect_id, name, category_id):
        """Entry that wins in the dialect (even if REMOVE), or None."""
        position = {s["layer_id"]: s["position"] for s in self.stacks[dialect_id]}
        candidates = [e for e in self.entries.values()
                      if e["layer_id"] in position and e["name"].upper() == name.upper()
                      and e["category_id"] == category_id]
        return max(candidates, key=lambda e: position[e["layer_id"]], default=None)

    def active(self, view, column, dialect_id):
        return [r[column] for r in self.q(f"SELECT {column} FROM {view} WHERE dialect_id = ?",
                                          dialect_id)]

    def dialect_machines(self, dialect_id):
        return [r for r in self.machine_dialect if r["dialect_id"] == dialect_id]

    def table_states(self, layer_ids, machine_ids):
        """State of every always-present table for some layers and machines."""
        out = []
        for k in self.table_kinds_ordered:
            if k["scope"] == "DIALECT":
                owners = [(self.layers[i], self.table_status.get((k["id"], "L", i))) for i in layer_ids]
            else:
                owners = [(self.machines[i], self.table_status.get((k["id"], "M", i))) for i in machine_ids]
            out.append({"k": k, "owners": owners})
        return out

    def custom_for(self, layer_ids, machine_ids):
        return [{"t": t, "columns": self.custom_columns[t["id"]], "rows": self.custom_rows[t["id"]],
                 "owner": self.layers.get(t["layer_id"]) or self.machines.get(t["machine_id"])}
                for t in self.custom_tables
                if t["layer_id"] in layer_ids or t["machine_id"] in machine_ids]

    # --- syntax ------------------------------------------------------
    def form_syntax(self, form_id):
        self.renderer.constructs_used = set()
        raw = self.renderer.render_form(form_id)
        constructs = sorted(self.renderer.constructs_used)
        expanded = self.renderer_expanded.render_form(form_id) if constructs else None
        return raw, expanded, constructs

    def construct_syntax(self, construct_id):
        return syntax_html(self.renderer.render_construct(construct_id))


# ---------------------------------------------------------------------
# Page contexts
# ---------------------------------------------------------------------
def interval(minimum, maximum, min_inc=1, max_inc=1):
    if minimum is None and maximum is None:
        return None
    fmt = lambda x: ("%g" % x) if x is not None else "∞"
    a = ("[" if min_inc else "(") if minimum is not None else "("
    b = ("]" if max_inc else ")") if maximum is not None else ")"
    lo = fmt(minimum) if minimum is not None else "−∞"
    return f"{a}{lo}, {fmt(maximum)}{b}"


def keyword_tokens(d, kid):
    out = []
    for t in d.tokens[kid]:
        m = d.machines.get(t["machine_id"])
        out.append({"hex": t["hex_value"], "machine": m, "notes": t["notes"]})
    return out


def keyword_abbreviations(d, kid):
    return [{"text": a["text"], "machine": d.machines.get(a["machine_id"]), "notes": a["notes"]}
            for a in d.abbreviations[kid]]


def entry_context(d, e):
    active_dialects = [d.dialects[x] for x in d.entry_dialects[e["id"]]]

    # dialects that contain the entry's layer but where the entry has been
    # redefined or removed by a later layer
    replacements = []
    for did, stack in d.stacks.items():
        if any(s["layer_id"] == e["layer_id"] for s in stack) and did not in d.entry_dialects[e["id"]]:
            w = d.winning_entry(did, e["name"], e["category_id"])
            if w:
                replacements.append({"dialect": d.dialects[did], "entry": w,
                                     "layer": d.layers[w["layer_id"]]})

    forms = []
    for f in d.entry_forms[e["id"]]:
        raw, expanded, constructs = d.form_syntax(f["id"])
        parameters = []
        for p in d.form_parameters[f["id"]]:
            parameters.append({
                "p": p,
                "kinds": [d.parameter_kinds[k] for k in d.parameter_node_kinds[p["id"]]],
                "construct": d.constructs.get(p["construct_type_id"]),
                "table": d.table_kinds.get(p["table_kind_id"]),
                "limits": [{"text": interval(l["minimum"], l["maximum"], l["min_inclusive"], l["max_inclusive"]),
                            "machine": d.machines.get(l["machine_id"]), "notes": l["notes"]}
                           for l in d.limits[p["id"]]],
                "allowed": [{"value": x["value"], "meaning": x["meaning"],
                            "machine": d.machines.get(x["machine_id"])} for x in d.allowed_values[p["id"]]],
            })
        rtype = d.data_types.get(f["return_type_id"])
        actions = []
        for fa in d.form_actions[f["id"]]:
            equivalents = defaultdict(list)
            for other in d.action_forms[fa["action_id"]]:
                fb = d.forms[other["form_id"]]
                if fb["entry_id"] == e["id"]:
                    continue
                for did in d.entry_dialects[fb["entry_id"]]:
                    if did in d.entry_dialects[e["id"]]:
                        continue
                    equivalents[did].append({"entry": d.entries[fb["entry_id"]], "form": fb,
                                             "coverage": other["coverage"], "notes": other["notes"]})
            uncovered = [x for x in d.dialects.values()
                         if x["id"] not in equivalents and x["id"] not in d.entry_dialects[e["id"]]]
            actions.append({
                "action": d.actions[fa["action_id"]], "coverage": fa["coverage"], "notes": fa["notes"],
                "equivalents": [(d.dialects[k], equivalents[k]) for k in d.dialects if k in equivalents],
                "uncovered": uncovered,
            })
        forms.append({
            "f": f,
            "syntax": syntax_html(raw),
            "expanded": syntax_html(expanded),
            "constructs": [{"c": d.constructs[c], "syntax": d.construct_syntax(c)} for c in constructs],
            "matches": same_syntax(raw, f["original_syntax"]),
            "source": d.sources.get(f["source_id"]),
            "rtype": rtype,
            "rtype_class": d.type_classes.get(rtype["type_class_id"]) if rtype else None,
            "ret": interval(f["return_min"], f["return_max"], f["return_min_inclusive"], f["return_max_inclusive"]),
            "op_class": d.operator_classes.get(f.get("operator_class_id")),
            "parameters": parameters,
            "actions": actions,
        })

    # keywords: from the syntax tree, otherwise from the entry name
    kids = []
    for f in d.entry_forms[e["id"]]:
        for kid in d.form_keywords[f["id"]]:
            if kid not in kids:
                kids.append(kid)
    if not kids:
        pieces = [p.strip().upper() for p in e["name"].split("...") if p.strip()]
        for did in d.entry_dialects[e["id"]]:
            for kid in d.active("v_dialect_keyword", "keyword_id", did):
                if d.keywords[kid]["text"].upper() in pieces and kid not in kids:
                    kids.append(kid)
        kids.sort(key=lambda k: pieces.index(d.keywords[k]["text"].upper()))
    keywords = [{"k": d.keywords[k], "tokens": keyword_tokens(d, k), "abbr": keyword_abbreviations(d, k)}
                for k in kids]

    references = []
    for r in d.references:
        if r["entry_id"] == e["id"]:
            label = "Closed by" if r["kind"] == "OPENS_BLOCK" else "See also"
            references.append((label, d.entries[r["related_entry_id"]]))
        elif r["related_entry_id"] == e["id"]:
            label = "Opened by" if r["kind"] == "OPENS_BLOCK" else "See also"
            references.append((label, d.entries[r["entry_id"]]))

    examples = [{"x": x, "machine": d.machines.get(x["machine_id"]), "form": d.forms.get(x["form_id"]),
                 "source": d.sources.get(x["source_id"])}
                for x in d.examples[e["id"]]]
    sources = [{"source": d.sources[x["source_id"]], "page": x["page"], "notes": x["notes"]}
               for x in d.entry_sources[e["id"]]]

    return {
        "e": e,
        "category": d.categories[e["category_id"]],
        "layer": d.layers[e["layer_id"]],
        "previous": d.entries.get(e["redefines_id"]),
        "later": [x for x in d.entries.values() if x["redefines_id"] == e["id"]],
        "dialects": active_dialects,
        "replacements": replacements,
        "forms": forms,
        "keywords": keywords,
        "references": references,
        "examples": examples,
        "sources": sources,
    }


def dialect_context(d, dia):
    did = dia["id"]
    stack = [{"position": s["position"], "layer": d.layers[s["layer_id"]]} for s in d.stacks[did]]
    machines = [{"m": d.machines[r["machine_id"]], "r": r} for r in d.dialect_machines(did)]

    entries = [d.entries[r["entry_id"]] for r in d.dialect_entries[did]]
    by_category = []
    for c in d.categories.values():
        items = sorted((x for x in entries if x["category_id"] == c["id"]), key=lambda x: x["name"].upper())
        if not items:
            continue
        rows = [{"e": x, "layer": d.layers[x["layer_id"]]} for x in items]
        # operators: subgroups by class (an entry appears under every class of its forms)
        subgroups = []
        if c["code"] == "OPERATOR" and d.operator_classes:
            by_class = defaultdict(list)
            for r in rows:
                forms = d.entry_forms[r["e"]["id"]]
                classes = []
                for f in forms:
                    k = f.get("operator_class_id")
                    if k not in classes:
                        classes.append(k)
                for k in classes:
                    titles = ([f["title"] for f in forms if f.get("operator_class_id") == k and f["title"]]
                              if len(classes) > 1 else [])
                    by_class[k].append(dict(r, titles=titles))
            order = [k for k in d.operator_classes if k in by_class] + ([None] if None in by_class else [])
            subgroups = [(d.operator_classes.get(k), by_class[k]) for k in order]
        by_category.append((c, rows, subgroups))

    # keywords with the effective token on each machine that hosts the dialect
    machine_tokens = defaultdict(dict)
    for r in d.q("SELECT * FROM v_machine_token WHERE dialect_id = ?", did):
        machine_tokens[r["keyword_id"]][r["machine_id"]] = r["hex_value"]
    keywords = []
    for kid in d.active("v_dialect_keyword", "keyword_id", did):
        k = d.keywords[kid]
        keywords.append({"k": k, "layer": d.layers[k["layer_id"]],
                         "tokens": [machine_tokens[kid].get(m["m"]["id"]) for m in machines],
                         "abbr": keyword_abbreviations(d, kid)})
    keywords.sort(key=lambda x: x["k"]["text"].upper())

    types = [d.data_types[t] for t in d.active("v_dialect_data_type", "data_type_id", did)]
    types = [{"t": t, "type_class": d.type_classes[t["type_class_id"]],
              "interval": interval(t["minimum"], t["maximum"])} for t in types]
    errors = d.q("SELECT e.* FROM v_dialect_error x JOIN error e ON e.id = x.error_id "
                 "WHERE x.dialect_id = ? ORDER BY e.number, e.code", did)
    features = d.q("SELECT f.* FROM v_dialect_feature x JOIN feature f "
                   "ON f.id = x.feature_id WHERE x.dialect_id = ? ORDER BY f.code", did)
    constructs = [{"c": d.constructs[c], "syntax": d.construct_syntax(c)}
                  for c in d.active("v_dialect_construct", "construct_id", did)]
    variable_kinds = [{"v": d.variable_kinds[v], "type": d.data_types[d.variable_kinds[v]["data_type_id"]],
                       "fields": d.q("SELECT * FROM variable_layout_field WHERE variable_kind_id = ? ORDER BY position", v)}
                      for v in sorted(d.active("v_dialect_variable_kind", "variable_kind_id", did))]
    program_layout = d.q("SELECT p.* FROM v_dialect_program_layout x JOIN program_layout_field p ON p.id = x.field_id "
                         "WHERE x.dialect_id = ? ORDER BY p.position", did)
    key_codes = d.q("SELECT k.*, kw.text AS keyword_text FROM v_dialect_key_code x JOIN key_code k ON k.id = x.key_code_id "
                    "LEFT JOIN keyword kw ON kw.id = k.keyword_id WHERE x.dialect_id = ? ORDER BY k.id", did)
    musical_notes = d.q("SELECT n.* FROM v_dialect_musical_note x JOIN musical_note n ON n.id = x.musical_note_id "
                        "WHERE x.dialect_id = ? ORDER BY n.octave, n.id", did)
    parameter_kinds = [{"p": d.parameter_kinds[p],
                        "type_class": d.type_classes.get(d.parameter_kinds[p]["type_class_id"]),
                        "variable_kind": d.variable_kinds.get(d.parameter_kinds[p]["variable_kind_id"])}
                       for p in sorted(d.active("v_dialect_parameter_kind", "parameter_kind_id", did))]

    # operator precedence: one row per level, highest first
    # (forms of an entry at the same level are shown once; the form title
    # appears if the entry has forms at different levels)
    levels = defaultdict(list)
    for x in entries:
        forms = d.entry_forms[x["id"]]
        per_level = defaultdict(list)
        for f in forms:
            if f.get("precedence") is not None:
                per_level[f["precedence"]].append(f)
        for p, items in per_level.items():
            titles = [f["title"] for f in items if f["title"]] if len(per_level) > 1 else []
            levels[p].append({"e": x, "titles": titles, "order": items[0]["id"],
                              "assoc": items[0].get("associativity")})
    operators = [(p, sorted(levels[p], key=lambda o: o["order"])) for p in sorted(levels, reverse=True)]

    # character sets of the machines that host the dialect, with the effective glyphs
    charsets = []
    try:
        rows = d.q("SELECT * FROM v_character WHERE dialect_id = ? ORDER BY charset_id, code", did)
    except sqlite3.OperationalError:          # database without the glyph tables
        rows = []
    by_set = defaultdict(list)
    for r in rows:
        by_set[r["charset_id"]].append(r)
    for sid, glyphs in by_set.items():
        cs = d.q("SELECT * FROM charset WHERE id = ?", sid)[0]
        charsets.append({"s": cs, "machine": d.machines[cs["machine_id"]], "glyphs": glyphs,
                         "rows": [glyphs[i:i + 16] for i in range(0, len(glyphs), 16)]})

    with_examples = sum(1 for x in entries if d.examples[x["id"]])
    examples_to_verify = sum(1 for x in entries for y in d.examples[x["id"]] if not y["verified"])
    layer_ids = [s["layer_id"] for s in d.stacks[did]]
    machine_ids = [m["m"]["id"] for m in machines]
    tables = d.table_states(layer_ids, machine_ids)
    custom = d.custom_for(layer_ids, machine_ids)

    return {"dia": dia, "stack": stack, "charsets": charsets, "machines": machines, "by_category": by_category,
            "tables": tables, "custom": custom, "program_layout": program_layout,
            "with_examples": with_examples, "examples_to_verify": examples_to_verify,
            "key_codes": key_codes, "musical_notes": musical_notes,
            "n_entries": len(entries), "keywords": keywords, "types": types, "errors": errors,
            "features": features, "constructs": constructs, "operators": operators,
            "variable_kinds": variable_kinds, "parameter_kinds": parameter_kinds}


def keyword_context(d, k):
    """Entries that use the keyword in their syntax tree."""
    dialects = [d.dialects[did] for did in d.dialects if k["id"] in d.dialect_keywords[did]]
    forms_by_entry = defaultdict(list)
    for fid, kids in d.form_keywords.items():
        if k["id"] in kids:
            forms_by_entry[d.forms[fid]["entry_id"]].append(d.forms[fid])
    # entries without a syntax tree: recognized by their name (FOR...TO -> FOR, TO)
    with_tree = {d.forms[f]["entry_id"] for f in d.form_keywords}
    for e in d.entries.values():
        if e["id"] in with_tree or e["id"] in forms_by_entry:
            continue
        pieces = [x.strip().upper() for x in e["name"].split("...")]
        if k["text"].upper() in pieces and any(k["id"] in d.dialect_keywords[x] for x in d.entry_dialects[e["id"]]):
            forms_by_entry[e["id"]] = list(d.entry_forms[e["id"]])
    entries = []
    for eid, forms in forms_by_entry.items():
        e = d.entries[eid]
        items = []
        for f in sorted(forms, key=lambda f: f["position"]):
            raw, _, _ = d.form_syntax(f["id"])
            items.append({"f": f, "syntax": syntax_html(raw)})
        entries.append({"e": e, "category": d.categories[e["category_id"]], "forms": items,
                        "dialects": [d.dialects[x] for x in d.entry_dialects[eid]]})
    entries.sort(key=lambda x: (x["category"]["id"], x["e"]["name"].upper()))
    return {"k": k, "layer": d.layers[k["layer_id"]], "dialects": dialects,
            "tokens": keyword_tokens(d, k["id"]), "abbr": keyword_abbreviations(d, k["id"]), "entries": entries}


def machine_context(d, m):
    dialects = [{"d": d.dialects[r["dialect_id"]], "r": r,
                 "n_entries": len(d.dialect_entries[r["dialect_id"]])}
                for r in d.machine_dialect if r["machine_id"] == m["id"]]
    dialects.sort(key=lambda x: (-x["r"]["is_default"], x["d"]["name"]))
    tables = [t for t in d.table_states([], [m["id"]]) if t["k"]["scope"] == "MACHINE"]
    return {"m": m, "dialects": dialects, "colors": d.colors[m["id"]], "attributes": d.attributes[m["id"]],
            "tables": tables, "custom": d.custom_for([], [m["id"]])}


def actions_context(d):
    dialects = list(d.dialects.values())
    groups = []
    for g in list(d.groups.values()) + [None]:
        rows = []
        for a in d.actions.values():
            if (a["group_id"] if g else None) != (g["id"] if g else None):
                continue
            if g is None and a["group_id"] in d.groups:
                continue
            cells = defaultdict(list)
            for fa in d.action_forms[a["id"]]:
                f = d.forms[fa["form_id"]]
                for did in d.entry_dialects[f["entry_id"]]:
                    cells[did].append({"entry": d.entries[f["entry_id"]], "form": f, "coverage": fa["coverage"]})
            if not cells:
                continue          # action that no dialect implements: not shown
            rows.append({"a": a, "cells": [cells.get(x["id"], []) for x in dialects],
                         "dialects": sorted(cells)})
        if rows:
            groups.append((g, rows))
    return {"dialects": dialects, "groups": groups}


def translator_data(d):
    """Compact data for translator.js."""
    forms = {}
    for f in d.forms.values():
        if not d.entry_dialects[f["entry_id"]]:
            continue
        raw, _, _ = d.form_syntax(f["id"])
        forms[f["id"]] = {
            "e": f["entry_id"], "t": f["title"],
            "s": str(syntax_html(raw)) if raw else None,
            "o": f["original_syntax"],
            "a": [[x["action_id"], x["coverage"], x["notes"]] for x in d.form_actions[f["id"]]],
        }
    entries = {e["id"]: {"n": e["name"], "c": d.categories[e["category_id"]]["name"], "u": entry_url(e),
                         "f": [f["id"] for f in d.entry_forms[e["id"]] if f["id"] in forms]}
               for e in d.entries.values() if d.entry_dialects[e["id"]]}
    return {
        "dialects": [{"id": x["id"], "c": x["code"], "n": dialect_name(x),
                      "e": sorted((r["entry_id"] for r in d.dialect_entries[x["id"]]),
                                  key=lambda i: d.entries[i]["name"].upper())}
                     for x in d.dialects.values()],
        "entries": entries,
        "forms": forms,
        "actions": {a["id"]: {"c": a["code"], "n": a["name"]} for a in d.actions.values()},
        "ed": {e: d.entry_dialects[e] for e in entries},
    }


def search_index(d):
    items = []
    for e in d.entries.values():
        dial = [d.dialects[x]["code"] for x in d.entry_dialects[e["id"]]]
        if not dial:
            continue
        items.append({"t": e["name"], "k": d.categories[e["category_id"]]["name"],
                      "d": (e["description"] or "") + " — " + ", ".join(dial), "u": entry_url(e)})
    out = items
    out += [{"t": m["name"], "k": "Machine", "d": " ".join(filter(None, [m["manufacturer"], str(m["year"] or "")])),
             "u": machine_url(m)} for m in d.machines.values()]
    out += [{"t": dialect_name(x), "k": "Dialect", "d": x["code"], "u": dialect_url(x)}
            for x in d.dialects.values()]
    out += [{"t": a["code"], "k": "Action", "d": a["name"], "u": "actions.html#" + a["code"]}
            for a in d.actions.values()]
    for k in d.keywords.values():
        dial = [x["code"] for x in d.dialects.values() if k["id"] in d.dialect_keywords[x["id"]]]
        if dial:
            out.append({"t": k["text"], "k": "Keyword", "d": ", ".join(dial), "u": keyword_url(k)})
    # tokens: useful to recognize a byte in a tokenized listing
    for kid, toks in d.tokens.items():
        k = d.keywords[kid]
        dial = [x for x in d.dialects.values() if kid in
                d.active("v_dialect_keyword", "keyword_id", x["id"])]
        for t in toks:
            for x in dial:
                out.append({"t": "$" + t["hex_value"], "k": "Token",
                            "d": f"{k['text']} — {x['code']}"
                                 + (f" ({d.machines[t['machine_id']]['name']})" if t["machine_id"] else ""),
                            "u": keyword_url(k)})
    return out


# Plural category names for the entry menu
PLURALS = {"Statement": "Statements", "Direct command": "Direct commands", "Function": "Functions",
           "Operator": "Operators", "System variable": "System variables",
           "Reserved variable": "Reserved variables"}


def plural(name):
    return PLURALS.get(name, name)


def dialect_name(x):
    return x["name"] + (" " + x["version"] if x["version"] and x["version"] not in x["name"] else "")


# ---------------------------------------------------------------------
# Writing
# ---------------------------------------------------------------------
def main():
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("database", nargs="?", default=str(FOLDER / "basic2basic.db"))
    ap.add_argument("--output", default=str(FOLDER / "site"), help="site folder (it is rebuilt)")
    args = ap.parse_args()

    if not Path(args.database).exists():
        sys.exit(f"Database not found: {args.database}")
    d = SiteData(sqlite3.connect(args.database))

    env = Environment(loader=FileSystemLoader(FOLDER / "templates"),
                      autoescape=select_autoescape(["html"]), trim_blocks=True, lstrip_blocks=True)
    env.globals.update(entry_url=entry_url, dialect_url=dialect_url, machine_url=machine_url,
                       dialect_name=dialect_name, plural=plural, keyword_url=keyword_url)
    env.filters["codepoint"] = lambda t: " ".join("U+%04X" % ord(c) for c in (t or ""))

    output = Path(args.output)
    if output.exists():
        if not (output / "index.html").exists():
            sys.exit(f"{output} exists and does not look like a generated site: not deleting it.")
        shutil.rmtree(output)
    for sub in ("entries", "dialects", "machines", "keywords"):
        (output / sub).mkdir(parents=True)
    shutil.copytree(FOLDER / "static", output / "static")

    count = 0

    def write_page(path, template, **ctx):
        nonlocal count
        root = "../" * path.count("/")
        html = env.get_template(template).render(root=root, page=path, **ctx)
        (output / path).write_text(html, encoding="utf-8")
        count += 1

    machines = [machine_context(d, m) for m in d.machines.values()]
    manufacturers = defaultdict(list)
    for m in machines:
        manufacturers[m["m"]["manufacturer"] or "Others"].append(m)
    write_page("index.html", "index.html", manufacturers=sorted(manufacturers.items()),
               dialects=[{"d": x, "n_entries": len(d.dialect_entries[x["id"]])} for x in d.dialects.values()],
               n_entries=len([e for e in d.entries.values() if d.entry_dialects[e["id"]]]), n_actions=len(d.actions))

    for ctx in machines:
        write_page(machine_url(ctx["m"]), "machine.html", **ctx)
    # previous/next navigation: in each dialect, entries follow the order of the
    # dialect page (by category; operators by class), each entry once
    nav = defaultdict(list)
    for x in d.dialects.values():
        ctx = dialect_context(d, x)
        write_page(dialect_url(x), "dialect.html", **ctx)
        order = []
        for c, rows, subgroups in ctx["by_category"]:
            items = [r["e"] for _, sg in subgroups for r in sg] if subgroups else [r["e"] for r in rows]
            order += [e for e in items if e not in order]
        for i, e in enumerate(order):
            nav[e["id"]].append({"dialect": x, "position": i + 1, "total": len(order),
                                 "prev": order[i - 1] if i > 0 else None,
                                 "next": order[i + 1] if i + 1 < len(order) else None})
    for e in d.entries.values():
        write_page(entry_url(e), "entry.html", nav=nav[e["id"]], **entry_context(d, e))
    for k in d.keywords.values():
        write_page(keyword_url(k), "keyword.html", **keyword_context(d, k))
    write_page("actions.html", "actions.html", **actions_context(d))
    write_page("translator.html", "translator.html")

    js = lambda name, var, obj: (output / "static" / name).write_text(
        f"window.{var} = " + json.dumps(obj, ensure_ascii=False, separators=(",", ":")) + ";\n",
        encoding="utf-8")
    js("search_index.js", "SEARCH_INDEX", search_index(d))
    js("translator_data.js", "TRANSLATOR_DATA", translator_data(d))

    print(f"Site built in {output}: {count} pages. Open {output / 'index.html'}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
