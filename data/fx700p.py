"""BASIC 2 BASIC - data source for Casio FX-700P BASIC.

Generates data/fx700p.sql:   python data/fx700p.py

Syntax trees are written with the same small language as data/zx80.py:
    S(...)  sequence          C(...)  choice            O(x)  optional
    R(x, sep=",", min=1)      repeat
    K("PRINT")  keyword       L(",")  literal           P("name", "NUM_EXPR")  parameter
Common options: att=True (attached to the previous item), meaning="...".

Everything here comes from the manual [1] unless a note says otherwise, and
nothing has been tested on the real machine yet (some results of the PokecomGO2
simulator, source [9], are in the notes, never as verified): parameters, forms and tables are MANUAL (or
INFERRED where Claude deduced them), features, errors and examples are not
verified. original_syntax holds the formats of the Program Command List
(manual pp. 66-68) and of the function table (p. 61).

Every explicit id is ID + n, so that the rows never collide with those of
the other dialects (data/zx80.py uses 1, 2, 3...).

Sources: [1] Casio, "FX-700P Instruction Manual" (scan, 72 pages);
[2] Casio, "FX-730P Owner's Manual", section 4-8 "Using a PB-100 program";
[3] M. von Cube, "Casio utilities" (mvcsys.de); [4] P. Piatek, "Casio
FX-700P - hardware"; [5] P. Piatek, bas2fx70.c (converts an ASCII BASIC
program to the FX-700P tape image: keyword tokens, ASCII -> Casio character
table, line format); [6] image of the 128 glyphs, 5x7 pixels, 16x8 grid
(data/sources/fx700p_charset.png); [7] P. Piatek, "Casio FX-700P - data
formats" (memory map, variables, program lines, file formats).
"""

import os

ID = 100000                       # offset of every explicit id of this dialect

# ---------------------------------------------------------------------
# References to the base data (data/base.sql)
# ---------------------------------------------------------------------
TYPE_CLASS = {"NUMERIC": 1, "INTEGER": 2, "REAL": 3, "STRING": 4, "ANY": 5, "BOOLEAN": 6}
CATEGORY = {"STATEMENT": 1, "COMMAND": 2, "FUNCTION": 3, "OPERATOR": 4,
            "SYSTEM_VARIABLE": 5, "RESERVED_VARIABLE": 6}
OPERATOR_CLASS = {"ARITHMETIC": 1, "BITWISE": 2, "CONDITIONAL": 3, "LOGICAL": 4, "MEMORY": 5,
                  "RELATIONAL": 6, "STRING": 7, "GROUPING": 8}

# ---------------------------------------------------------------------
# Dialect identity
# ---------------------------------------------------------------------
MACHINE = dict(id=2, code="FX700P", name="Casio FX-700P", manufacturer="Casio", year=None,
               cpu="Hitachi HD61913A01 (4-bit, internal ROM) (source [4])",
               notes="Programmable calculator: 12-position 5x7 dot matrix LCD, 1568 program steps with "
                     "26 memories (up to 222), 10 program areas P0-P9. Two HD61914A RAM chips at $0000-$07FF and "
                     "$0800-$0FFF (source [4]). Options: FA-3 cassette interface, mini printer.")
# Machines that share the dialect: the same calculator with less memory and a keyboard
# without the F functions (according to the editor's sources). Their key combinations are
# in PB100_ABBREVIATIONS.
OTHER_MACHINES = [
    dict(id=ID + 2, code="PB100", name="Casio PB-100", manufacturer="Casio", year=1982,
         cpu="Hitachi HD61913A01, as in the FX-700P (service manual, checked by the editor)",
         notes="The FX-700P with less memory: 544 steps, 26 memories expandable to 94; with the OR-1 RAM pack "
               "as much as the FX-700P (222 memories; the scan of the manual reads 1,668 steps). Keys with one or "
               "two operations (SHIFT); the functions have no F key and are typed letter by letter."),
    dict(id=ID + 3, code="TRS80_PC4", name="Tandy Radio Shack TRS-80 PC-4", manufacturer="Tandy Radio Shack",
         year=1983,
         cpu="Hitachi HD61913A01, as in the FX-700P (service manual, checked by the editor)", notes="The Casio PB-100 sold under the Radio Shack name."),
]
DIALECT = dict(id=2, code="CASIO_FX700P", name="Casio FX-700P BASIC", version=None, author="Casio", year=None,
               notes="BASIC of a programmable calculator: numeric variables A-Z, character variables A$-Z$ "
                     "of up to 7 characters and the exclusive character variable $ of up to 30. The same "
                     "BASIC runs on the Casio PB-100 (less memory, no F key for the functions) and on its "
                     "rebrandings TRS-80 PC-4 and Olympia OP-544. Memory addresses in the tables are those "
                     "of the FX-700P.")
LAYER = dict(id=2, code="FX700P_core", name="Casio FX-700P BASIC", kind="CORE", author="Casio", year=None)

SRC_MANUAL = ID + 1
SOURCES = [
    (SRC_MANUAL, "FX-700P Instruction Manual", None, "Casio", None, "MANUAL", None,
     "Scanned English manual, 72 pages; the pages cited are the printed ones."),
    (ID + 2, "FX-730P Owner's Manual, 4-8 Using a PB-100 Program", None, "Casio", None, "MANUAL",
     "https://www.manualslib.com/manual/1058309/Casio-Fx-730p.html?page=93",
     "Differences between the PB-100/FX-700P BASIC and the FX-730P one."),
    (ID + 3, "Casio utilities", "Marcus von Cube", None, None, "WEB", "https://mvcsys.de/doc/casioutil.html",
     "The FX-700P does not understand REM; the internal encoding is not ASCII."),
    (ID + 4, "Casio FX-700P - hardware", "Piotr Piatek", None, None, "WEB",
     "https://calculators.pdp-11.ru/hardware.htm", "Microprocessor and RAM chips."),
    (ID + 5, "bas2fx70.c", "Piotr Piatek", None, None, "WEB", "https://mk.bs0dd.net/piotr433/programs.htm",
     "C source of a converter from ASCII BASIC to the FX-700P tape image: keyword tokens, table from ASCII to "
     "the Casio character codes, format of a program line and of the tape file."),
    (ID + 6, "FX-700P character set (image)", None, None, None, "WEB", None,
     "The 128 glyphs, 5x7 pixels, in a 16x8 grid for the codes 0-127 (data/sources/fx700p_charset.png)."),
    (ID + 7, "Casio FX-700P - data formats", "Piotr Piatek", None, None, "WEB",
     "https://mk.bs0dd.net/piotr433/formats.htm",
     "Memory map, numeric and string variables, program lines, FOR and GOSUB stacks, tape file formats."),
    (ID + 8, "Model PC-4 Pocket Computer Programming Guide", None, "Tandy / Radio Shack", None, "MANUAL",
     "https://archive.org/details/Model_PC-4_Pocket_Computer_Programming_Guide_19xx_Tandy",
     "Tutorial for the TRS-80 PC-4 (the same BASIC). Uses character arrays: K$(0) to K$(9) are the memories K to T."),
    (ID + 9, "PokecomGO2 (pokecom2)", "digihori (Horiuchi)", None, None, "WEB", "https://github.com/digihori/pokecom2",
     "Android PB-100 simulator: the BASIC is rewritten in Java (SBasic.java), the ROM is not used. Its results show "
     "what its author implemented, not what the machine does: the FOR stack has no limit, NEXT without FOR and "
     "RETURN without GOSUB give error 2, commands it does not run in a program (LIST, DEFM, VER, LOAD, SAVE, RUN) "
     "are skipped, CLEAR in a program works like VAC, READ/DATA/RESTORE/ON/BEEP/LET are added."),
]

DATA_TYPES = [
    # id, code, name, suffix, class, minimum, maximum, bytes, notes
    (ID + 1, "REAL", "Real number", None, "REAL", -9.999999999e99, 9.999999999e99, None,
     "Absolute values from 1E-99 to 9.999999999E99, and 0; calculations use 12 mantissa digits, "
     "the display shows 10 (8 with an exponent). Below 1E-99 the result becomes 0; above the range: error 3. "
     "A memory takes the place of 8 program steps. In a program a number is stored as its characters; the "
     "exponent is a character of its own: ᴇ (code $1F), or ᴇ- ($1E) for a negative exponent (source [5])."),
    (ID + 2, "STRING", "Character string", "$", "STRING", None, None, None,
     "Up to 7 characters in a character variable (A$-Z$), up to 30 in the exclusive character variable $. "
     "Only joining (+) and comparison are possible."),
]

# Features: answers to the catalogue in data/base.sql (feature_kind).
# code, value, verified, notes. Nothing is verified on the real machine.
FEATURES = [
    ("LINE_NUMBERS", "1-9999", False, "A line with the same number as an existing one replaces it."),
    ("MULTIPLE_STATEMENTS", "Yes", False,
     "A line holds up to 62 characters, line number included. VAC and EXP cannot be used in a multistatement."),
    ("STATEMENT_SEPARATOR", ":", False, None),
    ("LET", "Absent", False, "There is no LET keyword: an assignment is written `variable = expression`."),
    ("TRUE_VALUE", "None", False, "Comparisons can only be written in IF: they produce no value."),
    ("FALSE_VALUE", "None", False, "Comparisons can only be written in IF: they produce no value."),
    ("TRUTH_TEST", "Comparison only", False, "IF needs a comparison; a number alone is not a condition."),
    ("INTEGER_CONVERSION", "Truncation (the decimal part is cut off)", False,
     "Stated for the line and area numbers of GOTO and GOSUB, the position of CSR and the arguments of MID."),
    ("MODAL_KEYBOARD", "Both", False,
     "With S the alphabet keys give statements (one-key commands), with F functions; "
     "everything can also be typed letter by letter."),
    ("TAB_ZONE_WIDTH", "None", False,
     "No zones: after ',' the next item is shown on a cleared display, after ';' it follows the previous one."),
    ("VARIABLE_TAB_STOPS", "Yes", False, "CSR n (0-11) inside PRINT shows the next item from position n."),
    ("FOR_RUNS_ONCE", "Yes", False,
     "From the PokecomGO2 simulator (source [9]): `FOR I=5 TO 1` executes the body once. Weak evidence: in its code "
     "the test that should skip the loop always succeeds, so it never skips. Not tested on the real machine."),
    ("FOR_VARIABLE_CHANGEABLE", "Yes", False,
     "From the PokecomGO2 simulator (source [9]): `I=I+4` inside `FOR I=1 TO 10` gives 5, then 10, then the loop "
     "ends. Not tested on the real machine."),
]

# Errors (p. 65): code, number, description. There is no error 8.
ERRORS = [
    ("MEMORY_OVERFLOW", 1, "Memory overflow or system stack overflow: not enough program steps, or a formula "
                           "too complex for the stack."),
    ("SYNTAX", 2, "Syntax error: format error in the program, different formats on the two sides of an "
                  "assignment, etc."),
    ("MATHEMATICAL", 3, "Mathematical error: a result of 1E100 or more, an argument outside the range of a "
                        "function, or a result that is indefinite or impossible."),
    ("UNDEFINED_LINE", 4, "Undefined line number: the line of a GOTO or GOSUB does not exist."),
    ("ARGUMENT", 5, "Argument error: the argument of a command or function is outside its range."),
    ("VARIABLE", 6, "Variable error: a memory that has not been expanded, or the same memory used as a "
                    "numeric and as a character variable at the same time."),
    ("NESTING", 7, "Nesting error: RETURN without GOSUB, NEXT outside a FOR loop, more than 8 subroutine "
                   "levels or more than 4 FOR loops."),
    ("OPTION", 9, "Option error: no printer or tape recorder connected when PRT mode or a tape command "
                  "such as SAVE is used."),
]

# Errors given by every entry with a parameter of a kind, an action or an
# operator class: selector, value, error code, cause, verified.
EXPR_MATH = "A calculation in the expression goes out of range, or its result is indefinite or impossible."
EXPR_VAR = "The expression uses a memory that has not been expanded, or a numeric and a character variable " \
           "of the same letter."
ERROR_RULES = [
    ("PARAMETER_KIND", "NUM_EXPR", "MATHEMATICAL", EXPR_MATH, False),
    ("PARAMETER_KIND", "NUM_EXPR", "VARIABLE", EXPR_VAR, False),
    ("PARAMETER_KIND", "STR_EXPR", "VARIABLE", EXPR_VAR, False),
    ("PARAMETER_KIND", "CONDITION", "MATHEMATICAL", EXPR_MATH, False),
    ("PARAMETER_KIND", "CONDITION", "VARIABLE", EXPR_VAR, False),
    ("PARAMETER_KIND", "ARRAY_ELEMENT", "VARIABLE", "The element is beyond the memories in use (expand them with DEFM).", False),
    ("PARAMETER_KIND", "STR_ARRAY_ELEMENT", "VARIABLE", "The element is beyond the memories in use (expand them with DEFM), "
     "or its memory holds a number.", False),
    ("PARAMETER_KIND", "NUM_VAR", "VARIABLE", "The letter is in use as a character variable.", False),
    ("PARAMETER_KIND", "STR_VAR", "VARIABLE", "The letter is in use as a numeric variable.", False),
    ("OPERATOR_CLASS", "ARITHMETIC", "MATHEMATICAL", "The result is 1E100 or more, or it is indefinite or impossible.", False),
    ("ACTION", "TAPE_SAVE", "OPTION", "No tape recorder connected.", False),
    ("ACTION", "TAPE_LOAD", "OPTION", "No tape recorder connected.", False),
    ("ACTION", "TAPE_VERIFY", "OPTION", "No tape recorder connected.", False),
    ("ACTION", "TAPE_SAVE_DATA", "OPTION", "No tape recorder connected.", False),
    ("ACTION", "TAPE_LOAD_DATA", "OPTION", "No tape recorder connected.", False),
    ("ACTION", "IO_PRINTER", "OPTION", "No printer connected.", False),
]


def EE(code, cause=None, verified=False, form=None, par=None, remove=False):
    """Error of an entry. form = position of the form (None = every form); par = parameter name;
    remove=True: an error that a rule would give does not happen here."""
    return dict(code=code, cause=cause, verified=verified, form=form, par=par, remove=remove)


# Errors of each entry, besides those of the rules and of the parameters.
# Nothing is verified. ARGUMENT errors are inferred (the manual gives only the general rule).
ENTRY_ERRORS = {
    "FOR...TO...STEP": [EE("NESTING", "More than 4 nested FOR loops (manual; the FOR stack of source [7] has 4 "
                                      "places). The PokecomGO2 simulator has no limit.")],
    "NEXT": [EE("NESTING", "NEXT outside a FOR loop (manual; the PokecomGO2 simulator gives error 2).")],
    "GOSUB": [EE("NESTING", "More than 8 subroutine levels.")],
    "RETURN": [EE("NESTING", "RETURN without GOSUB (manual; the PokecomGO2 simulator gives error 2).")],
    "VAL": [EE("SYNTAX", "The string holds no number (e.g. \"ABC\"); in a program the message is `ERR 2` "
                         "without program area and line.")],
    "DEFM": [EE("MEMORY_OVERFLOW", "Not enough free program steps for the memories asked for.")],
    "INPUT": [EE("SYNTAX", "Characters typed for a numeric variable (inferred: the manual only says that an "
                           "error occurs; AC returns to the question mark).")],
    "CSR": [EE("ARGUMENT", "Position outside 0-11 (inferred).")],
    "MID": [EE("ARGUMENT", "m or n outside 1-30, or m+n greater than the number of characters plus 1 (inferred).")],
    "SET": [EE("ARGUMENT", "n outside 0-9 (inferred).")],
    "GOTO": [EE("ARGUMENT", "Program area outside 0-9 (inferred).", form=2)],
    "=": [EE("SYNTAX", "The two sides have different types (number and string).")],
}

# Keywords: text, notes. No token is known: the manual gives no codes.
KEYWORDS = [
    ("INPUT", None), ("PRINT", None), ("CSR", None), ("GOTO", None), ("IF", None), ("THEN", None),
    ("GOSUB", None), ("RETURN", None), ("FOR", None), ("TO", None), ("STEP", None), ("NEXT", None),
    ("STOP", None), ("END", None), ("VAC", None), ("LIST", None), ("RUN", None), ("CLEAR", None),
    ("MODE", None), ("SET", None), ("DEFM", None), ("KEY", None), ("LEN(", "The token includes the opening parenthesis."), ("MID(", "The token includes the opening parenthesis."),
    ("VAL(", "The token includes the opening parenthesis."), ("SAVE", None), ("LOAD", None), ("PUT", None), ("GET", None), ("VER", None),
    ("SIN", None), ("COS", None), ("TAN", None), ("ASN", None), ("ACS", None), ("ATN", None),
    ("SQR", None), ("EXP", None), ("LN", None), ("LOG", None), ("INT", None), ("FRAC", None),
    ("ABS", None), ("SGN", None), ("RND(", "The token includes the opening parenthesis."), ("RAN#", None),
    ("π", "Constant pi: a character (code $1B), not a token."),
    ("+", None), ("-", None), ("*", None), ("/", None), ("↑", "Power: x↑y."),
    ("=", "Assignment and comparison."), ("≠", "Not equal (one character)."),
    (">", None), ("≥", "One character."), ("<", None), ("≤", "One character."),
]

# Abbreviations: the key combination that types each keyword (manual pp. 5-7).
# "S + key" = shift-in mode, "F + key" = function mode; the key is named by its
# main symbol. EE is the exponent key. Keywords not listed: typed letter by letter.
# They are entered for the FX-700P (machine_id); the PB-100 and PC-4 have PB100_ABBREVIATIONS.
ABBREVIATIONS = {
    # S + alphabet keys: one-key commands
    "GOSUB": "S + A", "FOR": "S + S", "TO": "S + D", "STEP": "S + F", "NEXT": "S + G",
    "GOTO": "S + H", "IF": "S + J", "THEN": "S + K", "PRINT": "S + L",
    "RETURN": "S + Z", "STOP": "S + X", "END": "S + C", "DEFM": "S + V", "RUN": "S + B",
    "LIST": "S + N", "INPUT": "S + M",
    # F + alphabet keys: one-key functions
    "SIN": "F + A", "COS": "F + S", "TAN": "F + D", "ASN": "F + F", "ACS": "F + G",
    "ATN": "F + H", "LOG": "F + J", "LN": "F + K", "EXP": "F + L",
    "SQR": "F + Z", "ABS": "F + X", "SGN": "F + C", "INT": "F + V", "FRAC": "F + B",
    "RAN#": "F + N", "CSR": "F + M",
    # other keys
    "≥": "S + +", "≤": "S + -", ">": "S + *", "<": "S + /", "≠": "S + =",
    "↑": "S + .", "π": "S + EE",
    "+": "+", "-": "-", "*": "*", "/": "/", "=": "=",
}

# PB-100 and TRS-80 PC-4 (PC-4 manual pp. 5-6, the same as the PB-100 manual; images from the
# editor, who read the key legends): the shift-in keys are those of the FX-700P (S + A = GOSUB,
# ..., S + . = ↑, S + EE = π), but there is no F key: the functions are typed letter by letter.
PB100_ABBREVIATIONS = {k: v for k, v in ABBREVIATIONS.items() if not v.startswith("F + ")}

# Tokens (source [5]): one byte, from $80. Operators and π are character codes,
# not tokens: their code is given too, with a note.
TOKENS = {
    "SIN": "80", "COS": "81", "TAN": "82", "ASN": "83", "ACS": "84", "ATN": "85", "LOG": "86", "LN": "87",
    "EXP": "88", "SQR": "89", "INT": "8A", "FRAC": "8B", "ABS": "8C", "SGN": "8D", "RND(": "8E", "RAN#": "8F",
    "LEN(": "90", "VAL(": "91", "MID(": "92", "KEY": "93", "CSR": "94", "TO": "95", "STEP": "96", "THEN": "97",
    "FOR": "A0", "NEXT": "A1", "GOTO": "A2", "GOSUB": "A3", "RETURN": "A4", "IF": "A5", "PRINT": "A6",
    "INPUT": "A7", "MODE": "A8", "STOP": "A9", "END": "AA",
    "VAC": "B0", "SET": "B1", "PUT": "B2", "GET": "B3",
    "DEFM": "C0", "SAVE": "C1", "LOAD": "C2", "VER": "C3", "LIST": "C4", "RUN": "C5", "CLEAR": "C6",
    # character codes
    "+": "01", "-": "02", "*": "03", "/": "04", "↑": "05", ">": "0A", "≥": "0B", "=": "0C", "≤": "0D",
    "<": "0E", "≠": "0F", "π": "1B",
}
CHARACTER_TOKENS = {"+", "-", "*", "/", "↑", ">", "≥", "=", "≤", "<", "≠", "π"}

# ---------------------------------------------------------------------
# Memory (source [7]). The RAM has 4-bit words (nibbles): a byte takes two
# addresses, low nibble first. Offsets and sizes are in bytes; fields that are
# not whole bytes have them NULL and give their nibbles in the description.
# The manual (p. 22) counts 2 steps for a line number, 1 for a token or a
# character and 1 for EXE: a step is a byte.
# ---------------------------------------------------------------------
PROGRAM_LAYOUT_EVIDENCE = "MANUAL"
PROGRAM_LAYOUT = [
    ("Line number", 0, 2, "LITTLE",
     "Binary-coded decimal, lower two digits first: line 1234 is the bytes `$34 $12`, i.e. the nibbles "
     "4 3 2 1 in memory."),
    ("Line text", 2, None, None,
     "Tokens ($80-$C6) and character codes ($00-$7F). Numbers are written as characters (digits $10-$19, point "
     "$1A, exponent $1F or $1E for a negative one); the colon between two statements is $FE (inside quotes the "
     "colon is the character $5F). Spaces outside quotes are not stored."),
    ("End of line", None, 1, None, "$FF, written when EXE stores the line."),
]
# Program and variables areas (FX-700P addresses, source [7]). Nothing before
# the programs and the variables is described: '' and the $E0 after each program
# area (as in the SAVE A files) are inferred.
MEMORY_AREAS_EVIDENCE = "INFERRED"
MEMORY_AREAS = [
    ("PROGRAM", "", "$E0 after each program area (assumed from the SAVE A files)",
     "The programs P0-P9 occupy $0220-$0E5F (3136 nibbles = 1568 steps). Memories expanded with DEFM take their "
     "room from the end of this area, 8 steps each."),
    ("VARIABLES", "", "",
     "The memories occupy the end of the RAM, 16 nibbles each, going down: A at $0FF0, B at $0FE0, ..., Z at "
     "$0E60, then the expanded memories. The exclusive $ is apart, at $01E0-$021F."),
]

# Variables in memory (source [7]): kind -> [(name, offset, size, description)]
NUMBER_LAYOUT = [
    ("Exponent", 0, 1, "Nibbles 0-1: the last two digits of the exponent plus 100, units first "
                       "(exponent 2 → 102 → nibbles 2, 0)."),
    ("Sign and first exponent digit", None, None,
     "Nibble 2: the first digit of the exponent plus 100, plus 5 if the mantissa is negative: 0 = positive "
     "mantissa and negative exponent, 1 = positive and positive, 5 = negative and negative, 6 = negative "
     "and positive."),
    ("Mantissa", None, None, "Nibbles 3-14: the 12 digits of the mantissa (1.00000000000 to 9.99999999999), last "
                             "digit first."),
    ("Type", None, None, "Nibble 15: 0 for a number. Zero is stored as 8 bytes $00 (also the empty string)."),
]
STRING_LAYOUT = [
    ("Characters", 0, 7, "Nibbles 0-13: up to 7 character codes, each low nibble first; unused places $00."),
    ("Separator", None, None, "Nibble 14: 0."),
    ("Length", None, None, "Nibble 15: number of characters, 1-7. Not being 0, it tells a string from a number."),
]
VARIABLE_LAYOUTS = {
    "NUMERIC": NUMBER_LAYOUT,
    "NUMERIC_ARRAY": NUMBER_LAYOUT,
    "STRING": STRING_LAYOUT,
    "STRING_ARRAY": STRING_LAYOUT,
    "EXCLUSIVE_STRING": [
        ("Length", 0, 1, "Number of characters, 0-30."),
        ("Characters", 1, None, "The character codes."),
        ("End", None, 1, "$FF."),
    ],
}
VARIABLE_LAYOUT_EVIDENCE = "MANUAL"

# ---------------------------------------------------------------------
# Character set (source [6]): 128 glyphs of 5x7 pixels for the codes 0-127.
# Bitmaps: 7 bytes in hexadecimal, one row per byte, bit 7 = leftmost pixel
# (only bits 7-3 are used). Codes from $80 are tokens: there are no glyphs.
# ---------------------------------------------------------------------
CHARSET = dict(id=ID + 1, code="FX700P_LCD", name="LCD character set", width=5, height=7,
               description="128 characters of 5x7 dots: capital and small letters, digits, operators and symbols. "
                           "The order of the glyphs is the internal character code, which is not ASCII.")

FX700P_GLYPHS = [
    "00000000000000", "002020F8202000", "000000F8000000", "0020A870A82000", "00081020408000", "2070A820202020", "20202020200020", "50505000000000",
    "5050F850F85050", "2078A07028F020", "40201008102040", "80402010F800F8", "0000F800F80000", "08102040F800F8", "10204080402010", "0040F820F81000",
    "708898A8C88870", "20602020202070", "708808102040F8", "F8102010088870", "10305090F81010", "F880F008088870", "304080F0888870", "F8081020202020",
    "70888870888870", "70888878081060", "00000000006060", "0000F850505098", "40201010102040", "10204040402010", "3800E080E080E0", "0000F080E080F0",
    "708888F8888888", "F08888F08888F0", "70888080808870", "E09088888890E0", "F88080F08080F8", "F88080F0808080", "708880B8888878", "888888F8888888",
    "70202020202070", "38101010109060", "8890A0C0A09088", "808080808080F8", "88D8A8A8888888", "8888C8A8988888", "70888888888870", "F08888F0808080",
    "70888888A89068", "F08888F0A09088", "788080700808F0", "F8202020202020", "88888888888870", "88888888885020", "888888A8A8D888", "88885020508888",
    "88885020202020", "F80810204080F8", "00000000000000", "00000000000000", "00000000000000", "00000000000000", "00000000000000", "00000000000000",
    "00007008788878", "8080B0C8888870", "00007080808870", "08086898888878", "00007088F88070", "10282070202020", "00007888780870", "8080B0C8888888",
    "20006020202070", "10001010109060", "40404850605048", "60202020202070", "0000D0A8A8A8A8", "0000B0C8888888", "00007088888870", "0000F088F08080",
    "00007888780808", "00005860404040", "000078807008F0", "00207020202810", "00008888889868", "00008888885020", "00008888A8A850", "0000C830206098",
    "000088483020C0", "0000F8102040F8", "00000000000000", "00000000000000", "70880810200020", "00000000602040", "00606000602040", "00606000606000",
    "00708888887000", "F88840204088F8", "60909060000000", "00002050F80000", "70880868A8A870", "00885020508800", "002000F8002000", "2070F8F8A82070",
    "002040F8402000", "0050F8F8702000", "002070F8702000", "7020F8F8202070", "00009090E88080", "708888885050D8", "20202020A87020", "002010F8102000",
    "C0C81020409818", "8850F820F82020", "00F8888888F800", "70404040404070", "6090A040A89068", "000000000000F8", "60204000000000", "00000060600000",
    "70101010101070", "F8F8F8F8F8F8F8", "00000000000000", "00000000000000", "00000000000000", "00000000000000", "00000000000000", "00000000000000",
]

# Unicode equivalent of each glyph (code -> character)
FX700P_UNICODE = {
    0x00: ' ', 0x01: '+', 0x02: '-', 0x03: '*', 0x04: '/', 0x05: '↑', 0x06: '!', 0x07: '"', 0x08: '#',
    0x09: '$', 0x0A: '>', 0x0B: '≥', 0x0C: '=', 0x0D: '≤', 0x0E: '<', 0x0F: '≠', 0x10: '0', 0x11: '1',
    0x12: '2', 0x13: '3', 0x14: '4', 0x15: '5', 0x16: '6', 0x17: '7', 0x18: '8', 0x19: '9', 0x1A: '.',
    0x1B: 'π', 0x1C: ')', 0x1D: '(', 0x1F: 'ᴇ', 0x20: 'A', 0x21: 'B', 0x22: 'C', 0x23: 'D', 0x24: 'E',
    0x25: 'F', 0x26: 'G', 0x27: 'H', 0x28: 'I', 0x29: 'J', 0x2A: 'K', 0x2B: 'L', 0x2C: 'M', 0x2D: 'N',
    0x2E: 'O', 0x2F: 'P', 0x30: 'Q', 0x31: 'R', 0x32: 'S', 0x33: 'T', 0x34: 'U', 0x35: 'V', 0x36: 'W',
    0x37: 'X', 0x38: 'Y', 0x39: 'Z', 0x40: 'a', 0x41: 'b', 0x42: 'c', 0x43: 'd', 0x44: 'e', 0x45: 'f',
    0x46: 'g', 0x47: 'h', 0x48: 'i', 0x49: 'j', 0x4A: 'k', 0x4B: 'l', 0x4C: 'm', 0x4D: 'n', 0x4E: 'o',
    0x4F: 'p', 0x50: 'q', 0x51: 'r', 0x52: 's', 0x53: 't', 0x54: 'u', 0x55: 'v', 0x56: 'w', 0x57: 'x',
    0x58: 'y', 0x59: 'z', 0x5C: '?', 0x5D: ',', 0x5E: ';', 0x5F: ':', 0x60: '○', 0x61: 'Σ', 0x62: '°',
    0x63: '△', 0x64: '@', 0x65: '×', 0x66: '÷', 0x67: '♠', 0x68: '←', 0x69: '♥', 0x6A: '♦', 0x6B: '♣',
    0x6C: 'μ', 0x6D: 'Ω', 0x6E: '↓', 0x6F: '→', 0x70: '%', 0x71: '¥', 0x72: '□', 0x73: '[', 0x74: '&',
    0x75: '_', 0x76: "'", 0x77: '·', 0x78: ']', 0x79: '■',
}

# Official Unicode names, written out so they do not depend on the Unicode version of Python
UNICODE_NAMES = {
    ' ': 'SPACE',
    '!': 'EXCLAMATION MARK',
    '"': 'QUOTATION MARK',
    '#': 'NUMBER SIGN',
    '$': 'DOLLAR SIGN',
    '%': 'PERCENT SIGN',
    '&': 'AMPERSAND',
    "'": 'APOSTROPHE',
    '(': 'LEFT PARENTHESIS',
    ')': 'RIGHT PARENTHESIS',
    '*': 'ASTERISK',
    '+': 'PLUS SIGN',
    ',': 'COMMA',
    '-': 'HYPHEN-MINUS',
    '.': 'FULL STOP',
    '/': 'SOLIDUS',
    '0': 'DIGIT ZERO',
    '1': 'DIGIT ONE',
    '2': 'DIGIT TWO',
    '3': 'DIGIT THREE',
    '4': 'DIGIT FOUR',
    '5': 'DIGIT FIVE',
    '6': 'DIGIT SIX',
    '7': 'DIGIT SEVEN',
    '8': 'DIGIT EIGHT',
    '9': 'DIGIT NINE',
    ':': 'COLON',
    ';': 'SEMICOLON',
    '<': 'LESS-THAN SIGN',
    '=': 'EQUALS SIGN',
    '>': 'GREATER-THAN SIGN',
    '?': 'QUESTION MARK',
    '@': 'COMMERCIAL AT',
    'A': 'LATIN CAPITAL LETTER A',
    'B': 'LATIN CAPITAL LETTER B',
    'C': 'LATIN CAPITAL LETTER C',
    'D': 'LATIN CAPITAL LETTER D',
    'E': 'LATIN CAPITAL LETTER E',
    'F': 'LATIN CAPITAL LETTER F',
    'G': 'LATIN CAPITAL LETTER G',
    'H': 'LATIN CAPITAL LETTER H',
    'I': 'LATIN CAPITAL LETTER I',
    'J': 'LATIN CAPITAL LETTER J',
    'K': 'LATIN CAPITAL LETTER K',
    'L': 'LATIN CAPITAL LETTER L',
    'M': 'LATIN CAPITAL LETTER M',
    'N': 'LATIN CAPITAL LETTER N',
    'O': 'LATIN CAPITAL LETTER O',
    'P': 'LATIN CAPITAL LETTER P',
    'Q': 'LATIN CAPITAL LETTER Q',
    'R': 'LATIN CAPITAL LETTER R',
    'S': 'LATIN CAPITAL LETTER S',
    'T': 'LATIN CAPITAL LETTER T',
    'U': 'LATIN CAPITAL LETTER U',
    'V': 'LATIN CAPITAL LETTER V',
    'W': 'LATIN CAPITAL LETTER W',
    'X': 'LATIN CAPITAL LETTER X',
    'Y': 'LATIN CAPITAL LETTER Y',
    'Z': 'LATIN CAPITAL LETTER Z',
    '[': 'LEFT SQUARE BRACKET',
    ']': 'RIGHT SQUARE BRACKET',
    '_': 'LOW LINE',
    'a': 'LATIN SMALL LETTER A',
    'b': 'LATIN SMALL LETTER B',
    'c': 'LATIN SMALL LETTER C',
    'd': 'LATIN SMALL LETTER D',
    'e': 'LATIN SMALL LETTER E',
    'f': 'LATIN SMALL LETTER F',
    'g': 'LATIN SMALL LETTER G',
    'h': 'LATIN SMALL LETTER H',
    'i': 'LATIN SMALL LETTER I',
    'j': 'LATIN SMALL LETTER J',
    'k': 'LATIN SMALL LETTER K',
    'l': 'LATIN SMALL LETTER L',
    'm': 'LATIN SMALL LETTER M',
    'n': 'LATIN SMALL LETTER N',
    'o': 'LATIN SMALL LETTER O',
    'p': 'LATIN SMALL LETTER P',
    'q': 'LATIN SMALL LETTER Q',
    'r': 'LATIN SMALL LETTER R',
    's': 'LATIN SMALL LETTER S',
    't': 'LATIN SMALL LETTER T',
    'u': 'LATIN SMALL LETTER U',
    'v': 'LATIN SMALL LETTER V',
    'w': 'LATIN SMALL LETTER W',
    'x': 'LATIN SMALL LETTER X',
    'y': 'LATIN SMALL LETTER Y',
    'z': 'LATIN SMALL LETTER Z',
    '¥': 'YEN SIGN',
    '°': 'DEGREE SIGN',
    '·': 'MIDDLE DOT',
    '×': 'MULTIPLICATION SIGN',
    '÷': 'DIVISION SIGN',
    'Σ': 'GREEK CAPITAL LETTER SIGMA',
    'Ω': 'GREEK CAPITAL LETTER OMEGA',
    'μ': 'GREEK SMALL LETTER MU',
    'π': 'GREEK SMALL LETTER PI',
    'ᴇ': 'LATIN LETTER SMALL CAPITAL E',
    '←': 'LEFTWARDS ARROW',
    '↑': 'UPWARDS ARROW',
    '→': 'RIGHTWARDS ARROW',
    '↓': 'DOWNWARDS ARROW',
    '≠': 'NOT EQUAL TO',
    '≤': 'LESS-THAN OR EQUAL TO',
    '≥': 'GREATER-THAN OR EQUAL TO',
    '■': 'BLACK SQUARE',
    '□': 'WHITE SQUARE',
    '△': 'WHITE UP-POINTING TRIANGLE',
    '○': 'WHITE CIRCLE',
    '♠': 'BLACK SPADE SUIT',
    '♣': 'BLACK CLUB SUIT',
    '♥': 'BLACK HEART SUIT',
    '♦': 'BLACK DIAMOND SUIT',
}

FX700P_NAMES = {0x00: "Space", 0x1E: "Exponent sign, negative exponent", 0x1F: "Exponent sign"}
BLANK_CODES = [0x3A, 0x3B, 0x3C, 0x3D, 0x3E, 0x3F, 0x5A, 0x5B, 0x7A, 0x7B, 0x7C, 0x7D, 0x7E, 0x7F]
CODE_NOTES = {
    0x05: "Power (^ in ASCII).",
    0x64: "bas2fx70 maps @ to $65, where the image shows ×: to be checked.",
    0x65: "bas2fx70 maps @ here; in the image @ is $64: to be checked.",
    0x76: "bas2fx70 maps both ' and ` here.",
    0x7A: "Blank in the image; bas2fx70 maps \\ here (the ¥ sign is $71): to be checked.",
}


def fx700p_glyphs(charset_id):
    for code in range(128):
        u = FX700P_UNICODE.get(code)
        yield dict(charset_id=charset_id, code=code, bitmap=FX700P_GLYPHS[code], unicode=u,
                   unicode_name=UNICODE_NAMES[u] if u else None, name=FX700P_NAMES.get(code))


def fx700p_screen_codes(machine_id):
    """Assumed: the display shows, for each code 0-127, the glyph with the same number."""
    for code in range(128):
        yield dict(machine_id=machine_id, code=code, glyph_code=code)


def fx700p_character_codes():
    """Rows of the character_code table for the 256 codes."""
    token_of = {int(v, 16): k for k, v in TOKENS.items() if k not in CHARACTER_TOKENS}
    for code in range(256):
        r = dict(layer_id=LAYER["id"], code=code, evidence="MANUAL", notes=CODE_NOTES.get(code))
        if code in BLANK_CODES:
            r.update(kind="UNUSED", evidence="INFERRED",
                     notes=r["notes"] or "Blank in the image of the glyphs: probably not used.")
        elif code < 128:
            r.update(kind="PRINTABLE", screen_code=code)
        elif code in token_of:
            r.update(kind="TOKEN", name=token_of[code])
        elif code == 0xFE:
            r.update(kind="CONTROL", name="Statement separator", action="Separates two statements on a line",
                     notes="The colon of a multistatement; the printable colon is $5F.")
        elif code == 0xFF:
            r.update(kind="CONTROL", name="End of line", action="Ends a program line")
        else:
            r.update(kind="UNUSED", evidence="INFERRED", notes="Not used by bas2fx70.")
        yield r


# State of the tables that always exist: (table kind, status, notes)
LAYER_TABLES = [
    ("CHARACTER_CODES", "PARTIAL", "From bas2fx70 [5] and the image of the glyphs [6]: the code of a character is "
                                   "the position of its glyph. $00-$7F characters, $80-$C6 tokens, $FE and $FF "
                                   "control codes. Codes with a blank glyph, and the @ and \\ of bas2fx70, to be "
                                   "checked."),
    ("KEYBOARD_CODES", "TO_DO", "KEY gives the character of the key pressed; whether keys have codes is not known."),
    ("ERRORS", "COMPLETE", "Shown as `ERRn Pa-l`: n = error code, a = program area, l = line number "
                           "(in manual calculation only `ERRn`). There is no error 8."),
    ("OPERATOR_PRECEDENCE", "PARTIAL", "From p. 10: functions, power, multiplication and division, addition and "
                                      "subtraction; left to right at the same level (the manual's example "
                                      "`2+3*SIN(17+13)↑2` = 2.75 puts the function before the power). The change of "
                                      "sign is placed before the power as in the PokecomGO2 simulator (source [9]: "
                                      "`-2↑2` = 4); not tested on the real machine."),
    ("VARIABLE_LAYOUT", "COMPLETE", "From source [7]. The RAM has 4-bit words, so the fields are given in nibbles. "
                                    "Each memory takes 16 nibbles (8 steps). Memory map of the FX-700P: $0000-$00FF "
                                    "buffers, $0100 ANS, $0110 seed of RAN#, $0120 position for MID, $0140-$01BF FOR "
                                    "stack (4 entries), $01C0-$01DF GOSUB stack (8 entries), $01E0-$021F $, "
                                    "$0220-$0E5F programs, $0E60-$0FFF memories Z to A."),
    ("PROGRAM_LAYOUT", "COMPLETE", "From source [7], confirmed by bas2fx70 [5] and by the step counts of p. 22. "
                                   "The end of each program area ($E0) is assumed."),
    ("MUSICAL_NOTES", "NOT_APPLICABLE", "The command list has no sound command."),
]
MACHINE_TABLES = [
    ("GLYPHS", "COMPLETE", "128 glyphs of 5x7 dots for the codes 0-127, from the image [6]; 14 of them are blank."),
    ("SCREEN_CODES", "PARTIAL", "Assumed: the display shows for each code 0-127 the glyph with the same number."),
    ("COLORS", "NOT_APPLICABLE", "Monochrome LCD."),
]

# ---------------------------------------------------------------------
# Variable types: id, code, name, data type, dimensions, naming rule, name
# pattern, max name length, significant characters, examples, notes.
# ---------------------------------------------------------------------
VARIABLE_KINDS = [
    (ID + 1, "NUMERIC", "Numeric variable", "REAL", 0, "one letter", r"^[A-Z]$", 1, 0, "A, Z",
     "The 26 memories A-Z. A memory holds either a number or a string: the same letter cannot be used "
     "as numeric and character variable at the same time (error 6)."),
    (ID + 2, "STRING", "Character variable", "STRING", 0, "one letter followed by $", r"^[A-Z]\$$", 1, 0, "A$, X$",
     "Up to 7 characters. Uses the memory of the numeric variable with the same letter."),
    (ID + 3, "EXCLUSIVE_STRING", "Exclusive character variable", "STRING", 0, "the sign $ alone", r"^\$$", None, None, "$",
     "Up to 30 characters, in a special memory not counted by DEFM. MID works on it only."),
    (ID + 4, "NUMERIC_ARRAY", "Numeric array", "REAL", 1,
     "one letter followed by a subscript in parentheses", r"^[A-Z]$", 1, 0, "A(5), Z(10)",
     "There is no DIM: an array is a view of the memories. A(0) = A, A(1) = B, ..., A(25) = Z; in general the "
     "element X(i) is the memory i places after X, so B(24) = Z and Z(1) is the first expanded memory "
     "(A(221) = Z(196) with all 222 memories). Expand the memories with DEFM before using elements beyond Z."),
    (ID + 5, "STRING_ARRAY", "Character array", "STRING", 1,
     "one letter followed by $ and a subscript in parentheses", r"^[A-Z]\$$", 1, 0, "A$(5), K$(9)",
     "Like the numeric array, a view of the memories: A$(0) = A$, A$(1) = B$, ...; an element uses the memory "
     "of the numeric element with the same letter and subscript, and holds up to 7 characters. Source [8] "
     "(PC-4 guide): `K$(0)` to `K$(9)` are the memories K to T, so they cannot be used together with K(0)-K(9). "
     "The FX-700P manual shows numeric arrays only: not tested."),
]

# Parameter types: id, code, name, nature, type class, variable kind, notes
PARAMETER_KINDS = [
    (ID + 1, "NUM_LITERAL", "Numeric literal", "LITERAL", "NUMERIC", None, None),
    (ID + 2, "STR_LITERAL", "String literal", "LITERAL", "STRING", None, "Enclosed in quotes."),
    (ID + 3, "NUM_EXPR", "Numeric expression", "EXPRESSION", "NUMERIC", None, None),
    (ID + 4, "STR_EXPR", "Character expression", "EXPRESSION", "STRING", None,
     "String literal, character variable, character array element, $, MID or KEY, or a sum of them."),
    (ID + 5, "NUM_VAR", "Numeric variable", "VARIABLE", None, "NUMERIC", None),
    (ID + 6, "STR_VAR", "Character variable", "VARIABLE", None, "STRING", "A$-Z$ or the exclusive $."),
    (ID + 7, "ARRAY_ELEMENT", "Array element", "ARRAY_ELEMENT", None, "NUMERIC_ARRAY", "E.g. A(5)."),
    (ID + 11, "STR_ARRAY_ELEMENT", "Character array element", "ARRAY_ELEMENT", None, "STRING_ARRAY",
     "E.g. K$(3). Source [8]; not tested on the FX-700P."),
    (ID + 8, "ANY_VAR", "Any variable", "VARIABLE", None, None, "Numeric or character variable, $ or array element (numeric or character)."),
    (ID + 9, "CONDITION", "Comparison", "CONDITION", "NUMERIC", None,
     "Two numeric expressions, or two character expressions, joined by = ≠ > ≥ < ≤. Strings are compared by "
     "their character codes; numbers and strings cannot be compared."),
    (ID + 10, "STATEMENT", "Statement", "STATEMENT", None, None, None),
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
    """Function written without parentheses: SIN x."""
    return S(K(name), P(arg))


def binary(op, kind="NUM_EXPR"):
    return S(P("a", kind), K(op), P("b", kind))


LEFT = "LEFT"
FN_ARG = ("Constant, variable or numeric expression. Without parentheses only the number or variable "
          "that follows is the argument, since functions come first: `SIN A+B` is `(SIN A)+B`.")


# Parameters: name -> dict(descr, conversion, error, limit=(min, max, note, min_incl, max_incl),
#                          allowed=[(value, meaning)], missing_line, ev)
# Forms: F(tree, par, actions=[(code, coverage, note)], orig, title, ret=(type, min, max[, min_incl, max_incl]),
#          descr, prec, op, assoc, ev, page)
def E(name, cat, descr, forms, notes=None, page=None):
    return dict(name=name, cat=cat, descr=descr, forms=forms, notes=notes, page=page)


def F(tree, par=None, actions=(), orig=None, title=None, ret=None, descr=None, prec=None, op=None, assoc=None,
      ev=None, page=None):
    return dict(tree=tree, par=par or {}, actions=list(actions), orig=orig, title=title, ret=ret, descr=descr,
                prec=prec, op=op, assoc=assoc, ev=ev, page=page)


IN_PROGRAM_IGNORED = ("In a program: not known on the real machine (the manual says the tape commands work "
                      "only manually). The PokecomGO2 simulator (source [9]) accepts the line and skips the "
                      "command when it is reached, with no error.")

A_NOTE = ("The `A` of the \"all areas\" form is the letter A, not a keyword: it has no token of its own "
          "(the token tables of source [5] have only LIST, CLEAR, SAVE and LOAD).")

LINE = dict(descr="Line number: numeric expression, decimal part cut off; 1 to 9999.", conversion="TRUNCATE",
            limit=(1, 9999), missing_line="ERROR", error="UNDEFINED_LINE")
AREA = dict(descr="Program area: numeric expression, decimal part cut off; 0 to 9. Execution goes to the first "
                  "line of that area.", conversion="TRUNCATE", limit=(0, 9))
FILENAME = dict(descr="Up to 8 letters, digits or symbols, in quotes. Without it, the first file found.")

ENTRIES = [
    # ------------------------------------------------------------ commands
    E("RUN", "COMMAND", "Runs the program of the current area.", [
        F(S(K("RUN"), O(P("n", "NUM_LITERAL"))), {"n": dict(descr="Line to start from; without it, the first line.")},
          [("PROG_RUN", "FULL", None)], orig="RUN [line number]")],
      notes="A program can also be started with S and the number of its area (S 0 to S 9) in RUN mode.\n\n"
            "In a program: not known on the real machine. The PokecomGO2 simulator (source [9]) gives error 2 for "
            "`10 RUN 20`, probably because it skips RUN and then reads the 20 as a syntax error.", page="27"),
    E("LIST", "COMMAND", "Lists the program of the current area, or (LIST A) the programs of all areas and the "
                         "data in all memories.", [
        F(S(K("LIST"), O(P("n", "NUM_LITERAL"))), {"n": dict(descr="Line to start from; without it, the first line.")},
          [("PROG_LIST", "FULL", None)], orig="LIST [line number]", title="Current area", page="28"),
        F(S(K("LIST"), L("A", meaning="All program areas P0-P9")), {}, [("PROG_LIST", "FULL", "All areas, and the variables too")],
          orig="LIST A", title="All areas", page="64")],
      notes=A_NOTE + "\n\n" + IN_PROGRAM_IGNORED + " Tried with `10 LIST`.", page="28"),
    E("CLEAR", "COMMAND", "Erases the program of the current area, or (CLEAR A) the programs of all areas P0-P9.", [
        F(S(K("CLEAR")), {}, [("PROG_NEW", "PARTIAL", "Only the current program area")], orig="CLEAR",
          title="Current area"),
        F(S(K("CLEAR"), L("A", meaning="All program areas P0-P9")), {}, [("PROG_NEW", "FULL", None)], orig="CLEAR A", title="All areas")],
      notes=A_NOTE + "\n\nIn a program: not known on the real machine. In the PokecomGO2 simulator (source [9]) "
            "CLEAR in a program clears the variables like VAC (a comment of its author in the source).", page="26"),
    E("DEFM", "COMMAND", "Turns program steps into memories (variables), or shows how many memories there are.", [
        F(S(K("DEFM"), O(P("n", "NUM_LITERAL"))),
          {"n": dict(descr="Memories to add to the 26 of A-Z: DEFM 30 gives 56. Each memory takes 8 steps. "
                           "Without n, the number of memories is shown.", limit=(0, 196))},
          [("VAR_RESERVE", "FULL", None)], orig=None)],
      notes="The answer is shown as `***VAR:56`. The exclusive character variable $ is not counted. According to "
            "source [2] DEFM can only be used manually on the PB-100 and FX-700P.\n\n" + IN_PROGRAM_IGNORED +
            " Tried with `10 DEFM 5`.", page="8"),
    E("SAVE", "COMMAND", "Records on tape the program of the current area, or (SAVE A) the programs of all areas.", [
        F(S(K("SAVE"), O(P("filename", "STR_LITERAL"))), {"filename": FILENAME},
          [("TAPE_SAVE", "PARTIAL", "Only the current program area")], orig='SAVE ["filename"]', title="Current area"),
        F(S(K("SAVE"), L("A", meaning="All program areas P0-P9"), O(P("filename", "STR_LITERAL"))), {"filename": FILENAME},
          [("TAPE_SAVE", "FULL", None)], orig='SAVE A ["filename"]', title="All areas")],
      notes=A_NOTE + "\n\nOnly manually. On tape a program file is a header ($D0 plus the length of the name, 8 characters of "
            "name, number of the first line) and the program lines in segments of up to 63 bytes, each started "
            "by $02 and ended by $F1; the last ends with $F0. Each byte is sent with a start bit, an even parity "
            "bit and stop bits (source [5]).\n\n"
            "SAVE A: on tape the file starts with $F0 plus the length of the name; the ten programs follow in "
            "one segment, each ended by $E0 (an empty program is $E0 alone) (source [7]).", page="63"),
    E("LOAD", "COMMAND", "Loads from tape a program into the current area, or (LOAD A) the programs of all areas "
                         "recorded with SAVE A.", [
        F(S(K("LOAD"), O(P("filename", "STR_LITERAL"))), {"filename": FILENAME},
          [("TAPE_LOAD", "FULL", None)], orig='LOAD ["filename"]', title="Current area",
          descr="The display shows `PF:` and the file name. The old program is erased from the first line number "
                "of the loaded one."),
        F(S(K("LOAD"), L("A", meaning="All program areas P0-P9"), O(P("filename", "STR_LITERAL"))), {"filename": FILENAME},
          [("TAPE_LOAD", "FULL", None)], orig='LOAD A ["filename"]', title="All areas",
          descr="Only manually. The display shows `AF:` and the file name; all the old programs are cleared.")],
      notes=A_NOTE, page="63"),
    E("VER", "COMMAND", "Checks that a program or data file has been recorded correctly on tape.", [
        F(S(K("VER"), O(P("filename", "STR_LITERAL"))), {"filename": FILENAME},
          [("TAPE_VERIFY", "FULL", None)], orig='VER ["filename"]')],
      notes=IN_PROGRAM_IGNORED + " Tried with `10 VER`.", page="64"),
    # ---------------------------------------------------------- statements
    E("=", "STATEMENT", "Assignment: gives a variable the value of an expression.", [
        F(C(S(C(P("variable", "NUM_VAR"), P("variable", "ARRAY_ELEMENT")), K("="), P("expression", "NUM_EXPR")),
            S(C(P("variable", "STR_VAR"), P("variable", "STR_ARRAY_ELEMENT")), K("="), P("expression", "STR_EXPR"))),
          {"variable": dict(descr="Numeric variable, character variable or array element (numeric or character)."),
           "expression": dict(descr="Of the same type as the variable.")},
          [("VAR_LET", "FULL", None)], orig="Variable = Numeric Expression")],
      notes="There is no LET keyword. `=` means \"assign\": `I=I+1` increases I by 1.", page="25"),
    E("INPUT", "STATEMENT", "Stops the program and reads values from the keyboard.", [
        F(S(K("INPUT"), R(S(O(S(P("message", "STR_LITERAL"), L(",", att=True))),
                            C(P("variable", "NUM_VAR"), P("variable", "STR_VAR"), P("variable", "ARRAY_ELEMENT"),
                              P("variable", "STR_ARRAY_ELEMENT"))),
                          sep=",")),
          {"message": dict(descr="Shown before the question mark: `INPUT \"A=\",A` shows `A=?`."),
           "variable": dict(descr="Numeric variable, character variable, $ or array element (numeric or character). For a number an "
                                  "expression or a variable can be typed (`14*25`, `X`).")},
          [("IO_INPUT", "FULL", None)], orig="INPUT variable string")],
      notes="AC does not end the wait for input; MODE 0 stops the program.", page="51"),
    E("PRINT", "STATEMENT", "Shows numbers and strings on the display.", [
        F(S(K("PRINT"),
            C(S(K("CSR"), P("n")), P("item", "NUM_EXPR"), P("item", "STR_EXPR")),
            R(S(C(L(";"), L(",")),
                C(S(K("CSR"), P("n")), P("item", "NUM_EXPR"), P("item", "STR_EXPR"))), min=0),
            O(C(L(";"), L(",")))),
          {"item": dict(descr="Numeric or character expression. A number is shown with a sign position, so "
                              "`PRINT \"N=\";N` shows `N= 15`."),
           "n": dict(descr="Position of the next item, 0 to 11, decimal part cut off.", conversion="TRUNCATE",
                     limit=(0, 11))},
          [("IO_PRINT", "FULL", None), ("IO_POSITION", "FULL", "CSR n")],
          orig="PRINT output control function {;|,} output element [{;|,} ...]",
          descr="';' shows the next item after the previous one; ',' shows it after the display has been cleared. "
                "The program stops with STOP on the display until EXE is pressed.")],
      notes="With the printer on (MODE 7) the output is also printed.", page="52"),
    E("GOTO", "STATEMENT", "Jumps to a line, or to the start of another program area.", [
        F(S(K("GOTO"), P("n")), {"n": LINE}, [("FLOW_GOTO", "FULL", "Accepts an expression")],
          orig="GOTO {line number | variable}", title="Line"),
        F(S(K("GOTO"), L("#"), P("p", att=True)), {"p": AREA},
          [("FLOW_GOTO", "PARTIAL", "To the first line of program area P0-P9")], title="Program area")],
      page="35"),
    E("IF", "STATEMENT", "Conditional jump or statement: if the comparison is false, the program goes on with "
                         "the next line.", [
        F(S(K("IF"), P("comparison", "CONDITION"), K("THEN"), C(P("n"), S(L("#"), P("p", att=True)))),
          {"comparison": dict(descr="One comparison."), "n": LINE, "p": AREA},
          [("FLOW_IF", "FULL", "No ELSE")], orig="IF comparison THEN line number", title="Jump"),
        F(S(K("IF"), P("comparison", "CONDITION"), L(";"), P("statement", "STATEMENT")),
          {"comparison": dict(descr="One comparison."), "statement": dict(descr="Command or assignment.")},
          [("FLOW_IF", "FULL", "No ELSE")], orig="IF comparison ; command", title="Statement")],
      notes="When the comparison is false the rest of the line is skipped as well.", page="40"),
    E("GOSUB", "STATEMENT", "Calls a subroutine; RETURN goes back to the statement after GOSUB.", [
        F(S(K("GOSUB"), P("n")), {"n": LINE}, [("FLOW_GOSUB", "FULL", "Accepts an expression")],
          orig="GOSUB {line number | variable}", title="Line"),
        F(S(K("GOSUB"), L("#"), P("p", att=True)), {"p": AREA},
          [("FLOW_GOSUB", "PARTIAL", "Subroutine at the start of program area P0-P9")], title="Program area")],
      notes="Up to 8 levels.", page="56"),
    E("RETURN", "STATEMENT", "Ends a subroutine and goes back to the statement after the GOSUB.", [
        F(S(K("RETURN")), {}, [("FLOW_RETURN", "FULL", None)], orig="RETURN")], page="56"),
    E("FOR...TO...STEP", "STATEMENT", "Starts a loop: the variable goes from the start value to the end value "
                                      "in steps of the given increment.", [
        F(S(K("FOR"), P("v", "NUM_VAR"), K("="), P("e1"), K("TO"), P("e2"), O(S(K("STEP"), P("e3")))),
          {"v": dict(descr="Numeric variable."), "e1": dict(descr="Start value."), "e2": dict(descr="End value."),
           "e3": dict(descr="Increment; 1 if STEP is omitted. To count down it must be negative (STEP -1).")},
          [("FLOW_FOR", "FULL", None)], orig="FOR v=e1 TO e2 [STEP e3]")],
      notes="The loop is repeated `[(e2-e1)/e3]+1` times. Up to 4 nested loops; a loop can be left with a jump "
            "but not entered. Numbers are decimal inside, so steps like 0.01 add up exactly.", page="45"),
    E("NEXT", "STATEMENT", "Ends a FOR loop: if the variable plus the increment does not pass the end value, "
                           "the loop is repeated.", [
        F(S(K("NEXT"), P("v", "NUM_VAR")), {"v": dict(descr="Variable of the loop.")},
          [("FLOW_NEXT", "FULL", None)], orig="NEXT v")], page="45"),
    E("STOP", "STATEMENT", "Stops the program for a while: EXE continues it.", [
        F(S(K("STOP")), {}, [("FLOW_STOP", "FULL", None), ("FLOW_CONTINUE", "PARTIAL", "With the EXE key")],
          orig="STOP")], page="33"),
    E("END", "STATEMENT", "Ends the program; it cannot be continued with EXE.", [
        F(S(K("END")), {}, [("FLOW_END", "FULL", None)], orig="END")],
      notes="It can be omitted at the end of a program, but it marks where the subroutines begin.", page="26"),
    E("VAC", "STATEMENT", "Clears all variables (sets them to 0).", [
        F(S(K("VAC")), {}, [("VAR_CLEAR", "FULL", None)], orig="VAC")],
      notes="It cannot be used in a multistatement.", page="38"),
    E("MODE", "STATEMENT", "Chooses the angle unit, or switches the printer on and off.", [
        F(S(K("MODE"), P("n", "NUM_LITERAL")),
          {"n": dict(descr="Angle unit.", allowed=[("4", "degrees"), ("5", "radians"), ("6", "gradians")])},
          [("MATH_ANGLE_UNIT", "FULL", None)], orig="MODE {4|5|6}", title="Angle unit"),
        F(S(K("MODE"), P("n", "NUM_LITERAL")),
          {"n": dict(descr="Printer.", allowed=[("7", "printing on (PRT)"), ("8", "printing off")])},
          [("IO_PRINTER", "FULL", None)], title="Printer")],
      notes="With the MODE key, MODE 0 (RUN), 1 (WRT), 2 and 3 (trace on and off) and MODE . (extension, small "
            "letters and symbols) are key operations. After MODE 7, write MODE 8 before the end of the program.",
      page="47"),
    E("SET", "STATEMENT", "Chooses how many significant digits or decimal places the numbers are shown with.", [
        F(S(K("SET"), C(S(L("E"), P("n", "NUM_LITERAL", att=True)), S(L("F"), P("n", "NUM_LITERAL", att=True)), L("N"))),
          {"n": dict(descr="0 to 9.", limit=(0, 9))},
          [("IO_FORMAT", "FULL", None)], orig="SET {En|Fn|N}")],
      notes="SET E n: n significant digits (SET E0 gives 8); SET F n: n decimal places; SET N: back to normal. "
            "Only the display is rounded: the value in memory does not change.", page="54"),
    E("PUT", "STATEMENT", "Records variables on tape.", [
        F(S(K("PUT"), O(P("filename", "STR_LITERAL")), P("first", "ANY_VAR"), O(S(L(","), P("last", "ANY_VAR")))),
          {"filename": FILENAME,
           "first": dict(descr="First variable; with $, write it first."),
           "last": dict(descr="Last variable: all the memories from the first to the last are recorded.")},
          [("TAPE_SAVE_DATA", "FULL", None)], orig='PUT ["filename"] variable')],
      notes="On tape the file starts with $E0 plus the length of the name; the variables follow, separated by $FF, "
            "without their names (source [7]).", page="64"),
    E("GET", "STATEMENT", "Loads variables from tape.", [
        F(S(K("GET"), O(P("filename", "STR_LITERAL")), P("first", "ANY_VAR"), O(S(L(","), P("last", "ANY_VAR")))),
          {"filename": FILENAME, "first": dict(descr="First variable."), "last": dict(descr="Last variable.")},
          [("TAPE_LOAD_DATA", "FULL", None)], orig='GET ["filename"] variable')], page="64"),
    # ----------------------------------------------------------- functions
    E("KEY", "FUNCTION", "Character of the key being pressed, without waiting; empty if no key is pressed.", [
        F(S(K("KEY")), {}, [("IO_KEY", "FULL", None)], orig="Character variable = KEY", ret=("STRING", None, None))],
      notes="Used as `character variable = KEY`.", page="52"),
    E("CSR", "FUNCTION", "Inside PRINT: shows the next item from the given position of the display.", [
        F(S(K("CSR"), P("n")), {"n": dict(descr="Position 0 to 11, decimal part cut off.", conversion="TRUNCATE",
                                          limit=(0, 11))},
          [("IO_POSITION", "FULL", None)], orig="CSR n {;|,}")],
      notes="After CSR n, ';' shows the next item from position n; ',' shows nothing until the display is cleared.",
      page="53"),
    E("LEN", "FUNCTION", "Number of characters of a character variable.", [
        F(S(K("LEN("), P("v", "STR_VAR", att=True), L(")", att=True)),
          {"v": dict(descr="Only a character variable.")},
          [("STR_LEN", "FULL", None)], orig="LEN (character variable)", ret=("REAL", 0, 30))], page="55"),
    E("MID", "FUNCTION", "Part of the exclusive character variable $.", [
        F(S(K("MID("), P("m", att=True), O(S(L(",", att=True), P("n", att=True))), L(")", att=True)),
          {"m": dict(descr="First character, 1 to 30, decimal part cut off.", conversion="TRUNCATE", limit=(1, 30)),
           "n": dict(descr="Number of characters, decimal part cut off; without it, all the characters from m on.",
                     conversion="TRUNCATE", limit=(1, 30))},
          [("STR_SUBSTRING", "PARTIAL", "Only on the exclusive variable $")], orig="MID (m [, n])",
          ret=("STRING", None, None))],
      notes="With $=\"ABCDEFGHIJ\": `MID(3,4)` = CDEF, `MID(1,2)` = AB, `MID(5)` = EFGHIJ.", page="55"),
    E("VAL", "FUNCTION", "Number written in a character variable.", [
        F(S(K("VAL("), P("v", "STR_VAR", att=True), L(")", att=True)),
          {"v": dict(descr="Only a character variable.")},
          [("STR_TO_NUM", "FULL", None)], orig="VAL (character variable)", ret=("REAL", None, None))], page="56"),
    E("SIN", "FUNCTION", "Sine, in the current angle unit.", [
        F(fn("SIN"), {"x": dict(descr=FN_ARG, limit=(-1440, 1440, "In degrees; 8π in radians, 1600 in gradians.", 0, 0),
                                error="MATHEMATICAL")},
          [("MATH_SIN", "FULL", None)], orig="SIN x", ret=("REAL", -1, 1))], page="61"),
    E("COS", "FUNCTION", "Cosine, in the current angle unit.", [
        F(fn("COS"), {"x": dict(descr=FN_ARG, limit=(-1440, 1440, "In degrees; 8π in radians, 1600 in gradians.", 0, 0),
                                error="MATHEMATICAL")},
          [("MATH_COS", "FULL", None)], orig="COS x", ret=("REAL", -1, 1))], page="61"),
    E("TAN", "FUNCTION", "Tangent, in the current angle unit.", [
        F(fn("TAN"), {"x": dict(descr=FN_ARG, limit=(-1440, 1440, "In degrees; 8π in radians, 1600 in gradians.", 0, 0),
                                error="MATHEMATICAL")},
          [("MATH_TAN", "FULL", None)], orig="TAN x", ret=("REAL", None, None))], page="61"),
    E("ASN", "FUNCTION", "Arc sine, in the current angle unit.", [
        F(fn("ASN"), {"x": dict(descr=FN_ARG, limit=(-1, 1), error="MATHEMATICAL")},
          [("MATH_ASN", "FULL", None)], orig="ASN x", ret=("REAL", None, None))], page="61"),
    E("ACS", "FUNCTION", "Arc cosine, in the current angle unit.", [
        F(fn("ACS"), {"x": dict(descr=FN_ARG, limit=(-1, 1), error="MATHEMATICAL")},
          [("MATH_ACS", "FULL", None)], orig="ACS x", ret=("REAL", None, None))], page="61"),
    E("ATN", "FUNCTION", "Arc tangent, in the current angle unit.", [
        F(fn("ATN"), {"x": dict(descr=FN_ARG)},
          [("MATH_ATN", "FULL", None)], orig="ATN x", ret=("REAL", None, None))], page="61"),
    E("SQR", "FUNCTION", "Square root.", [
        F(fn("SQR"), {"x": dict(descr=FN_ARG, limit=(0, None), error="MATHEMATICAL")},
          [("MATH_SQR", "FULL", None)], orig="SQR x", ret=("REAL", 0, None))], page="61"),
    E("EXP", "FUNCTION", "The number e (2.718281828...).", [
        F(S(K("EXP"), L("1")), {}, [("MATH_EXP", "PARTIAL", "Only EXP 1, the constant e")], orig="EXP 1",
          ret=("REAL", None, None))],
      notes="The manual calls it a command that calls out the value of the exponential table: the argument can "
            "only be 1. It cannot be used in a continuous calculation nor in a multistatement. For e↑x, assign "
            "EXP 1 to a variable and use ↑.", page="61"),
    E("LN", "FUNCTION", "Natural logarithm.", [
        F(fn("LN"), {"x": dict(descr=FN_ARG, limit=(0, None, None, 0, 1), error="MATHEMATICAL")},
          [("MATH_LN", "FULL", None)], orig="LN x", ret=("REAL", None, None))], page="61"),
    E("LOG", "FUNCTION", "Common (base 10) logarithm.", [
        F(fn("LOG"), {"x": dict(descr=FN_ARG, limit=(0, None, None, 0, 1), error="MATHEMATICAL")},
          [("MATH_LOG", "FULL", None)], orig="LOG x", ret=("REAL", None, None))], page="61"),
    E("INT", "FUNCTION", "Largest integer not greater than the argument.", [
        F(fn("INT"), {"x": dict(descr=FN_ARG)}, [("MATH_INT", "FULL", None)], orig="INT x", ret=("REAL", None, None))],
      page="61"),
    E("FRAC", "FUNCTION", "The argument without its integer part.", [
        F(fn("FRAC"), {"x": dict(descr=FN_ARG)}, [("MATH_FRAC", "FULL", None)], orig="FRAC x", ret=("REAL", None, None))],
      page="61"),
    E("ABS", "FUNCTION", "Absolute value.", [
        F(fn("ABS"), {"x": dict(descr=FN_ARG)}, [("MATH_ABS", "FULL", None)], orig="ABS x", ret=("REAL", 0, None))],
      page="61"),
    E("SGN", "FUNCTION", "Sign: 1 if positive, 0 if zero, -1 if negative.", [
        F(fn("SGN"), {"x": dict(descr=FN_ARG)}, [("MATH_SGN", "FULL", None)], orig="SGN x", ret=("REAL", -1, 1))],
      page="61"),
    E("RND", "FUNCTION", "Rounds x at the digit of 10 to the power y.", [
        F(S(K("RND("), P("x", att=True), L(",", att=True), P("y", att=True), L(")", att=True)),
          {"x": dict(descr="Value to round."), "y": dict(descr="Power of 10 of the digit to keep: -2 rounds to hundredths.")},
          [("MATH_ROUND", "FULL", None)], orig="RND (x, y)", ret=("REAL", None, None))],
      notes="The parentheses are required. Not a random number: see RAN#. The manual rounds 12.3*4.56 = 56.088 to "
            "10^-2 and shows 56.1 (to be checked).", page="61"),
    E("RAN#", "FUNCTION", "Random number between 0 and 1.", [
        F(S(K("RAN#")), {}, [("RND_VALUE", "PARTIAL", "Only between 0 and 1")], orig="RAN #",
          ret=("REAL", 0, 1, 0, 0))],
      notes="10 significant digits: `RND(RAN#,-4)*1000` gives a three-digit number. The seed is kept in memory "
            "at $0110 and starts at 0.43429448190 (source [7]).", page="61"),
    E("π", "FUNCTION", "The number pi (3.141592654).", [
        F(S(K("π")), {}, [("MATH_PI", "FULL", None)], orig=None, ret=("REAL", None, None))], page="23"),
    # ----------------------------------------------------------- operators
    E("↑", "OPERATOR", "Raise to a power.", [
        F(binary("↑"), {"a": dict(descr="Greater than 0; a negative base is accepted when b is a natural number.")},
          [("OP_POWER", "FULL", None)], orig="x↑y", assoc=LEFT, prec=4, op="ARITHMETIC", ret=("REAL", None, None))],
      page="12"),
    E("-", "OPERATOR", "Change of sign and subtraction.", [
        F(S(K("-"), P("a", att=True)), {}, [("OP_NEG", "FULL", None)], orig=None, prec=5, op="ARITHMETIC",
          title="Change of sign", ret=("REAL", None, None)),
        F(binary("-"), {}, [("OP_SUB", "FULL", None)], orig=None, assoc=LEFT, prec=2, op="ARITHMETIC",
          title="Subtraction", ret=("REAL", None, None))],
      notes="The manual does not say where the change of sign stands in the order of calculation. It is placed "
            "**before** the power as in the PokecomGO2 simulator (source [9]), where `-2↑2` gives 4, that is "
            "`(-2)↑2`, not -4; there it can also follow another operator (`2↑-2` = 0.25, `3--2` = 5, `-2*-3` = 6) "
            "or a function (`SIN -30` = -0.5 in MODE 4). Not tested on the real machine.", page="10"),
    E("*", "OPERATOR", "Multiplication.", [
        F(binary("*"), {}, [("OP_MUL", "FULL", None)], orig=None, assoc=LEFT, prec=3, op="ARITHMETIC",
          ret=("REAL", None, None))], page="10"),
    E("/", "OPERATOR", "Division.", [
        F(binary("/"), {}, [("OP_DIV", "FULL", None)], orig=None, assoc=LEFT, prec=3, op="ARITHMETIC",
          ret=("REAL", None, None))], page="10"),
    E("+", "OPERATOR", "Addition, and joining of strings.", [
        F(binary("+"), {}, [("OP_ADD", "FULL", None)], orig=None, assoc=LEFT, prec=2, op="ARITHMETIC",
          title="Addition", ret=("REAL", None, None)),
        F(S(P("a", "STR_EXPR"), K("+"), P("b", "STR_EXPR")), {}, [("STR_CONCAT", "FULL", None)], orig=None,
          assoc=LEFT, prec=2, op="STRING", title="Joining", ret=("STRING", None, None))],
      notes="`A$=\"123\"`, `B$=\"456\"`: `A$+B$` = \"123456\". The result must fit the variable "
            "(7 characters, 30 for $).", page="24"),
    E("( )", "OPERATOR", "Parentheses: the expression inside is calculated first.", [
        F(S(L("("), P("e", "NUM_EXPR", att=True), L(")", att=True)), {"e": dict(descr="Numeric expression.")},
          [("OP_GROUP", "FULL", None)], orig=None, op="GROUPING")], page="10"),
]

for _op, _action, _name in (("=", "OP_EQ", "Equal"), ("≠", "OP_NE", "Not equal"), (">", "OP_GT", "Greater than"),
                            ("≥", "OP_GE", "Greater than or equal"), ("<", "OP_LT", "Less than"),
                            ("≤", "OP_LE", "Less than or equal")):
    ENTRIES.append(E(_op, "OPERATOR", f"{_name}: only in the comparison of IF.", [
        F(binary(_op), {}, [(_action, "FULL", None)], orig=None, prec=1, op="RELATIONAL", title="Between numbers"),
        F(S(P("a", "STR_EXPR"), K(_op), P("b", "STR_EXPR")), {}, [(_action.replace("OP_", "OP_STR_"), "FULL", None)],
          orig=None, prec=1,
          op="RELATIONAL", title="Between strings")],
      notes="Strings are compared by their character codes (the manual says ASCII); a number cannot be compared "
            "with a string.", page="40"))


# ---------------------------------------------------------------------
# Usage examples. All TO BE VERIFIED. manual=True: taken from the manual
# (page = printed page); the others are written by Claude.
# ---------------------------------------------------------------------
def X(title, code, expected=None, description=None, form=None, manual=False, page=None, verified=False):
    return dict(title=title, code=code, expected=expected, description=description, form=form, manual=manual,
                page=page, verified=verified)


EXAMPLES = {
    "RUN": [X("Run from a line", "RUN 30", None, "Runs the program of the current area from line 30.")],
    "LIST": [X("List from a line", "LIST 20", "The lines from 20 on, one at a time.", form=1),
             X("List everything", "LIST A", "All programs P0-P9 and the contents of the memories.", form=2)],
    "CLEAR": [X("Erase the current area", "CLEAR", None, "Only the program of the current area is erased.",
                form=1, manual=True, page="26"),
              X("Erase all programs", "CLEAR A", None, "The programs of P0-P9 are erased.", form=2, manual=True,
                page="26")],
    "DEFM": [X("Expand the memories", "DEFM 30", "***VAR:56", "26 + 30 memories; 240 program steps are used.",
               manual=True, page="8"),
             X("Show the memories", "DEFM", "***VAR:56", manual=True, page="8")],
    "SAVE": [X("Record a program", 'SAVE "ABC"', None, "The tape recorder must be recording.", form=1, manual=True,
               page="63"),
             X("Record all programs", 'SAVE A "FX-700P"', None, form=2, manual=True, page="63")],
    "LOAD": [X("Load a program", 'LOAD "ABC"', "PF:ABC", "Shown while loading.", form=1, manual=True, page="63"),
             X("Load all programs", 'LOAD A "FX-700P"', "AF:FX-700P", "Shown while loading.", form=2, manual=True,
               page="63")],
    "VER": [X("Check a recording", 'VER "ABC"', None, "Works like LOAD, without changing the memory.")],
    "INPUT": [X("Input with a message", '10 INPUT "A=",A\n20 PRINT A*2', "A=?",
                "Type 21 and EXE: 42 is shown.", manual=True, page="51")],
    "PRINT": [X("Text and number", '10 N=15\n20 PRINT "N=";N', "N= 15", "The space is the sign position.",
                manual=True, page="40"),
              X("Position on the display", "10 X=3\n20 PRINT X;CSR 5;X↑2", None,
                "3 is shown, then 9 from position 5.", manual=True, page="53")],
    "GOTO": [X("Computed jump", "10 INPUT A\n20 GOTO A*100", None,
               "With A = 1, 2 or 3 the program goes on at line 100, 200 or 300.", form=1, manual=True, page="38"),
             X("Another program area", "GOTO #5", None, "Jumps to the first line of P5.", form=2, manual=True, page="35")],
    "IF": [X("Conditional jump", "10 INPUT A\n20 IF A>10 THEN 50\n30 PRINT \"SMALL\"\n40 END\n50 PRINT \"LARGE\"",
             None, "Type 15: LARGE is shown.", form=1),
           X("Conditional statement", "70 IF A>B;B=A", None, "B gets the value of A when A is greater.",
             form=2, manual=True, page="41")],
    "GOSUB": [X("Call a subroutine", "10 A=2\n20 GOSUB 100\n30 PRINT A\n40 END\n100 A=A*A\n110 RETURN", "4", form=1)],
    "RETURN": [X("End of a subroutine", "10 GOSUB 100\n20 PRINT \"BACK\"\n30 END\n100 PRINT \"SUB\"\n110 RETURN",
                 "SUB\nBACK")],
    "FOR...TO...STEP": [X("Sum of squares", "10 B=0\n20 FOR I=1 TO 10\n30 B=B+I↑2\n40 NEXT I\n50 PRINT B", "385"),
                        X("Count down", "10 FOR I=10 TO 1 STEP -1\n20 PRINT I\n30 NEXT I", "10\n9\n...\n1"),
                        X("Body executed at least once", '10 FOR I=5 TO 1\n20 PRINT I\n30 NEXT I\n40 PRINT "FINE"',
                          "5\nFINE", "The end value is smaller than the start, but the body runs once "
                          "(so in the PokecomGO2 simulator, source [9])."),
                        X("Changing the loop variable", "10 FOR I=1 TO 10\n20 I=I+4\n30 PRINT I\n40 NEXT I",
                          "5\n10", "NEXT adds 1 to the changed value; after 10 the loop ends (so in PokecomGO2).")],
    "NEXT": [X("Steps of 2", "10 FOR I=1 TO 10 STEP 2\n20 PRINT I;\n30 NEXT I", "1 3 5 7 9")],
    "STOP": [X("Pause", '10 PRINT "A"\n20 STOP\n30 PRINT "B"', "A", "EXE continues and shows B.")],
    "END": [X("End before the subroutines", "10 GOSUB 100\n20 END\n100 PRINT 1\n110 RETURN", "1")],
    "VAC": [X("Clear the variables", "10 A=5\n20 VAC\n30 PRINT A", "0")],
    "MODE": [X("Degrees", "10 MODE 4\n20 PRINT SIN 30", "0.5", form=1, manual=True, page="62"),
             X("Print a result", "100 MODE 7\n110 PRINT A\n120 MODE 8", None, "A is printed too.", form=2,
               manual=True, page="64")],
    "SET": [X("Significant digits", "SET E4\n100/6", "1.667E01", manual=True, page="20"),
            X("Decimal places", "SET F2\n123/7", "17.57", manual=True, page="20"),
            X("Back to normal", "SET N\n1/3", "0.3333333333", manual=True, page="20")],
    "PUT": [X("Record variables", 'PUT "1-2" A,Z', None, "Records the variables from A to Z.", manual=True, page="64"),
            X("Record $ and an array", 'PUT "DT" $,A,Z(10)', None, "$ must come first.", manual=True, page="64")],
    "GET": [X("Load variables", 'GET "1-2" A,Z', None, "Loads the variables from A to Z.")],
    "KEY": [X("Wait for a key", '10 A$=KEY:IF A$="" THEN 10\n20 PRINT A$', None,
              "Line 10 repeats until a key is pressed.", manual=True, page="52")],
    "CSR": [X("Position", "PRINT CSR 5;\"A\"", None, "A is shown at position 5.")],
    "LEN": [X("Length", '10 C$="ABCDE"\n20 D=LEN(C$)\n30 PRINT D', "5")],
    "MID": [X("Part of $", '10 $="ABCDEFGHIJ"\n20 PRINT MID(3,4)', "CDEF", manual=True, page="55"),
            X("To the end", '10 $="ABCDEFGHIJ"\n20 PRINT MID(5)', "EFGHIJ", manual=True, page="55")],
    "VAL": [X("Number from a string", '10 Z$="78963"\n20 PRINT VAL(Z$)', "78963", manual=True, page="56")],
    "SIN": [X("Sine in degrees", "MODE 4\nSIN 30", "0.5"),
            X("Function before power", "MODE 4\nPRINT SIN 30↑2", "0.25",
              "The function is calculated first: (SIN 30)↑2, not SIN 900 (so in PokecomGO2 and in the "
              "manual's order of calculation).")],
    "COS": [X("Cosine in degrees", "MODE 4\nCOS 60", "0.5")],
    "TAN": [X("Tangent in degrees", "MODE 4\nTAN 45", "1")],
    "ASN": [X("Arc sine", "MODE 4\nASN 0.5", "30")],
    "ACS": [X("Arc cosine", "MODE 4\nACS 0.5", "60")],
    "ATN": [X("Arc tangent", "MODE 4\nATN 1", "45")],
    "SQR": [X("Sum of roots", "SQR 2+SQR 5", "3.65028154", manual=True, page="20")],
    "EXP": [X("Power of e", "10 E=EXP 1\n20 INPUT A,B\n30 C=(A+E↑1.5)/B\n40 PRINT C", None,
              "e is put in E, then (A+e↑1.5)/B is calculated.", manual=True, page="62")],
    "LN": [X("Natural logarithm", "LN 90", "4.49980967", manual=True, page="19")],
    "LOG": [X("Gain in dB", "10 INPUT X,Y\n20 Z=20*LOG (Y/X)\n30 PRINT Z", None, manual=True, page="62")],
    "INT": [X("Integer part", "INT (7800/96)", "81", manual=True, page="20")],
    "FRAC": [X("Fractional part", "FRAC (7800/96)", "0.25", manual=True, page="20")],
    "ABS": [X("Absolute value", "ABS (-78.9/5.6)", "14.08928571", manual=True, page="20")],
    "SGN": [X("Sign", "SGN -2", "-1", manual=True, page="20")],
    "RND": [X("Round", "RND (12.3*4.56,-2)", "56.1", "As printed in the manual (56.088 rounded).",
              manual=True, page="20")],
    "RAN#": [X("Three-digit random number", "10 N=RND(RAN#,-4)*1000\n20 PRINT N\n30 END", None,
               manual=True, page="62")],
    "π": [X("Area of a circle", "10 INPUT R\n20 S=π*R↑2\n30 PRINT S", None, "Type 2: 12.56637061.",
            manual=True, page="23")],
    "↑": [X("Power", "2↑10", "1024"),
          X("Negative exponent", "2↑-2", "0.25", "The change of sign can follow the power sign (so in PokecomGO2).")],
    "-": [X("Subtraction", "2431-1593", "838", form=2, manual=True, page="12"),
          X("Change of sign and power", "-2↑2", "4", "The change of sign is calculated first: (-2)↑2 (so in PokecomGO2).",
            form=1),
          X("Minus after minus", "3--2", "5", "Subtraction of a negative number (so in PokecomGO2).", form=2),
          X("Minus after times", "-2*-3", "6", "So in PokecomGO2.", form=1)],
    "*": [X("Multiplication", "838*2", "1676", manual=True, page="12")],
    "/": [X("Division", "1E5/7", "14285.71429", manual=True, page="10")],
    "+": [X("Addition", "741+852", "1593", form=1, manual=True, page="12")],
    "( )": [X("Order of calculation", "MODE 4\n2+3*SIN(17+13)↑2", "2.75", manual=True, page="10")],
    "=": [X("Equal strings", '10 A$="XYZ"\n20 IF A$="XYZ" THEN 40\n30 END\n40 PRINT "SAME"', "SAME", form=2)],
    "≠": [X("Different strings", '10 P$="A":Q$="B"\n20 IF P$≠Q$ THEN 40\n30 END\n40 PRINT "DIFF"', "DIFF", form=2)],
    ">": [X("Greater", "10 A=12\n20 IF A>10 THEN 40\n30 END\n40 PRINT \"YES\"", "YES", form=1)],
    "≥": [X("Greater or equal", "10 X=5:Y=5\n20 IF X≥Y THEN 40\n30 END\n40 PRINT \"YES\"", "YES", form=1)],
    "<": [X("Less", "10 A=3\n20 IF A<10 THEN 40\n30 END\n40 PRINT \"YES\"", "YES", form=1)],
    "≤": [X("Less or equal", "10 A=10\n20 IF A≤10 THEN 40\n30 END\n40 PRINT \"YES\"", "YES", form=1)],
}
# "=" is both an assignment (STATEMENT) and a comparison (OPERATOR): EXAMPLES holds the
# examples of the comparison, EXAMPLES_BY_CATEGORY those of the assignment.
EXAMPLES_BY_CATEGORY = {("=", "STATEMENT"): [
    X("Increase a variable", "10 I=0\n20 I=I+1\n30 PRINT I", "1"),
    X("Join strings", '10 A$="123":B$="456"\n20 C$=A$+B$\n30 PRINT C$', "123456", manual=True, page="24"),
    X("Character array", '10 K$(0)="ADA":K$(1)="BOB"\n20 PRINT K$(1);L$', "BOBBOB",
      "K$(1) is the memory L, so L$ holds the same string (source [8]).")]}

REFERENCES = [("FOR...TO...STEP", "NEXT", "OPENS_BLOCK"), ("GOSUB", "RETURN", "OPENS_BLOCK"),
              ("SAVE", "LOAD", "SEE_ALSO"), ("PUT", "GET", "SEE_ALSO"),
              ("STOP", "END", "SEE_ALSO"),
              ("MID", "LEN", "SEE_ALSO"), ("KEY", "INPUT", "SEE_ALSO"), ("RND", "RAN#", "SEE_ALSO"),
              ("VAC", "DEFM", "SEE_ALSO"), ("CSR", "PRINT", "SEE_ALSO"), ("EXP", "LN", "SEE_ALSO")]

# Things still to do that are not tied to one row (table open_question).
OPEN_QUESTIONS = [
    "Character codes $3A-$3F, $5A, $5B, $7A-$7F have a blank glyph: are they used? bas2fx70 maps @ to $65 "
    "(× in the image, @ is $64) and \\ to $7A (blank): which is right?",
    "Does each program area end with $E0 in memory, as in the SAVE A files?",
    "RND: the manual rounds 56.088 to 10^-2 and shows 56.1; check what RND(x,y) really does.",
    "Commands in a program (LIST, CLEAR, DEFM, VER, RUN, LOAD, SAVE): what does the real machine do? The PokecomGO2 "
    "simulator skips them (CLEAR works like VAC) and is no evidence.",
    "FOR: body executed at least once? loop variable changeable inside? at most 4 nested loops (manual, source [7])? "
    "Error of NEXT without FOR and RETURN without GOSUB (7 in the manual, 2 in PokecomGO2)?",
    "Order of the change of sign against the power (`-2↑2`: 4 in PokecomGO2, not tested on the real machine).",
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
           "--  BASIC 2 BASIC - Casio FX-700P BASIC",
           "--  GENERATED FILE from data/fx700p.py: edit that file and regenerate.",
           "-- " + "=" * 69, "", "PRAGMA foreign_keys = ON;", "BEGIN;", ""]
    w = out.append
    layer_id = LAYER["id"]

    w(row("machine", MACHINE))
    for m in OTHER_MACHINES:
        w(row("machine", m))
    w(row("dialect", DIALECT))
    w(row("layer", LAYER))
    w(row("dialect_layer", dict(dialect_id=DIALECT["id"], layer_id=layer_id, position=1)))
    machines = [MACHINE] + OTHER_MACHINES
    for m in machines:
        w(row("machine_dialect", dict(machine_id=m["id"], dialect_id=DIALECT["id"], medium="ROM", is_default=1)))
    w("")
    # each machine has its own copy of the character set (same glyphs)
    for k, m in enumerate(machines):
        charset = dict(CHARSET, id=CHARSET["id"] + k, code=CHARSET["code"] + ("" if k == 0 else f"_{m['code']}"))
        w(row("charset", dict(machine_id=m["id"], **charset)))
        for g in fx700p_glyphs(charset["id"]):
            w(row("glyph", g))
        for sc in fx700p_screen_codes(m["id"]):
            w(row("screen_code", sc))
    for cc in fx700p_character_codes():
        w(row("character_code", cc))
    w("")
    for area, prologue, epilogue, notes in MEMORY_AREAS:
        w(row("memory_area", dict(layer_id=layer_id, area=area, prologue=prologue, epilogue=epilogue, notes=notes,
                                  evidence=MEMORY_AREAS_EVIDENCE)))
    for k, (name, offset, size, order, descr) in enumerate(PROGRAM_LAYOUT, start=1):
        w(row("program_layout_field", dict(layer_id=layer_id, position=k, name=name, offset=offset, size=size,
                                           byte_order=order, description=descr, evidence=PROGRAM_LAYOUT_EVIDENCE)))
    for kind, status, notes in LAYER_TABLES:
        w(f"INSERT INTO table_status (table_kind_id, layer_id, status, notes) "
          f"SELECT id, {layer_id}, {q(status)}, {q(notes)} FROM table_kind WHERE code = {q(kind)};")
    for m in machines:
        for kind, status, notes in MACHINE_TABLES:
            w(f"INSERT INTO table_status (table_kind_id, machine_id, status, notes) "
              f"SELECT id, {m['id']}, {q(status)}, {q(notes)} FROM table_kind WHERE code = {q(kind)};")
    w("")
    for s in SOURCES:
        w(row("source", dict(zip(("id", "title", "author", "publisher", "year", "kind", "url", "notes"), s))))
    w("")
    type_id = {}
    for tid, code, name, suffix, cls, mn, mx, nbytes, notes in DATA_TYPES:
        type_id[code] = tid
        w(row("data_type", dict(id=tid, layer_id=layer_id, code=code, name=name, suffix=suffix,
                                type_class_id=TYPE_CLASS[cls], minimum=mn, maximum=mx, bytes=nbytes, notes=notes)))
    w("")
    variable_kind_id = {}
    for vid, code, name, dtype, dims, rule, pattern, max_length, significant, examples, notes in VARIABLE_KINDS:
        variable_kind_id[code] = vid
        w(row("variable_kind", dict(id=vid, layer_id=layer_id, code=code, name=name, data_type_id=type_id[dtype],
                                    dimensions=dims, name_rule=rule, name_pattern=pattern, max_name_length=max_length,
                                    significant_chars=significant, examples=examples, notes=notes)))
    for code, fields in VARIABLE_LAYOUTS.items():
        for k, (name, offset, size, descr) in enumerate(fields, start=1):
            w(row("variable_layout_field", dict(variable_kind_id=variable_kind_id[code], position=k, name=name,
                                                offset=offset, size=size, description=descr,
                                                evidence=VARIABLE_LAYOUT_EVIDENCE)))
    w("")
    parameter_kind_id = {}
    for pid, code, name, nature, cls, vkind, notes in PARAMETER_KINDS:
        parameter_kind_id[code] = pid
        w(row("parameter_kind", dict(id=pid, layer_id=layer_id, code=code, name=name, nature=nature,
                                     type_class_id=TYPE_CLASS[cls] if cls else None,
                                     variable_kind_id=variable_kind_id[vkind] if vkind else None, notes=notes)))
    w("")
    for code, value, verified, notes in FEATURES:
        w(f"INSERT INTO feature (layer_id, feature_kind_id, value, verified, notes) "
          f"SELECT {layer_id}, id, {q(value)}, {1 if verified else 0}, {q(notes)} FROM feature_kind WHERE code = {q(code)};")
    w("")
    error_codes = {x[0] for x in ERRORS}
    for code, number, descr in ERRORS:
        w(row("error", dict(layer_id=layer_id, code=code, number=number, message=f"ERR{number}", description=descr)))
    for selector, value, code, cause, verified in ERROR_RULES:
        assert code in error_codes, code
        w(row("error_rule", dict(layer_id=layer_id, selector=selector, selector_value=value, error_code=code,
                                 cause=cause, verified=verified)))
    w("")
    keyword_id = {}
    assert set(ABBREVIATIONS) <= {k[0] for k in KEYWORDS}, set(ABBREVIATIONS) - {k[0] for k in KEYWORDS}
    assert set(TOKENS) <= {k[0] for k in KEYWORDS}, set(TOKENS) - {k[0] for k in KEYWORDS}
    for i, (text, notes) in enumerate(KEYWORDS, start=1):
        keyword_id[text] = ID + i
        w(row("keyword", dict(id=ID + i, layer_id=layer_id, text=text, notes=notes)))
        # key combinations: FX-700P keyboard, then PB-100 / PC-4 keyboard
        w(row("abbreviation", dict(keyword_id=ID + i, machine_id=MACHINE["id"], text=ABBREVIATIONS.get(text, ""))))
        for m in OTHER_MACHINES:
            w(row("abbreviation", dict(keyword_id=ID + i, machine_id=m["id"], text=PB100_ABBREVIATIONS.get(text, ""))))
        if text in TOKENS:
            w(row("token", dict(keyword_id=ID + i, hex_value=TOKENS[text],
                                notes="Character code, not a token." if text in CHARACTER_TOKENS else None)))
    w("")

    names = [(e["name"], e["cat"]) for e in ENTRIES]
    assert len(names) == len(set(names)), "duplicate entry"
    entry_names = {e["name"] for e in ENTRIES}
    assert set(ENTRY_ERRORS) <= entry_names, set(ENTRY_ERRORS) - entry_names
    assert set(EXAMPLES) <= entry_names, set(EXAMPLES) - entry_names
    counter = dict(entry=ID, form=ID, par=ID, node=ID * 10)
    entry_id = {}

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
            r["parameter_kind_id"] = parameter_kind_id[n["pkind"]]
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

    for e in ENTRIES:
        counter["entry"] += 1
        eid = counter["entry"]
        entry_id.setdefault(e["name"], eid)            # the first entry with the name (references, examples)
        w(f"-- {e['name']} ({e['cat']})")
        w(row("entry", dict(id=eid, layer_id=layer_id, name=e["name"], category_id=CATEGORY[e["cat"]],
                            description=e["descr"], notes=e["notes"])))
        w(row("entry_source", dict(entry_id=eid, source_id=SRC_MANUAL, page=e["page"])))
        entry_par_ids = {}
        for k, f in enumerate(e["forms"], start=1):
            counter["form"] += 1
            fid = counter["form"]
            ret = f["ret"]
            w(row("syntax_form", dict(
                id=fid, entry_id=eid, position=k, title=f["title"], description=f["descr"],
                original_syntax=f["orig"], source_id=SRC_MANUAL, page=f["page"] or e["page"],
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
                assert d.get("error") is None or d["error"] in error_codes, d.get("error")
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
        form_ids = {k: counter["form"] - len(e["forms"]) + k for k in range(1, len(e["forms"]) + 1)}
        # errors and examples of "=" go to the right entry: the assignment is a STATEMENT, the comparison an OPERATOR
        is_first = entry_id[e["name"]] == eid
        errors = ENTRY_ERRORS.get(e["name"], []) if is_first else []
        examples = EXAMPLES_BY_CATEGORY.get((e["name"], e["cat"]), EXAMPLES.get(e["name"], []))
        for k, x in enumerate(errors, start=1):
            assert x["code"] in error_codes, x["code"]
            targets = ([(x["form"], entry_par_ids[(x["form"], x["par"])])] if x["form"] and x["par"] else
                       [(x["form"], None)] if not x["par"] else
                       [(fk, pid) for (fk, name), pid in entry_par_ids.items() if name == x["par"]])
            assert targets, (e["name"], x)
            for fk, pid in targets:
                w(row("entry_error", dict(entry_id=eid, form_id=form_ids[fk] if fk else None, parameter_id=pid,
                                          error_code=x["code"], operation="REMOVE" if x["remove"] else "ADD",
                                          cause=x["cause"], verified=x["verified"], position=k)))
        for k, x in enumerate(examples, start=1):
            w(row("example", dict(entry_id=eid, form_id=form_ids[x["form"]] if x["form"] else None,
                                  position=k, title=x["title"], description=x["description"],
                                  code=x["code"], expected_result=x["expected"], verified=1 if x["verified"] else 0,
                                  source_id=SRC_MANUAL if x["manual"] else None,
                                  page=x["page"] if x["manual"] else None)))
        w("")

    for a, b, kind in REFERENCES:
        w(row("reference", dict(entry_id=entry_id[a], related_entry_id=entry_id[b], kind=kind)))
    for k, text in enumerate(OPEN_QUESTIONS, start=1):
        w(row("open_question", dict(layer_id=layer_id, position=k, question=text)))
    w("")
    w("COMMIT;")
    return "\n".join(out) + "\n"


if __name__ == "__main__":
    target = os.path.join(os.path.dirname(os.path.abspath(__file__)), "fx700p.sql")
    with open(target, "w", encoding="utf-8") as f:
        f.write(generate())
    print(f"written {target}")
