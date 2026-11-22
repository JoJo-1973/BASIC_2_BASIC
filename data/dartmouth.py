"""BASIC 2 BASIC - data source for Dartmouth BASIC, editions 1 to 4 (1964-1968).

Generates data/dartmouth.sql:   python data/dartmouth.py

The four editions are layers of one stack:
    DARTMOUTH_1ED_core   1st edition, May 1964      (GE-225, then GE-235)
    DARTMOUTH_2ED_layer  2nd edition, October 1964  (GE-235)
    DARTMOUTH_3ED_layer  3rd edition, 1966          (GE-235)
    DARTMOUTH_4ED_layer  4th edition, January 1968  (GE-635)
and there is one dialect per edition (1 = core; 2 = core + 2nd; ...). A fifth layer,
    DARTMOUTH_CARD_layer Card BASIC, October 1964   (GE-235, punched cards)
sits on the 2nd edition (core + 2nd + Card): a branch of the stack, so the generator
keeps the state of each layer and starts every layer from the state of the one below.

Syntax trees use the same small language as data/zx80.py and data/fx700p.py:
    S(...)  sequence          C(...)  choice            O(x)  optional
    R(x, sep=",", min=1)      repeat
    K("PRINT")  keyword       L(",")  literal           P("name", "NUM_EXPR")  parameter
Common options: att=True (attached to the previous item), meaning="...".

Sources (see SOURCES): [1] the May 1964 manual is Part I only: the four statements of
Part II (GOSUB, RETURN, DIM, REM), RND, INT and the arrays are taken from the October
1964 manual [2] and marked INFERRED ("ev": parameters and forms; notes elsewhere).
The 3rd edition manual is not available: its layer comes from the GE manual [3]
(Dartmouth's BASIC as sold by GE on the GE-235, rev. January 1967) and from
Wikipedia [5]; facts found only in one of them say so. The 4th edition comes
from the Dartmouth manual [4]. Nothing has been tested: features, errors and
examples are all to verify (the DTSS-Win simulator [8] can be used for that).

Every explicit id is ID + n, so that the rows never collide with those of the
other dialects (zx80: 1, 2, 3...; fx700p: 100000 + n).
"""

import copy
import os

ID = 200000                       # offset of every explicit id of this dialect

# ---------------------------------------------------------------------
# References to the base data (data/base.sql)
# ---------------------------------------------------------------------
TYPE_CLASS = {"NUMERIC": 1, "INTEGER": 2, "REAL": 3, "STRING": 4, "ANY": 5, "BOOLEAN": 6}
CATEGORY = {"STATEMENT": 1, "COMMAND": 2, "FUNCTION": 3, "OPERATOR": 4,
            "SYSTEM_VARIABLE": 5, "RESERVED_VARIABLE": 6}
OPERATOR_CLASS = {"ARITHMETIC": 1, "BITWISE": 2, "CONDITIONAL": 3, "LOGICAL": 4, "MEMORY": 5,
                  "RELATIONAL": 6, "STRING": 7, "GROUPING": 8}

# ---------------------------------------------------------------------
# Sources
# ---------------------------------------------------------------------
SRC_MAY64, SRC_OCT64, SRC_GE67, SRC_4ED, SRC_WIKI, SRC_KURTZ, SRC_LISTINGS, SRC_DTSSWIN, SRC_HOPL = (ID + k for k in range(1, 10))
SOURCES = [
    (SRC_MAY64, "BASIC Instruction Manual, May 1964 (First Draft)", "John G. Kemeny, Thomas E. Kurtz",
     "Dartmouth College Computation Center", 1964, "MANUAL", "https://www.dartmouth.edu/basicfifty/basicmanual_1964.pdf",
     "The first manual, Part I \"For beginners\" only (pages 1-22): 9 statements besides END; Part II (four more "
     "statements, RND, INT, vectors and matrices) is not in the reprint. Facsimile published by T. E. Kurtz in 2000. "
     "Local copy: data/sources/basicmanual_1964.pdf (scan; the pages cited are the printed ones)."),
    (SRC_OCT64, "BASIC (1 October 1964)", "John G. Kemeny, Thomas E. Kurtz", "Dartmouth College Computation Center",
     1964, "MANUAL", "https://bitsavers.org/pdf/dartmouth/dtss/196410_BASIC.pdf",
     "The 2nd edition manual, 57 pages: 15 statements, error stops (appendix A), limitations (appendix B); "
     "chapter IV describes Card BASIC with MAT."),
    (SRC_GE67, "BASIC Language Reference Manual (June 1965, rev. January 1967)", None,
     "General Electric Information Service Department", 1967, "MANUAL",
     "https://ftp.mirrorservice.org/sites/www.bitsavers.org/pdf/ge/MarkI_Timesharing/202026A_BASIC_Language_Reference_Manual_Jan1967.pdf",
     "Dartmouth's BASIC on the GE-235 as sold by GE (publication IPC-202026A). Used for the 3rd edition, whose "
     "Dartmouth manual is not available: INPUT, RESTORE, MAT, INT as floor, run-time error messages, limitations."),
    (SRC_4ED, "BASIC, 4th Edition (January 1968)", "Dartmouth College", "Dartmouth Publications", 1968, "MANUAL",
     "https://archive.org/stream/bitsavers_dartmouthB_3679804/BASIC_4th_Edition_Jan68_djvu.txt",
     "GE-635 version. Read in the text version; local copy of the scan: data/sources/BASIC_4th_Edition_Jan68.pdf."),
    (SRC_WIKI, "Dartmouth BASIC", None, "Wikipedia", None, "WEB", "https://en.wikipedia.org/wiki/Dartmouth_BASIC",
     "History of the editions: what each one added."),
    (SRC_KURTZ, "Dartmouth BASIC: summary of language and commands", "Thomas E. Kurtz", "Dartmouth College", 2005,
     "WEB", "https://www.dartmouth.edu/basicfifty/commands.html",
     "Summary of the original BASIC as run by the DTSS simulator: 15 statements, precision of the GE-225/235, "
     "unary minus before the power."),
    (SRC_LISTINGS, "Dartmouth BASIC compiler listings (BA-1, BA-2, BA-3)", "transcribed by Thomas E. Kurtz", None, 1965,
     "WEB", "https://dtss.dartmouth.edu/proofed/BASIC/",
     "GE-235 assembly source headed \"telebasic rev. 1, basic and teach combined, 8 feb 65\": between the 2nd and "
     "the 3rd edition (it already has INPUT)."),
    (SRC_DTSSWIN, "DTSS-Win simulator", "Thomas E. Kurtz", "Dartmouth College", 2007, "WEB",
     "https://dtss.dartmouth.edu/DTSS-Win.zip",
     "True BASIC simulation of the GE-235 running the original BASIC compiler (BASICCOMPILER.TRU, machine code) "
     "and Algol. Local copy kept by the editor."),
    (SRC_HOPL, "BASIC (in History of Programming Languages, ed. R. L. Wexelblat)", "Thomas E. Kurtz", "Academic Press",
     1981, "BOOK", "https://doi.org/10.1145/800025.1198404",
     "Kurtz's paper for the ACM HOPL conference of 1978, pp. 515-537: the design of each edition from the 1st to the "
     "6th. It quotes the complete 1st edition manual (June 1964, with Part II: pages 25, 31, 37, 39), the 3rd "
     "edition manual (1966) and its Supplement (1967). Local copy: data/sources/Kurtz.pdf."),
]

# ---------------------------------------------------------------------
# Machines, dialects, layers
# ---------------------------------------------------------------------
GE225, GE235, GE635 = ID + 1, ID + 2, ID + 3
MACHINES = [
    dict(id=GE225, code="GE225", name="General Electric GE-225", manufacturer="General Electric", year=None,
         cpu="GE-225 (20-bit words)",
         notes="With a Datanet-30 communications computer handling the Teletype terminals (Model 33 and 35), the first "
               "Dartmouth Time-Sharing System: the first BASIC programs ran on it on 1 May 1964. Replaced by the "
               "faster GE-235 around June 1964 (source [5])."),
    dict(id=GE235, code="GE235", name="General Electric GE-235", manufacturer="General Electric", year=None,
         cpu="GE-235 (20-bit words: three 6-bit characters)",
         notes="The faster GE-225, with the Datanet-30: the Dartmouth Time-Sharing System from mid-1964 to 1967 "
               "(Phase I). Floating point of about 30 bits of mantissa (nine to ten digits), binary exponent from "
               "-256 to 255 (source [6]). The DTSS-Win simulator [8] emulates this machine. GE sold the GE-235 with the "
               "Datanet-30 as the GE-265, with a copy of the Dartmouth system, from early 1965 [9]."),
    dict(id=GE635, code="GE635", name="General Electric GE-635", manufacturer="General Electric", year=None,
         cpu="GE-635 (36-bit words)",
         notes="Installed at Dartmouth in late 1966 and early 1967; GE's Phase I operating system ran on it from "
               "September 1967. Dartmouth wrote the compilers: the 4th edition, first an experimental version of "
               "spring 1967, was the BASIC of this machine [9]. The 3rd edition stayed on the GE-235."),
]
L1, L2, L3, L4, L5 = ID + 1, ID + 2, ID + 3, ID + 4, ID + 5
LAYERS = [
    dict(id=L1, code="DARTMOUTH_1ED_core", name="Dartmouth BASIC, 1st edition", kind="CORE",
         author="John G. Kemeny, Thomas E. Kurtz", year=1964,
         notes="May 1964. The manual [1] describes 9 statements besides END; GOSUB, RETURN, DIM, REM, RND, INT and "
               "the arrays (its Part II, not available) are taken from the October 1964 manual [2]. Kurtz [9], quoting the "
               "complete manual of June 1964, confirms the 14 statements (LET, PRINT, END, FOR, NEXT, GO TO, IF...THEN, "
               "DEF, READ, DATA, DIM, GOSUB, RETURN, REM) and the 10 functions."),
    dict(id=L2, code="DARTMOUTH_2ED_layer", name="Dartmouth BASIC, 2nd edition", kind="LAYER",
         author="John G. Kemeny, Thomas E. Kurtz", year=1964,
         notes="October 1964 [2]: STOP, the semicolon in PRINT, subscripts from 0, more commands."),
    dict(id=L3, code="DARTMOUTH_3ED_layer", name="Dartmouth BASIC, 3rd edition", kind="LAYER",
         author="John G. Kemeny, Thomas E. Kurtz", year=1966,
         notes="1966. From the GE manual of January 1967 [3] and Wikipedia [5] (the Dartmouth manual is not "
               "available): INPUT, RESTORE, MAT, SGN, INT as floor, unary minus after the power, run-time "
               "messages, nested GOSUB. Kurtz [9] confirms INPUT, MAT, SGN, RESTORE, INT as floor and the unary "
               "minus (p. 40 of the 1966 manual), and says that Dartmouth stopped developing this version in 1965: "
               "this is why the compiler of February 1965 (DTSS-Win) already behaves like it."),
    dict(id=L4, code="DARTMOUTH_4ED_layer", name="Dartmouth BASIC, 4th edition", kind="LAYER",
         author="Dartmouth College", year=1968,
         notes="January 1968 [4], GE-635: strings, ON...GO TO, TAB, RANDOMIZE, CHANGE, multi-line DEF, MAT INPUT, "
               "NUM, DET, COT, RESTORE* and RESTORE$. According to Kurtz [9] most of it ran from spring 1967 on the "
               "GE-635, described in the Supplement to the 3rd edition manual; the manual of 1968 added only "
               "multi-line DEF and CHANGE. Designed with GE, which suggested the strings."),
    dict(id=L5, code="DARTMOUTH_CARD_layer", name="Card BASIC", kind="LAYER",
         author="John G. Kemeny, Thomas E. Kurtz", year=1964,
         notes="October 1964 [2] chapter IV, pp. 50-52: the 2nd edition run from punched cards, with the output on the "
               "high-speed printer. Relations written as three-letter words, labels between single quotes, data on "
               "cards after END, PAGE and MAT."),
]
DIALECTS = [
    # dialect, layers of its stack, machines (machine_id, is_default)
    (dict(id=ID + 1, code="DARTMOUTH_BASIC_1", name="Dartmouth BASIC (1st edition)", version="1st edition",
          author="John G. Kemeny, Thomas E. Kurtz", year=1964,
          notes="The original BASIC, compiled (compile and go) on the Dartmouth Time-Sharing System and used from "
                "Teletype terminals. Only numbers: strings can be printed as labels, not stored."),
     [L1], [(GE225, 1), (GE235, 0)]),
    (dict(id=ID + 2, code="DARTMOUTH_BASIC_2", name="Dartmouth BASIC (2nd edition)", version="2nd edition",
          author="John G. Kemeny, Thomas E. Kurtz", year=1964,
          notes="The October 1964 version. The same manual describes Card BASIC (batch, with MAT), entered as its own dialect."),
     [L1, L2], [(GE235, 1)]),
    (dict(id=ID + 3, code="DARTMOUTH_BASIC_3", name="Dartmouth BASIC (3rd edition)", version="3rd edition",
          author="John G. Kemeny, Thomas E. Kurtz", year=1966,
          notes="The first version called an \"edition\"; INPUT makes programs interactive. GE-235 only: Dartmouth "
                "stopped developing it in 1965, knowing it would move to the GE-635, and it stayed in use until "
                "autumn 1967 [9]."),
     [L1, L2, L3], [(GE235, 1)]),
    (dict(id=ID + 4, code="DARTMOUTH_BASIC_4", name="Dartmouth BASIC (4th edition)", version="4th edition",
          author="Dartmouth College", year=1968,
          notes="The version most later BASICs descend from: string variables, ON...GO TO, TAB, RANDOMIZE."),
     [L1, L2, L3, L4], [(GE635, 1)]),
    (dict(id=ID + 5, code="DARTMOUTH_CARD_BASIC", name="Dartmouth Card BASIC", version="October 1964",
          author="John G. Kemeny, Thomas E. Kurtz", year=1964,
          notes="A parallel version of the 2nd edition for decks of punched cards: longer programs, no limit on the "
                "data, faster output on the high-speed printer, matrix statements [2] p. 50."),
     [L1, L2, L5], [(GE235, 1)]),
]

# ---------------------------------------------------------------------
# Small language for the syntax trees
# ---------------------------------------------------------------------
def _n(kind, children=(), **o):
    return dict(kind=kind, children=list(children), **o)


def S(*c, **o): return _n("SEQUENCE", c, **o)
def C(*c, **o): return _n("CHOICE", c, **o)
def O(x, **o): return _n("OPTIONAL", [x], **o)
def R(x, sep=None, min=1, max=None, **o): return _n("REPEAT", [x], separator=sep, min_occ=min, max_occ=max, **o)
def K(t, **o): return _n("KEYWORD", text=t, **o)
def L(t, **o): return _n("LITERAL", text=t, **o)
def P(name, kind="NUM_EXPR", **o): return _n("PARAMETER", name=name, pkind=kind, **o)


def fn(name, arg="x"):
    """Function with its argument in parentheses: SIN(X)."""
    return S(K(name), L("(", att=True), P(arg, att=True), L(")", att=True))


def binary(op, kind="NUM_EXPR"):
    return S(P("a", kind), K(op), P("b", kind))


LEFT = "LEFT"


# Parameters: name -> dict(descr, conversion, error, limit=(min, max, note, min_incl, max_incl),
#                          allowed=[(value, meaning)], missing_line, ev)
# Forms: F(tree, par, actions=[(code, coverage, note)], orig, title, ret=(type, min, max[, min_incl, max_incl]),
#          descr, prec, op, assoc, ev, page)
# Entries: E(name, cat, descr, forms, notes, page, src, diff); diff = difference_notes of a REPLACE.
def E(name, cat, descr, forms, notes=None, page=None, src=None, diff=None):
    return dict(name=name, cat=cat, descr=descr, forms=forms, notes=notes, page=page, src=src, diff=diff,
                remove=False)


def REMOVE(name, cat, diff):
    return dict(name=name, cat=cat, descr=None, forms=[], notes=None, page=None, src=None, diff=diff, remove=True)


def F(tree, par=None, actions=(), orig=None, title=None, ret=None, descr=None, prec=None, op=None, assoc=None,
      ev=None, page=None):
    return dict(tree=tree, par=par or {}, actions=list(actions), orig=orig, title=title, ret=ret, descr=descr,
                prec=prec, op=op, assoc=assoc, ev=ev, page=page)


def EE(code, cause=None, verified=False, form=None, par=None, remove=False):
    """Error of an entry. form = position of the form (None = every form); par = parameter name;
    remove=True: an error that a rule would give does not happen here."""
    return dict(code=code, cause=cause, verified=verified, form=form, par=par, remove=remove)


def X(title, code, expected=None, description=None, form=None, manual=False, page=None, verified=False, src=None):
    """Usage example. manual=True: taken from the manual of the layer (or src); always to verify."""
    return dict(title=title, code=code, expected=expected, description=description, form=form, manual=manual,
                page=page, verified=verified, src=src)


def redo(entry, diff, **changes):
    """Copy of an entry of a lower layer, for a REPLACE: the whole entry is copied, then changed."""
    e = copy.deepcopy(entry)
    e.update(changes)
    e["diff"] = diff
    return e


def find(entries, name, cat):
    for e in entries:
        if e["name"] == name and e["cat"] == cat:
            return e
    raise KeyError((name, cat))


# Shared parameter definitions
LINE = dict(descr="Line number: an integer of up to five digits, written as a number (not a formula).",
            limit=(1, 99999), missing_line="ERROR", error="UNDEFINED_NUMBER")
FN_ARG = dict(descr="Any formula.")
INF = "INFERRED"     # evidence of the facts taken from the October 1964 manual into the 1st edition

# =====================================================================
# 1st EDITION (core) - May 1964 [1]
# =====================================================================
DATA_TYPES_1 = [
    # code, name, suffix, class, minimum, maximum, max_length, precision, notes
    ("REAL", "Number", None, "REAL", -5.7896e76, 5.7896e76, None, "9 digits",
     "Floating point on the GE-225/235: about 30 bits of mantissa (the manual says up to 9 digits, \"the limit of "
     "accuracy of the computer\"), binary exponent from -256 to 255 (source [6]), so magnitudes from about "
     "4.31809E-78 to 5.78960E76 (the limits printed in the GE manual [3], p. 37). A constant has up to 9 digits, "
     "a decimal point and a minus sign, and can be followed by E and a power of ten: `5E1`, `2.39E-12` [1] p. 5."),
]

VARIABLE_KINDS_1 = [
    # code, name, data type, dimensions, naming rule, pattern, max length, significant, examples, notes
    ("NUMERIC", "Variable", "REAL", 0, "one letter, or one letter followed by one digit", r"^[A-Z][0-9]?$", 2, 0,
     "A, X, N5, X0, K9", "286 names. Only capital letters exist on the Teletype [1] p. 5. The manual does not say "
                         "what an unassigned variable holds; Kurtz [9] says that variables were first set to zero "
                         "in the 4th edition."),
    ("LIST", "List", "REAL", 1, "one letter followed by a subscript in parentheses", r"^[A-Z]$", 1, 0, "A(5), B(I+1)",
     "A one-dimensional array (vector). Part II of the manual [1] is missing: from the 2nd edition manual [2] and "
     "from source [5], whose description of the 1st edition is that a list needs no DIM up to 10 elements, numbered "
     "**from 1 to 10** (subscript 0 came with the 2nd edition). Kurtz [9] confirms it: without DIM, subscripts "
     "1-10 in each dimension. A letter can be a simple variable and a list at the "
     "same time, not a list and a table."),
    ("TABLE", "Table", "REAL", 2, "one letter followed by two subscripts in parentheses", r"^[A-Z]$", 1, 0,
     "B(1,1), M(I,J)",
     "A two-dimensional array (matrix). Inferred from the 2nd edition manual [2] (Part II of [1] is missing): "
     "subscripts from 1 to 10 without DIM, as for the lists."),
]

PARAMETER_KINDS_1 = [
    # code, name, nature, type class, variable kind, notes
    ("NUM_LITERAL", "Number", "LITERAL", "NUMERIC", None, "Up to 9 digits, decimal point, sign, E and exponent."),
    ("LINE_NUMBER", "Line number", "LITERAL", "INTEGER", None, "1 to 99999, written as digits."),
    ("LABEL", "Label", "LITERAL", "STRING", None, "Text in quotes, printed as it is."),
    ("FN_LETTER", "Function letter", "LITERAL", "STRING", None, "One letter A-Z, written right after FN: FNA to FNZ."),
    ("NUM_EXPR", "Formula", "EXPRESSION", "NUMERIC", None,
     "Numbers, variables, list and table elements, functions and the operators + - * / ↑, with parentheses."),
    ("NUM_VAR", "Variable", "VARIABLE", None, "NUMERIC", None),
    ("LIST_ELEMENT", "List element", "ARRAY_ELEMENT", None, "LIST", "E.g. A(I)."),
    ("TABLE_ELEMENT", "Table element", "ARRAY_ELEMENT", None, "TABLE", "E.g. B(I,J)."),
    ("ANY_VAR", "Variable or element", "VARIABLE", None, None, "A variable or an element of a list or table."),
    ("ARRAY_NAME", "List or table name", "ARRAY_NAME", None, None, "One letter."),
    ("CONDITION", "Relation", "CONDITION", "NUMERIC", None,
     "Two formulas joined by one relation: = < <= > >= <>. Only after IF; it produces no value."),
    ("FREE_TEXT", "Remark", "FREE_TEXT", None, None, "Any text up to the end of the line."),
]

FEATURES_1 = [
    # code, value, verified, notes
    ("LINE_NUMBERS", "1-99999", False,
     "Called instruction numbers; statements are run in the order of their numbers, whatever the order they were "
     "typed in [1] p. 4. A line with the number of an existing one replaces it; a number alone deletes the line [1] p. 19."),
    ("MULTIPLE_STATEMENTS", "No", False, "One statement per line."),
    ("STATEMENT_SEPARATOR", "None", False, None),
    ("LET", "Mandatory", False, "Every assignment starts with LET: `10 A=5*5` is not a statement (source [5])."),
    ("TRUE_VALUE", "None", False, "Relations can only be written in IF...THEN: they produce no value."),
    ("FALSE_VALUE", "None", False, "Relations can only be written in IF...THEN: they produce no value."),
    ("TRUTH_TEST", "Relation only", False, "IF needs a relation between two formulas; a formula alone is not a condition."),
    ("INTEGER_CONVERSION", "Not stated", False,
     "The manuals do not say what happens to a subscript that is not an integer. INT truncates towards zero "
     "(see INT)."),
    ("FOR_RUNS_ONCE", "No", False,
     "Inferred from the 2nd edition manual [2] pp. 13-14: a loop whose start is already past the final value is "
     "not executed at all; the May manual does not say."),
    ("FOR_VARIABLE_CHANGEABLE", "Not stated", False, None),
    ("MODAL_KEYBOARD", "No", False, "Teletype keyboard: everything is typed letter by letter."),
    ("TAB_ZONE_WIDTH", "15 columns", False,
     "Five zones of 15 characters on a 75-character line: from the 2nd edition manual [2] p. 31; the May manual "
     "only shows that commas separate the printed values."),
    ("VARIABLE_TAB_STOPS", "No", False, None),
]

ERRORS_1 = [
    # code, message, description. The May manual [1] p. 19 shows five messages (marked); the others are the
    # error stops of the October 1964 manual [2] pp. 53-54, assumed to exist already.
    ("ILLEGAL_FORMULA", "ILLEGAL FORMULA", "The commonest error: missing parentheses, illegal variable names, "
                                           "missing multiplication signs, illegal numbers. Shown in [1] p. 19."),
    ("INCORRECT_FORMAT", "INCORRECT FORMAT", "The form of the statement is wrong, especially IF...THEN and FOR. "
                                             "Shown in [1] p. 19."),
    ("END_NOT_LAST", "END IS NOT LAST", "A statement has a number greater than END (also two END statements). "
                                        "Shown in [1] p. 19."),
    ("UNDEFINED_NUMBER", "UNDEFINED NUMBER", "GO TO or IF...THEN names a line number that does not exist. Shown "
                                             "in [1] p. 19."),
    ("NO_DATA", "NO DATA", "The program has READ but no DATA statement. Shown in [1] p. 19."),
    ("DIMENSION_TOO_LARGE", "DIMENSION TOO LARGE", "From [2]."),
    ("ILLEGAL_CONSTANT", "ILLEGAL CONSTANT", "More than nine digits, or a number of the wrong form. From [2]."),
    ("ILLEGAL_RELATION", "ILLEGAL RELATION", "The relation of an IF...THEN is wrong. From [2]."),
    ("ILLEGAL_LINE_NUMBER", "ILLEGAL LINE NUMBER", "A line number of the wrong form or of more than five digits. "
                                                   "From [2]."),
    ("ILLEGAL_INSTRUCTION", "ILLEGAL INSTRUCTION", "The word after the line number is not a statement. From [2]."),
    ("ILLEGAL_VARIABLE", "ILLEGAL VARIABLE", "From [2]."),
    ("NO_END", "NO END INSTRUCTION", "From [2]."),
    ("UNDEFINED_FUNCTION", "UNDEFINED FUNCTION", "A function FN is used but never defined with DEF. From [2]."),
    ("PROGRAM_TOO_LONG", "PROGRAM TOO LONG", "From [2]."),
    ("TOO_MUCH_DATA", "TOO MUCH DATA", "From [2]."),
    ("TOO_MANY_LABELS", "TOO MANY LABELS", "The labels to print are too long altogether. From [2]."),
    ("TOO_MANY_LOOPS", "TOO MANY LOOPS", "More than 26 FOR loops. From [2]."),
    ("NOT_MATCH_WITH_FOR", "NOT MATCH WITH FOR", "NEXT with the wrong variable, or loops not nested properly. "
                                                 "From [2]."),
    ("FOR_WITHOUT_NEXT", "FOR WITHOUT NEXT", "From [2]."),
    ("CUT_PROGRAM_OR_DIMS", "CUT PROGRAM OR DIMS", "The program and the arrays do not fit together. From [2] (the "
                                                   "same message in [3] and [4])."),
    ("SUBSCRIPT_ERROR", "SUBSCRIPT ERROR", "A subscript outside the range given by DIM, or outside the default "
                                           "range without DIM. From [2]."),
    ("ILLEGAL_RETURN", "ILLEGAL RETURN", "RETURN before any GOSUB. From [2]."),
]

ERROR_RULES_1 = [
    # selector, value, error code, cause, verified
    ("PARAMETER_KIND", "NUM_EXPR", "ILLEGAL_FORMULA", "The formula is not written correctly.", False),
    ("PARAMETER_KIND", "NUM_EXPR", "UNDEFINED_FUNCTION", "The formula uses an FN function that is never defined.", False),
    ("PARAMETER_KIND", "CONDITION", "ILLEGAL_RELATION", "The relation is not one of = < <= > >= <>.", False),
    ("PARAMETER_KIND", "LIST_ELEMENT", "SUBSCRIPT_ERROR", "The subscript is outside the range of the list.", False),
    ("PARAMETER_KIND", "TABLE_ELEMENT", "SUBSCRIPT_ERROR", "A subscript is outside the range of the table.", False),
    ("PARAMETER_KIND", "NUM_LITERAL", "ILLEGAL_CONSTANT", "More than nine digits, or a number of the wrong form.", False),
]

KEYWORDS_1 = [
    ("HELLO", None), ("RUN", None), ("LIST", None), ("SAVE", None), ("STOP", None),
    ("LET", None), ("PRINT", None), ("END", None), ("FOR", None), ("TO", None), ("STEP", None), ("NEXT", None),
    ("GO TO", "Spaces do not count: also written GOTO, as in the examples of [1]."),
    ("IF", None), ("THEN", None), ("DEF", None), ("FN", "Followed by one letter: FNA to FNZ."),
    ("READ", None), ("DATA", None), ("GOSUB", None), ("RETURN", None), ("DIM", None), ("REM", None),
    ("SIN", None), ("COS", None), ("TAN", None), ("ATN", None), ("EXP", None), ("LOG", None), ("SQR", None),
    ("ABS", None), ("RND", None), ("INT", None),
    ("+", None), ("-", None), ("*", None), ("/", None), ("↑", "Power: an upward arrow on the Teletype (^ in ASCII)."),
    ("=", "Assignment in LET, relation in IF."), ("<", None), ("<=", None), (">", None), (">=", None),
    ("<>", "Not equal (\"less or greater\")."),
]

IF_NOTE = ("If the relation is false the program goes on with the next statement. GO TO and IF...THEN may jump "
           "to a REM or DATA line, which does nothing [2] p. 45.")
PRINT_ITEM_1 = C(P("label", "LABEL"), P("formula"), S(P("label", "LABEL"), P("formula")))

ENTRIES_1 = [
    # ------------------------------------------------------------ commands
    E("HELLO", "COMMAND", "Starts a session: the system asks for the user number, the problem name, the system and "
                          "whether the program is new or old.", [
        F(S(K("HELLO")), {}, [("SESSION_START", "FULL", None)], orig="HELLO")],
      notes="The dialogue of [1] p. 17 (the user's answers after the dashes):\n\n"
            "```\nUSER NO.--446425\nPROBLEM NO.--M36-2\nSYSTEM--BASIC\nTYPE OR OLD--TYPE\nREADY.\n```\n\n"
            "The problem name has up to 6 letters, digits or symbols. TYPE starts a new program, OLD brings back a "
            "saved one. HELLO is typed only to start a new problem, not to correct a program.", page="16-18"),
    E("RUN", "COMMAND", "Compiles and runs the program.", [
        F(S(K("RUN")), {}, [("PROG_RUN", "FULL", None)], orig="RUN")],
      notes="The answers are preceded by the user number and the problem name, and followed by the time used, "
            "rounded to the second: `TIME: 0 SECS.` [1] p. 17. Errors found while compiling are printed instead of "
            "the answers.", page="17"),
    E("LIST", "COMMAND", "Types the current version of the program.", [
        F(S(K("LIST")), {}, [("PROG_LIST", "FULL", None)], orig="LIST")], page="18"),
    E("SAVE", "COMMAND", "Keeps the program on the disk, under its problem name.", [
        F(S(K("SAVE")), {}, [("TAPE_SAVE", "FULL", "On the disk of the time-sharing system")], orig="SAVE")],
      notes="A saved program stays available for about a month; it is called back with HELLO and the answer OLD "
            "[1] p. 18.", page="18"),
    E("STOP", "COMMAND", "Stops whatever is going on, even while the Teletype is typing at full speed.", [
        F(S(K("STOP")), {}, [("PROG_BREAK", "FULL", None)], orig="STOP")],
      notes="The letters do not show until the typing has stopped, but the command works [1] p. 18.", page="18"),
    # ---------------------------------------------------------- statements
    E("LET", "STATEMENT", "Computes the value of a formula and gives it to a variable.", [
        F(S(K("LET"), C(P("variable", "NUM_VAR"), P("variable", "LIST_ELEMENT"), P("variable", "TABLE_ELEMENT")),
            K("="), P("formula")),
          {"variable": dict(descr="A variable or an element of a list or table."),
           "formula": dict(descr="Any formula.")},
          [("VAR_LET", "FULL", None)], orig="LET V = F")],
      notes="`LET X = X + 2` increases X by 2: LET computes the formula and *calls the answer* V [1] p. 7.",
      page="7"),
    E("PRINT", "STATEMENT", "Types the values of formulas and labels on a line.", [
        F(S(K("PRINT"), O(S(PRINT_ITEM_1, R(S(L(","), PRINT_ITEM_1), min=0), O(L(","))))),
          {"label": dict(descr="Text in quotes, typed as it is."),
           "formula": dict(descr="Any formula: its value is typed.")},
          [("IO_PRINT", "FULL", None)], orig="PRINT",
          descr="Commas separate the items. A label can be followed directly by a formula: `PRINT \"ROOTS =\" S+T`. "
                "PRINT alone skips a line.")],
      notes="Five values fit on a line, in zones of 15 characters (from [2]); the May manual shows the rule only "
            "by examples. Whether a final comma keeps the next PRINT on the same line is stated only in [2].\n\n"
            "DTSS-Win (compiler of February 1965) prints the round brackets of a label as square ones: "
            "`PRINT \"()\"` and `PRINT \"[]\"` both print `[]`. The cause (the internal code of the GE-235 or the "
            "simulator) is not known.",
      page="7-8"),
    E("END", "STATEMENT", "Last statement of every program: it must have the highest number.", [
        F(S(K("END")), {}, [("FLOW_END", "FULL", None)], orig="END")], page="4"),
    E("FOR...TO...STEP", "STATEMENT", "Starts a loop: the variable goes from the first value to the second in "
                                      "steps of 1 or of the STEP value.", [
        F(S(K("FOR"), P("v", "NUM_VAR"), K("="), P("f1"), K("TO"), P("f2"), O(S(K("STEP"), P("f3")))),
          {"v": dict(descr="A single letter (manual p. 10): N, X; not N5."),
           "f1": dict(descr="First value: a number or a formula."), "f2": dict(descr="Final value: a number or a formula."),
           "f3": dict(descr="Step; 1 when STEP is omitted.")},
          [("FLOW_FOR", "FULL", None)], orig="FOR V = F1 TO F2")],
      notes="The loop is closed by NEXT with the same variable. Steps that are not integers worked because the "
            "GE-225 truncated its binary results: .1 was slightly less, so `FOR X = 1 TO 10 STEP .1` reached 10, "
            "while `FOR X = 10 TO 1 STEP -.1` did not reach 1 [9].", page="9-10"),
    E("NEXT", "STATEMENT", "Ends the loop of the FOR with the same variable.", [
        F(S(K("NEXT"), P("v", "NUM_VAR")), {"v": dict(descr="The variable of the FOR.")},
          [("FLOW_NEXT", "FULL", None)], orig="NEXT V")], page="9"),
    E("GO TO", "STATEMENT", "Jumps to a line.", [
        F(S(K("GO TO"), P("n", "LINE_NUMBER")), {"n": LINE}, [("FLOW_GOTO", "FULL", None)], orig="GO TO N")],
      page="11"),
    E("IF...THEN", "STATEMENT", "Jumps to a line if a relation between two formulas is true.", [
        F(S(K("IF"), P("relation", "CONDITION"), K("THEN"), P("n", "LINE_NUMBER")),
          {"relation": dict(descr="F1 relation F2, with one of = > < >= <= <>."), "n": LINE},
          [("FLOW_IF", "PARTIAL", "Only a jump, no ELSE")], orig="IF F1 α F2 THEN N")],
      notes=IF_NOTE, page="11-12"),
    E("DEF", "STATEMENT", "Defines a function FNA to FNZ with one argument.", [
        F(S(K("DEF"), K("FN"), P("letter", "FN_LETTER", att=True), L("(", att=True), P("argument", "NUM_VAR", att=True),
            L(")", att=True), K("="), P("formula")),
          {"letter": dict(descr="A to Z: up to 26 functions."),
           "argument": dict(descr="Used only for the definition; the manual says not to use it elsewhere in the "
                                  "program."),
           "formula": dict(descr="Any formula containing the argument; on one line.")},
          [("FN_DEFINE", "FULL", None)], orig="DEF FNC(Z) = Z↑3 + 2.7*Z")],
      notes="DEF may be anywhere in the program. `DEF FNS(Z) = SIN(Z*P/180)` gives a sine in degrees, "
            "`DEF FNL(Z) = LOG(Z)/LOG(10)` a common logarithm [1] p. 13.", page="13"),
    E("READ", "STATEMENT", "Gives the variables the next numbers of the DATA statements.", [
        F(S(K("READ"), R(P("variable", "ANY_VAR"), sep=",")),
          {"variable": dict(descr="Variables or elements, separated by commas.")},
          [("DATA_READ", "FULL", None)], orig="READ A, B, C")],
      notes="When there is no data left, the program stops, with no message [1] p. 15. The compiler of February "
            "1965 (DTSS-Win) already prints `OUT OF DATA IN n` and stops.", page="14-15"),
    E("DATA", "STATEMENT", "Numbers for READ, taken in the order of the DATA statements.", [
        F(S(K("DATA"), R(P("number", "NUM_LITERAL"), sep=",")),
          {"number": dict(descr="Numbers separated by commas, as many as fit on the line.")},
          [("DATA_DEFINE", "FULL", None)], orig="DATA 1, 2, 3")],
      notes="Never executed: it can be anywhere, usually just before END. Up to 200 numbers in all [1] p. 14.",
      page="14"),
    E("GOSUB", "STATEMENT", "Calls a subroutine: RETURN goes back to the statement after the GOSUB.", [
        F(S(K("GOSUB"), P("n", "LINE_NUMBER")), {"n": dict(LINE, ev=INF)}, [("FLOW_GOSUB", "FULL", None)],
          orig="GOSUB N", ev=INF)],
      notes="Part II of the May manual is missing: taken from the 2nd edition manual [2] pp. 42-43, which says that "
            "a GOSUB inside a subroutine \"just won't work\": no nesting. The compiler of February 1965 (DTSS-Win) "
            "already runs nested GOSUBs correctly. Kurtz [9] writes that GOSUB \"used a stack for the return address\", "
            "which does not agree with [2].", src=SRC_OCT64, page="42-43"),
    E("RETURN", "STATEMENT", "Goes back to the statement after the last GOSUB.", [
        F(S(K("RETURN")), {}, [("FLOW_RETURN", "FULL", None)], orig="RETURN", ev=INF)],
      notes="Taken from the 2nd edition manual [2] (Part II of [1] is missing).", src=SRC_OCT64, page="42-43"),
    E("DIM", "STATEMENT", "Gives lists and tables more elements than the default.", [
        F(S(K("DIM"), R(S(P("array", "ARRAY_NAME"), L("(", att=True), P("n", "NUM_LITERAL", att=True),
                          O(S(L(",", att=True), P("m", "NUM_LITERAL", att=True)), att=True), L(")", att=True)), sep=",")),
          {"array": dict(descr="One letter.", ev=INF),
           "n": dict(descr="Largest subscript (of the rows, for a table).", ev=INF),
           "m": dict(descr="Largest column subscript of a table.", ev=INF)},
          [("VAR_DIM", "PARTIAL", "Numeric arrays of one or two dimensions")], orig="DIM A(17), B(15,20)", ev=INF)],
      notes="Taken from the 2nd edition manual [2] p. 38 (Part II of [1] is missing). According to source [5] the "
            "1st edition needed DIM only for more than 10 elements, numbered from 1.", src=SRC_OCT64, page="38"),
    E("REM", "STATEMENT", "Remark: does nothing.", [
        F(S(K("REM"), O(P("text", "FREE_TEXT"))), {"text": dict(descr="Any text.")},
          [("PROG_REM", "FULL", None)], orig="REM", ev=INF)],
      notes="Taken from the 2nd edition manual [2] p. 45 (Part II of [1] is missing).", src=SRC_OCT64, page="45"),
    # ----------------------------------------------------------- functions
    E("SIN", "FUNCTION", "Sine; the argument is in radians.", [
        F(fn("SIN"), {"x": FN_ARG}, [("MATH_SIN", "FULL", None)], orig="SIN(X)", ret=("REAL", -1, 1))], page="5"),
    E("COS", "FUNCTION", "Cosine; the argument is in radians.", [
        F(fn("COS"), {"x": FN_ARG}, [("MATH_COS", "FULL", None)], orig="COS(X)", ret=("REAL", -1, 1))], page="5"),
    E("TAN", "FUNCTION", "Tangent; the argument is in radians.", [
        F(fn("TAN"), {"x": FN_ARG}, [("MATH_TAN", "FULL", None)], orig="TAN(X)", ret=("REAL", None, None))], page="5"),
    E("ATN", "FUNCTION", "Arc tangent, in radians.", [
        F(fn("ATN"), {"x": FN_ARG}, [("MATH_ATN", "FULL", None)], orig="ATN(X)", ret=("REAL", None, None))], page="5"),
    E("EXP", "FUNCTION", "e raised to the argument.", [
        F(fn("EXP"), {"x": FN_ARG}, [("MATH_EXP", "FULL", None)], orig="EXP(A)", ret=("REAL", 0, None))], page="5"),
    E("LOG", "FUNCTION", "Natural logarithm.", [
        F(fn("LOG"), {"x": FN_ARG}, [("MATH_LN", "FULL", None)], orig="LOG(A)", ret=("REAL", None, None))],
      notes="The 2nd edition manual [2] says that the logarithm is taken of the absolute value of the argument, "
            "with no message.", page="5"),
    E("SQR", "FUNCTION", "Square root of the absolute value of the argument.", [
        F(fn("SQR"), {"x": FN_ARG}, [("MATH_SQR", "FULL", None)], orig="SQR(A)", ret=("REAL", 0, None))],
      notes="The square root is always taken of the absolute value: `SQR(-4)` = 2, with no message [1] p. 5. The "
            "compiler of February 1965 (DTSS-Win) prints `SQUARE ROOT OF NEGATIVE NUMBER IN n`, then goes on with "
            "the root of the absolute value.",
      page="5"),
    E("ABS", "FUNCTION", "Absolute value.", [
        F(fn("ABS"), {"x": FN_ARG}, [("MATH_ABS", "FULL", None)], orig="ABS(X)", ret=("REAL", 0, None))], page="6"),
    E("RND", "FUNCTION", "Random number between 0 and 1.", [
        F(fn("RND"), {"x": dict(descr="Has no significance, but must be written.")},
          [("RND_VALUE", "PARTIAL", "Only between 0 and 1")], orig="RND(X)", ret=("REAL", 0, 1))],
      notes="The May manual only names it (\"see Part II\"): taken from the 2nd edition manual [2] pp. 39-40. "
            "Every run gives the same sequence. DTSS-Win (compiler of February 1965) confirms it: in LIB/GUESS, "
            "`INT(100*RND(0)+1)` gives 75 at the start of every RUN, then 20. Kurtz [9] confirms the dummy argument in "
            "the 1st edition (\"no doubt we were merely being lazy\").", src=SRC_OCT64, page="39-40"),
    E("INT", "FUNCTION", "Integer part, truncated towards zero.", [
        F(fn("INT"), {"x": dict(FN_ARG)}, [("MATH_INT", "PARTIAL", "Truncation towards zero, not the floor")],
          orig="INT(X)", ret=("REAL", None, None))],
      notes="The May manual only names it: taken from the 2nd edition manual [2] p. 39, where `INT(-7.8)` = -7. "
            "Rounding: `INT(X+.5)` for positive X, `INT(X-.5)` for negative X. Kurtz [9] quotes the complete 1st "
            "edition manual (June 1964, p. 31): `INT(3.45)` = 3, `INT(-34.567)` = -34.", src=SRC_OCT64, page="39"),
    E("FN", "FUNCTION", "Calls a function defined with DEF.", [
        F(S(K("FN"), P("letter", "FN_LETTER", att=True), L("(", att=True), P("x", att=True), L(")", att=True)),
          {"letter": dict(descr="Letter of a function defined with DEF."), "x": FN_ARG},
          [("FN_CALL", "FULL", None)], orig="FNC(X)", ret=("REAL", None, None))], page="13"),
    # ----------------------------------------------------------- operators
    E("↑", "OPERATOR", "Raise to a power, of the absolute value of the base.", [
        F(binary("↑"), {"a": dict(descr="Base: its absolute value is used, so X↑3 of a negative X is positive.")},
          [("OP_POWER", "PARTIAL", "Of the absolute value of the base")], orig="X↑2", prec=4, assoc=LEFT,
          op="ARITHMETIC", ret=("REAL", 0, None))],
      notes="`A↑B` is computed as |A|↑B: for a negative X write `X*X*X`, not `X↑3` [1] p. 5 (also [2] p. 9). "
            "`A↑B↑C` is `(A↑B)↑C` [2] p. 10. The DTSS-Win simulator, which runs a compiler of February 1965, gives "
            "`(-2)↑3` = -8: the sign was already kept by then.", page="5"),
    E("-", "OPERATOR", "Change of sign and subtraction.", [
        F(S(K("-"), P("a", att=True)), {}, [("OP_NEG", "FULL", None)], prec=5, op="ARITHMETIC", title="Change of sign",
          ret=("REAL", None, None)),
        F(binary("-"), {}, [("OP_SUB", "FULL", None)], prec=2, assoc=LEFT, op="ARITHMETIC", title="Subtraction",
          ret=("REAL", None, None))],
      notes="A leading minus sign comes **before** the power: `-X↑2` is `(-X)↑2` (source [6]); corrected in the "
            "3rd edition.", page="5"),
    E("*", "OPERATOR", "Multiplication; it must always be written.", [
        F(binary("*"), {}, [("OP_MUL", "FULL", None)], prec=3, assoc=LEFT, op="ARITHMETIC", ret=("REAL", None, None))],
      page="5"),
    E("/", "OPERATOR", "Division.", [
        F(binary("/"), {}, [("OP_DIV", "FULL", None)], prec=3, assoc=LEFT, op="ARITHMETIC", ret=("REAL", None, None))],
      notes="`A/B/C` is `(A/B)/C` [2] p. 10. Division by zero is not described in [1] or [2]; the compiler of "
            "February 1965 (DTSS-Win) prints 1 for `1/0`, with no message.", page="5"),
    E("+", "OPERATOR", "Addition.", [
        F(binary("+"), {}, [("OP_ADD", "FULL", None)], prec=2, assoc=LEFT, op="ARITHMETIC", ret=("REAL", None, None))],
      page="5"),
    E("( )", "OPERATOR", "Parentheses: the formula inside is computed first.", [
        F(S(L("("), P("f", att=True), L(")", att=True)), {"f": dict(descr="Any formula.")}, [("OP_GROUP", "FULL", None)],
          op="GROUPING")],
      page="6"),
]

for _op, _action, _name in (("=", "OP_EQ", "Equal"), ("<>", "OP_NE", "Not equal"), (">", "OP_GT", "Greater than"),
                            (">=", "OP_GE", "Greater than or equal"), ("<", "OP_LT", "Less than"),
                            ("<=", "OP_LE", "Less than or equal")):
    ENTRIES_1.append(E(_op, "OPERATOR", f"{_name}: only in the relation of IF...THEN.", [
        F(binary(_op), {}, [(_action, "FULL", None)], prec=1, op="RELATIONAL")],
        notes="Numbers only: strings came with the 4th edition.", page="12"))

ENTRY_ERRORS_1 = {
    "LET": [EE("ILLEGAL_VARIABLE", "The name on the left is not a variable.")],
    "FOR...TO...STEP": [EE("INCORRECT_FORMAT", "The FOR is not written in its form ([1] p. 19, [2])."),
                        EE("TOO_MANY_LOOPS", "More than 26 FOR statements (from [2])."),
                        EE("FOR_WITHOUT_NEXT", "No NEXT closes the loop (from [2]).")],
    "NEXT": [EE("NOT_MATCH_WITH_FOR", "Another variable than the FOR's, or loops crossed (from [2]).")],
    "IF...THEN": [EE("INCORRECT_FORMAT", "The IF...THEN is not written in its form ([1] p. 19).")],
    "READ": [EE("NO_DATA", "The program has no DATA statement ([1] p. 19)."),
             EE("ILLEGAL_VARIABLE", "An item of the list is not a variable.")],
    "DATA": [EE("TOO_MUCH_DATA", "More numbers than the limit (200 in [1] p. 14).")],
    "RETURN": [EE("ILLEGAL_RETURN", "RETURN before any GOSUB (from [2]).")],
    "DIM": [EE("DIMENSION_TOO_LARGE", "From [2]."), EE("CUT_PROGRAM_OR_DIMS", "The arrays take too much room (from [2]).")],
    "END": [EE("END_NOT_LAST", "A statement has a higher number ([1] p. 19)."),
            EE("NO_END", "The program has no END (from [2]).")],
    "PRINT": [EE("TOO_MANY_LABELS", "The labels of the program are too long altogether (from [2]).")],
}

EXAMPLES_1 = {
    "LET": [X("Increase a variable", "10 LET X = 2\n20 LET X = X + 2\n30 PRINT X\n40 END", "4")],
    "PRINT": [X("Values and a label", '5 PRINT "SINE OF 30, 60, 90 DEGREES."\n10 LET P = 3.14159265\n'
                                      '20 PRINT SIN(P/6), SIN(P/3), SIN(P/2)\n30 END',
                "SINE OF 30, 60, 90 DEGREES.\n .5            .866025       1.", manual=True, page="8"),
              X("Label followed by a value", '10 LET S = 3\n20 PRINT "ROOTS =" S\n30 END', "ROOTS = 3",
                "No separator is needed between a label and a formula (as in [1] p. 21).")],
    "END": [X("The shortest program", "LET X = (7+8)/3\nPRINT X\nEND", "5",
              "The first program of the manual, written without line numbers in the preface.", manual=True, page="1")],
    "FOR...TO...STEP": [X("Sum of 100 fifth powers", '10 PRINT "SUM OF 100 FIFTH POWERS."\n20 LET S = 0\n'
                                                     '30 FOR N = 1 TO 100\n40 LET S = S + N↑5\n50 NEXT N\n60 PRINT S\n99 END',
                          None, manual=True, page="9"),
                        X("Even numbers", "20 LET S = 0\n30 FOR N = 2 TO 100 STEP 2\n40 LET S = S + N↑5\n50 NEXT N\n"
                                          "60 PRINT S\n99 END", None, manual=True, page="10")],
    "NEXT": [X("Table of exponentials", '10 PRINT "X", "EXP(X)"\n20 FOR X = 0 TO 20\n30 PRINT X, EXP(X)\n'
                                        '40 NEXT X\n50 END', None, manual=True, page="9")],
    "GO TO": [X("Back to an earlier line", "10 READ X\n20 PRINT X, X↑2\n30 GO TO 10\n40 DATA 1, 2, 3\n99 END",
                "1             1\n2             4\n3             9", "The program stops when the data are used up.")],
    "IF...THEN": [X("Largest value of the sine", "10 LET X0 = 0\n20 LET M = SIN(0)\n30 FOR N = 1 TO 300\n"
                                                  "40 LET X = N/100\n50 IF SIN(X) <= M THEN 100\n60 LET X0 = X\n"
                                                  "70 LET M = SIN(X)\n100 NEXT N\n110 PRINT X0, M\n999 END",
                    None, manual=True, page="12")],
    "DEF": [X("Sine in degrees and common logarithm", "10 LET P = 3.14159265\n20 DEF FNS(Z) = SIN(Z*P/180)\n"
                                                      "30 DEF FNL(Z) = LOG(Z)/LOG(10)\n40 PRINT FNS(30), FNL(100)\n50 END",
              ".5            2", "Lines 10-30 are in the manual.", manual=True, page="13")],
    "READ": [X("Data for several runs", "10 READ X\n20 LET Y = X↑3 + X↑2 - X\n30 PRINT X, Y\n40 GO TO 10\n"
                                        "50 DATA 1.23, -.2345, 12.3, 1E-17, 123456815\n99 END", None,
               "Stops after the fifth value, with no message.", manual=True, page="15")],
    "DATA": [X("Order of the data", "10 READ A, B, C\n20 READ D1, D2, D3, D4\n30 PRINT A, D4\n80 DATA 1, 2, 3, 4, 5, 6\n"
                                    "90 DATA 7, 8, 9, 10\n99 END", "1             7",
               "A = 1, B = 2, C = 3, D1 = 4, ..., D4 = 7.", manual=True, page="14")],
    "GOSUB": [X("Call a subroutine", "10 LET X = 3\n20 GOSUB 100\n30 PRINT Y\n40 STOP\n100 LET Y = X*X\n110 RETURN\n"
                                     "120 END", "9", "STOP comes with the 2nd edition: in the 1st write `40 GO TO 120`.")],
    "RETURN": [X("Two calls", "10 GOSUB 100\n20 GOSUB 100\n30 GO TO 999\n100 PRINT \"HELLO\"\n110 RETURN\n999 END",
                 "HELLO\nHELLO")],
    "DIM": [X("A longer list", "10 DIM A(20)\n20 FOR I = 1 TO 20\n30 LET A(I) = I*I\n40 NEXT I\n50 PRINT A(20)\n60 END",
              "400")],
    "REM": [X("A remark", "10 REM SQUARES\n20 PRINT 3↑2\n30 END", "9")],
    "SIN": [X("Sine of 30 degrees", "10 PRINT SIN(3.14159265/6)\n20 END", ".5")],
    "COS": [X("Cosine of 0", "10 PRINT COS(0)\n20 END", "1")],
    "TAN": [X("Tangent", "10 PRINT TAN(.785398)\n20 END", "1")],
    "ATN": [X("Arc tangent", "10 PRINT 4*ATN(1)\n20 END", "3.14159")],
    "EXP": [X("The number e", "10 PRINT EXP(1)\n20 END", "2.71828")],
    "LOG": [X("Average of 100 logarithms", '10 PRINT "AVERAGE OF 100 LOGS"\n20 LET S = 0\n30 FOR N = 1 TO 100\n'
                                          '40 LET S = S + FNL(N)\n50 NEXT N\n60 LET S = S/100\n70 PRINT S\n'
                                          '80 DEF FNL(Z) = LOG(Z)/LOG(10)\n99 END',
              "AVERAGE OF 100 LOGS\n1.5797", manual=True, page="21")],
    "SQR": [X("Root of a negative number", "10 PRINT SQR(-4)\n20 END", "2", "The absolute value is used, with no "
              "message according to [1]. DTSS-Win (compiler of February 1965) prints `SQUARE ROOT OF NEGATIVE NUMBER "
              "IN 10` and then 2.")],
    "ABS": [X("Absolute value", "10 PRINT ABS(-3.5)\n20 END", "3.5")],
    "RND": [X("Three random numbers", "10 FOR I = 1 TO 3\n20 PRINT RND(0),\n30 NEXT I\n40 END", None,
              "The same three numbers at every run.")],
    "INT": [X("Truncation", "10 PRINT INT(7.8), INT(-7.8)\n20 END", "7            -7", "INT(-7.8) = -7 checked on "
              "DTSS-Win (compiler of February 1965).", verified=True, manual=True, src=SRC_OCT64,
              page="39")],
    "FN": [X("Root of a function", '10 PRINT "ROOT OF FUNCTION."\n30 DEF FNF(Z) = Z↑5 + Z↑3 - 1\n40 LET X = 0\n'
                                   '50 LET D = .5\n60 LET Y = FNF(X)\n70 IF Y = 0 THEN 200\n80 IF Y > 0 THEN 150\n'
                                   '90 LET X = X + D\n100 GO TO 160\n150 LET X = X - D\n160 IF D < .0001 THEN 200\n'
                                   '170 LET D = D/2\n180 GO TO 60\n200 PRINT "ROOT =" X\n999 END',
             "ROOT OF FUNCTION.\nROOT = .837585", manual=True, page="22")],
    "↑": [X("Power of a negative number", "10 PRINT (-2)↑3\n20 END", "8", "The absolute value of the base is used "
            "according to [1] p. 5 and [2] p. 9; DTSS-Win (compiler of February 1965) prints -8.")],
    "-": [X("Minus before the power", "10 LET X = 3\n20 PRINT -X↑2\n30 END", "9", "`(-X)↑2` (source [6]); "
            "checked on DTSS-Win (compiler of February 1965).", form=1, verified=True)],
    "*": [X("Product", "10 PRINT 6*7\n20 END", "42")],
    "/": [X("Division from the left", "10 PRINT 24/4/2\n20 END", "3")],
    "+": [X("Sum", "10 PRINT 741+852\n20 END", "1593")],
    "( )": [X("Parentheses", "10 LET X = (7+8)/3\n20 PRINT X\n30 END", "5", manual=True, page="1")],
    "=": [X("Equal", '10 LET A = 2\n20 IF A = 2 THEN 50\n30 PRINT "NO"\n40 GO TO 99\n50 PRINT "YES"\n99 END', "YES")],
    "<": [X("Less than", '10 IF 1 < 2 THEN 40\n20 PRINT "NO"\n30 GO TO 99\n40 PRINT "YES"\n99 END', "YES")],
    "HELLO": [X("Start a session", "HELLO", "USER NO.--", "The system goes on with PROBLEM NO., SYSTEM, TYPE OR OLD.",
                manual=True, page="17")],
}

REFERENCES_1 = [("FOR...TO...STEP", "NEXT", "OPENS_BLOCK"), ("GOSUB", "RETURN", "OPENS_BLOCK"),
                ("READ", "DATA", "SEE_ALSO"), ("DEF", "FN", "SEE_ALSO"), ("GO TO", "IF...THEN", "SEE_ALSO"),
                ("SAVE", "HELLO", "SEE_ALSO")]

OPEN_QUESTIONS_1 = [
    "Part II of the May 1964 manual is missing: GOSUB, RETURN, DIM, REM, RND, INT and the arrays are taken from the "
    "October 1964 manual. Kurtz [9] answers part of it (the four statements are DIM, GOSUB, RETURN, REM; lists from "
    "1 to 10 without DIM; INT truncates), quoting the complete manual of June 1964, which is still to be found.",
    "GOSUB in the 1st edition: the October 1964 manual says a GOSUB inside a subroutine does not work, Kurtz [9] "
    "that GOSUB used a stack for the return address. Which one is right for 1964?",
    "Errors: the May manual shows only five messages; the others come from the October 1964 manual. The simulator "
    "DTSS-Win runs a compiler of February 1965 that already has 3rd edition behaviours (nested GOSUB, OUT OF DATA, "
    "LOG OF NEGATIVE NUMBER, SQUARE ROOT OF NEGATIVE NUMBER, the sign of (-2)↑3), so it cannot confirm the 1964 "
    "behaviour. Why does it print 1 for 1/0?",
    "FOR: the May manual wants a single letter, the October manual any unsubscripted variable (FOR X1): was the "
    "1st edition really stricter? Does a loop whose start is past the end run zero times, as in the October manual?",
    "Variables and program in memory, internal character code of the GE-235: to be taken from the compiler listings "
    "BA-1..BA-3 [7].",
    "DTSS-Win prints the round brackets of a label as square ones (`PRINT \"()\"` gives `[]`): does the GE-235 "
    "code of a label have no round brackets, or is it the simulator?",
]

TABLES_1 = [
    # table kind, status, notes (DIALECT scope)
    ("CHARACTER_CODES", "COMPLETE", "The codes of the Teletype ASR-33 (ASCII-1963, 64 printable characters, upper case "
                                    "only), INFERRED: no statement shows them before CHANGE in the 4th edition, whose "
                                    "table [4] p. 68 gives the same codes. The internal code of the GE-235 is not "
                                    "entered. DTSS-Win keeps statements typed in lower case in the listing but rejects "
                                    "them at RUN (`ILLEGAL INSTRUCTION IN 10`); it prints ( and [ of a label alike, "
                                    "as [."),
    ("KEYBOARD_CODES", "NOT_APPLICABLE", "No statement reads the keyboard."),
    ("ERRORS", "PARTIAL", "Printed with the line number: `ILLEGAL FORMULA IN 30` [1] p. 19 (some messages without "
                          "it, e.g. `NO DATA`). The May manual shows five messages; the others are from [2]."),
    ("OPERATOR_PRECEDENCE", "COMPLETE", "Parentheses, then the change of sign (before the power, source [6]), the "
                                        "power, * and /, + and -, left to right at the same level [2] p. 10."),
    ("VARIABLE_LAYOUT", "TO_DO", "Compiled program: to be taken from the listings [7]."),
    ("PROGRAM_LAYOUT", "TO_DO", "The program is kept as text; its format on the disk is to be taken from the listings [7]."),
    ("MUSICAL_NOTES", "NOT_APPLICABLE", "No sound."),
]
MACHINE_TABLES = [
    ("GLYPHS", "COMPLETE", "**Reconstruction**: the Teletype ASR-33 printed with a type cylinder, so there are no "
                           "original bitmaps. The 64 glyphs (US print head, with the UK variant that has the pound "
                           "sign in place of $) are rasterized from the TrueType font "
                           "\"TeleType ASR 33 UK\" (© 2015 David Bonham), drawn from photographs of Teletype listings."),
    ("SCREEN_CODES", "COMPLETE", "No screen: output on paper. These rows only link each printed code (32-95) to the "
                                 "glyph with the same number."),
    ("COLORS", "NOT_APPLICABLE", "Output on paper."),
]

# =====================================================================
# 2nd EDITION - October 1964 [2]
# =====================================================================
VARIABLE_KINDS_2 = [
    ("LIST", "List", "REAL", 1, "one letter followed by a subscript in parentheses", r"^[A-Z]$", 1, 0, "A(5), B(I+1)",
     "Subscripts from **0** to 10 without DIM; DIM sets other upper limits. A letter can be a simple variable and "
     "a list at the same time, not a list and a table [2] pp. 36-38. Up to 1500 elements in all lists and tables."),
    ("TABLE", "Table", "REAL", 2, "one letter followed by two subscripts in parentheses", r"^[A-Z]$", 1, 0,
     "B(0,0), M(I,J)", "Subscripts from 0 to 10 in each dimension without DIM [2] p. 37."),
]
FEATURES_2 = [
    ("FOR_RUNS_ONCE", "No", True,
     "A loop whose start is already past the final value runs zero times; the variable is then left at the first "
     "value minus one step: after `FOR Z = 2 TO -2` Z is 1 [2] p. 30. Checked on DTSS-Win (compiler of February "
     "1965)."),
    ("TAB_ZONE_WIDTH", "15 columns", False, "Five zones of 15 characters on a 75-character line [2] p. 31."),
]
KEYWORDS_2 = [("NEW", None), ("OLD", None), ("SCRATCH", None), ("RENAME", None), ("CATALOG", None),
              ("UNSAVE", None), (";", "Packed output in PRINT.")]

_print1 = find(ENTRIES_1, "PRINT", "STATEMENT")
PRINT_SEP_2 = C(L(","), L(";"))
_for1, _next1 = find(ENTRIES_1, "FOR...TO...STEP", "STATEMENT"), find(ENTRIES_1, "NEXT", "STATEMENT")
ENTRIES_2 = [
    redo(_for1, "The loop variable can be any unsubscripted variable (FOR X1).",
         forms=[F(S(K("FOR"), P("v", "NUM_VAR"), K("="), P("f1"), K("TO"), P("f2"), O(S(K("STEP"), P("f3")))),
                  {"v": dict(descr="An unsubscripted variable: X, X1."),
                   "f1": dict(descr="First value."), "f2": dict(descr="Final value."),
                   "f3": dict(descr="Step; 1 when STEP is omitted; it can be negative or a fraction.")},
                  [("FLOW_FOR", "FULL", None)], orig="FOR <unsubscripted variable> = <expression> TO <expression> "
                                                     "STEP <expression>")],
         notes="If the first value is already past the final one the body is skipped: after `50 FOR Z = 2 TO -2` "
               "Z is 1, the first value minus the step [2] p. 30. At most 26 FOR in a program [2] p. 55.",
         page="29-30, 56", src=None),
    redo(_next1, "Any unsubscripted variable.",
         forms=[F(S(K("NEXT"), P("v", "NUM_VAR")), {"v": dict(descr="The variable of the FOR: X, X1.")},
                  [("FLOW_NEXT", "FULL", None)], orig="NEXT <unsubscripted variable>")], page="29, 56", src=None),
    redo(find(ENTRIES_1, "DATA", "STATEMENT"), "Up to 300 numbers.",
         notes="Never executed: it can be anywhere. Up to 300 numbers in all [2] p. 55.", page="27, 56", src=None),
    E("NEW", "COMMAND", "Erases the current program and asks for a new problem name.", [
        F(S(K("NEW")), {}, [("PROG_NEW", "FULL", None)], orig="NEW")], page="20"),
    E("OLD", "COMMAND", "Brings back a saved program.", [
        F(S(K("OLD")), {}, [("TAPE_LOAD", "FULL", "From the disk of the time-sharing system")], orig="OLD")],
      notes="In the May 1964 manual OLD is only the answer to the question TYPE OR OLD of HELLO; in October HELLO asks "
            "NEW OR OLD [2] p. 19.", page="20"),
    E("SCRATCH", "COMMAND", "Erases the current program but keeps its problem name.", [
        F(S(K("SCRATCH")), {}, [("PROG_NEW", "PARTIAL", "Keeps the name")], orig="SCRATCH")], page="20"),
    E("RENAME", "COMMAND", "Gives the current program a new problem name without erasing it.", [
        F(S(K("RENAME")), {}, [("PROG_RENAME", "FULL", None)], orig="RENAME")], page="20"),
    E("CATALOG", "COMMAND", "Lists the saved programs of the user.", [
        F(S(K("CATALOG")), {}, [("DISK_DIRECTORY", "FULL", None)], orig="CATALOG")], page="20"),
    E("UNSAVE", "COMMAND", "Deletes the saved program from the disk.", [
        F(S(K("UNSAVE")), {}, [("DISK_DELETE", "FULL", None)], orig="UNSAVE")],
      notes="Users are asked to unsave the programs they no longer need.", page="20"),
    redo(find(ENTRIES_1, "LIST", "COMMAND"), "Can start from a given line (LIST-n).",
         forms=[F(S(K("LIST"), O(S(L("-"), P("n", "LINE_NUMBER", att=True)))),
                  {"n": dict(descr="First line to list.", limit=(1, 99999))},
                  [("PROG_LIST", "FULL", None)], orig="LIST - XXXXX")],
         notes="Typing S stops the listing.", page="20", src=None),
    E("STOP", "STATEMENT", "Stops the program.", [
        F(S(K("STOP")), {}, [("FLOW_STOP", "FULL", None)], orig="STOP")],
      notes="It can replace a GO TO the END line where a program has several ends [2] p. 45.", page="45"),
    redo(_print1, "The semicolon packs the output: the next item starts at the next multiple of three characters.",
         forms=[F(S(K("PRINT"), O(S(PRINT_ITEM_1, R(S(PRINT_SEP_2, PRINT_ITEM_1), min=0), O(PRINT_SEP_2)))),
                  {"label": dict(descr="Text in quotes, typed as it is; it fills whole zones."),
                   "formula": dict(descr="Any formula: its value is typed.")},
                  [("IO_PRINT", "FULL", None)], orig="PRINT",
                  descr="',' moves to the next zone of 15 characters (after the fifth, to the next line); ';' moves "
                        "to the next multiple of three characters, at least six per number. A PRINT ending with a "
                        "comma or semicolon does not end the line; PRINT alone skips a line.")],
         notes="Numbers: up to six significant digits, integers in full up to nine digits, no trailing zeros, "
               "numbers below 0.1 as `X.XXXXXE-Y` unless they fit in six decimal places; integers without a "
               "decimal point [2] pp. 31-35. On DTSS-Win (compiler of February 1965) the exponent is printed after a "
               "space (`5.82077 E-9`, `1.71799 E 8`), and a value that rounds to an integer without being one keeps "
               "the point (`1.`, `-45.`).",
         page="31-35", src=None),
]
ENTRY_ERRORS_2 = {}
EXAMPLES_2 = {
    "FOR...TO...STEP": [X("A loop run zero times", "10 FOR Z = 2 TO -2\n20 NEXT Z\n30 PRINT Z\n40 END", "1",
                          "Z is the first value minus the step [2] p. 30. Checked on DTSS-Win (compiler of February "
                          "1965).", verified=True)],

    "STOP": [X("Two ends", '10 READ X\n20 IF X < 0 THEN 50\n30 PRINT SQR(X)\n40 STOP\n50 PRINT "NEGATIVE"\n'
                           '60 DATA 16\n99 END', "4")],
    "PRINT": [X("Zones and packed output", "10 PRINT 1, 2, 3\n20 PRINT 1; 2; 3\n30 END",
                " 1             2             3\n 1    2    3", "Comma: zones of 15; semicolon: multiples of 3.")],
    "LIST": [X("List from a line", "LIST-100", None, "The program from line 100 on.", manual=True, page="18")],
    "CATALOG": [X("Saved programs", "CATALOG", None)],
}
EXAMPLES_2["FOR...TO...STEP"].append(X("Loop variable with a digit", "10 FOR X1 = 1 TO 2\n20 PRINT X1\n30 NEXT X1\n40 END",
                                        "1\n2", "Checked on DTSS-Win (compiler of February 1965).", verified=True))
EXAMPLES_2["PRINT"].append(X("Element 0 of a list", "10 DIM A(5)\n20 LET A(0) = 1\n30 PRINT A(0)\n40 END", "1",
                             "Subscripts start at 0 from the 2nd edition. Checked on DTSS-Win (compiler of February "
                             "1965).", verified=True))
REFERENCES_2 = [("STOP", "END", "SEE_ALSO"), ("SAVE", "UNSAVE", "SEE_ALSO"), ("NEW", "SCRATCH", "SEE_ALSO"),
                ("OLD", "SAVE", "SEE_ALSO")]
OPEN_QUESTIONS_2 = ["Card BASIC (chapter IV of the October 1964 manual: PAGE, MAT, relations EQU LSS ...) is not "
                    "entered: is it worth a dialect of its own?"]
TABLES_2 = [
    ("CHARACTER_CODES", "COMPLETE", "As in the 1st edition."),
    ("KEYBOARD_CODES", "NOT_APPLICABLE", "No statement reads the keyboard."),
    ("ERRORS", "COMPLETE", "Appendix A of [2] pp. 53-54 (22 messages, found while compiling: the program does not "
                           "run, checked on DTSS-Win with `ILLEGAL FORMULA IN 20`); printed with the line number: `INCORRECT FORMAT IN 5` [2] p. 24. The compiler of "
                           "February 1965 (DTSS-Win) also has run-time messages that do **not** stop the program: "
                           "`SQUARE ROOT OF NEGATIVE NUMBER IN 20` is printed and the run goes on. Limits behind them, appendix B p. 55: about two feet of "
                           "Teletype paper of program, 175 constants and printed labels, 300 data numbers, printed "
                           "labels slightly under 600 characters in all, 26 FOR, 80 GO TO and IF-THEN, 1500 list "
                           "and table elements."),
    ("OPERATOR_PRECEDENCE", "COMPLETE", "As in the 1st edition [2] p. 10."),
    ("VARIABLE_LAYOUT", "TO_DO", "To be taken from the listings [7]."),
    ("PROGRAM_LAYOUT", "TO_DO", "To be taken from the listings [7]."),
    ("MUSICAL_NOTES", "NOT_APPLICABLE", "No sound."),
]

# =====================================================================
# 3rd EDITION - 1966: GE manual of January 1967 [3] and Wikipedia [5]
# =====================================================================
DATA_TYPES_3 = []
PARAMETER_KINDS_3 = [
    ("MATRIX_NAME", "Matrix name", "ARRAY_NAME", None, None, "A list (vector) or table (matrix): one letter."),
]
FEATURES_3 = [
    ("INTEGER_CONVERSION", "Not stated", False,
     "INT now gives the largest integer not greater than the argument (floor) [3] p. 25."),
]
ERRORS_3 = [
    ("OUT_OF_DATA", "OUT OF DATA", "READ finds no data left: the program stops [3] p. 36.", None),
    ("RETURN_BEFORE_GOSUB", "RETURN BEFORE GOSUB", "RETURN with no GOSUB to go back to [3] p. 36.", None),
    ("ILLEGAL_RETURN", None, None, "REMOVE"),
    ("TOO_MANY_LABELS", None, None, "REMOVE"),
    ("GOSUB_TOO_DEEP", "GOSUB NESTED TOO DEEPLY", "Too many GOSUB without RETURN [3] p. 36.", None),
    ("DIVISION_BY_ZERO", "DIVISION BY ZERO", "The program goes on with the largest number as the result [3] p. 36.",
     None),
    ("DIMENSION_ERROR", "DIMENSION ERROR", "Dimensions of the matrices of a MAT statement that do not agree [3] p. 36.",
     None),
    ("NEARLY_SINGULAR", "NEARLY SINGULAR MATRIX", "MAT INV of a matrix that has (almost) no inverse [3] p. 37.", None),
    ("ZERO_NEGATIVE_POWER", "ZERO TO A NEGATIVE POWER", "[3] p. 37.", None),
    ("ABS_RAISED_TO_POWER", "ABSOLUTE VALUE RAISED TO POWER", "A negative base with a non-integer exponent: the "
                                                             "absolute value is used and the program goes on [3] p. 37.",
     None),
    ("OVERFLOW", "OVERFLOW", "A result of about 5.78960E76 or more [3] p. 37.", None),
    ("UNDERFLOW", "UNDERFLOW", "A result smaller than about 4.31809E-78: it becomes 0 [3] p. 37.", None),
    ("EXP_TOO_LARGE", "EXP TOO LARGE", "[3] p. 37.", None),
    ("LOG_NEGATIVE", "LOG OF NEGATIVE NUMBER", "The logarithm of the absolute value is used [3] p. 37.", None),
    ("LOG_ZERO", "LOG OF ZERO", "[3] p. 37.", None),
    ("SQR_NEGATIVE", "SQUARE ROOT OF A NEGATIVE NUMBER", "The root of the absolute value is used [3] p. 37.", None),
]
ERROR_RULES_3 = [
    ("OPERATOR_CLASS", "ARITHMETIC", "OVERFLOW", "The result is too large.", False),
    ("OPERATOR_CLASS", "ARITHMETIC", "UNDERFLOW", "The result is too small: it becomes 0.", False),
]
KEYWORDS_3 = [("INPUT", None), ("RESTORE", None), ("SGN", None), ("MAT", "Starts every matrix statement."),
              ("ZER", None), ("CON", None), ("IDN", None), ("TRN", None), ("INV", None),
              ("LENGTH", None), ("SYSTEM", None)]

MAT_NOTE_3 = ("The matrices must have a DIM. Their subscript 0 can be used [5]. Eleven MAT statements in [3] "
              "pp. 31-34 (from Card BASIC of the 2nd edition). According to Kurtz [9], in the 3rd edition MAT "
              "counts from row and column 0, so `CON(3,4)` is 4 × 5; `MAT A = B` is not allowed (write "
              "`MAT A = (1)*B`); in MAT PRINT the semicolon packs and the comma uses the zones.")
MAT_FORMS_3 = [
    F(S(K("MAT"), P("c", "MATRIX_NAME"), K("="), P("a", "MATRIX_NAME"), K("+"), P("b", "MATRIX_NAME")), {},
      [("MAT_ADD", "FULL", None)], orig="MAT C = A + B", title="Sum"),
    F(S(K("MAT"), P("c", "MATRIX_NAME"), K("="), P("a", "MATRIX_NAME"), K("-"), P("b", "MATRIX_NAME")), {},
      [("MAT_SUB", "FULL", None)], orig="MAT C = A - B", title="Difference"),
    F(S(K("MAT"), P("c", "MATRIX_NAME"), K("="), P("a", "MATRIX_NAME"), K("*"), P("b", "MATRIX_NAME")), {},
      [("MAT_MUL", "FULL", None)], orig="MAT C = A * B", title="Product"),
    F(S(K("MAT"), P("c", "MATRIX_NAME"), K("="), L("("), P("k", att=True), L(")", att=True), K("*"),
        P("a", "MATRIX_NAME")), {"k": dict(descr="Any formula, in parentheses.")},
      [("MAT_SCALAR", "FULL", None)], orig="MAT C = (K) * A", title="Multiple"),
    F(S(K("MAT"), P("c", "MATRIX_NAME"), K("="), K("ZER"), O(S(L("(", att=True), P("m", att=True),
                                                                 O(S(L(",", att=True), P("n", att=True)), att=True),
                                                                 L(")", att=True)), att=True)),
      {"m": dict(descr="Rows (a formula)."), "n": dict(descr="Columns (a formula).")},
      [("MAT_ZERO", "FULL", None)], orig="MAT C = ZER(M,N)", title="Zero matrix"),
    F(S(K("MAT"), P("c", "MATRIX_NAME"), K("="), K("CON"), O(S(L("(", att=True), P("m", att=True),
                                                                 O(S(L(",", att=True), P("n", att=True)), att=True),
                                                                 L(")", att=True)), att=True)),
      {"m": dict(descr="Rows (a formula)."), "n": dict(descr="Columns (a formula).")},
      [("MAT_ONES", "FULL", None)], orig="MAT C = CON(M,N)", title="Ones"),
    F(S(K("MAT"), P("c", "MATRIX_NAME"), K("="), K("IDN"), O(S(L("(", att=True), P("n", att=True), L(")", att=True)), att=True)),
      {"n": dict(descr="Order of the square matrix.")},
      [("MAT_IDENTITY", "FULL", None)], orig="MAT C = IDN(N)", title="Identity"),
    F(S(K("MAT"), P("c", "MATRIX_NAME"), K("="), K("TRN"), L("(", att=True), P("a", "MATRIX_NAME", att=True),
        L(")", att=True)), {}, [("MAT_TRANSPOSE", "FULL", None)], orig="MAT C = TRN(A)", title="Transpose"),
    F(S(K("MAT"), P("c", "MATRIX_NAME"), K("="), K("INV"), L("(", att=True), P("a", "MATRIX_NAME", att=True),
        L(")", att=True)), {}, [("MAT_INVERSE", "FULL", None)], orig="MAT C = INV(A)", title="Inverse"),
]

_minus1 = find(ENTRIES_1, "-", "OPERATOR")
ENTRIES_3 = [
    E("LENGTH", "COMMAND", "Tells the length of the program, in characters.", [
        F(S(K("LENGTH")), {}, [("PROG_LENGTH", "FULL", None)], orig="LENGTH")],
      notes="From the GE manual [3] appendix C (programs up to 6400 characters).", page="41"),
    E("SYSTEM", "COMMAND", "Chooses the language system (BASIC or ALGOL).", [
        F(S(K("SYSTEM")), {}, [("SYSTEM_SELECT", "FULL", None)], orig="SYSTEM")],
      notes="From the GE manual [3] appendix C.", page="41"),
    E("INPUT", "STATEMENT", "Types a question mark and waits for values typed at the Teletype.", [
        F(S(K("INPUT"), R(P("variable", "ANY_VAR"), sep=",")),
          {"variable": dict(descr="Variables or elements, separated by commas; the values are typed the same way.")},
          [("IO_INPUT", "FULL", None)], orig="INPUT X, Y")],
      notes="New in the 3rd edition [5]: for the first time a program can ask for data while it runs. The listings "
            "of February 1965 [7] already have it. DTSS-Win (compiler of February 1965) answers a value it cannot read "
            "with `INPUT DATA NOT IN CORRECT FORMAT. RETYPE IT.` and a new question mark (seen in LIB/GUESS).",
      page="29-30"),
    E("RESTORE", "STATEMENT", "Starts the data list again: the next READ takes the first number.", [
        F(S(K("RESTORE")), {}, [("DATA_RESTORE", "FULL", None)], orig="RESTORE")], page="30"),
    E("SGN", "FUNCTION", "Sign of the argument: 1, 0 or -1.", [
        F(fn("SGN"), {"x": FN_ARG}, [("MATH_SGN", "FULL", None)], orig="SGN(X)", ret=("REAL", -1, 1))],
      notes="Added in the 3rd edition according to source [5]; the GE manual [3] does not list it.", src=SRC_WIKI),
    E("MAT READ", "STATEMENT", "Reads matrices from the data list, row by row.", [
        F(S(K("MAT"), K("READ"), R(P("matrix", "MATRIX_NAME"), sep=",")),
          {"matrix": dict(descr="Matrices with a DIM.")}, [("MAT_READ", "FULL", None)], orig="MAT READ A, B")],
      notes=MAT_NOTE_3, page="31"),
    E("MAT PRINT", "STATEMENT", "Prints matrices, one row per line; a list is printed as a column.", [
        F(S(K("MAT"), K("PRINT"), P("matrix", "MATRIX_NAME"), R(S(C(L(","), L(";")), P("matrix", "MATRIX_NAME")), min=0),
            O(C(L(","), L(";")))),
          {"matrix": dict(descr="Matrices; after ';' a matrix is printed packed.")},
          [("MAT_PRINT", "FULL", None)], orig="MAT PRINT A")],
      notes=MAT_NOTE_3, page="31"),
    E("MAT", "STATEMENT", "Matrix arithmetic: sum, difference, product, multiple, zero, ones, identity, transpose, "
                          "inverse.", MAT_FORMS_3,
      notes=MAT_NOTE_3 + " One operation per statement. Dimensions can be given in parentheses after ZER, CON and IDN.",
      page="32-34"),
    redo(find(ENTRIES_1, "INT", "FUNCTION"), "Floor instead of truncation: INT(-2.35) = -3.",
         descr="Largest integer not greater than the argument.",
         forms=[F(fn("INT"), {"x": FN_ARG}, [("MATH_INT", "FULL", None)], orig="INT(X)", ret=("REAL", None, None))],
         notes="`INT(-2.35)` = -3 [3] p. 25; rounding can now be written `INT(X+.5)` for every X.", page="25",
         src=None),
    redo(_minus1, "The change of sign comes after the power: -X↑2 = -(X↑2).",
         forms=[F(S(K("-"), P("a", att=True)), {}, [("OP_NEG", "FULL", None)], prec=2, op="ARITHMETIC",
                  title="Change of sign", ret=("REAL", None, None)),
                F(binary("-"), {}, [("OP_SUB", "FULL", None)], prec=2, assoc=LEFT, op="ARITHMETIC", title="Subtraction",
                  ret=("REAL", None, None))],
         notes="A leading minus is now applied after the power: `-X↑2` is `-(X↑2)` (source [5]).", page=None,
         src=SRC_WIKI),
    redo(find(ENTRIES_1, "↑", "OPERATOR"), "A negative base with an integer exponent gives the right result.",
         descr="Raise to a power.",
         forms=[F(binary("↑"), {"a": dict(descr="Base: negative only with an integer exponent; otherwise its absolute "
                                                "value is used, with a message.")},
                  [("OP_POWER", "FULL", None)], orig="X↑2", prec=4, assoc=LEFT, op="ARITHMETIC", ret=("REAL", None, None))],
         notes="`(-3)↑3` = -27 [3] p. 37. `A↑B↑C` is `(A↑B)↑C`.", page="37", src=None),
    redo(find(ENTRIES_1, "/", "OPERATOR"), "Division by zero gives a message and the largest number.",
         notes="`A/B/C` is `(A/B)/C`. Division by zero prints DIVISION BY ZERO and goes on with the largest number "
               "[3] p. 36.", page="36", src=None),
    redo(find(ENTRIES_1, "SQR", "FUNCTION"), "A negative argument gives a message.",
         notes="The root of the absolute value is used, with the message SQUARE ROOT OF A NEGATIVE NUMBER [3] p. 37.",
         page="25", src=None),
    redo(find(ENTRIES_1, "LOG", "FUNCTION"), "A negative or zero argument gives a message.",
         notes="The logarithm of the absolute value is used, with the message LOG OF NEGATIVE NUMBER; LOG(0) gives "
               "LOG OF ZERO [3] p. 37.", page="25", src=None),
    redo(find(ENTRIES_1, "EXP", "FUNCTION"), "A result too large gives a message.",
         notes="EXP TOO LARGE when the result is out of range [3] p. 37.", page="25", src=None),
    redo(find(ENTRIES_1, "READ", "STATEMENT"), "Running out of data prints OUT OF DATA.",
         notes="When there is no data left the program stops with the message OUT OF DATA [3] p. 36 (which can be a "
               "normal end).", page="19", src=None),
    redo(find(ENTRIES_1, "GOSUB", "STATEMENT"), "Subroutines can call other subroutines.",
         forms=[F(S(K("GOSUB"), P("n", "LINE_NUMBER")), {"n": LINE}, [("FLOW_GOSUB", "FULL", None)], orig="GOSUB N")],
         notes="GOSUB can be nested; the depth limit is not given (GOSUB NESTED TOO DEEPLY). A subroutine should be "
               "left only with RETURN [3] p. 28.", page="28", src=None),
    redo(find(ENTRIES_1, "RETURN", "STATEMENT"), "The error is now RETURN BEFORE GOSUB, at run time.",
         forms=[F(S(K("RETURN")), {}, [("FLOW_RETURN", "FULL", None)], orig="RETURN")], notes=None, page="28", src=None),
    redo(find(ENTRIES_2, "PRINT", "STATEMENT"), "Packed zones of 6, 9 or 12 characters.",
         notes="';' gives packed zones of 6, 9 or 12 characters; a final comma or semicolon keeps the line open "
               "[3] pp. 23-24.", page="23-24", src=None),
    redo(find(ENTRIES_1, "DATA", "STATEMENT"), "Up to 1280 numbers.",
         notes="Never executed: it can be anywhere. Up to 1280 numbers in all [3] p. 38.", page="20", src=None),
]
ENTRY_ERRORS_3 = {
    "READ": [EE("OUT_OF_DATA", "No data left: the program stops."), EE("NO_DATA", "The program has no DATA statement.")],
    "RETURN": [EE("RETURN_BEFORE_GOSUB", "RETURN with no GOSUB to go back to.")],
    "GOSUB": [EE("GOSUB_TOO_DEEP", "Too many nested GOSUB.")],
    "/": [EE("DIVISION_BY_ZERO", "The divisor is 0: the program goes on with the largest number.")],
    "↑": [EE("ZERO_NEGATIVE_POWER", "0 raised to a negative power."),
          EE("ABS_RAISED_TO_POWER", "A negative base with a non-integer exponent.")],
    "SQR": [EE("SQR_NEGATIVE", "The argument is negative: the root of its absolute value is used.")],
    "LOG": [EE("LOG_NEGATIVE", "The argument is negative: the logarithm of its absolute value is used."),
            EE("LOG_ZERO", "The argument is 0.")],
    "EXP": [EE("EXP_TOO_LARGE", "The result is out of range.")],
    "MAT": [EE("DIMENSION_ERROR", "The dimensions of the matrices do not agree."),
            EE("NEARLY_SINGULAR", "The matrix has no inverse.", form=9)],
    "MAT READ": [EE("OUT_OF_DATA", "No data left.")],
    "INPUT": [EE("ILLEGAL_VARIABLE", "An item of the list is not a variable.")],
}
EXAMPLES_3 = {
    "INPUT": [X("Ask for two numbers", "10 INPUT A, B\n20 PRINT A+B\n30 END", "?", "Type 2, 3 and RETURN: 5 is printed.")],
    "RESTORE": [X("Read the data twice", "10 READ A, B\n20 RESTORE\n30 READ C\n40 PRINT A, B, C\n50 DATA 1, 2\n60 END",
                  "1             2             1")],
    "SGN": [X("Signs", "10 PRINT SGN(-5), SGN(0), SGN(3)\n20 END", "-1            0             1")],
    "MAT READ": [X("Read and print a matrix", "10 DIM A(2,3)\n20 MAT READ A\n30 MAT PRINT A\n40 DATA 1,2,3,4,5,6\n50 END",
                   " 1             2             3\n\n 4             5             6")],
    "MAT PRINT": [X("Packed", "10 DIM A(2,2)\n20 MAT A = IDN\n30 MAT PRINT A;\n40 END", None)],
    "MAT": [X("Product", "10 DIM A(2,2), B(2,2), C(2,2)\n20 MAT READ A, B\n30 MAT C = A * B\n40 MAT PRINT C\n"
                         "50 DATA 1,2,3,4, 1,0,0,1\n60 END", " 1             2\n\n 3             4", form=3),
            X("Inverse", "10 DIM A(2,2), B(2,2)\n20 MAT READ A\n30 MAT B = INV(A)\n40 MAT PRINT B\n50 DATA 2,0,0,4\n60 END",
              " .5            0\n\n 0             .25", form=9)],
    "INT": [X("Floor", "10 PRINT INT(7.8), INT(-2.35)\n20 END", "7            -3", manual=True, page="25")],
    "-": [X("Minus after the power", "10 LET X = 3\n20 PRINT -X↑2\n30 END", "-9", form=1)],
    "↑": [X("Negative base, integer exponent", "10 PRINT (-3)↑3\n20 END", "-27", manual=True, page="37")],
    "/": [X("Division by zero", "10 PRINT 1/0\n20 END", "DIVISION BY ZERO IN 10", "Then the largest number is printed.")],
    "GOSUB": [X("Nested subroutines", "10 GOSUB 100\n20 STOP\n100 GOSUB 200\n110 RETURN\n200 PRINT \"DEEP\"\n210 RETURN\n"
                                      "999 END", "DEEP")],
}
EXAMPLES_3["GOSUB"].append(X("Nested subroutines, checked", '10 GOSUB 100\n20 PRINT "BACK IN MAIN"\n30 STOP\n'
                              '100 PRINT "OUTER"\n110 GOSUB 200\n120 PRINT "BACK IN OUTER"\n130 RETURN\n200 PRINT "INNER"\n'
                              '210 RETURN\n220 END', "OUTER\nINNER\nBACK IN OUTER\nBACK IN MAIN",
                              "Checked on DTSS-Win (compiler of February 1965).", verified=True))
EXAMPLES_3["READ"] = [X("Out of data", "10 READ A\n20 PRINT A\n30 READ B\n40 PRINT \"AFTER\"\n50 DATA 5\n99 END",
                        "5\n\nOUT OF DATA IN 30", "The program stops: AFTER is not printed. Checked on DTSS-Win "
                        "(compiler of February 1965), with the same lines numbered 50-90.", verified=True)]
EXAMPLES_3["LOG"] = EXAMPLES_1["LOG"] + [X("Logarithm of a negative number", "10 PRINT LOG(-1)\n20 END",
                                           "LOG OF NEGATIVE NUMBER IN 10\n 0", "The logarithm of the absolute value "
                                           "is printed and the program goes on. Checked on DTSS-Win (compiler of "
                                           "February 1965).", verified=True)]
REFERENCES_3 = [("READ", "RESTORE", "SEE_ALSO"), ("INPUT", "READ", "SEE_ALSO"), ("MAT READ", "MAT", "SEE_ALSO"),
                ("MAT PRINT", "MAT", "SEE_ALSO"), ("SGN", "ABS", "SEE_ALSO")]
OPEN_QUESTIONS_3 = [
    "The 3rd edition is built from the GE manual of January 1967 and from Wikipedia: check it against the Dartmouth "
    "3rd edition manual (1 January 1966) if it can be found. SGN, the unary minus after the power and INT as floor "
    "are now confirmed by Kurtz [9].",
]
TABLES_3 = [
    ("CHARACTER_CODES", "COMPLETE", "As in the 1st edition."),
    ("KEYBOARD_CODES", "NOT_APPLICABLE", "INPUT reads whole lines."),
    ("ERRORS", "COMPLETE", "From the GE manual [3] appendix A: compile-time messages and run-time messages; some run-time "
                           "errors only print a message and the program goes on."),
    ("OPERATOR_PRECEDENCE", "COMPLETE", "The change of sign now comes after the power (source [5])."),
    ("VARIABLE_LAYOUT", "TO_DO", "Not documented."),
    ("PROGRAM_LAYOUT", "TO_DO", "Not documented."),
    ("MUSICAL_NOTES", "NOT_APPLICABLE", "No sound."),
]

# =====================================================================
# 4th EDITION - January 1968 [4]
# =====================================================================
DATA_TYPES_4 = [
    ("REAL", "Number", None, "REAL", -1.70141e38, 1.70141e38, None, "9 digits",
     "Floating point of the GE-635. Constants of up to nine digits, with E and an exponent: `1E7`, `.123456789E-2` "
     "[4] p. 14. The largest value is inferred from EXP TOO LARGE (an argument above 88.029 [4] p. 72): about "
     "1.70141E38."),
    ("STRING", "String", "$", "STRING", None, None, None, None,
     "No fixed maximum length: a string longer than 60 characters needs a DIM, e.g. `DIM A$(1000)` [4] p. 75. "
     "Only assignment, READ, INPUT, PRINT, comparison and CHANGE: no joining or substrings."),
]
VARIABLE_KINDS_4 = [
    ("NUMERIC", "Variable", "REAL", 0, "one letter, or one letter followed by one digit", r"^[A-Z][0-9]?$", 2, 0,
     "A, X, N5, X0, K9", "All variables are 0 when the program starts [4] p. 15."),
    ("STRING", "String variable", "STRING", 0, "a variable name followed by $", r"^[A-Z][0-9]?\$$", 2, 0, "A$, C7$",
     "Empty when the program starts (not stated)."),
    ("STRING_LIST", "String list", "STRING", 1, "one letter followed by $ and a subscript in parentheses", r"^[A-Z]\$$",
     1, 0, "V$(3)", "One dimension only: there are no string tables [4] p. 63."),
]
PARAMETER_KINDS_4 = [
    ("STR_LITERAL", "String", "LITERAL", "STRING", None,
     "In quotes; in DATA and INPUT also without quotes if it starts with a letter and has no comma [4] p. 64."),
    ("STR_EXPR", "String value", "EXPRESSION", "STRING", None, "A string in quotes, a string variable or a list element."),
    ("STR_VAR", "String variable", "VARIABLE", None, "STRING", None),
    ("STR_LIST_ELEMENT", "String list element", "ARRAY_ELEMENT", None, "STRING_LIST", "E.g. V$(3)."),
    ("ANY_VAR", "Variable or element", "VARIABLE", None, None, "A numeric or string variable, or an element of a list or "
                                                                "table."),
    ("CONDITION", "Relation", "CONDITION", "ANY", None,
     "Two formulas, or two strings, joined by one relation: = < <= > >= <>. Strings are compared in alphabetical "
     "order, trailing blanks ignored [4] p. 65."),
    ("LINE_LIST", "Line numbers", "LITERAL", "INTEGER", None, "Line numbers separated by commas."),
]
FEATURES_4 = [
    ("INTEGER_CONVERSION", "Integer part (floor)", False,
     "ON and TAB use the integer part of their formula [4] pp. 36, 40; INT is the floor."),
    ("FOR_VARIABLE_CHANGEABLE", "Yes", False,
     "The start, limit and step are computed once; the body may change the variable, and the end test uses its "
     "current value [4] p. 37."),
    ("VARIABLE_TAB_STOPS", "No", False, "TAB(n) in PRINT moves to column n (0-74), but there are no tab stops."),
]
ERRORS_4 = [
    ("INCORRECT_FORMAT", "ILLEGAL FORMAT", "The form of the statement is wrong [4] p. 70.", "REPLACE"),
    ("NO_DATA", None, None, "REMOVE"),
    ("NO_NUMERIC_DATA", "NO NUMERIC DATA", "READ of a number, but no number in DATA [4] p. 70.", None),
    ("NO_STRING_DATA", "NO STRING DATA", "READ of a string, but no string in DATA [4] p. 70.", None),
    ("UNDEFINED_FUNCTION", "UNDEFINED FUNCTION FN", "A function FN is used but never defined [4] p. 70.", "REPLACE"),
    ("UNDEFINED_NUMBER", "UNDEFINED LINE NUMBER", "A jump to a line that does not exist: `UNDEFINED LINE NUMBER 50 IN "
                                                  "20` [4] p. 31.", "REPLACE"),
    ("NOT_MATCH_WITH_FOR", "NEXT WITHOUT FOR", "NEXT with no FOR, or loops crossed [4] p. 30.", "REPLACE"),
    ("PROGRAM_TOO_LONG", None, None, "REMOVE"),
    ("TOO_MUCH_DATA", None, None, "REMOVE"),
    ("TOO_MANY_LOOPS", None, None, "REMOVE"),
    ("NEARLY_SINGULAR", None, None, "REMOVE"),
    ("SQR_NEGATIVE", "SQUARE ROOT OF NEGATIVE NUMBER", "The root of the absolute value is used [4] p. 72.", "REPLACE"),
    ("ILLEGAL_CHARACTER", "ILLEGAL CHARACTER", "[4] p. 70.", None),
    ("WRONG_ARGUMENTS", "INCORRECT NUMBER OF ARGUMENTS", "[4] p. 70.", None),
    ("WRONG_SUBSCRIPTS", "INCORRECT NUMBER OF SUBSCRIPTS", "[4] p. 70.", None),
    ("FORS_TOO_DEEP", "FORS NESTED TOO DEEPLY", "[4] p. 71.", None),
    ("ILLEGAL_LINE_REFERENCE", "ILLEGAL LINE REFERENCE", "E.g. a jump into a multi-line DEF [4] p. 71.", None),
    ("UNFINISHED_DEF", "UNFINISHED DEF", "A multi-line DEF without FNEND [4] p. 71.", None),
    ("NESTED_DEF", "NESTED DEF", "A DEF inside a multi-line DEF [4] p. 71.", None),
    ("TOO_COMPLICATED", "EXPRESSION TOO COMPLICATED", "[4] p. 71.", None),
    ("TOO_MANY_CONSTANTS", "TOO MANY CONSTANTS", "More than 100 constants (small integers do not count) [4] p. 75.",
     None),
    ("ILLEGAL_MAT_TRANSPOSE", "ILLEGAL MAT TRANSPOSE", "E.g. MAT A = TRN(A) [4] p. 71.", None),
    ("ILLEGAL_MAT_FUNCTION", "ILLEGAL MAT FUNCTION", "[4] p. 71.", None),
    ("ILLEGAL_MAT_MULTIPLE", "ILLEGAL MAT MULTIPLE", "E.g. MAT A = A * B [4] p. 71.", None),
    ("MISMATCHED_STRING", "MISMATCHED STRING OPERATION", "A string where a number is wanted, or the other way round "
                                                         "[4] p. 71.", None),
    ("SYSTEM_ERROR", "SYSTEM ERROR", "[4] p. 71.", None),
    ("ON_OUT_OF_RANGE", "ON EVALUATED OUT OF RANGE", "The formula of ON is below 1 or beyond the list [4] p. 72.", None),
    ("USELESS_LOOP", "USELESS LOOP", "[4] p. 72.", None),
    ("OUT_OF_ROOM", "OUT OF ROOM", "[4] p. 72.", None),
    ("TIME_UP", "TIME UP - LOOPING", "Only in TEACH programs [4] p. 72.", None),
    ("INPUT_FORMAT", "INPUT DATA NOT IN CORRECT FORMAT--RETYPE IT", "[4] p. 73.", None),
    ("NOT_ENOUGH_INPUT", "NOT ENOUGH INPUT--ADD MORE", "[4] p. 73.", None),
    ("TOO_MUCH_INPUT", "TOO MUCH INPUT--EXCESS IGNORED", "[4] p. 73.", None),
]
ERROR_RULES_4 = [
    ("PARAMETER_KIND", "STR_EXPR", "MISMATCHED_STRING", "A number where a string is wanted.", False),
    ("PARAMETER_KIND", "NUM_EXPR", "MISMATCHED_STRING", "A string where a number is wanted.", False),
    ("PARAMETER_KIND", "LIST_ELEMENT", "WRONG_SUBSCRIPTS", "Two subscripts for a list.", False),
    ("PARAMETER_KIND", "TABLE_ELEMENT", "WRONG_SUBSCRIPTS", "One subscript for a table.", False),
]
KEYWORDS_4 = [("ON", None), ("TAB", None), ("RANDOMIZE", "RANDOM also accepted [4] p. 45."), ("CHANGE", None),
              ("FNEND", None), ("COT", None), ("NUM", None), ("DET", None), ("RESTORE*", None), ("RESTORE$", None),
              ("'", "Remark to the end of the line."), ("BYE", "GOODBYE is also accepted [4] p. 27."),
              ("REPLACE", None)]

_input3 = find(ENTRIES_3, "INPUT", "STATEMENT")
PRINT_ITEM_4 = C(P("label", "LABEL"), P("formula"), P("string", "STR_EXPR"), S(K("TAB"), L("(", att=True),
                                                                                P("n", att=True), L(")", att=True)))
ENTRIES_4 = [
    E("BYE", "COMMAND", "Ends the session.", [
        F(S(K("BYE")), {}, [("SESSION_END", "FULL", None)], orig="BYE")], notes="Also GOODBYE [4] p. 27.", page="27"),
    E("REPLACE", "COMMAND", "Saves the program in place of the saved copy with the same name.", [
        F(S(K("REPLACE")), {}, [("TAPE_SAVE", "PARTIAL", "Replaces the saved copy")], orig="REPLACE")], page="78"),
    redo(find(ENTRIES_1, "LET", "STATEMENT"), "Strings, and several variables in one LET.",
         forms=[F(C(S(K("LET"), R(S(C(P("variable", "NUM_VAR"), P("variable", "LIST_ELEMENT"),
                                       P("variable", "TABLE_ELEMENT")), K("="))), P("formula")),
                    S(K("LET"), R(S(C(P("variable", "STR_VAR"), P("variable", "STR_LIST_ELEMENT")), K("="))),
                      P("formula", "STR_EXPR"))),
                  {"variable": dict(descr="Numeric or string variables or elements; several can get the same value."),
                   "formula": dict(descr="A formula, or a string for string variables.")},
                  [("VAR_LET", "FULL", None)], orig="LET X = Y = A(3,1) = 1")],
         notes="`LET X = Y = A(3,1) = 1` gives all three the value 1 [4] p. 33.", page="32-33", src=None),
    redo(find(ENTRIES_3, "PRINT", "STATEMENT"), "Strings and TAB(n).",
         forms=[F(S(K("PRINT"), O(S(PRINT_ITEM_4, R(S(PRINT_SEP_2, PRINT_ITEM_4), min=0), O(PRINT_SEP_2)))),
                  {"label": dict(descr="Text in quotes."), "formula": dict(descr="Any formula."),
                   "string": dict(descr="A string variable or element."),
                   "n": dict(descr="Column 0 to 74: integer part, taken modulo 75.", conversion="TRUNCATE")},
                  [("IO_PRINT", "FULL", None), ("IO_POSITION", "FULL", "TAB(n)")], orig="PRINT",
                  descr="',' moves to the next of five zones of 15 columns; ';' packs: a number is printed as its sign "
                        "(minus or space), the digits and one space. A final ',' or ';' keeps the line open.")],
         notes="Integers of more than eight digits are printed as `1.34218 E+8`; other numbers with up to six "
               "significant digits, below 0.1 in E form unless they fit in six decimal places [4] p. 41.",
         page="34, 38-42", src=None),
    redo(_input3, "Strings, and messages for wrong input.",
         notes="Types `?`; the values are separated by commas. A PRINT ending with ';' keeps the question mark on its "
               "line. Strings can be typed without quotes if they start with a letter [4] pp. 50-51, 64.",
         page="50-51", src=None),
    redo(find(ENTRIES_3, "READ", "STATEMENT"), "Strings; the data are two separate lists.",
         notes="Numbers and strings of the DATA statements form two separate lists: a numeric READ takes the next "
               "number, a string READ the next string [4] p. 66. When the data run out: OUT OF DATA [4] p. 33.",
         page="33, 66", src=None),
    redo(find(ENTRIES_3, "DATA", "STATEMENT"), "Strings too.",
         forms=[F(S(K("DATA"), R(C(P("item", "NUM_LITERAL"), P("item", "STR_LITERAL")), sep=",")),
                  {"item": dict(descr="Numbers (not formulas) and strings, separated by commas.")},
                  [("DATA_DEFINE", "FULL", None)], orig="DATA")],
         notes="Never executed; all DATA statements form one list, in the order of their numbers [4] p. 33-34.",
         page="33-34", src=None),
    redo(find(ENTRIES_3, "RESTORE", "STATEMENT"), "RESTORE* and RESTORE$ restart only one of the two data lists.",
         forms=[F(S(K("RESTORE")), {}, [("DATA_RESTORE", "FULL", None)], orig="RESTORE", title="Both lists"),
                F(S(K("RESTORE*")), {}, [("DATA_RESTORE", "PARTIAL", "Only the numbers")], orig="RESTORE*",
                  title="Numbers"),
                F(S(K("RESTORE$")), {}, [("DATA_RESTORE", "PARTIAL", "Only the strings")], orig="RESTORE$",
                  title="Strings")],
         notes=None, page="52, 66", src=None),
    redo(find(ENTRIES_1, "IF...THEN", "STATEMENT"), "Strings can be compared; GO TO can replace THEN.",
         forms=[F(S(K("IF"), P("relation", "CONDITION"), C(K("THEN"), K("GO TO")), P("n", "LINE_NUMBER")),
                  {"relation": dict(descr="Two formulas or two strings joined by a relation."), "n": LINE},
                  [("FLOW_IF", "PARTIAL", "Only a jump, no ELSE")], orig="IF ... THEN line")],
         notes=IF_NOTE, page="35-36", src=None),
    E("ON...GO TO", "STATEMENT", "Jumps to the first, second, ... line of the list, according to the value of a formula.", [
        F(S(K("ON"), P("f"), C(K("GO TO"), K("THEN")), P("lines", "LINE_LIST")),
          {"f": dict(descr="Integer part 1 selects the first line, 2 the second, ...", conversion="TRUNCATE"),
           "lines": dict(descr="Line numbers separated by commas.", missing_line="ERROR", error="UNDEFINED_NUMBER")},
          [("FLOW_ON_GOTO", "FULL", None)], orig="ON expr GO TO l1, l2, ...")],
      notes="THEN can be written instead of GO TO [4] p. 36.", page="36"),
    E("RANDOMIZE", "STATEMENT", "Starts RND from an unpredictable point.", [
        F(S(K("RANDOMIZE")), {}, [("RND_SEED", "PARTIAL", "No seed value: an unpredictable start")], orig="RANDOMIZE")],
      notes="Without it RND gives the same numbers at every run: leave it out while debugging [4] p. 45.", page="45"),
    E("CHANGE", "STATEMENT", "Turns a string into a list of character codes, or a list of codes into a string.", [
        F(S(K("CHANGE"), P("s", "STR_VAR"), K("TO"), P("v", "ARRAY_NAME")),
          {"s": dict(descr="A string variable."), "v": dict(descr="A numeric list: element 0 gets the length, the "
                                                                  "others the codes.")},
          [("STR_TO_CODES", "FULL", None)], orig="CHANGE A$ TO A", title="String to codes"),
        F(S(K("CHANGE"), P("v", "ARRAY_NAME"), K("TO"), P("s", "STR_VAR")),
          {"v": dict(descr="A numeric list: element 0 holds the number of characters."), "s": dict(descr="A string variable.")},
          [("STR_FROM_CODES", "FULL", None)], orig="CHANGE A TO A$", title="Codes to string")],
      notes="The codes are those of the table of [4] pp. 67-68 (ASCII: A = 65).", page="67-69"),
    redo(find(ENTRIES_1, "DEF", "STATEMENT"), "Functions without argument, and functions of several lines ended by "
                                              "FNEND.",
         forms=[F(S(K("DEF"), K("FN"), P("letter", "FN_LETTER", att=True),
                    O(S(L("(", att=True), P("argument", "NUM_VAR", att=True), L(")", att=True)), att=True), K("="), P("formula")),
                  {"letter": dict(descr="A to Z."), "argument": dict(descr="Optional: `DEF FNA = 3.1416*R↑2`."),
                   "formula": dict(descr="Any formula; other variables take their values at the time of the call.")},
                  [("FN_DEFINE", "FULL", None)], orig="DEF FNA(X) = formula", title="One line"),
                F(S(K("DEF"), K("FN"), P("letter", "FN_LETTER", att=True),
                    O(S(L("(", att=True), P("argument", "NUM_VAR", att=True), L(")", att=True)), att=True)),
                  {"letter": dict(descr="A to Z."), "argument": dict(descr="Optional.")},
                  [("FN_DEFINE", "FULL", "Several lines, ended by FNEND")], orig="DEF FNA(X)", title="Several lines",
                  descr="The lines that follow compute the result and give it to FNx (`LET FNA = ...`); FNEND ends "
                        "the definition.")],
         notes="Multi-line DEFs cannot be nested, and no jump may enter or leave them [4] p. 48. Whether a function "
               "can have more than one argument is to be checked in the manual.", page="46-48", src=None),
    E("FNEND", "STATEMENT", "Ends a function of several lines.", [
        F(S(K("FNEND")), {}, [("FN_END", "FULL", None)], orig="FNEND")], page="47"),
    E("'", "STATEMENT", "Remark after an apostrophe, also at the end of a statement.", [
        F(S(K("'"), O(P("text", "FREE_TEXT", att=True))), {"text": dict(descr="Any text.")},
          [("PROG_REM", "FULL", None)], orig="'")],
      notes="It does not work on a line ending with a string in quotes [4] p. 52.", page="52"),
    redo(find(ENTRIES_1, "RND", "FUNCTION"), "No argument.",
         forms=[F(S(K("RND")), {}, [("RND_VALUE", "PARTIAL", "Only between 0 and 1")], orig="RND", ret=("REAL", 0, 1))],
         notes="`INT(A*RND+B)` gives integers from B to A+B-1 [4] p. 44. The same sequence at every run unless "
               "RANDOMIZE is used.", page="43-44", src=None),
    E("COT", "FUNCTION", "Cotangent; the argument is in radians.", [
        F(fn("COT"), {"x": FN_ARG}, [("MATH_COT", "FULL", None)], orig="COT(X)", ret=("REAL", None, None))], page="13"),
    E("TAB", "FUNCTION", "In PRINT: moves to a column.", [
        F(S(K("TAB"), L("(", att=True), P("n", att=True), L(")", att=True)),
          {"n": dict(descr="Column 0 to 74: integer part, modulo 75.", conversion="TRUNCATE")},
          [("IO_POSITION", "FULL", None)], orig="TAB(N)")],
      notes="Ignored if the print position has already passed the column [4] pp. 40-41.", page="40-41"),
    E("NUM", "FUNCTION", "Number of values read by the last MAT INPUT.", [
        F(S(K("NUM")), {}, [("MAT_INPUT_COUNT", "FULL", None)], orig="NUM", ret=("REAL", 0, None))], page="57"),
    E("DET", "FUNCTION", "Determinant of the matrix inverted by the last MAT INV.", [
        F(S(K("DET")), {}, [("MAT_DET", "FULL", None)], orig="DET", ret=("REAL", None, None))],
      notes="0 if the matrix had no inverse: the program goes on [4] pp. 59-60.", page="59-61"),
    E("MAT INPUT", "STATEMENT", "Reads a list from the Teletype; its length need not be given.", [
        F(S(K("MAT"), K("INPUT"), P("v", "MATRIX_NAME")), {"v": dict(descr="A list.")},
          [("MAT_INPUT", "FULL", None)], orig="MAT INPUT V")],
      notes="NUM gives the number of values typed; `&` before RETURN continues on the next line [4] p. 57.",
      page="57-58"),
    redo(find(ENTRIES_3, "MAT", "STATEMENT"), "Copy of a matrix (MAT B = A); INV sets DET.",
         forms=MAT_FORMS_3 + [F(S(K("MAT"), P("b", "MATRIX_NAME"), K("="), P("a", "MATRIX_NAME")), {},
                                [("MAT_COPY", "FULL", None)], orig="MAT B = A", title="Copy")],
         notes="Default dimensions: 10 for a list, 10 × 10 for a table; row and column 0 are ignored by MAT but take "
               "room. `MAT A = A * B` and `MAT A = TRN(A)` are not allowed. A matrix with no inverse does not stop the "
               "program: DET is 0 [4] pp. 53-61.", page="53-61", src=None),
]
# Relations between strings (4th edition): the six operators get a second form.
for _op, _action in (("=", "OP_EQ"), ("<>", "OP_NE"), (">", "OP_GT"), (">=", "OP_GE"), ("<", "OP_LT"), ("<=", "OP_LE")):
    _e = find(ENTRIES_1, _op, "OPERATOR")
    _num = copy.deepcopy(_e["forms"][0])
    _num["title"] = "Between numbers"
    ENTRIES_4.append(redo(_e, "Also between two strings.", forms=[
        _num,
        F(binary(_op, "STR_EXPR"), {}, [(_action.replace("OP_", "OP_STR_"), "FULL", None)], prec=1, op="RELATIONAL",
          title="Between strings", page="65")],
        notes="Strings are compared in alphabetical order, trailing blanks ignored [4] p. 65.", page="12, 65"))

ENTRY_ERRORS_4 = {
    "ON...GO TO": [EE("ON_OUT_OF_RANGE", "The integer part is below 1 or beyond the number of lines.")],
    "DEF": [EE("NESTED_DEF", "A DEF inside a function of several lines.", form=2),
            EE("UNFINISHED_DEF", "No FNEND.", form=2)],
    "READ": [EE("OUT_OF_DATA", "No data left."), EE("NO_NUMERIC_DATA", "A number is read but DATA holds none."),
             EE("NO_STRING_DATA", "A string is read but DATA holds none.")],
    "INPUT": [EE("INPUT_FORMAT", "The values typed are not in the right form."),
              EE("NOT_ENOUGH_INPUT", "Fewer values than variables."), EE("TOO_MUCH_INPUT", "More values than variables.")],
    "MAT": [EE("DIMENSION_ERROR", "The dimensions of the matrices do not agree."),
            EE("ILLEGAL_MAT_MULTIPLE", "The result is also a factor: MAT A = A * B.", form=3),
            EE("ILLEGAL_MAT_TRANSPOSE", "MAT A = TRN(A).", form=8)],
    "MAT INPUT": [EE("INPUT_FORMAT", "The values typed are not in the right form.")],
    "CHANGE": [EE("MISMATCHED_STRING", "The two sides are not a string and a list.")],
}
EXAMPLES_4 = {
    "LET": [X("Several at once", "10 LET X = Y = 1\n20 LET A$ = \"YES\"\n30 PRINT X; Y; A$\n40 END", " 1  1 YES")],
    "PRINT": [X("Columns", '10 PRINT "A"; TAB(10); "B"\n20 END', "A         B", "B in column 10.")],
    "INPUT": [X("A name", '10 PRINT "NAME";\n20 INPUT N$\n30 PRINT "HELLO "; N$\n40 END', "NAME?")],
    "READ": [X("Numbers and strings", '10 READ A$, N\n20 PRINT A$; N\n30 DATA "TEN", 10\n40 END', "TEN 10")],
    "DATA": [X("Unquoted string", "10 READ A$\n20 PRINT A$\n30 DATA HELLO\n40 END", "HELLO")],
    "RESTORE": [X("Only the strings", '10 READ A$, B$, N\n20 RESTORE$\n30 READ C$\n40 PRINT C$; N\n'
                                      '50 DATA "X", "Y", 5\n60 END', "X 5", form=3)],
    "IF...THEN": [X("Strings", '10 INPUT A$\n20 IF A$ = "YES" THEN 50\n30 PRINT "NO"\n40 STOP\n50 PRINT "OK"\n60 END',
                    None, "Trailing blanks do not count: \"YES \" = \"YES\".")],
    "ON...GO TO": [X("Three ways", '10 INPUT K\n20 ON K GO TO 100, 200, 300\n100 PRINT "ONE"\n110 STOP\n'
                                   '200 PRINT "TWO"\n210 STOP\n300 PRINT "THREE"\n999 END', None,
                     "Type 2: TWO is printed.")],
    "RANDOMIZE": [X("Dice", "10 RANDOMIZE\n20 FOR I = 1 TO 5\n30 PRINT INT(6*RND+1);\n40 NEXT I\n50 END", None,
                    "Different numbers at every run.")],
    "CHANGE": [X("Codes to string", "10 DIM A(5)\n20 FOR I = 0 TO 5\n30 READ A(I)\n40 NEXT I\n50 CHANGE A TO A$\n"
                                    "60 PRINT A$\n70 DATA 5, 65, 66, 67, 68, 69\n80 END", "ABCDE", form=2, manual=True,
                 page="68-69"),
               X("String to codes", '10 DIM A(10)\n20 LET A$ = "A"\n30 CHANGE A$ TO A\n40 PRINT A(0); A(1)\n50 END',
                 " 1  65", form=1)],
    "DEF": [X("Several lines", "10 DEF FNM(X)\n20 LET FNM = X\n30 IF X >= 0 THEN 50\n40 LET FNM = -X\n50 FNEND\n"
                               "60 PRINT FNM(-4)\n70 END", "4", form=2),
            X("No argument", "10 LET R = 2\n20 DEF FNA = 3.1416*R↑2\n30 PRINT FNA\n40 END", "12.5664", form=1)],
    "FNEND": [X("End of a function", "10 DEF FNS(X)\n20 LET FNS = X*X\n30 FNEND\n40 PRINT FNS(3)\n50 END", "9")],
    "'": [X("Remark at the end", "10 LET P = 3.14159 ' PI\n20 PRINT P\n30 END", "3.14159")],
    "RND": [X("Integers 1 to 6", "10 PRINT INT(6*RND+1)\n20 END", None)],
    "COT": [X("Cotangent", "10 PRINT COT(.785398)\n20 END", "1")],
    "TAB": [X("Column 20", '10 PRINT TAB(20); "*"\n20 END', "                    *")],
    "NUM": [X("Average of the typed values", "10 MAT INPUT V\n20 LET N = NUM\n30 IF N = 0 THEN 99\n40 LET S = 0\n"
                                             "50 FOR I = 1 TO N\n60 LET S = S + V(I)\n70 NEXT I\n80 PRINT S/N\n99 END",
              None, manual=True, page="53")],
    "DET": [X("Determinant", "10 DIM A(2,2), B(2,2)\n20 MAT READ A\n30 MAT B = INV(A)\n40 PRINT DET\n50 DATA 1,2,3,4\n"
                             "60 END", "-2")],
    "MAT INPUT": [X("A list from the keyboard", "10 MAT INPUT V\n20 PRINT NUM\n30 END", "?", "Type 1,2,3: 3 is printed.")],
    "BYE": [X("End of the session", "BYE", None)],
}
REFERENCES_4 = [("ON...GO TO", "GO TO", "SEE_ALSO"), ("RANDOMIZE", "RND", "SEE_ALSO"), ("TAB", "PRINT", "SEE_ALSO"),
                ("DEF", "FNEND", "OPENS_BLOCK"), ("MAT INPUT", "NUM", "SEE_ALSO"), ("MAT", "DET", "SEE_ALSO"),
                ("'", "REM", "SEE_ALSO"), ("COT", "TAN", "SEE_ALSO")]
OPEN_QUESTIONS_4 = [
    "DEF: can a function have more than one argument in the 4th edition? Maximum string length (strings over 60 "
    "characters need a DIM)? GOSUB and FOR nesting limits?",
]
TABLES_4 = [
    ("CHARACTER_CODES", "COMPLETE", "The table of CHANGE [4] p. 68: printable characters 32-94, the back arrow 95 "
                                    "(\"useful on output\"), EOT 4, BELL 7, LF 10, CR 13, RUB-OUT 127 (tape only); "
                                    "128 codes in all, the others duplicates, lower case for other Teletypes, or useless."),
    ("KEYBOARD_CODES", "NOT_APPLICABLE", "INPUT reads whole lines."),
    ("ERRORS", "COMPLETE", "Section 2.8 of [4] pp. 70-73: compile-time messages, run-time messages that stop the "
                           "program or let it go on, input messages. Printed with the line: `OUT OF DATA IN 20`."),
    ("OPERATOR_PRECEDENCE", "COMPLETE", "As in the 3rd edition [4] p. 12."),
    ("VARIABLE_LAYOUT", "TO_DO", "Not documented. Size rule of thumb: C/4 + M + S < 8000 (C characters of the "
                                 "program, M array elements, S strings) [4] p. 74."),
    ("PROGRAM_LAYOUT", "TO_DO", "Not documented."),
    ("MUSICAL_NOTES", "NOT_APPLICABLE", "No sound."),
]

# =====================================================================
# CARD BASIC - October 1964 [2] chapter IV (on top of the 2nd edition)
# =====================================================================
VARIABLE_KINDS_C = [
    ("LIST", "List", "REAL", 1, "one letter followed by a subscript in parentheses", r"^[A-Z]$", 1, 0, "A(5), B(I+1)",
     "At most 1000 elements in a list; at most 4000 elements in all lists and tables. Matrices start with element "
     "1, not 0 [2] p. 51."),
    ("TABLE", "Table", "REAL", 2, "one letter followed by two subscripts in parentheses", r"^[A-Z]$", 1, 0,
     "B(1,1), M(I,J)", "No dimension above 500; at most 4000 elements in all lists and tables. Matrices start with "
                       "element 1, not 0 [2] p. 51."),
]
PARAMETER_KINDS_C = [
    ("LABEL", "Label", "LITERAL", "STRING", None, "Text between single quotes ('), which replace the double quotes "
                                                  "on the cards [2] p. 50."),
    ("MATRIX_NAME", "Matrix name", "ARRAY_NAME", None, None, "A list (vector) or table (matrix) with a DIM."),
]
FEATURES_C = [
    ("TAB_ZONE_WIDTH", "8 zones per line", False,
     "The high-speed printer prints 8 numbers per line, up to 18 in packed format [2] p. 50; the width of a zone is "
     "not given."),
]
KEYWORDS_C = [("EQU", None), ("NQU", None), ("LSS", None), ("LQU", None),
              ("GRT", "Greater than, on the cards [2] p. 50."), ("GQU", None),
              ("PAGE", None), ("MAT", "Starts every matrix statement."),
              ("ZER", None), ("CON", None), ("IDN", None), ("TRN", None), ("INV", None)]

CARD_INF = "Inferred: Card BASIC is run from a deck of cards, and the manual does not describe Teletype commands for it."
ENTRIES_C = [REMOVE(_c, "COMMAND", CARD_INF) for _c in ("HELLO", "RUN", "LIST", "SAVE", "STOP", "NEW", "OLD",
                                                        "SCRATCH", "RENAME", "CATALOG", "UNSAVE")]
ENTRIES_C += [REMOVE(_op, "OPERATOR", "Relations are written as three-letter words on the cards [2] p. 50.")
              for _op in ("=", "<>", "<", "<=", ">", ">=")]
for _op, _action, _name, _sym in (("EQU", "OP_EQ", "Equal", "="), ("NQU", "OP_NE", "Not equal", "<>"),
                                  ("LSS", "OP_LT", "Less than", "<"), ("LQU", "OP_LE", "Less than or equal", "<="),
                                  ("GRT", "OP_GT", "Greater than", ">"), ("GQU", "OP_GE", "Greater than or equal", ">=")):
    ENTRIES_C.append(E(_op, "OPERATOR", f"{_name}: only in the relation of IF...THEN; written {_sym} on the Teletype.", [
        F(binary(_op), {}, [(_action, "FULL", None)], prec=1, op="RELATIONAL", orig=f"A {_op} B")],
        notes=f"Card equivalent of {_sym}: the key-punch has fewer symbols [2] p. 50.", page="50"))
ENTRIES_C += [
    redo(find(ENTRIES_2, "PRINT", "STATEMENT"), "Labels between single quotes; the semicolon is punched as a "
                                                "multiple punch 5-8; 8 numbers per line on the printer.",
         notes="Single quotes replace the double quotes; the semicolon is a 5-8 multiple punch [2] p. 50. The "
               "high-speed printer prints 8 numbers per line, up to 18 in packed format.", page="50", src=None),
    REMOVE("DATA", "STATEMENT", "No DATA statement: the numbers are punched on a data deck after the END card "
                                "[2] p. 50."),
    redo(find(ENTRIES_1, "READ", "STATEMENT"), "The numbers come from the data deck after the END card, with no limit.",
         notes="The data deck follows the END card: numbers separated by commas, as many per card as wanted, "
               "without line numbers or the word DATA; there is no limit on the data [2] pp. 50-51.",
         page="50-51", src=None),
    E("PAGE", "STATEMENT", "Starts a new page of the printed output.", [
        F(S(K("PAGE")), {}, [("IO_NEW_PAGE", "FULL", None)], orig="PAGE")],
      notes="The manual gives no other detail [2] p. 50.", page="50"),
    E("MAT READ", "STATEMENT", "Reads one matrix of the dimensions shown from the data.", [
        F(S(K("MAT"), K("READ"), P("matrix", "MATRIX_NAME"), L("(", att=True), P("m", att=True),
            O(S(L(",", att=True), P("n", att=True)), att=True), L(")", att=True)),
          {"matrix": dict(descr="A matrix with a DIM."),
           "m": dict(descr="Rows: a formula, at most the DIM."), "n": dict(descr="Columns; without it a column vector.")},
          [("MAT_READ", "FULL", None)], orig="MAT READ A(M,N)")],
      notes="The dimensions can be formulas: `DIM A(20,20)`, `READ M`, `MAT READ A(M,M)` reads a square matrix of any "
            "size up to 20 × 20 [2] p. 52. A matrix must be first used in a MAT statement.", page="51-52"),
    E("MAT PRINT", "STATEMENT", "Prints one matrix; vectors are printed as rows.", [
        F(S(K("MAT"), K("PRINT"), P("matrix", "MATRIX_NAME"), O(L(";"))),
          {"matrix": dict(descr="A matrix or vector.")}, [("MAT_PRINT", "FULL", None)], orig="MAT PRINT A",
          descr="Followed by the 5-8 punch (;) the matrix is printed packed.")], page="51-52"),
    E("MAT", "STATEMENT", "Matrix arithmetic: sum, difference, product, multiple, zero, ones, identity, transpose, "
                          "inverse.", MAT_FORMS_3,
      notes="The matrices must have a DIM and start with element 1; a vector can stand for a matrix [2] pp. 51-52.",
      page="51-52"),
]
ENTRY_ERRORS_C = {
    "READ": [EE("NO_DATA", "No data deck after the END card."), EE("ILLEGAL_VARIABLE", "An item is not a variable.")],
    "MAT READ": [EE("DIMENSION_TOO_LARGE", "More than the limits of [2] p. 51.")],
}
EXAMPLES_C = {
    "EQU": [X("Equal", "10 READ A\n20 IF A EQU 2 THEN 50\n30 PRINT 'NO'\n40 STOP\n50 PRINT 'YES'\n60 END\n2", "YES",
              "The last card is the data deck.")],
    "LSS": [X("Less than", "10 IF 1 LSS 2 THEN 40\n20 PRINT 'NO'\n30 STOP\n40 PRINT 'YES'\n50 END", "YES")],
    "PRINT": [X("Label in single quotes", "10 PRINT 'SQUARE ROOT OF 2 =' SQR(2)\n20 END", "SQUARE ROOT OF 2 = 1.41421")],
    "READ": [X("Data deck", "10 READ A, B\n20 PRINT A + B\n30 END\n3, 4", "7", "The data card follows END.")],
    "PAGE": [X("Two pages", "10 PRINT 'FIRST'\n20 PAGE\n30 PRINT 'SECOND'\n40 END", None)],
    "MAT READ": [X("Square matrix of any size", "10 DIM A(20,20)\n20 READ M\n30 MAT READ A(M,M)\n40 MAT PRINT A\n50 END\n"
                                                "2, 1, 2, 3, 4", None, manual=True, page="52")],
    "MAT PRINT": [X("Packed", "10 DIM A(3,3)\n20 MAT A = IDN(3)\n30 MAT PRINT A;\n40 END", None)],
    "MAT": [X("Inverse", "10 DIM A(2,2), B(2,2)\n20 MAT READ A(2,2)\n30 MAT B = INV(A)\n40 MAT PRINT B\n50 END\n"
                         "2, 0, 0, 4", None, form=9)],
}
REFERENCES_C = [("MAT READ", "MAT", "SEE_ALSO"), ("MAT PRINT", "MAT", "SEE_ALSO"), ("PAGE", "PRINT", "SEE_ALSO")]
OPEN_QUESTIONS_C = [
    "The examples of the entries inherited from the 1st and 2nd edition are written for the Teletype (double "
    "quotes, relations as symbols): in Card BASIC they need single quotes and EQU, LSS, ...",
    "Card BASIC: are the Teletype commands really absent (removed here by inference)? How is the power written on the "
    "cards (↑ or something else)? Are the other limits (constants, GO TO) those of the Teletype version?",
]
TABLES_C = [
    ("CHARACTER_CODES", "TO_DO", "The rows shown are inherited from the Teletype version. On the cards: single quote "
                                 "for the double quote, multiple punch 5-8 for the semicolon [2] p. 50; card and "
                                 "printer codes not entered."),
    ("KEYBOARD_CODES", "NOT_APPLICABLE", "No keyboard: punched cards."),
    ("ERRORS", "COMPLETE", "The messages of appendix A of [2] pp. 53-54; none is marked as Card BASIC only."),
    ("OPERATOR_PRECEDENCE", "COMPLETE", "As in the 2nd edition; relations as three-letter words."),
    ("VARIABLE_LAYOUT", "TO_DO", "Not documented."),
    ("PROGRAM_LAYOUT", "TO_DO", "A deck of cards, one statement per card."),
    ("MUSICAL_NOTES", "NOT_APPLICABLE", "No sound."),
]


# =====================================================================
# Teletype ASR-33: character codes and glyphs
# =====================================================================
# The terminals were Teletype ASR-33 (and 35): a 64-character set, codes 32-95 of ASCII-1963, upper case
# only (94 = up arrow, 95 = back arrow). Printing was mechanical, so there are no original glyphs: these
# 16x16 bitmaps are a RECONSTRUCTION, rasterized from the TrueType font "TeleType ASR 33 UK" (c) 2015
# David Bonham (data/sources/teletype.ttf), drawn from photographs of faded Teletype listings. The font's
# pound sign (its glyph 0x60) is the only glyph of the UK variant: the UK print head printed the pound
# sign where the US head printed $ (code 36). Rasterization: all glyphs at one scale, the band from the
# highest to the lowest ink mapped to rows 1-14 (16x16) or 1-21 (24x24), each glyph centred horizontally,
# box filter, ink > 45 %.
GLYPH_SIZE = 24                   # 16 or 24: which of the two rasterizations is entered
POUND = 163                       # key of the pound sign (glyph 0x60 of the font) in the dicts below
CHARSET = dict(code="ASR33", name="Teletype ASR-33, US print head (reconstruction)", language="us",
               width=GLYPH_SIZE, height=GLYPH_SIZE,
               description="Reconstruction: the ASR-33 printed with a type cylinder, so these bitmaps are rasterized "
                           "from the TrueType font \"TeleType ASR 33 UK\" (c) 2015 David Bonham, drawn from "
                           "photographs of Teletype listings. 64 glyphs, codes 32-95 of ASCII-1963, no lower case.")
CHARSET_UK = dict(code="ASR33_UK", name="Teletype ASR-33, UK print head (reconstruction)", language="uk",
                  width=GLYPH_SIZE, height=GLYPH_SIZE,
                  description="Variant of the US set: the pound sign in place of $ (code 36); the other glyphs "
                              "are inherited. Reconstruction from the same font, made for the ICL 2903 emulator, "
                              "which imitates an ASR-33 with a UK print head.")
ASR33_GLYPHS_16 = {
    32: "0000000000000000000000000000000000000000000000000000000000000000",
    33: "0000018003C003C003C0038003C003C003800180018003C003C003C000800000",
    34: "000000200E700E700E700E700E20000000000000000000000000000000000000",
    35: "0000000000B001B001B0016007F002600FF00FE006800D800F80090000000000",
    36: "0000010007E00FF00D900D800F8007E001F003B8019801B81FF00FE000800000",
    37: "000000600FF01B2019601F4006C001800100032007F80ED80CF80CF808000000",
    38: "0000008003E003600360036003C007800F981DF81CF01FF00FF8079804000000",
    39: "0000000003C003C003C003C00180008000000000000000000000000000000000",
    40: "0000004000E001C0038003000600060007000700038001C001E000C000000000",
    41: "000006000700038001C000C0006000E000E000E000C001C00380070006000000",
    42: "000000000000018001801DB80FF003E00FF01FF8099001800180000000000000",
    43: "0000000000000180018003800FB81FF81FF80380038003800000000000000000",
    44: "0000000000000000000000000000000000C001E000E000E007C0078002000000",
    45: "0000000000000000000000000FF81FF81FF80820000000000000000000000000",
    46: "0000000000000000000000000000000000000000018003C00180000000000000",
    47: "0000001000380038007000E001E001C00380070007000E001E001C0008000000",
    48: "000003C007E007E00E700E700E6006600E20067004700E700FE003C000000000",
    49: "00000100038003C0018001800180018001800180018001C003C007E003800000",
    50: "0000000007E00EF01C3018301830007001E007800E0008101FF80FF000000000",
    51: "000001C007E00F700C300030007000700070003808381C380FF007E001800000",
    52: "00000180018001900330073806300E301C301C383FFC1FF80078007C00100000",
    53: "000002400FF00FE00C000C000FE00FF000700038003818301FF00FE001800000",
    54: "0000004001C0078006000C000FE01FF01C30181818180C300FF007E000400000",
    55: "00000FF00FF00C700870006000E000C001C00180018001800380038001000000",
    56: "0000018007D00D3018700C600EE00FE00D701C3018381C380FF007E003800000",
    57: "0000018007E00F700C30183808180C3007F003F0007000E003C0078000000000",
    58: "0000000000000000018003C003C001C00000018003C003C003C0018000000000",
    59: "0000000001C001E001E001C0000000C001C001E001E007C00780060000000000",
    60: "000000000000001801F807F01F801C001F8007E000F800380000000000000000",
    61: "000000000000000000000FF00FF000000FF00FF0000000000000000000000000",
    62: "00000000000008000F000FC003F000F000F003E00F800F000000000000000000",
    63: "0000010007E00FF00C700830007000E001C001800000000001C001C001800000",
    64: "0000018007E00EF00C3019D01FF01A701E781FF01FF00C000EE007E001000000",
    65: "00000000018003C003C0066004200C300C301FF01FF018381C383C3C08180000",
    66: "000000001FF01EF80C180C180C180FF80FF80C180C1C0C1C1EF83FF007C00000",
    67: "0000008007F00E700C300C100C001C00180018000C180C380FF007E003C00000",
    68: "000000801FE01EF00C380C180C180C1C0C1C0C180C180C381FF01FE014000000",
    69: "000000F01FF80C380C080C000DC00FC00FC00C800C080C181FF81FF800000000",
    70: "00000FE03FF81D3C0C000C800FC00FC00FC00CC00C000C001C001E0004000000",
    71: "0000010007F006700C3008101800087008F81C381C380C380FF807F800D00000",
    72: "00001C383C7C1C3C1C381C380FF80FF81F701C381C381C383E3C3C3C00180000",
    73: "000003C007E007C00180018001800180018001800180018007E007F002C00000",
    74: "000000000078007800300030003000300C301C301C300E700FE007C000000000",
    75: "000000301C3808380C600CC00DC00FC00FE00CE00C700C303C781C7C00000000",
    76: "000010001E001C000C000C000C000C000C000C000C180EFC3FFC1FF800000000",
    77: "0000000038181C781E781E781BD81BB811981998181818183C383C7C10180000",
    78: "000018001C3C1E381E181F181B18199819D819D81CF81C781C781E3000000000",
    79: "000007E00FF01818081808180810181018181C18181818181FF80FF007E00000",
    80: "000008401FF01FF81C380C180C1C0CF80FF00FE00C000C001C003E0000000000",
    81: "0000018007E00CF0183018301830183010381B9019F80CF00FF807F801900000",
    82: "000000001FE01FF01C30081008300FF00FE00860082008301C381C3C00000000",
    83: "0000000007F00EF00C200C000E0007C001F00030001808300FF00FE008800000",
    84: "000006001FF81FF81998018001800180018001800180018003C007C001000000",
    85: "000000103C3C1C3818181818081808181818181818180C300FF007E000000000",
    86: "000000083E7C1E3C0C180C180C380E3006300770076003E003C001C000000000",
    87: "000000003C3C1C381818183018100DB00DB00FF00FF007F006E0066000000000",
    88: "000018103C3C1C38066007E001C0018003C0026004600C301C383C3800000000",
    89: "000000003C3C1C3C0C78067007E003C0018001800180018003C003C001800000",
    90: "000000A00FE01FF018E001C001800300060006000C181C381FF81FF800200000",
    91: "0000008007E007C00600060006000600070006000600060007E007E001800000",
    92: "000008001C000C000E0007000780038001C000E000E000700078003800000000",
    93: "0000070007E003E00060006000600060006000600060006007E007E002800000",
    94: "00000000018003C007E007E0018001800180018001C001800000000000000000",
    95: "0000000000000000000006000F201FF80FF00600000000000000000000000000",
    163: "000003000FC0084008000C0006000780070003000F001F001FF80FF000400000",
}
ASR33_GLYPHS_24 = {
    32: "000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
    33: "000000000000003C00007E00007E00007E00007C00007C00003C00007E00007C00007C00007C00003C00003800001800003C00007E00007E00007E00007C00003C00000000000000",
    34: "00000000000001C1C007E7C007C3E007C3C003C7C003C3C003C7C003C180018100000000000000000000000000000000000000000000000000000000000000000000000000000000",
    35: "000000000000000000001CC0001DC000198000398000198000338001FFE0007F8000670003FF8007FF8003FF0001CC0003DC00039C0003FC00033800011000000000000000000000",
    36: "000000000000003C0000FF0003FF8007FBC003B8C007380007B80003F80001FC0000FF80003F800039E00038E00038E00038E00639E007FFC007FF8001FE00001C00000000000000",
    37: "000000000000027B8003FFC007F7800621800E33000F770007F60003DE00001C00001C000038000070000073C000EFE001EEE001CE7003CEF003CFE0038FE0020280000000000000",
    38: "000000000000001C00003F00007F80007380007380007380007700007F0000FE0001FC0007F86007DCF0071FF00707C00F9F8007DFC007FFF003FDF000F060008000000000000000",
    39: "000000000000001800007E00007E00007E00007E00003E00003C00003C00001C00000C00000000000000000000000000000000000000000000000000000000000000000000000000",
    40: "000000000000000200001F00001F00003E0000380000700000700000E00000E00000E00000E00000F00000F000007800007C00003F00003F00001F00000E00000200000000000000",
    41: "00000000000000E00000F000007800003C00001E00001E00000E00000700000700000700000700000F00000F00000E00001E00003E00007C0000F80001F00000C000000000000000",
    42: "0000000000000000000000000018000038000018000718E007D9E003FFE001FF80007F0000FF8007FFE007DBE00718E0003C00003800003800000000000000000000000000000000",
    43: "000000000000000000000000000000003800003C00003C00007C0001FC0007FFF00FFFF007FFF0007C00003C00003C00007C00003C00003000000000000000000000000000000000",
    44: "000000000000000000000000000000000000000000000000000000000000000000000000000400001F00001F80000F80000F00001F0000FF0000FE0001F80000F000000000000000",
    45: "00000000000000000000000000000000000000000000000000000003FFE007FFE00FFFF007FFF003FFE0010000000000000000000000000000000000000000000000000000000000",
    46: "000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000003C00003E00003E00003C00001C00000000000000000000000000",
    47: "0000000000000000400000E00001E00003E00003C0000780000F80001F00001E00003E00007C0000F80000F00001F00003E00003E00007C000078000070000030000000000000000",
    48: "000000000000007E0000FF0001FF8001E78003C78001C78001C38001C38001C38001C38001C38001838001C78001C78001C3C001C3C001FF8001FF00007E00001800000000000000",
    49: "000000000000001800003C00007E00007C00003C00001C00003C00001C00001C00001C00003C00003C00003C00003C00003C00003C00007E00007F0000FF00007E00000000000000",
    50: "00000000000000180000FE0001FF8003C7C00781C00701C00601E00701E00001E00003C0003F8000FF0001F00003C0000380000700E007FFE007FFE003FFE0013900000000000000",
    51: "000000000000007E0000FF8001FFC003C3C00380C00000C00001C00003C00007C00007800007C00001E00001E00300E00780E00781E007FFC003FFC000FF80003C00000000000000",
    52: "000000000000001800003C000038000038C00079E000F1E000F0E001E1E003C1E003C1E00780E00F81E00FC1E00FFFF00FFFF80FEBE00003F00007F00003F0000060000000000000",
    53: "000000000000007F8001FFC003FFC003800003000003000003880003FF0003FF800397C00003C00001E00001E00000E00601E00703C007FFC003FF8003FF00007E00000000000000",
    54: "000000000000000E00003E00007E0000F80001E00001C00003800003FF0007FF8007C7C00781C00700E00700E00700E00700E00381C003F7C001FF8000FF00004E00000000000000",
    55: "00000000000003FFC003FFE007FFC00783C00703C0020780000780000F00000F00000E00001E00001C00001C00003C00003800003800003800007800003800003000000000000000",
    56: "00000000000000FC0001FEC003FFC00381C00703C007038007078003CF0003FF0001FF8003B7C00781C00700E00700E00700E00781E003FFC003FFC001FF80007E00000000000000",
    57: "000000000000007C0001FF0003FF8003D3C00781C00700E00700E00700E00301E00383E001FFC001FFE0007FC0000380000F80001F00003F0000FC0001F80000E000000000000000",
    58: "000000000000000000000000000000000000003C00007E00007E00007E00007E00003C00000000000000001800003E00007E00007E00007E00007C00003800000000000000000000",
    59: "000000000000000000001E00001F00003F00003F80003F00001E00000C00000000001E00003F00003F00003F00001F00003E0000FC0001FC0001F000008000000000000000000000",
    60: "0000000000000000000000000000600000F0000FF0007FE001FF4007FC000FC0000F80000FF00003FE0000FF80001FF00003F00001E0000000000000000000000000000000000000",
    61: "00000000000000000000000000000000000000000000000003FFC003FFC00001800000000136C003FFC003FFC0000000000000000000000000000000000000000000000000000000",
    62: "00000000000000000000000000000003800003E00003F80001FF00007F80001FC00007E0000FE0001FC000FF0003FC0003F00003E000018000000000000000000000000000000000",
    63: "00000000000000300000FE0001FF8003FFC003C3C00381C00103C0000780000FC0001F80001F00001C00001C00001800000000001000003E00003E00003E00003C00000000000000",
    64: "000000000000003C0000FF0001FF8003C3C00301C0031CC0073EE007FFE006F7E00667C006C7E007E7E007FFC0077FC0071C0003810003C78001FF8000FF00007C00000000000000",
    65: "000000000000001000003800003C00007E0000EE0000E70001C3000183800181800183C00301C00301C007FFC007FFE0071BE00700E00700F00F81F01F83F80F01F0000000000000",
    66: "0000000000000300000FFF800FFFE00788E00300700380700380700380F003B1E003FFE003FFE00383F00300700300780380700700700F41F00FFFE00FFFC00FFF80000000000000",
    67: "000000000000000C0000FFC001FFC003C3E00381E00300E00700000700000700000700000700000700000700400780E00781E00381E003E7C001FF8000FF80007E00000000000000",
    68: "00000000000001DE000FFF800FFF800701E00701E00700600380700700700380700380700380700380700380700380700780E00783E007FFC00FFF800FFF0007E000000000000000",
    69: "00000000000007FFC00FFFE00FDFF00300F0038060038000038800039E0003FE0003FE0003DE00038E000384000380200380700380700FFFF00FFFF00FFFE0020080000000000000",
    70: "0000000000000FFFC00FFFF00FFFF00F80F0078060038000038C0003BE0003FE0003FE0003FE00039E000784000380000380000780000FC0000FC0000FC000058000000000000000",
    71: "000000000000003F8000FFC001FFC001C3C00381C00300C00300000700000701000307C0030FE00707E00700E00780E00781E00381E003E7E001FFE000FFE0007EC0000000000000",
    72: "0000000000000F81F01F83F81F83F80781F00700E00781E007C1E0037FE007FFE003FFE007F7E00781E00781E00781E00781E00781F00FC3F01FC3F81F81F00700F0000000000000",
    73: "000000000000007F0000FF0001FF0000FE00003C00003800003800003800003C00003800003800003800003C00003C00003C00007C0000FF0001FF8001FF8000FF00000000000000",
    74: "0000000000000001000003E00003F00003E00001C00001C00001C00001C00000C00000C00381C00781C007C1C007C1C00741C007C7C007FFC001FF00007C00000800000000000000",
    75: "0000000000000681E00F83F00F83F00303C0030780038F80030E00031E0003BE0003FE0003F70003C7000387000387800383C00703E00F83F00FC3F00783F0010060000000000000",
    76: "0000000000000FC0000FC00007C00007800003800003800003800003800003800003C00003800003800003800003807003C07807FFF00FFFF01FFFF007FFF0000000000000000000",
    77: "0000000000000A00000E00F00F01F00F83E00F83E007C7E00EE7E00EEFE00E7EE00E7CE00E3C600E3C600E1CE00E08E00600E00F00E00F01E01FC3F81F83F80601E0000000000000",
    78: "0000000000000F00D00F83F00FC1F007E0F007E0E007F07006F8F00778F00738F0061CF0071CF0061EF0071EF0070FE00707F00787E00FC3E00FC3E00FC1C0000000000000000000",
    79: "00000000000001FF8003FFC007AFE00700E00600600200E00700E00700E00600E00780E00700E00700E00780E00700E00700E00700E00799E003FFE003FFC001FF80000000000000",
    80: "00000000000007FE000FFFC00FFFE00FFFF00F01F00300F00380700380F80381F003A7F001FFC003FFC003A7000380000780000700000F80000FC0000FC000068000000000000000",
    81: "000000000000007C0000FF0001FF800387C00701C00701C00601C00601C00E01E00600E00600E00E79E00678E0063DE0061FC0078FC003EFC003FFF001FFF0003FE0000000000000",
    82: "0000000000000C00000FFF000FFF000FFFC00701C00300E00300E00301E00307C003FF8003FF0003DF000303000303000301800301C00781E00F81F00F81F8020020000000000000",
    83: "00000000000000180000FF8001FFC003C7C003818003800003800003C00001FC0000FF00003F800003C00001C00000E00000E00301C007FFC007FF8007FF00023C00000000000000",
    84: "00000000000003FAC007FFE00FFFE00FFFF00E3CF0063860003C00001C00001800001800003800003800003800003800003800003800007E0000FE0000FE00003000000000000000",
    85: "0000000000000F00F01FC3F80F81F80701F00700E00700E00700E00700E00700E00700E00700E00700E00700E00700E00780E00380C003F7C001FF8001FF00003000000000000000",
    86: "0000000000000700E00FC3F81FC3F807C1F80380E00380E00380E00380E00381E003C1C001C3C001E3C001F7C000E78000FF80007F00007F00007E00003C00001800000000000000",
    87: "0000000000000000600F81F00FC3F80F81F00700E00700E00701E00710E00711C00339C0033CC003FDC003FFC003FFC001FFC001EF8001FF8001EF8000E700004200000000000000",
    88: "0000000000000F81E00F81F80F81F001C1C001E38000E78000F600001E00001C00003C00003E00007E0000E70000C3800183800381C00F00E00F81F01F81F00501F0000000000000",
    89: "0000000000000400C00F81F01F83F80F83F00783E003C3C001E78000FF0000FF00007E00003C00003C00001C00003C00001C00001800003C00007E00007E00003E00000000000000",
    90: "000000000000001F8003FF8007FF8007FF80070780021F00001E00003C0000780000700000E00001C00001C0000380200780E00781E007FFF007FFF007FFE00753C0000000000000",
    91: "00000000000000380000FF0000FF0001FE0000E00000E00000E00000E00000E00000E00000E00001E00000E00001E00000E00001E00000FF0000FF8000FF00003C00000000000000",
    92: "00000000000003000007800007800003C00003C00001E00001F00000F800007800007C00003E00001F00000F000007800007C00007E00003E00001E00000E0000000000000000000",
    93: "00000000000000FE0000FF0000FF80006F00000780000700000700000700000780000700000700000700000700000700000700000700007F0001FF0000FF0000EE00000000000000",
    94: "000000000000000000001000003C00007E0000FF8001FF0000FF00003D00003C00003C00003C00001C00003C00003C00003C00001C00000800000000000000000000000000000000",
    95: "00000000000000000000000000000000000000000000000001C00003E00007FFC007FFE003FFE003E08001C000004000000000000000000000000000000000000000000000000000",
    163: "00000000000000F80001FE00030F0002030003000003000001800001C00001F00001F80001F80000300000300001F00003F00007780007FBE007FFE001FFC0014F80000000000000",
}
ASR33_GLYPHS = ASR33_GLYPHS_16 if GLYPH_SIZE == 16 else ASR33_GLYPHS_24
GLYPH_NAMES = {32: "Space", 94: "Up arrow", 95: "Back arrow"}
GLYPH_UNICODE = {94: ("\u2191", "UPWARDS ARROW"), 95: ("\u2190", "LEFTWARDS ARROW")}
CONTROL_CODES = {4: ("EOT", "End of transmission"), 7: ("BELL", "Rings the bell of the Teletype"),
                 10: ("LF", "Line feed"), 13: ("CR", "Carriage return"), 127: ("RUB-OUT", "Tape use only")}


def glyph_rows(charset_id):
    import unicodedata
    for code in range(32, 96):
        u, uname = GLYPH_UNICODE.get(code, (chr(code), unicodedata.name(chr(code))))
        yield dict(charset_id=charset_id, code=code, bitmap=ASR33_GLYPHS[code], unicode=u, unicode_name=uname,
                   name=GLYPH_NAMES.get(code), notes="Reconstruction from a TrueType font, not an original bitmap.")


def character_code_rows(layer_id, base_id, manual, redefines=None):
    """Codes 0-127. In the core INFERRED (no statement shows the codes before the 4th edition); in the 4th
    edition the codes of the table of [4] p. 68 are MANUAL (REPLACE of the core rows)."""
    for code in range(128):
        listed = 32 <= code <= 95 or code in CONTROL_CODES
        if manual and not listed:
            continue
        r = dict(id=base_id + code, layer_id=layer_id, code=code,
                 evidence="MANUAL" if manual else "INFERRED")
        if redefines:
            r.update(operation="REPLACE", redefines_id=redefines + code)
        if 32 <= code <= 95:
            r.update(kind="PRINTABLE", screen_code=code)
            if code == 95:
                r["notes"] = "Back arrow: \"useful on output\" [4] p. 68 (underscore in later ASCII)."
            elif code == 94:
                r["notes"] = "The power operator (circumflex in later ASCII)."
        elif code in CONTROL_CODES:
            name, action = CONTROL_CODES[code]
            r.update(kind="CONTROL", name=name, action=action)
        elif 96 <= code <= 126:
            r.update(kind="UNUSED", notes="Lower case: not on the ASR-33 (64 characters); on some Teletypes these codes "
                                          "duplicate the upper-case ones [4] p. 68.")
        else:
            r.update(kind="UNUSED")
        yield r


# Programs distributed with the DTSS-Win simulator [8] (BAS* test programs and LIB), unchanged except
# for ^ written as ↑ and the indentation removed. Not run yet: to verify.
EXAMPLES_1.setdefault('ABS', []).extend([
    X('Absolute values', '10 FOR N = -10 TO 10 STEP 2\n15 LET X = N/3\n20 PRINT X, ABS(X)\n30 NEXT N\n40 END', None, 'From the DTSS-Win simulator files (BASABS).', manual=True, src=SRC_DTSSWIN, page='BASABS'),
])
EXAMPLES_1.setdefault('ATN', []).extend([
    X('Arc tangent in degrees', '10 LET P1 = 3.14159265\n20 FOR T = -5 TO 5\n30 PRINT ATN(T)*180/P1\n40 NEXT T\n50 END', None, 'From the DTSS-Win simulator files (BASATN).', manual=True, src=SRC_DTSSWIN, page='BASATN'),
])
EXAMPLES_1.setdefault('COS', []).extend([
    X('Table of cosines', '10 LET P = 3.14159265\n20 FOR D = 0 TO 180 STEP 10\n30 PRINT D, COS(D*P/180)\n40 NEXT D\n50 END', None, 'From the DTSS-Win simulator files (BASCOS).', manual=True, src=SRC_DTSSWIN, page='BASCOS'),
])
EXAMPLES_1.setdefault('EXP', []).extend([
    X('Table of exponentials', '10 FOR X = -1 TO 1 STEP .5\n20 PRINT X, EXP(X)\n30 NEXT X\n40 END', None, 'From the DTSS-Win simulator files (BASEXP).', manual=True, src=SRC_DTSSWIN, page='BASEXP'),
])
EXAMPLES_1.setdefault('FOR...TO...STEP', []).extend([
    X('Simple loop', '10 FOR I = 1 TO 3\n20 PRINT I\n30 NEXT I\n40 END', '1\n2\n3', 'From the DTSS-Win simulator files (BASFOR).', manual=True, src=SRC_DTSSWIN, page='BASFOR'),
    X('Approximate pi', '100 REM PIE\n110 READ D\n120 DATA 10\n130 LET S = 1\n140 LET N = 6\n150 FOR I = 1 TO D\n160 LET X = S/2\n170 LET Y = 1 - SQR(1 - X*X)\n180 LET S = SQR(X*X + Y*Y)\n190 LET N = 2*N\n200 LET P = N*S/2\n210 PRINT I, P\n220 NEXT I\n230 END', None, 'From the DTSS-Win simulator files (LIB/PIE).', manual=True, src=SRC_DTSSWIN, page='LIB/PIE'),
])
EXAMPLES_1.setdefault('NEXT', []).extend([
    X('Nested loops', '10 FOR X = 1 TO 5 STEP 3\n30 FOR Y = 1 TO X\n40 PRINT X, Y\n50 NEXT Y\n60 NEXT X\n70 END', None, 'From the DTSS-Win simulator files (BASLOP).', manual=True, src=SRC_DTSSWIN, page='BASLOP'),
])
EXAMPLES_1.setdefault('IF...THEN', []).extend([
    X('Jumps in a loop', '10 FOR I = 1 TO 2\n20 IF I = 1 THEN 50\n30 PRINT "TWO"\n40 GOTO 60\n50 PRINT "ONE"\n60 NEXT I\n70 END', 'ONE\nTWO', 'From the DTSS-Win simulator files (BASNFO).', manual=True, src=SRC_DTSSWIN, page='BASNFO'),
])
EXAMPLES_1.setdefault('PRINT', []).extend([
    X('Print an integer', '10 PRINT 3\n20 END', '3', 'From the DTSS-Win simulator files (BASPRT).', manual=True, src=SRC_DTSSWIN, page='BASPRT'),
    X('Quadratic equation', '5 PRINT "QUADRATIC EQUATION"\n6 PRINT\n10 READ A, B, C\n20 LET D = B * B -4 * A * C\n30 LET S = - B / (2 * A )\n40 LET T = SQR(D) / (2 * A)\n50 IF D = 0 THEN 100\n60 IF D < 0 THEN 200\n70 PRINT A, B, C, "TWO REAL ROOTS"\n80 PRINT "ROOTS = " S + T, S - T\n90 GOTO 300\n100 PRINT A, B, C, "ONE ROOT"\n110 PRINT "ROOT =" S\n120 GOTO 300\n200 PRINT A, B, C, "COMPLEX ROOTS"\n210 PRINT "REAL PART=" S, "IMAGINARY PART=" T\n300 PRINT\n310 GOTO 10\n400 DATA 1, -2, -3, 1, -4, 4, 1, 0, 2\n999 END', None, 'From the DTSS-Win simulator files (LIB/QUAD).', manual=True, src=SRC_DTSSWIN, page='LIB/QUAD'),
])
EXAMPLES_1.setdefault('RND', []).extend([
    X('Three random numbers', '10 LET T = 3\n15 FOR N = 1 TO T\n20 PRINT RND(0)\n30 NEXT N\n40 END', None, 'From the DTSS-Win simulator files (BASRND).', manual=True, src=SRC_DTSSWIN, page='BASRND'),
])
EXAMPLES_1.setdefault('SIN', []).extend([
    X('Table of sines', '10 LET P = 3.14159265\n20 FOR D = 0 TO 180 STEP 10\n30 PRINT D, SIN(D*P/180)\n40 NEXT D\n50 END', None, 'From the DTSS-Win simulator files (BASSIN).', manual=True, src=SRC_DTSSWIN, page='BASSIN'),
])
EXAMPLES_1.setdefault('SQR', []).extend([
    X('Table of square roots', '10 FOR X = 0 TO 10\n20 PRINT X, SQR(X)\n30 NEXT X\n40 END', None, 'From the DTSS-Win simulator files (BASSQR).', manual=True, src=SRC_DTSSWIN, page='BASSQR'),
])
EXAMPLES_1.setdefault('TAN', []).extend([
    X('Table of tangents', '10 LET P = 3.14159265\n20 FOR D = 0 TO 180 STEP 10\n30 PRINT D, TAN(D*P/180)\n40 NEXT D\n50 END', None, 'From the DTSS-Win simulator files (BASTAN).', manual=True, src=SRC_DTSSWIN, page='BASTAN'),
])
EXAMPLES_1.setdefault('-', []).extend([
    X('Subtraction', '10 LET S = 2 - 5\n20 PRINT S\n30 END', '-3', 'From the DTSS-Win simulator files (BASSUB).', manual=True, src=SRC_DTSSWIN, page='BASSUB'),
])
EXAMPLES_1.setdefault('INT', []).extend([
    X('Integer part of thirds', '10 FOR N = -10 TO 10 STEP 2\n15 LET X = N/3\n20 PRINT X, INT(X)\n30 NEXT N\n40 END', None, 'From the DTSS-Win simulator files (BASINT).', manual=True, src=SRC_DTSSWIN, page='BASINT'),
])
EXAMPLES_1.setdefault('LOG', []).extend([
    X('Natural and common logarithms', '10 FOR X = 1 TO 10\n20 PRINT X, LOG(X), LOG(X)/LOG(10)\n30 NEXT X\n40 END', None, 'From the DTSS-Win simulator files (BASLOG).', manual=True, src=SRC_DTSSWIN, page='BASLOG'),
])
EXAMPLES_1.setdefault('GOSUB', []).extend([
    X('Greatest common divisor', '10 PRINT "A", "B", "GCD"\n20 READ A, B\n30 LET X = A\n40 LET Y = B\n50 GOSUB 200\n90 PRINT A, B, G\n100 GOTO 20\n110 DATA 60, 90\n120 DATA 38456, 64872\n200 LET Q = INT(X/Y)\n210 LET R = X - Q*Y\n220 IF R = 0 THEN 300\n230 LET X = Y\n240 LET Y = R\n250 GOTO 200\n300 LET G = Y\n310 RETURN\n999 END', None, 'From the DTSS-Win simulator files (LIB/GCD). GCD 30 for 60 and 90, 8 for 38456 and 64872; it stops when the data run out.', manual=True, src=SRC_DTSSWIN, page='LIB/GCD'),
])
EXAMPLES_1.setdefault('RETURN', []).extend([
    X('GCD of three numbers', '10 PRINT "A", "B", "C", "GCD"\n20 READ A, B, C\n30 LET X = A\n40 LET Y = B\n50 GOSUB 200\n60 LET X = G\n70 LET Y = C\n80 GOSUB 200\n90 PRINT A, B, C, G\n100 GOTO 20\n110 DATA 60, 90, 120\n120 DATA 38456, 64872, 98765\n200 LET Q = INT(X/Y)\n210 LET R = X - Q*Y\n220 IF R = 0 THEN 300\n230 LET X = Y\n240 LET Y = R\n250 GOTO 200\n300 LET G = Y\n310 RETURN\n999 END', None, 'From the DTSS-Win simulator files (LIB/GCD3NO). The same subroutine called twice: GCD 30, then 1.', manual=True, src=SRC_DTSSWIN, page='LIB/GCD3NO'),
])
EXAMPLES_1.setdefault('DATA', []).extend([
    X('Life of a mortgage', '1 REM MORTGAGE COMOPUTER\n2 REM YEARLY INTEREST RATE\n10 DATA 0.05\n15 REM INITIAL PRINCIPAL\n20 DATA 28500\n25 REM MONTHLY PAYMENT\n30 DATA 170\n35 REM STARTING MONTH AND YEAR\n40 DATA 1, 1964\n50 READ I, P, P1, M, Y\n60 LET R = 1 + I/12\n70 PRINT "YEAR", "PRINCIPAL"\n80 PRINT Y, P\n90 LET P = P*R - P1\n100 IF P >= 0 THEN 120\n110 LET P = 0\n120 LET M = M + 1\n130 IF M > 12 THEN 160\n140 PRINT "       ",\n150 GO TO 190\n160 LET M = 1\n170 LET Y = Y + 1\n180 PRINT Y,\n190 PRINT INT(P)\n200 IF P > 0 THEN 90\n210 END', None, 'From the DTSS-Win simulator files (LIB/MORT). DATA lines interleaved with REM lines; the typing slip COMOPUTER is in the original.', manual=True, src=SRC_DTSSWIN, page='LIB/MORT'),
])
EXAMPLES_2.setdefault('PRINT', []).extend([
    X('Semicolon', '10 PRINT 2; 3\n20 END', None, 'From the DTSS-Win simulator files (BASSEM).', manual=True, src=SRC_DTSSWIN, page='BASSEM'),
    X('A list from element 0', '10 FOR I = 0 TO 10\n20 LET X(I) = I\n30 NEXT I\n40 FOR I = 0 TO 10\n50 PRINT X(I);\n60 NEXT I\n70 END', None, 'From the DTSS-Win simulator files (BASLIS). Element 0 and the default size of 10, without DIM.', manual=True, src=SRC_DTSSWIN, page='BASLIS'),
    X('Plot of the normal curve', '100 REM PLOT A NORMAL DISTRIBUTION CURVE\n110\n120 DEF FNN(X) = EXP(-(X↑2/2))/SQR(2*3.14159265)\n130\n140 FOR X = -2 TO 2 STEP .1\n150 LET Y = FNN(X)\n160 LET Y = INT(100*Y)\n170 FOR Z = 1 TO Y\n180 PRINT " ";\n190 NEXT Z\n200 PRINT "*"\n210 NEXT X\n220 END', None, 'From the DTSS-Win simulator files (LIB/NORMAL). The file writes the power as ^, the ASCII character with the code of ↑ (94). Lines 110 and 130 are empty.', manual=True, src=SRC_DTSSWIN, page='LIB/NORMAL'),
])
EXAMPLES_2.setdefault('STOP', []).extend([
    X('Compiling long expressions', '005 STOP\n010 LET X = X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X\n020 LET X = X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X\n030 LET X = X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X\n040 LET X = X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X\n999 END', None, 'From the DTSS-Win simulator files (BASTIM). A test of the compiler: STOP ends the run before the long LETs, which are only compiled.', manual=True, src=SRC_DTSSWIN, page='BASTIM'),
])
EXAMPLES_3.setdefault('INPUT', []).extend([
    X('Ask for a move', '10 PRINT "YOUR MOVE";\n20 INPUT N\n30 PRINT N\n40 END', 'YOUR MOVE?', 'From the DTSS-Win simulator files (BASINP).', manual=True, src=SRC_DTSSWIN, page='BASINP'),
    X('Guess a number', '100 REM GUESSING GAME\n110\n120 PRINT "GUESS THE NUMBER BETWEEN 1 AND 100."\n130\n140 LET X = INT(100*RND(0)+1)\n150 LET N = 0\n160 PRINT "YOUR GUESS";\n170 INPUT G\n180 LET N = N+1\n190 IF G = X THEN 300\n200 IF G < X THEN 250\n210 PRINT "TOO LARGE, GUESS AGAIN"\n220 GOTO 160\n230\n250 PRINT "TOO SMALL, GUESS AGAIN"\n260 GOTO 160\n270\n300 PRINT "YOU GUESSED IT, IN"; N; "TRIES"\n310 PRINT "ANOTHER GAME (YES = 1, NO = 0)";\n320 INPUT A\n330 IF A = 1 THEN 140\n340 PRINT "THANKS FOR PLAYING"\n350 END', None, 'From the DTSS-Win simulator files (LIB/GUESS).', manual=True, src=SRC_DTSSWIN, page='LIB/GUESS'),
])

# Output of the BAS* programs on DTSS-Win (compiler of February 1965), run by the editor on 22 Nov 2026.
DTSSWIN_OUTPUT = {
    'BASABS': '-3.33333        3.33333\n-2.66667        2.66667\n-2              2\n-1.33333        1.33333\n-.666667        .666667\n 0              0\n .666667        .666667\n 1.33333        1.33333\n 2              2\n 2.66667        2.66667\n 3.33333        3.33333',
    'BASATN': '-78.6901\n-75.9638\n-71.5651\n-63.435\n-45.\n 0\n 45\n 63.4349\n 71.5651\n 75.9638\n 78.6901',
    'BASCOS': ' 0              1\n 10             .984808\n 20             .939693\n 30             .866025\n 40             .766044\n 50             .642788\n 60             .5\n 70             .34202\n 80             .173648\n 90             5.82077 E-9\n 100           -.173648\n 110           -.34202\n 120           -.5\n 130           -.642788\n 140           -.766044\n 150           -.866025\n 160           -.939693\n 170           -.984808\n 180           -1.',
    'BASEXP': '-1              .367879\n-.5             .606531\n 0              1\n .5             1.64872\n 1              2.71828',
    'BASFOR': ' 1\n 2\n 3',
    'BASINP': 'YOUR MOVE? 42\n\n 42',
    'BASINT': '-3.33333       -3\n-2.66667       -2\n-2             -2\n-1.33333       -1\n-.666667        0\n 0              0\n .666667        0\n 1.33333        1\n 2              2\n 2.66667        2\n 3.33333        3',
    'BASLOG': ' 1              0              0\n 2              .693147        .30103\n 3              1.09861        .477121\n 4              1.38629        .60206\n 5              1.60944        .69897\n 6              1.79176        .778151\n 7              1.94591        .845098\n 8              2.07944        .90309\n 9              2.19722        .954243\n 10             2.30259        1',
    'BASLOP': ' 1              1\n 4              1\n 4              2\n 4              3\n 4              4',
    'BASNFO': 'ONE\nTWO',
    'BASPRT': ' 3',
    'BASRND': ' .746478\n .196324\n 4.12519 E-2',
    'BASSEM': ' 2     3',
    'BASSIN': ' 0              0\n 10             .173648\n 20             .34202\n 30             .5\n 40             .642788\n 50             .766044\n 60             .866025\n 70             .939693\n 80             .984808\n 90             1.\n 100            .984808\n 110            .939693\n 120            .866025\n 130            .766044\n 140            .642788\n 150            .5\n 160            .34202\n 170            .173648\n 180            8.73115 E-9',
    'BASSQR': ' 0              0\n 1              1\n 2              1.41421\n 3              1.73205\n 4              2\n 5              2.23607\n 6              2.44949\n 7              2.64575\n 8              2.82843\n 9              3\n 10             3.16228',
    'BASSUB': '-3',
    'BASTAN': ' 0              0\n 10             .176327\n 20             .36397\n 30             .57735\n 40             .8391\n 50             1.19175\n 60             1.73205\n 70             2.74748\n 80             5.67128\n 90             1.71799 E 8\n 100           -5.67128\n 110           -2.74748\n 120           -1.73205\n 130           -1.19175\n 140           -.8391\n 150           -.57735\n 160           -.36397\n 170           -.176327\n 180           -8.73115 E-9',
    'BASTIM': '',
    'LIB/GUESS': 'GUESS THE NUMBER BETWEEN 1 AND 100.\nYOUR GUESS? 50\n\nTOO SMALL, GUESS AGAIN\nYOUR GUESS? 75\n\nYOU GUESSED IT, IN 2    TRIES\nANOTHER GAME [YES = 1, NO = 0]?',
    'BASLIS': ' 0     1     2     3     4     5     6     7     8     9     10',
    'LIB/GCD': 'A              B              GCD\n 60             90             30\n 38456          64872          8\n\nOUT OF DATA IN  20',
    'LIB/GCD3NO': 'A              B              C              GCD\n 60             90             120            30\n 38456          64872          98765          1\n\nOUT OF DATA IN  20',
    'LIB/MORT': 'YEAR           PRINCIPAL\n 1964           28500\n                28448\n                28397\n                28345\n                28293\n                28241\n                28189\n                28136\n                28083\n                28030\n                27977\n                27924\n 1965           27870\n...\n                736\n                569\n                401\n                233\n 1988           64\n                0',
    'LIB/NORMAL': '     *\n      *\n       *\n         *\n           *\n            *\n              *\n                 *\n                   *\n                     *\n                        *\n                          *\n                            *\n                               *\n                                 *\n                                   *\n                                    *\n                                      *\n                                       *\n                                       *\n                                       *\n                                       *\n                                       *\n                                      *\n                                    *\n                                   *\n                                 *\n                               *\n                            *\n                          *\n                        *\n                     *\n                   *\n                 *\n              *\n            *\n           *\n         *\n       *\n      *',
    'LIB/PIE': ' 1              3.10583\n 2              3.13263\n 3              3.13935\n 4              3.14103\n 5              3.14145\n 6              3.14156\n 7              3.14158\n 8              3.14159\n 9              3.14159\n 10             3.14159',
    'LIB/QUAD': 'QUADRATIC EQUATION\n\n 1             -2             -3             TWO REAL ROOTS\nROOTS =  3     -1\n\n 1             -4              4             ONE ROOT\nROOT = 2\n\n\nSQUARE ROOT OF NEGATIVE NUMBER IN  40\n 1              0              2             COMPLEX ROOTS\nREAL PART= 0                  IMAGINARY PART= 1.41421\n\n\nOUT OF DATA IN  10',
}

# Remarks on single DTSS-Win runs, appended to the description of the example.
DTSSWIN_NOTE = {
    'LIB/MORT': ' The run prints 291 lines (to 1988): only the first and last lines are shown, the dots stand for the rest.',
    'LIB/NORMAL': ' Only 40 lines for the 41 values from -2 to 2: the sum of the steps of .1 passes 2 by a little, so the last value is lost.',
    'LIB/GUESS': ' One game, with the guesses 50 and 75 typed by the editor; the run was left at the last INPUT. The prompt of line 310 is printed with square brackets, `[YES = 1, NO = 0]`, although the program has round ones (DTSS-Win prints every round bracket of a label as a square one). The number to guess is 75 at the start of every RUN, and the second game of the same run asks for 20: RND gives the same sequence on every run.',
    'LIB/QUAD': ' SQR(D) with D = -8 prints the message and goes on with the root of the absolute value: the imaginary part is 1.41421.',
}
for _dct in (EXAMPLES_1, EXAMPLES_2, EXAMPLES_3):
    for _lst in _dct.values():
        for _x in _lst:
            if _x['src'] == SRC_DTSSWIN and _x['page'] in DTSSWIN_OUTPUT and not _x['verified']:
                _x['expected'] = DTSSWIN_OUTPUT[_x['page']] or None
                _x['verified'] = True
                _x['description'] = (_x['description'] or '') + (' Output checked on DTSS-Win (compiler of February 1965)'
                                                                 + (': it prints nothing.' if not DTSSWIN_OUTPUT[_x['page']] else '.'))
                _x['description'] += DTSSWIN_NOTE.get(_x['page'], '')
# The manual example of LOG (AVELOG) was also run on DTSS-Win: same result.
_x = EXAMPLES_1['LOG'][0]
assert _x['title'] == 'Average of 100 logarithms'
_x['verified'] = True
_x['description'] = (_x['description'] or '') + 'Output checked on DTSS-Win (compiler of February 1965, program AVELOG): the same result, printed as ` 1.5797`.'



# ---------------------------------------------------------------------
# The layers in order
# ---------------------------------------------------------------------
LAYER_DATA = [
    dict(layer=LAYERS[0], base=None, src=SRC_MAY64, character_codes=list(character_code_rows(L1, ID, False)), data_types=DATA_TYPES_1, variable_kinds=VARIABLE_KINDS_1,
         parameter_kinds=PARAMETER_KINDS_1, features=FEATURES_1,
         errors=[(c, m, d, None) for c, m, d in ERRORS_1], error_rules=ERROR_RULES_1, keywords=KEYWORDS_1,
         entries=ENTRIES_1, entry_errors=ENTRY_ERRORS_1, examples=EXAMPLES_1, references=REFERENCES_1,
         open_questions=OPEN_QUESTIONS_1, tables=TABLES_1),
    dict(layer=LAYERS[1], base=L1, src=SRC_OCT64, data_types=[], variable_kinds=VARIABLE_KINDS_2, parameter_kinds=[],
         features=FEATURES_2, errors=[], error_rules=[], keywords=KEYWORDS_2, entries=ENTRIES_2,
         entry_errors=ENTRY_ERRORS_2, examples=EXAMPLES_2, references=REFERENCES_2, open_questions=OPEN_QUESTIONS_2,
         tables=TABLES_2),
    dict(layer=LAYERS[2], base=L2, src=SRC_GE67, data_types=DATA_TYPES_3, variable_kinds=[], parameter_kinds=PARAMETER_KINDS_3,
         features=FEATURES_3, errors=ERRORS_3, error_rules=ERROR_RULES_3, keywords=KEYWORDS_3, entries=ENTRIES_3,
         entry_errors=ENTRY_ERRORS_3, examples=EXAMPLES_3, references=REFERENCES_3, open_questions=OPEN_QUESTIONS_3,
         tables=TABLES_3),
    dict(layer=LAYERS[3], base=L3, src=SRC_4ED,
         character_codes=list(character_code_rows(L4, ID + 1000, True, redefines=ID)), data_types=DATA_TYPES_4, variable_kinds=VARIABLE_KINDS_4,
         parameter_kinds=PARAMETER_KINDS_4, features=FEATURES_4, errors=ERRORS_4, error_rules=ERROR_RULES_4,
         keywords=KEYWORDS_4, entries=ENTRIES_4, entry_errors=ENTRY_ERRORS_4, examples=EXAMPLES_4,
         references=REFERENCES_4, open_questions=OPEN_QUESTIONS_4, tables=TABLES_4),
    dict(layer=LAYERS[4], base=L2, src=SRC_OCT64, data_types=[], variable_kinds=VARIABLE_KINDS_C,
         parameter_kinds=PARAMETER_KINDS_C, features=FEATURES_C, errors=[], error_rules=[], keywords=KEYWORDS_C,
         entries=ENTRIES_C, entry_errors=ENTRY_ERRORS_C, examples=EXAMPLES_C, references=REFERENCES_C,
         open_questions=OPEN_QUESTIONS_C, tables=TABLES_C),
]


# ---------------------------------------------------------------------
# SQL generation
# ---------------------------------------------------------------------
def q(v):
    if v is None:
        return "NULL"
    if isinstance(v, bool):
        return "1" if v else "0"
    if isinstance(v, (int, float)):
        return repr(v) if isinstance(v, float) else str(v)
    return "'" + str(v).replace("'", "''") + "'"


def row(table, values):
    columns = ", ".join(values)
    return f"INSERT INTO {table} ({columns}) VALUES ({', '.join(q(v) for v in values.values())});"


def generate():
    out = ["-- " + "=" * 69,
           "--  BASIC 2 BASIC - Dartmouth BASIC, editions 1 to 4",
           "--  GENERATED FILE from data/dartmouth.py: edit that file and regenerate.",
           "-- " + "=" * 69, "", "PRAGMA foreign_keys = ON;", "BEGIN;", ""]
    w = out.append

    for m in MACHINES:
        w(row("machine", m))
    for lay in LAYERS:
        w(row("layer", lay))
    for d, stack, machines in DIALECTS:
        w(row("dialect", d))
        for pos, lid in enumerate(stack, start=1):
            w(row("dialect_layer", dict(dialect_id=d["id"], layer_id=lid, position=pos)))
        for mid, default in machines:
            w(row("machine_dialect", dict(machine_id=mid, dialect_id=d["id"], medium="OTHER", is_default=default,
                                          notes="Compiler on the time-sharing system.")))
    for k, m in enumerate(MACHINES):
        cs_id = ID + 1 + k
        w(row("charset", dict(id=cs_id, machine_id=m["id"], **dict(CHARSET, code=f"ASR33_{m['code']}"))))
        for gr in glyph_rows(cs_id):
            w(row("glyph", gr))
        uk_id = ID + 11 + k
        w(row("charset", dict(id=uk_id, machine_id=m["id"], base_charset_id=cs_id,
                              **dict(CHARSET_UK, code=f"ASR33_UK_{m['code']}"))))
        w(row("glyph", dict(charset_id=uk_id, code=36, bitmap=ASR33_GLYPHS[POUND], unicode="\u00a3",
                            unicode_name="POUND SIGN", name="Pound sign",
                            notes="UK print head: in place of $. Reconstruction from a TrueType font.")))
        for code in range(32, 96):
            w(row("screen_code", dict(machine_id=m["id"], code=code, glyph_code=code)))
        for kind, status, notes in MACHINE_TABLES:
            w(f"INSERT INTO table_status (table_kind_id, machine_id, status, notes) "
              f"SELECT id, {m['id']}, {q(status)}, {q(notes)} FROM table_kind WHERE code = {q(kind)};")
    for s in SOURCES:
        w(row("source", dict(zip(("id", "title", "author", "publisher", "year", "kind", "url", "notes"), s))))
    w("")

    # cumulative state: code -> id of the latest version, over the layers seen so far
    type_id, vkind_id, pkind_id, feature_id, error_id, error_msg, keyword_id = {}, {}, {}, {}, {}, {}, {}
    entry_latest = {}            # (name, cat) -> dict(id, entry, form_ids, par_ids, errors, examples)
    counter = dict(dt=ID, vk=ID, pk=ID, kw=ID, entry=ID, form=ID, par=ID, node=ID * 10, err=ID)

    def node(n, form_id, parent, position, par_ids):
        counter["node"] += 1
        nid = counter["node"]
        kind = n["kind"]
        r = dict(id=nid, form_id=form_id, parent_id=parent, position=position, kind=kind,
                 attached=1 if n.get("att") else 0, meaning=n.get("meaning"))
        if kind == "LITERAL":
            r["text"] = n["text"]
        elif kind == "KEYWORD":
            r["keyword_id"] = keyword_id[n["text"]]
        elif kind == "PARAMETER":
            r["parameter_id"] = par_ids[n["name"]]
            r["parameter_kind_id"] = pkind_id[n["pkind"]]
        elif kind == "REPEAT":
            r.update(separator=n["separator"], min_occ=n["min_occ"], max_occ=n["max_occ"])
        w(row("syntax_node", r))
        for k, c in enumerate(n["children"], start=1):
            node(c, form_id, nid, k, par_ids)

    def parameter_names(n, acc):
        if n["kind"] == "PARAMETER" and n["name"] not in acc:
            acc.append(n["name"])
        for c in n["children"]:
            parameter_names(c, acc)
        return acc

    snapshots = {}               # layer id -> state after that layer (stacks can branch: Card BASIC)
    for ld in LAYER_DATA:
        lid = ld["layer"]["id"]
        if ld["base"] is None:
            type_id, vkind_id, pkind_id, feature_id, error_id, error_msg, keyword_id = {}, {}, {}, {}, {}, {}, {}
            entry_latest = {}
        else:
            (type_id, vkind_id, pkind_id, feature_id, error_id, error_msg, keyword_id,
             entry_latest) = copy.deepcopy(snapshots[ld["base"]])
        w(f"-- ================= layer {ld['layer']['code']}")
        for cc in ld.get("character_codes", []):
            w(row("character_code", cc))
        for kind, status, notes in ld["tables"]:
            w(f"INSERT INTO table_status (table_kind_id, layer_id, status, notes) "
              f"SELECT id, {lid}, {q(status)}, {q(notes)} FROM table_kind WHERE code = {q(kind)};")
        for code, name, suffix, cls, mn, mx, maxlen, prec, notes in ld["data_types"]:
            counter["dt"] += 1
            old = type_id.get(code)
            w(row("data_type", dict(id=counter["dt"], layer_id=lid, code=code, name=name, suffix=suffix,
                                    type_class_id=TYPE_CLASS[cls], minimum=mn, maximum=mx, max_length=maxlen,
                                    precision=prec, operation="REPLACE" if old else "ADD", redefines_id=old,
                                    notes=notes)))
            type_id[code] = counter["dt"]
        for code, name, dtype, dims, rule, pattern, maxlen, sig, examples, notes in ld["variable_kinds"]:
            counter["vk"] += 1
            old = vkind_id.get(code)
            w(row("variable_kind", dict(id=counter["vk"], layer_id=lid, code=code, name=name,
                                        data_type_id=type_id[dtype], dimensions=dims, name_rule=rule,
                                        name_pattern=pattern, max_name_length=maxlen, significant_chars=sig,
                                        examples=examples, notes=notes, operation="REPLACE" if old else "ADD",
                                        redefines_id=old)))
            vkind_id[code] = counter["vk"]
        for code, name, nature, cls, vkind, notes in ld["parameter_kinds"]:
            counter["pk"] += 1
            old = pkind_id.get(code)
            w(row("parameter_kind", dict(id=counter["pk"], layer_id=lid, code=code, name=name, nature=nature,
                                         type_class_id=TYPE_CLASS[cls] if cls else None,
                                         variable_kind_id=vkind_id[vkind] if vkind else None, notes=notes,
                                         operation="REPLACE" if old else "ADD", redefines_id=old)))
            pkind_id[code] = counter["pk"]
        for code, value, verified, notes in ld["features"]:
            old = feature_id.get(code)
            w(f"INSERT INTO feature (layer_id, feature_kind_id, value, verified, notes, operation, redefines_id) "
              f"SELECT {lid}, id, {q(value)}, {1 if verified else 0}, {q(notes)}, {q('REPLACE' if old else 'ADD')}, "
              f"{old or 'NULL'} FROM feature_kind WHERE code = {q(code)};")
            # the feature id is not explicit: find it by layer and kind
            feature_id[code] = f"(SELECT f.id FROM feature f JOIN feature_kind k ON k.id = f.feature_kind_id " \
                               f"WHERE f.layer_id = {lid} AND k.code = {q(code)})"
        for code, message, descr, op in ld["errors"]:
            counter["err"] += 1
            old = error_id.get(code)
            if op == "REMOVE":
                assert old, code
                w(row("error", dict(id=counter["err"], layer_id=lid, code=code, message=error_msg[code],
                                    operation="REMOVE", redefines_id=old)))
                del error_id[code]
                continue
            operation = "REPLACE" if old else "ADD"
            assert (op == "REPLACE") == bool(old) or op is None, (code, op)
            w(row("error", dict(id=counter["err"], layer_id=lid, code=code, message=message, operation=operation,
                                redefines_id=old, description=descr)))
            error_id[code], error_msg[code] = counter["err"], message
        for selector, value, code, cause, verified in ld["error_rules"]:
            assert code in error_id, code
            w(row("error_rule", dict(layer_id=lid, selector=selector, selector_value=value, error_code=code,
                                     cause=cause, verified=verified)))
        for text, notes in ld["keywords"]:
            counter["kw"] += 1
            assert text not in keyword_id, text
            w(row("keyword", dict(id=counter["kw"], layer_id=lid, text=text, notes=notes)))
            keyword_id[text] = counter["kw"]
        w("")

        names = [(e["name"], e["cat"]) for e in ld["entries"]]
        assert len(names) == len(set(names)), "duplicate entry"
        layer_names = {e["name"] for e in ld["entries"]}
        assert set(ld["entry_errors"]) <= layer_names, set(ld["entry_errors"]) - layer_names
        assert set(ld["examples"]) <= layer_names, set(ld["examples"]) - layer_names
        first_of_name = {}
        for e in ld["entries"]:
            first_of_name.setdefault(e["name"], (e["name"], e["cat"]))
        layer_entry_ids = {}
        for e in ld["entries"]:
            key = (e["name"], e["cat"])
            prev = entry_latest.get(key)
            counter["entry"] += 1
            eid = counter["entry"]
            layer_entry_ids.setdefault(e["name"], eid)
            src = e["src"] or ld["src"]
            if e["remove"]:
                assert prev, key
                w(row("entry", dict(id=eid, layer_id=lid, name=e["name"], category_id=CATEGORY[e["cat"]],
                                    operation="REMOVE", redefines_id=prev["id"], difference_notes=e["diff"])))
                del entry_latest[key]
                continue
            assert (prev is None) == (e["diff"] is None), (key, "REPLACE needs diff, ADD must not have it")
            w(f"-- {e['name']} ({e['cat']})")
            w(row("entry", dict(id=eid, layer_id=lid, name=e["name"], category_id=CATEGORY[e["cat"]],
                                operation="REPLACE" if prev else "ADD", redefines_id=prev["id"] if prev else None,
                                description=e["descr"], difference_notes=e["diff"], notes=e["notes"])))
            w(row("entry_source", dict(entry_id=eid, source_id=src, page=e["page"])))
            entry_par_ids, form_ids = {}, {}
            for k, f in enumerate(e["forms"], start=1):
                counter["form"] += 1
                fid = counter["form"]
                form_ids[k] = fid
                ret = f["ret"]
                w(row("syntax_form", dict(
                    id=fid, entry_id=eid, position=k, title=f["title"], description=f["descr"],
                    original_syntax=f["orig"], source_id=src, page=f["page"] or e["page"],
                    return_type_id=type_id[ret[0]] if ret else None,
                    return_min=ret[1] if ret else None, return_max=ret[2] if ret else None,
                    return_min_inclusive=ret[3] if ret and len(ret) > 3 else 1,
                    return_max_inclusive=ret[4] if ret and len(ret) > 4 else 1,
                    precedence=f["prec"], associativity=f["assoc"],
                    operator_class_id=OPERATOR_CLASS[f["op"]] if f["op"] else None,
                    evidence=f["ev"] or ("MANUAL" if ret and (ret[1] is not None or ret[2] is not None) else None))))
                par_ids = {}
                for name in parameter_names(f["tree"], []):
                    d = f["par"].get(name, {})
                    pev = d.get("ev", "MANUAL" if d else None)
                    counter["par"] += 1
                    par_ids[name] = counter["par"]
                    assert d.get("error") is None or d["error"] in error_id, d.get("error")
                    w(row("parameter", dict(
                        id=counter["par"], form_id=fid, name=name,
                        conversion=d.get("conversion", "NONE"), error_code=d.get("error"),
                        missing_line=d.get("missing_line"), description=d.get("descr"), evidence=pev)))
                    if "limit" in d:
                        lim = d["limit"]
                        w(row("parameter_limit", dict(parameter_id=counter["par"], minimum=lim[0], maximum=lim[1],
                                                      notes=lim[2] if len(lim) > 2 else None,
                                                      min_inclusive=lim[3] if len(lim) > 3 else 1,
                                                      max_inclusive=lim[4] if len(lim) > 4 else 1, evidence=pev)))
                    for value, meaning in d.get("allowed", []):
                        w(row("allowed_value", dict(parameter_id=counter["par"], value=value, meaning=meaning,
                                                    evidence=pev)))
                node(f["tree"], fid, None, 1, par_ids)
                entry_par_ids.update({(k, name): pid for name, pid in par_ids.items()})
                for code, coverage, note in f["actions"]:
                    w(f"INSERT INTO form_action (form_id, action_id, coverage, notes) "
                      f"SELECT {fid}, id, {q(coverage)}, {q(note)} FROM action WHERE code = {q(code)};")
            # errors and examples: those of this layer, or (for a REPLACE) those of the previous version;
            # a name shared by two categories (=) gives them to the first one only
            is_first = first_of_name[e["name"]] == key
            own_err = ld["entry_errors"].get(e["name"]) if is_first else None
            own_ex = ld["examples"].get(e["name"]) if is_first else None
            errors = own_err if own_err is not None else (prev["errors"] if prev else [])
            examples = own_ex if own_ex is not None else (prev["examples"] if prev else [])
            examples_src = src if own_ex is not None else (prev["ex_src"] if prev else src)
            for k, x in enumerate(errors, start=1):
                if x["code"] not in error_id:
                    continue          # error no longer in this edition
                targets = ([(x["form"], entry_par_ids[(x["form"], x["par"])])] if x["form"] and x["par"] else
                           [(x["form"], None)] if not x["par"] else
                           [(fk, pid) for (fk, name), pid in entry_par_ids.items() if name == x["par"]])
                assert targets, (e["name"], x)
                for fk, pid in targets:
                    if fk and fk not in form_ids:
                        continue
                    w(row("entry_error", dict(entry_id=eid, form_id=form_ids[fk] if fk else None, parameter_id=pid,
                                              error_code=x["code"], operation="REMOVE" if x["remove"] else "ADD",
                                              cause=x["cause"], verified=x["verified"], position=k)))
            for k, x in enumerate(examples, start=1):
                w(row("example", dict(entry_id=eid, form_id=form_ids.get(x["form"]) if x["form"] else None,
                                      position=k, title=x["title"], description=x["description"],
                                      code=x["code"], expected_result=x["expected"], verified=1 if x["verified"] else 0,
                                      source_id=(x["src"] or examples_src) if x["manual"] else None,
                                      page=x["page"] if x["manual"] else None)))
            entry_latest[key] = dict(id=eid, errors=errors, examples=examples, ex_src=examples_src)
            w("")

        for a, b, kind in ld["references"]:
            ida = layer_entry_ids.get(a) or next(v["id"] for (n, c), v in entry_latest.items() if n == a)
            idb = layer_entry_ids.get(b) or next(v["id"] for (n, c), v in entry_latest.items() if n == b)
            w(row("reference", dict(entry_id=ida, related_entry_id=idb, kind=kind)))
        for k, text in enumerate(ld["open_questions"], start=1):
            w(row("open_question", dict(layer_id=lid, position=k, question=text)))
        snapshots[lid] = copy.deepcopy((type_id, vkind_id, pkind_id, feature_id, error_id, error_msg, keyword_id,
                                        entry_latest))
        w("")
    w("COMMIT;")
    return "\n".join(out) + "\n"


if __name__ == "__main__":
    target = os.path.join(os.path.dirname(os.path.abspath(__file__)), "dartmouth.sql")
    with open(target, "w", encoding="utf-8") as f:
        f.write(generate())
    print(f"written {target}")
