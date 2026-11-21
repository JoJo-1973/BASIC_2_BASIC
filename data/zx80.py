"""BASIC 2 BASIC - data source for Sinclair ZX80 BASIC (4K ROM).

Generates data/zx80.sql:   python data/zx80.py

Syntax trees are written with a few functions:
    S(...)  sequence          C(...)  choice            O(x)  optional
    R(x, sep=",", min=1)      repeat
    K("PRINT")  keyword       L(",")  literal           P("name", "NUM_EXPR")  parameter
The second argument of P is the parameter type (PARAMETER_KINDS, default
NUM_EXPR). A parameter that accepts several types is written as a choice of
P with the same name: C(P("x", "NUM_VAR"), P("x", "STR_VAR")).
Common options: att=True (attached to the previous item), meaning="...".

original_syntax holds the headings of appendix II, section 3, of the
manual (None where the manual has none).

Sources: [1] H. Davenport, "Sinclair ZX80 Operating Manual", 2nd ed., 1980
(chapters 3-14, appendices I-III); [2] G. Wearmouth, "An Assembly Listing
of the ROM of the Sinclair ZX80"; [3] Wikipedia, "ZX80 character set".
"""

import os

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
MACHINE = dict(id=1, code="ZX80", name="Sinclair ZX80", manufacturer="Science of Cambridge (Sinclair)",
               year=1980, cpu="Z80A (NEC µPD780C-1), 3.25 MHz",
               notes="1 KB of RAM as standard. The ZX81 8K ROM was available as an upgrade: it is a different dialect.")
DIALECT = dict(id=1, code="SINCLAIR_ZX80_4K", name="Sinclair ZX80 BASIC", version="4K ROM",
               author="John Grant (Nine Tiles)", year=1980,
               notes="Integer-only BASIC. Statement keywords are entered with a single key.")
LAYER = dict(id=1, code="ZX80_4K_core", name="Sinclair ZX80 BASIC (4K ROM)", kind="CORE",
             author="John Grant (Nine Tiles)", year=1980)

SOURCES = [
    (1, "Sinclair ZX80 Operating Manual - A Course in BASIC Programming", "Hugo Davenport",
     "Science of Cambridge Ltd", 1980, "MANUAL", None, "Second edition"),
    (2, "An Assembly Listing of the ROM of the Sinclair ZX80", "Geoff Wearmouth",
     None, 2002, "WEB", None, "Commented disassembly of the 4K ROM"),
    (3, "ZX80 character set", "Wikipedia", None, None, "WEB",
     "https://en.wikipedia.org/wiki/ZX80_character_set", None),
    (4, "ZX80 keyboard layout", "Grant Searle", None, None, "IMAGE", None,
     "Drawing of the original keyboard legends: data/sources/zx80_keyboard.png"),
]

DATA_TYPES = [
    # id, code, name, suffix, class, minimum, maximum, bytes, notes
    (1, "INT16", "Integer", None, "INTEGER", -32768, 32767, 2,
     "The only numeric type. Out of range: error 6."),
    (2, "STRING", "String", "$", "STRING", None, None, None,
     "Any length, including empty, limited only by memory. The character with code 1 acts as terminator."),
]

# Features: answers to the catalogue in data/base.sql (feature_kind).
# code, value, verified, notes. verified=False when the answer is not certain.
# All verified by the editor on 2026-11-21.
FEATURES = [
    ("LINE_NUMBERS", "1-9999", True, "Entering line 0 gives an error."),
    ("MULTIPLE_STATEMENTS", "No", True, None),
    ("STATEMENT_SEPARATOR", "None", True, None),
    ("LET", "Mandatory", True, "Every statement starts with a keyword."),
    ("TRUE_VALUE", "-1", True, None),
    ("FALSE_VALUE", "0", True, None),
    ("TRUTH_TEST", "NONZERO", True, "AND, OR and NOT work bit by bit: NOT 1 = -2, which is true."),
    ("INTEGER_CONVERSION", "Truncation towards zero", True, None),
    ("FOR_RUNS_ONCE", "Yes", True, None),
    ("FOR_VARIABLE_CHANGEABLE", "Yes", True, None),
    ("MODAL_KEYBOARD", "Yes", True,
     "With the K cursor a key enters the whole keyword; functions are typed letter by letter."),
    ("TAB_ZONE_WIDTH", "8 columns", True, "4 zones on the 32-column screen."),
    ("VARIABLE_TAB_STOPS", "No", True, None),
]

ERRORS = [
    # code, number, description
    ("OK", 0, "No error: command executed, end of program, BREAK pressed, or GO TO a line beyond the end of the program."),
    ("NEXT_WITHOUT_FOR", 1, "NEXT with a variable that is not the counter of an active FOR loop."),
    ("VARIABLE_NOT_FOUND", 2, "Undefined variable (also an array that has not been dimensioned)."),
    ("SUBSCRIPT_OUT_OF_RANGE", 3, "Array subscript out of range, or error while computing the subscript."),
    ("OUT_OF_MEMORY", 4, "Out of memory for a new variable, a longer string or the screen."),
    ("SCREEN_FULL", 5, "No more room on the screen (PRINT)."),
    ("OVERFLOW", 6, "Result outside the range from -32768 to 32767."),
    ("RETURN_WITHOUT_GOSUB", 7, "RETURN without a matching GO SUB."),
    ("INPUT_AS_COMMAND", 8, "INPUT can only be used in a program."),
    ("STOP", 9, "STOP statement executed; CONTINUE resumes from the next line."),
]

# Keywords: text, token (hexadecimal code or None), notes
KEYWORDS = [
    ('"', "01", "String delimiter. A typed quote is stored in the program as $01 (checked on an emulator: "
                "10 PRINT \"ABC\" is stored as 0 10 244 1 38 39 40 1 118), although the token table of the manual "
                "lists $D4. $01 is not printable; the printable quote is code 212."),
    ("THEN", "D5", None), ("TO", "D6", None),
    (";", "D7", "Symbol: code used in the program."), (",", "D8", "Symbol: code used in the program."),
    (")", "D9", "Symbol: code used in the program (on screen 17)."),
    ("(", "DA", "Symbol: code used in the program (on screen 16)."),
    ("NOT", "DB", None), ("-", "DC", "Code used in the program (on screen 18)."),
    ("+", "DD", "Code used in the program (on screen 19)."),
    ("*", "DE", "Code used in the program (on screen 20)."),
    ("/", "DF", "Code used in the program (on screen 21)."),
    ("AND", "E0", None), ("OR", "E1", None), ("**", "E2", "Multi-character operator reduced to a single code."),
    ("=", "E3", "Code used in the program (on screen 22)."),
    (">", "E4", "Appendix II of the manual swaps > and < (source [3])."),
    ("<", "E5", "Appendix II of the manual swaps > and < (source [3])."),
    ("LIST", "E6", None), ("RETURN", "E7", None), ("CLS", "E8", None), ("DIM", "E9", None),
    ("SAVE", "EA", None), ("FOR", "EB", None), ("GO TO", "EC", None), ("POKE", "ED", None),
    ("INPUT", "EE", None), ("RANDOMISE", "EF", None), ("LET", "F0", None), ("NEXT", "F3", None),
    ("PRINT", "F4", None), ("NEW", "F6", None), ("RUN", "F7", None), ("STOP", "F8", None),
    ("CONTINUE", "F9", None), ("IF", "FA", None), ("GO SUB", "FB", None), ("LOAD", "FC", None),
    ("CLEAR", "FD", None), ("REM", "FE", None),
    # Functions: no token, typed letter by letter
    ("ABS", None, "Function: typed letter by letter, it has no token."),
    ("CHR$", None, "Function: typed letter by letter, it has no token."),
    ("CODE", None, "Function: typed letter by letter, it has no token."),
    ("PEEK", None, "Function: typed letter by letter, it has no token."),
    ("RND", None, "Function: typed letter by letter, it has no token."),
    ("STR$", None, "Function: typed letter by letter, it has no token."),
    ("TL$", None, "Function: typed letter by letter, it has no token."),
    ("USR", None, "Function: typed letter by letter, it has no token."),
]


# ---------------------------------------------------------------------
# Abbreviations: the key combination that types each keyword (source [4]).
# Single key = the main symbol of the key; modified key = "SHIFT + key".
# Keywords not listed here have no abbreviation (empty string).
# The keyboard shortens some legends: RET = RETURN, CONT = CONTINUE,
# GOTO = GO TO, GOSUB = GO SUB, RAND = RANDOMISE.
# ---------------------------------------------------------------------
ABBREVIATIONS = {
    # shifted keys
    "NOT": "SHIFT + 1", "AND": "SHIFT + 2", "THEN": "SHIFT + 3", "TO": "SHIFT + 4",
    '"': "SHIFT + Y", "(": "SHIFT + I", ")": "SHIFT + O", "*": "SHIFT + P",
    "**": "SHIFT + H", "-": "SHIFT + J", "+": "SHIFT + K", "=": "SHIFT + L",
    ";": "SHIFT + X", "/": "SHIFT + V", "OR": "SHIFT + B", "<": "SHIFT + N",
    ">": "SHIFT + M", ",": "SHIFT + .",
    # single keys
    "NEW": "Q", "LOAD": "W", "SAVE": "E", "RUN": "R", "CONTINUE": "T", "REM": "Y",
    "IF": "U", "INPUT": "I", "PRINT": "O",
    "LIST": "A", "STOP": "S", "DIM": "D", "FOR": "F", "GO TO": "G", "POKE": "H",
    "RANDOMISE": "J", "LET": "K",
    "CLEAR": "X", "CLS": "C", "GO SUB": "V", "RETURN": "B", "NEXT": "N",
}


# ---------------------------------------------------------------------
# Machine character set (source: image data/sources/zx80_charset.png)
# 8x8 bitmaps: 8 bytes in hexadecimal, one row per byte, bit 7 = leftmost pixel.
# The first 64 glyphs are codes 0-63, the other 64 are codes 128-191 (inverse).
# ---------------------------------------------------------------------
CHARSET = dict(id=1, code="ZX80_ROM", name="ROM character set", width=8, height=8,
               description="64 characters and their inverses; non-printable codes appear as '?' and tokens as their keyword.")

ZX80_GLYPHS = [
    "0000000000000000", "0014140000000000", "F0F0F0F0F0F0F0F0", "00000000FFFFFFFF", "F0F0F0F000000000", "0F0F0F0F00000000", "00000000F0F0F0F0", "000000000F0F0F0F",
    "0F0F0F0FF0F0F0F0", "AA55AA55AA55AA55", "00000000AA55AA55", "AA55AA5500000000", "001E217820207F00", "00083E483E093E08", "0000000800000800", "003E410608000800",
    "0004080808080400", "0010080808081000", "000000003E000000", "000008083E080800", "00002A1C081C2A00", "0000020408102000", "0000003E003E0000", "0000100804081000",
    "0000040810080400", "0000080000080810", "0000000000080810", "00000000000C0C00", "001C224141221C00", "000C140404041E00", "003E41013E407F00", "003E410601413E00",
    "000C1424447F0400", "007F407E01413E00", "003E407E41413E00", "007F010204080800", "003E413E41413E00", "003E41413F013E00", "003E41417F414100", "007E417E41417E00",
    "001E214040211E00", "007C424141427C00", "007F407C40407F00", "007F407C40404000", "001E214047211E00", "0041417F41414100", "003E080808083E00", "0002020242221C00",
    "0042447844424100", "0040404040407F00", "0041635549414100", "0061514945434100", "003E414141413E00", "007E41417E404000", "003E414149453E00", "007E41417E444200",
    "003E403E01413E00", "007F080808080800", "0041414141413E00", "0041414122140800", "0041414149552200", "0021120C0C122100", "0041221C08080800", "007F020408107F00",
    "FFFFFFFFFFFFFFFF", "FFEBEBFFFFFFFFFF", "0F0F0F0F0F0F0F0F", "FFFFFFFF00000000", "0F0F0F0FFFFFFFFF", "F0F0F0F0FFFFFFFF", "FFFFFFFF0F0F0F0F", "FFFFFFFFF0F0F0F0",
    "F0F0F0F00F0F0F0F", "55AA55AA55AA55AA", "FFFFFFFF55AA55AA", "55AA55AAFFFFFFFF", "FFE1DE87DFDF80FF", "FFF7C1B7C1F6C1F7", "FFFFFFF7FFFFF7FF", "FFC1BEF9F7FFF7FF",
    "FFFBF7F7F7F7FBFF", "FFEFF7F7F7F7EFFF", "FFFFFFFFC1FFFFFF", "FFFFF7F7C1F7F7FF", "FFFFD5E3F7E3D5FF", "FFFFFDFBF7EFDFFF", "FFFFFFC1FFC1FFFF", "FFFFEFF7FBF7EFFF",
    "FFFFFBF7EFF7FBFF", "FFFFF7FFFFF7F7EF", "FFFFFFFFFFF7F7EF", "FFFFFFFFFFF3F3FF", "FFE3DDBEBEDDE3FF", "FFF3EBFBFBFBE1FF", "FFC1BEFEC1BF80FF", "FFC1BEF9FEBEC1FF",
    "FFF3EBDBBB80FBFF", "FF80BF81FEBEC1FF", "FFC1BF81BEBEC1FF", "FF80FEFDFBF7F7FF", "FFC1BEC1BEBEC1FF", "FFC1BEBEC0FEC1FF", "FFC1BEBE80BEBEFF", "FF81BE81BEBE81FF",
    "FFE1DEBFBFDEE1FF", "FF83BDBEBEBD83FF", "FF80BF83BFBF80FF", "FF80BF83BFBFBFFF", "FFE1DEBFB8DEE1FF", "FFBEBE80BEBEBEFF", "FFC1F7F7F7F7C1FF", "FFFDFDFDBDDDE3FF",
    "FFBDBB87BBBDBEFF", "FFBFBFBFBFBF80FF", "FFBE9CAAB6BEBEFF", "FF9EAEB6BABCBEFF", "FFC1BEBEBEBEC1FF", "FF81BEBE81BFBFFF", "FFC1BEBEB6BAC1FF", "FF81BEBE81BBBDFF",
    "FFC1BFC1FEBEC1FF", "FF80F7F7F7F7F7FF", "FFBEBEBEBEBEC1FF", "FFBEBEBEDDEBF7FF", "FFBEBEBEB6AADDFF", "FFDEEDF3F3EDDEFF", "FFBEDDE3F7F7F7FF", "FF80FDFBF7EF80FF",
]

ZX80_UNICODE = {
    0: " ", 1: '"', 2: "▌", 3: "▄", 4: "▘", 5: "▝", 6: "▖", 7: "▗",
    8: "▞", 9: "▒", 10: "\U0001FB8F", 11: "\U0001FB8E", 12: "£", 13: "$", 14: ":", 15: "?",
    16: "(", 17: ")", 18: "-", 19: "+", 20: "*", 21: "/", 22: "=", 23: ">", 24: "<", 25: ";", 26: ",", 27: ".",
    128: "█", 130: "▐", 131: "▀", 132: "▟", 133: "▙", 134: "▜", 135: "▛",
    136: "▚", 137: "\U0001FB90", 138: "\U0001FB91", 139: "\U0001FB92",
}
ZX80_UNICODE.update({28 + i: str(i) for i in range(10)})
ZX80_UNICODE.update({38 + i: chr(65 + i) for i in range(26)})

# Official Unicode names of the code points above (Unicode Character Database).
# Written out here so that the result does not depend on the Unicode version of Python.
UNICODE_NAMES = {
    ' ': "SPACE",
    '"': "QUOTATION MARK",
    '$': "DOLLAR SIGN",
    '(': "LEFT PARENTHESIS",
    ')': "RIGHT PARENTHESIS",
    '*': "ASTERISK",
    '+': "PLUS SIGN",
    ',': "COMMA",
    '-': "HYPHEN-MINUS",
    '.': "FULL STOP",
    '/': "SOLIDUS",
    '0': "DIGIT ZERO",
    '1': "DIGIT ONE",
    '2': "DIGIT TWO",
    '3': "DIGIT THREE",
    '4': "DIGIT FOUR",
    '5': "DIGIT FIVE",
    '6': "DIGIT SIX",
    '7': "DIGIT SEVEN",
    '8': "DIGIT EIGHT",
    '9': "DIGIT NINE",
    ':': "COLON",
    ';': "SEMICOLON",
    '<': "LESS-THAN SIGN",
    '=': "EQUALS SIGN",
    '>': "GREATER-THAN SIGN",
    '?': "QUESTION MARK",
    'A': "LATIN CAPITAL LETTER A",
    'B': "LATIN CAPITAL LETTER B",
    'C': "LATIN CAPITAL LETTER C",
    'D': "LATIN CAPITAL LETTER D",
    'E': "LATIN CAPITAL LETTER E",
    'F': "LATIN CAPITAL LETTER F",
    'G': "LATIN CAPITAL LETTER G",
    'H': "LATIN CAPITAL LETTER H",
    'I': "LATIN CAPITAL LETTER I",
    'J': "LATIN CAPITAL LETTER J",
    'K': "LATIN CAPITAL LETTER K",
    'L': "LATIN CAPITAL LETTER L",
    'M': "LATIN CAPITAL LETTER M",
    'N': "LATIN CAPITAL LETTER N",
    'O': "LATIN CAPITAL LETTER O",
    'P': "LATIN CAPITAL LETTER P",
    'Q': "LATIN CAPITAL LETTER Q",
    'R': "LATIN CAPITAL LETTER R",
    'S': "LATIN CAPITAL LETTER S",
    'T': "LATIN CAPITAL LETTER T",
    'U': "LATIN CAPITAL LETTER U",
    'V': "LATIN CAPITAL LETTER V",
    'W': "LATIN CAPITAL LETTER W",
    'X': "LATIN CAPITAL LETTER X",
    'Y': "LATIN CAPITAL LETTER Y",
    'Z': "LATIN CAPITAL LETTER Z",
    '£': "POUND SIGN",
    '▀': "UPPER HALF BLOCK",
    '▄': "LOWER HALF BLOCK",
    '█': "FULL BLOCK",
    '▌': "LEFT HALF BLOCK",
    '▐': "RIGHT HALF BLOCK",
    '▒': "MEDIUM SHADE",
    '▖': "QUADRANT LOWER LEFT",
    '▗': "QUADRANT LOWER RIGHT",
    '▘': "QUADRANT UPPER LEFT",
    '▙': "QUADRANT UPPER LEFT AND LOWER LEFT AND LOWER RIGHT",
    '▚': "QUADRANT UPPER LEFT AND LOWER RIGHT",
    '▛': "QUADRANT UPPER LEFT AND UPPER RIGHT AND LOWER LEFT",
    '▜': "QUADRANT UPPER LEFT AND UPPER RIGHT AND LOWER RIGHT",
    '▝': "QUADRANT UPPER RIGHT",
    '▞': "QUADRANT UPPER RIGHT AND LOWER LEFT",
    '▟': "QUADRANT UPPER RIGHT AND LOWER LEFT AND LOWER RIGHT",
    "\U0001FB8E": "UPPER HALF MEDIUM SHADE",
    "\U0001FB8F": "LOWER HALF MEDIUM SHADE",
    "\U0001FB90": "INVERSE MEDIUM SHADE",
    "\U0001FB91": "UPPER HALF BLOCK AND LOWER HALF INVERSE MEDIUM SHADE",
    "\U0001FB92": "UPPER HALF INVERSE MEDIUM SHADE AND LOWER HALF BLOCK",
}

ZX80_NAMES = {0: "space", 1: "quote", 128: "inverse space"}
ZX80_NAMES.update({i: "graphic" for i in range(2, 12)})
ZX80_NAMES.update({128 + i: "inverse graphic" for i in range(2, 12)})

PRINTED_AS_QUESTION_MARK = set(range(64, 128)) | set(range(192, 212)) | {241, 242, 245, 255}


GLYPH_CODES = list(range(64)) + list(range(128, 192))     # glyph number = screen code


def zx80_glyphs():
    """Rows of the glyph table: 128 glyphs, numbered like the screen codes."""
    for i, code in enumerate(GLYPH_CODES):
        yield dict(charset_id=CHARSET["id"], code=code, bitmap=ZX80_GLYPHS[i],
                   inverse_of=code - 128 if code >= 128 else None,
                   unicode=ZX80_UNICODE.get(code),
                   unicode_name=UNICODE_NAMES[ZX80_UNICODE[code]] if code in ZX80_UNICODE else None,
                   name=ZX80_NAMES.get(code))


def zx80_screen_codes():
    """Rows of the screen_code table: each screen code shows the glyph with the same number."""
    for code in GLYPH_CODES:
        yield dict(machine_id=MACHINE["id"], code=code, glyph_code=code,
                   notes="Inverse video" if code >= 128 else None)


def zx80_character_codes():
    """Rows of the character_code table for the 256 codes."""
    for code in range(256):
        r = dict(layer_id=LAYER["id"], code=code)
        if code == 0x01:
            # glyph 1 is the quote, but code 1 does not print it: it ends the strings
            r.update(kind="CONTROL", name="String terminator", action="Ends a string",
                     notes="Not printable (PRINT CHR$(1) prints nothing). It ends the strings in the variables area "
                           "and is the byte with which typed quotes are stored in the program. "
                           "The printable quote is code 212.")
        elif code == 212:
            r.update(kind="PRINTABLE", screen_code=1,
                     notes="Printable quote: cannot be typed from the keyboard, but can be put in string variables.")
        elif code < 64 or 128 <= code < 192:
            r.update(kind="PRINTABLE", screen_code=code)
        elif code == 0x76:
            r.update(kind="CONTROL", name="NEWLINE", action="Ends a program line")
        elif code in PRINTED_AS_QUESTION_MARK:
            r.update(kind="UNUSED", screen_code=15, notes="Printed as '?'")
        else:
            r.update(kind="TOKEN")
        yield r


# Program and variables in memory (source: the editor, 2026-11-21).
# memory areas: area, prologue, epilogue ('' = nothing)
MEMORY_AREAS = [
    ("PROGRAM", "", "$00, $00", None),
    ("VARIABLES", "", "$80", None),
]
# program line: name, offset, size, byte order, description (None = variable)
PROGRAM_LAYOUT = [
    ("Line number", 0, 2, "BIG", None),
    ("Line text", 2, None, None, "Tokenized text of the line."),
    ("NEWLINE", None, 1, None, "$76."),
]
# variables: variable type code -> layouts: (layout name, [(name, offset, size, byte order, description)])
VARIABLE_LAYOUTS = {
    "NUMERIC": [
        ("Name of one character", [
            ("Name", 0, 1, None, "Character code of the letter OR $60."),
            ("Value", 1, 2, "LITTLE", None),
        ]),
        ("Name of more than one character", [
            ("First letter", 0, 1, None, "Character code of the first letter AND $1F OR $40."),
            ("Following letters", 1, None, None, "Character codes of the letters from the second to the last but one."),
            ("Last letter", None, 1, None, "Character code of the last letter AND $1F OR $80."),
            ("Value", None, 2, "LITTLE", None),
        ]),
    ],
    "STRING": [
        (None, [
            ("Name", 0, 1, None, "Character code of the letter AND $1F OR $80."),
            ("Characters", 1, None, None, "Character codes of the string, from the first to the last."),
            ("Terminator", None, 1, None, "$01."),
        ]),
    ],
    "NUMERIC_ARRAY": [
        (None, [
            ("Name", 0, 1, None, "Character code of the letter AND $1F OR $90."),
            ("Size", 1, 1, None, "Size of the array, n."),
            ("Elements", 2, None, "LITTLE", "Elements from 0 to n, 2 bytes each: element k at offset 2*(k+1)."),
        ]),
    ],
    "LOOP_CONTROL": [
        (None, [
            ("Name", 0, 1, None, "Character code of the letter AND $1F OR $E0."),
            ("Value", 1, 2, "LITTLE", None),
            ("Upper limit", 3, 2, "LITTLE", "End value of the FOR loop."),
            ("FOR line", 5, 2, "BIG", "Number of the line where the FOR loop is defined, plus 1."),
        ]),
    ],
}


# State of the tables that always exist: (table kind, status, notes)
LAYER_TABLES = [
    ("CHARACTER_CODES", "COMPLETE", None),
    ("KEYBOARD_CODES", "NOT_APPLICABLE", "The ZX80 BASIC has no keyboard codes."),
    ("ERRORS", "COMPLETE", "Reports are shown as n/m: n = error code (0 = no error), m = line number."),
    ("OPERATOR_PRECEDENCE", "COMPLETE", None),
    ("VARIABLE_LAYOUT", "COMPLETE", None),
    ("PROGRAM_LAYOUT", "COMPLETE", None),
    ("MUSICAL_NOTES", "NOT_APPLICABLE", "The ZX80 has no sound."),
]
MACHINE_TABLES = [
    ("GLYPHS", "COMPLETE", None),
    ("SCREEN_CODES", "COMPLETE", None),
    ("COLORS", "NOT_APPLICABLE", "Black and white display."),
]


# ---------------------------------------------------------------------
# Variable types: code, name, data type, dimensions, naming rule, name
# pattern, examples, notes. The memory layout is not entered yet.
# ---------------------------------------------------------------------
VARIABLE_KINDS = [
    (1, "NUMERIC", "Numeric variable", "INT16", 0, "letter followed by letters or digits",
     r"^[A-Z][A-Z0-9]*$", 0, 0, "A, AB3", "No length limit."),
    (2, "STRING", "String variable", "STRING", 0, "one letter followed by $",
     r"^[A-Z]\$$", 1, 0, "A$, Z$", "At most 26 string variables."),
    (3, "NUMERIC_ARRAY", "Numeric array", "INT16", 1,
     "one letter; an element is written with one integer subscript in parentheses",
     r"^[A-Z]$", 1, 0, "B(5), F(12)",
     "One dimension, subscripts start from 0. An array can have the same name as a variable "
     "(not recommended). The manual describes integer arrays only."),
    (4, "LOOP_CONTROL", "Loop control variable", "INT16", 0, "one letter",
     r"^[A-Z]$", 1, 0, "I", None),
]

# Parameter types: code, name, nature, type class (LITERAL/EXPRESSION),
# variable kind (VARIABLE/ARRAY_*), notes
PARAMETER_KINDS = [
    (1, "NUM_LITERAL", "Numeric literal", "LITERAL", "NUMERIC", None, None),
    (2, "STR_LITERAL", "String literal", "LITERAL", "STRING", None, "Enclosed in quotes."),
    (3, "NUM_EXPR", "Numeric expression", "EXPRESSION", "NUMERIC", None, None),
    (4, "STR_EXPR", "String expression", "EXPRESSION", "STRING", None, None),
    (5, "NUM_VAR", "Numeric variable name", "VARIABLE", None, "NUMERIC", None),
    (6, "STR_VAR", "String variable name", "VARIABLE", None, "STRING", None),
    (7, "ARRAY_NAME", "Numeric array name", "ARRAY_NAME", None, "NUMERIC_ARRAY", None),
    (8, "ARRAY_ELEMENT", "Numeric array element", "ARRAY_ELEMENT", None, "NUMERIC_ARRAY", "E.g. B(3)."),
    (9, "LOOP_VAR", "Loop control variable name", "VARIABLE", None, "LOOP_CONTROL", None),
    (10, "FREE_TEXT", "Free text", "FREE_TEXT", None, None, None),
    (11, "STATEMENT", "Statement", "STATEMENT", None, None, None),
    (12, "CONDITION", "Condition", "CONDITION", "NUMERIC", None,
     "Usually a relational expression, whose terms can also be strings (A$=\"Y\"); its numeric value is read with the truth test: 0 = false, otherwise true."),
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


def function(name, arg, kind="NUM_EXPR"):
    """NAME(arg): ZX80 functions need parentheses."""
    return S(K(name), K("(", att=True), P(arg, kind, att=True), K(")", att=True))


def binary(op, kind="NUM_EXPR"):
    return S(P("a", kind), K(op), P("b", kind))


# At equal precedence the ZX80 evaluates from left to right: A>B>C means (A>B)>C.
LEFT = "LEFT"


# Parameters: name -> dict(descr, conversion, error, limit=(min, max[, note]), missing_line)
# Forms: dict(title, orig, tree, par, actions=[(code, coverage, note)], ret=(type, min, max))
def E(name, cat, descr, forms, examples=(), notes=None):
    return dict(name=name, cat=cat, descr=descr, forms=forms, examples=list(examples), notes=notes)


# prec = operator precedence; op = operator class (OPERATOR_CLASS); assoc = associativity
def F(tree, par=None, actions=(), orig=None, title=None, ret=None, descr=None, prec=None, op=None, assoc=None):
    return dict(tree=tree, par=par or {}, actions=list(actions), orig=orig, title=title, ret=ret, descr=descr,
                prec=prec, op=op, assoc=assoc)


# A line number that does not exist: the next existing line is used.
LINE_NO = dict(descr="Line number (also an expression). Beyond the end of the program execution stops with 0/n.",
               missing_line="NEXT_LINE")

ENTRIES = [
    # ------------------------------------------------------------ commands
    E("LIST", "COMMAND", "Lists the program from a given line, which becomes the current line.", [
        F(S(K("LIST"), O(P("n"))),
          {"n": dict(descr="Line to start from; without an argument it is 0. An error while computing n is not reported.",
                     missing_line="NEXT_LINE")},
          [("PROG_LIST", "FULL", None)], orig="LIST n")]),
    E("RUN", "COMMAND", "Runs the program: same as CLEAR followed by GO TO n.", [
        F(S(K("RUN"), O(P("n"))),
          {"n": dict(descr="Starting line; without an argument it is 1.", missing_line="NEXT_LINE")},
          [("PROG_RUN", "FULL", "Also clears the variables")], orig="RUN n")]),
    E("NEW", "COMMAND", "Returns the computer to its power-on state: erases program and variables.", [
        F(S(K("NEW")), actions=[("PROG_NEW", "FULL", None)], orig="NEW")]),
    E("CONTINUE", "COMMAND", "Resumes execution from the line of the last n/m report; after STOP (9/m) from line m+1.", [
        F(S(K("CONTINUE")), actions=[("FLOW_CONTINUE", "FULL", None)], orig="CONTINUE")]),
    E("SAVE", "COMMAND", "Saves system variables, program and variables to tape, preceded by 5 seconds of silence.", [
        F(S(K("SAVE")), actions=[("TAPE_SAVE", "FULL", "No file name: it also saves the variables")], orig="SAVE")],
      notes="Meant as a command, not as a program statement."),
    E("LOAD", "COMMAND", "Loads from tape system variables, program and variables saved with SAVE.", [
        F(S(K("LOAD")), actions=[("TAPE_LOAD", "FULL", "No file name: it loads the first program found")], orig="LOAD")],
      notes="BREAK during the leader keeps the program in memory; BREAK after the data has started is the same as NEW."),
    # ---------------------------------------------------------- statements
    E("LET", "STATEMENT", "Assigns a value to a variable.", [
        F(S(K("LET"),
            C(S(C(P("variable", "NUM_VAR"), P("variable", "ARRAY_ELEMENT")), K("="), P("expression", "NUM_EXPR")),
              S(P("variable", "STR_VAR"), K("="), P("expression", "STR_EXPR")))),
          {"variable": dict(descr="Numeric variable, string variable or array element."),
           "expression": dict(descr="Of the same type as the variable.")},
          [("VAR_LET", "FULL", None)], orig=None)],
      notes="An empty string is made only of the name byte and the terminator $01."),
    E("PRINT", "STATEMENT", "Writes on the upper part of the screen.", [
        F(S(K("PRINT"), O(C(P("item", "NUM_EXPR"), P("item", "STR_EXPR"))),
            R(S(C(K(";"), K(",")), O(C(P("item", "NUM_EXPR"), P("item", "STR_EXPR")), att=True)), min=0, att=True)),
          {"item": dict(descr="Numeric or string expression. Strings appear without quotes, numbers as with STR$.")},
          [("IO_PRINT", "FULL", None)], orig="PRINT list",
          descr="';' joins the items; ',' moves to the next zone (columns 9, 17, 25). A trailing separator suppresses the new line.")]),
    E("INPUT", "STATEMENT", "Reads a value from the keyboard and assigns it to a variable.", [
        F(S(K("INPUT"), C(P("destination", "NUM_VAR"), P("destination", "STR_VAR"), P("destination", "ARRAY_ELEMENT"))),
          {"destination": dict(descr="Numeric variable, string variable or array element. An expression can be typed.")},
          [("IO_INPUT", "PARTIAL", "One variable only, no prompt")], orig="INPUT dest")],
      notes="Only inside a program: as a command it gives error 8. For a string the quotes appear, and they can be deleted."),
    E("IF", "STATEMENT", "Executes the statement after THEN if the condition is not zero.", [
        F(S(K("IF"), P("condition", "CONDITION"), K("THEN"), P("statement", "STATEMENT")),
          {"condition": dict(descr="False if 0, true otherwise. Comparisons give -1 or 0."),
           "statement": dict(descr="Any statement, with its keyword.")},
          [("FLOW_IF", "FULL", "No ELSE")], orig="IF n THEN statement")]),
    E("GO TO", "STATEMENT", "Jumps to the given line.", [
        F(S(K("GO TO"), P("n")), {"n": LINE_NO}, [("FLOW_GOTO", "FULL", "Accepts an expression")], orig="GO TO n")]),
    E("GO SUB", "STATEMENT", "Calls the subroutine that starts at the given line; RETURN goes back to the next line.", [
        F(S(K("GO SUB"), P("n")), {"n": LINE_NO}, [("FLOW_GOSUB", "FULL", "Accepts an expression")], orig="GO SUB n")],
      notes="Subroutines can call themselves."),
    E("RETURN", "STATEMENT", "Goes back to the line after the last GO SUB executed.", [
        F(S(K("RETURN")), actions=[("FLOW_RETURN", "FULL", None)], orig="RETURN")],
      notes="Without a matching GO SUB: error 7."),
    E("FOR...TO", "STATEMENT", "Starts a loop: the counter goes from the start value to the end value in steps of 1.", [
        F(S(K("FOR"), P("a", "LOOP_VAR"), K("="), P("start"), K("TO"), P("end")),
          {"a": dict(descr="Control variable: a single letter."),
           "start": dict(descr="Start value."),
           "end": dict(descr="End value.")},
          [("FLOW_FOR", "PARTIAL", "Step fixed at 1: there is no STEP")], orig="FOR a = n TO n")],
      notes="At the end of the loop the counter is end+1. NEXT is matched dynamically. "
            "Since the line to return to is not kept on a stack, FOR loops that are not nested can be written "
            "without causing errors."),
    E("NEXT", "STATEMENT", "Increments the counter and goes back to the statement after FOR if it has not passed the end value.", [
        F(S(K("NEXT"), P("a", "LOOP_VAR")),
          {"a": dict(descr="Control variable of the loop.", error="NEXT_WITHOUT_FOR")},
          [("FLOW_NEXT", "FULL", None)], orig="NEXT a")],
      notes="Since the line to return to of a FOR loop is not kept on a stack, FOR loops that are not nested "
            "can be written without causing errors."),
    E("STOP", "STATEMENT", "Stops the program with code 9; CONTINUE resumes from the next line.", [
        F(S(K("STOP")), actions=[("FLOW_STOP", "FULL", None)], orig="STOP")]),
    E("DIM", "STATEMENT", "Creates an array with subscripts from 0 to n.", [
        F(S(K("DIM"), P("a", "ARRAY_NAME"), K("(", att=True), P("n", att=True), K(")", att=True)),
          {"a": dict(descr="Array name: a single letter."),
           "n": dict(descr="Highest subscript: the array has n+1 elements.")},
          [("VAR_DIM", "PARTIAL", "One dimension only, integers only")], orig="DIM a(n)")],
      notes="If the array already exists, the new space is reserved but the old array is still used."),
    E("CLEAR", "STATEMENT", "Clears all variables.", [
        F(S(K("CLEAR")), actions=[("VAR_CLEAR", "FULL", None)], orig="CLEAR")]),
    E("CLS", "STATEMENT", "Clears the upper part of the screen.", [
        F(S(K("CLS")), actions=[("SCREEN_CLS", "FULL", None)], orig="CLS")]),
    E("POKE", "STATEMENT", "Writes a byte to memory.", [
        F(S(K("POKE"), P("address"), K(",", att=True), P("value", att=True)),
          {"address": dict(descr="Memory address."),
           "value": dict(descr="Value written modulo 256.")},
          [("MEM_POKE", "FULL", None)], orig="POKE n,v")]),
    E("RANDOMISE", "STATEMENT", "Seeds the random number generator.", [
        F(S(K("RANDOMISE"), O(P("n"))),
          {"n": dict(descr="Seed. Without an argument, or with 0, the video frame counter is used.")},
          [("RND_SEED", "FULL", None)], orig="RANDOMISE n")],
      notes="Sets the seed n of the pseudo-random generator used by RND (the algorithm is in the notes of RND). "
            "A negative seed is read as an unsigned 16-bit number: RANDOMISE -5 is the same as a seed of 65531."),
    E("REM", "STATEMENT", "Comment: it has no effect.", [
        F(S(K("REM"), O(P("text", "FREE_TEXT"))), {"text": dict(descr="Any text.")},
          [("PROG_REM", "FULL", None)], orig="REM")]),
    # ----------------------------------------------------------- functions
    E("ABS", "FUNCTION", "Absolute value.", [
        F(function("ABS", "n"), {}, [("MATH_ABS", "FULL", None)],
          orig="ABS(n)", ret=("INT16", 0, 32767))]),
    E("CHR$", "FUNCTION", "Character with the given code.", [
        F(function("CHR$", "n"), {"n": dict(descr="Character code. CHR$(1) gives the empty string; CHR$(212) gives the quote.", limit=(0, 255))},
          [("STR_CHR", "FULL", "The ZX80's own character set, not ASCII")], orig="CHR$(n)", ret=("STRING", None, None))]),
    E("CODE", "FUNCTION", "Code of the first character of a string.", [
        F(function("CODE", "s", "STR_EXPR"), {},
          [("STR_CODE", "FULL", "The ZX80's own character set, not ASCII")], orig="CODE(s)", ret=("INT16", 0, 255))]),
    E("PEEK", "FUNCTION", "Byte stored at the given address.", [
        F(function("PEEK", "n"), {"n": dict(descr="Memory address.")},
          [("MEM_PEEK", "FULL", None)], orig="PEEK(n)", ret=("INT16", 0, 255))]),
    E("RND", "FUNCTION", "Random integer.", [
        F(function("RND", "n"), {"n": dict(descr="With n>0 the result goes from 1 to n; with n<0 it goes from 1 to 32767 or from -32768 to n "
                           "(see the algorithm in the notes); with n=0 it is 1.")},
          [("RND_VALUE", "FULL", "Integer from 1 to n")], orig="RND(n)", ret=("INT16", None, None))],
      notes="Algorithm (checked on an emulator against the sequences of `RANDOMISE 5` with `RND(100)` and "
            "`RND(-10)`, and of `RANDOMISE -5`):\n"
            "\n"
            "1. Let n be the seed of the pseudo-random generator (a negative seed is read as an unsigned "
            "16-bit number: -5 becomes 65531).\n"
            "2. If n = 0, let n = 65536.\n"
            "3. Let `m = (n*77) MOD 65537`.\n"
            "4. If m = 65536, let m = 0.\n"
            "5. `RND(x)` gives `u*m/65536 + 1` (integer division), where u is x read as an unsigned 16-bit "
            "number (`x AND 65535`: -10 becomes 65526); the result is read as a signed 16-bit integer.\n"
            "6. Let n = m and go back to step 2."),
    E("STR$", "FUNCTION", "Number converted to a decimal string (1 to 6 characters, including any minus sign).", [
        F(function("STR$", "n"), {},
          [("STR_FROM_NUM", "FULL", None)], orig="STR$(n)", ret=("STRING", None, None))]),
    E("TL$", "FUNCTION", "The string without its first character.", [
        F(function("TL$", "s", "STR_EXPR"), {},
          [("STR_SUBSTRING", "PARTIAL", "Only removes the first character")], orig="TL$(s)", ret=("STRING", None, None))]),
    E("USR", "FUNCTION", "Calls a machine code routine and returns its value.", [
        F(function("USR", "n"), {"n": dict(descr="Address of the routine.")},
          [("MEM_CALL", "FULL", "Returns HL, or n if HL does not change")], orig="USR(n)", ret=("INT16", None, None))]),
    # ----------------------------------------------------------- operators
    E("**", "OPERATOR", "Raise to a power.", [
        F(binary("**"), {}, [("OP_POWER", "FULL", None)], orig=None, assoc=LEFT, prec=10, op="ARITHMETIC", ret=("INT16", None, None))]),
    E("-", "OPERATOR", "Change of sign and subtraction.", [
        F(S(K("-"), P("a", att=True)), {},
          [("OP_NEG", "FULL", None)], orig=None, prec=9, op="ARITHMETIC", title="Change of sign", ret=("INT16", None, None)),
        F(binary("-"), {},
          [("OP_SUB", "FULL", None)], orig=None, assoc=LEFT, prec=6, op="ARITHMETIC", title="Subtraction", ret=("INT16", None, None))]),
    E("*", "OPERATOR", "Multiplication.", [
        F(binary("*"), {}, [("OP_MUL", "FULL", None)], orig=None, assoc=LEFT, prec=8, op="ARITHMETIC", ret=("INT16", None, None))]),
    E("/", "OPERATOR", "Integer division, truncated towards zero.", [
        F(binary("/"), {}, [("OP_DIV", "PARTIAL", "Integer division only")], orig=None, assoc=LEFT, prec=7, op="ARITHMETIC", ret=("INT16", None, None))]),
    E("+", "OPERATOR", "Addition.", [
        F(binary("+"), {}, [("OP_ADD", "FULL", None)], orig=None, assoc=LEFT, prec=6, op="ARITHMETIC", ret=("INT16", None, None))]),
]

for _op, _action, _name in (("=", "OP_EQ", "Equal"), (">", "OP_GT", "Greater than"), ("<", "OP_LT", "Less than")):
    ENTRIES.append(E(_op, "OPERATOR", f"{_name}: -1 if true, 0 if false.", [
        F(binary(_op), {}, [(_action, "FULL", None)], orig=None, assoc=LEFT, prec=5, op="RELATIONAL",
          title="Between numbers", ret=("INT16", -1, 0)),
        F(S(P("s1", "STR_EXPR"), K(_op), P("s2", "STR_EXPR")), {},
          [(_action, "FULL", None)], orig=f"s{_op}s", assoc=LEFT, prec=5, op="RELATIONAL", title="Between strings", ret=("INT16", -1, 0))]))

BITWISE_NOTE = ("With truth values (comparisons give -1 if true, 0 if false) it also behaves as a conditional "
                "operator: this is a side effect of working bit by bit on signed 16-bit integers, the only numeric type.")

# Truth tables of one bit, in Markdown (each of the 16 bits is computed this way)
NOT_TABLE = ("Each bit of the result:\n\n"
             "| a | `NOT a` |\n|---|---|\n| 0 | 1 |\n| 1 | 0 |\n\n")
AND_TABLE = ("Each bit of the result:\n\n"
             "| a | b | `a AND b` |\n|---|---|---|\n| 0 | 0 | 0 |\n| 0 | 1 | 0 |\n| 1 | 0 | 0 |\n| 1 | 1 | 1 |\n\n")
OR_TABLE = ("Each bit of the result:\n\n"
            "| a | b | `a OR b` |\n|---|---|---|\n| 0 | 0 | 0 |\n| 0 | 1 | 1 |\n| 1 | 0 | 1 |\n| 1 | 1 | 1 |\n\n")

ENTRIES += [
    E("NOT", "OPERATOR", "Bitwise negation: NOT n is -n-1.", [
        F(S(K("NOT"), P("a")), {}, [("OP_NOT", "FULL", "Bitwise")], orig=None, prec=4, op="BITWISE", ret=("INT16", None, None))], notes=NOT_TABLE + BITWISE_NOTE),
    E("AND", "OPERATOR", "Bitwise conjunction.", [
        F(binary("AND"), {}, [("OP_AND", "FULL", "Bitwise")], orig=None, assoc=LEFT, prec=3, op="BITWISE", ret=("INT16", None, None))], notes=AND_TABLE + BITWISE_NOTE),
    E("OR", "OPERATOR", "Bitwise disjunction.", [
        F(binary("OR"), {}, [("OP_OR", "FULL", "Bitwise")], orig=None, assoc=LEFT, prec=2, op="BITWISE", ret=("INT16", None, None))], notes=OR_TABLE + BITWISE_NOTE),
    E("( )", "OPERATOR", "Parentheses: the expression inside is evaluated before what surrounds it.", [
        F(S(L("("), C(P("e", "NUM_EXPR", att=True), P("e", "STR_EXPR", att=True), att=True), L(")", att=True)),
          {"e": dict(descr="Numeric or string expression.")},
          [], orig=None, op="GROUPING")]),
]

# ---------------------------------------------------------------------
# Usage examples. All of them are TO BE VERIFIED (verified = 0) until they
# are tried on a ZX80 or an emulator: then the editor adds verified=True.
# manual=True: taken from the manual.
# form = position of the form the example shows (None = the entry in general).
# ---------------------------------------------------------------------
def X(title, code, expected=None, description=None, form=None, manual=False, verified=False):
    return dict(title=title, code=code, expected=expected, description=description, form=form, manual=manual,
                verified=verified)


EXAMPLES = {
    # ------------------------------------------------------------ commands
    "LIST": [
        X("List from a line", "LIST 100", "The program from line 100 onwards.",
          "Line 100 becomes the current line. If it does not exist, the listing starts from the next line.", verified=True),
    ],
    "RUN": [
        X("Run the program", "RUN", None, "Clears the variables and runs the program from the first line.", verified=True),
        X("Run from a line", "RUN 100", None, "Clears the variables and runs the program from line 100.", verified=True),
    ],
    "NEW": [
        X("Erase everything", "NEW", "An empty screen.", "Program and variables are erased, as at power-on.", verified=True),
    ],
    "CONTINUE": [
        X("Resume after STOP", '10 STOP\n20 PRINT "AGAIN"\nRUN\nCONTINUE', "9/10\nAGAIN",
          "RUN stops at line 10 with report 9/10; CONTINUE resumes from line 20.", verified=True),
    ],
    "SAVE": [
        X("Save to tape", "SAVE", None,
          "Start the tape recorder in record before pressing NEWLINE: system variables, program and variables are saved.", verified=True),
    ],
    "LOAD": [
        X("Load from tape", "LOAD", None,
          "Start the tape recorder in play: the first program found is loaded with its variables.", verified=True),
    ],
    # ---------------------------------------------------------- statements
    "LET": [
        X("Numeric variable", "10 LET A=5\n20 PRINT A*2", "10", form=1, verified=True),
        X("String variable", '10 LET N$="ZX80"\n20 PRINT N$', "ZX80", form=1, verified=True),
        X("Array element", "10 DIM B(3)\n20 LET B(2)=7\n30 PRINT B(2)", "7", form=1, verified=True),
    ],
    "PRINT": [
        X("String and number together", 'PRINT "A=";A', None,
          "Prints a string followed by the value of A, without spaces.", verified=True),
        X("Print zones", 'PRINT 1,2,3,4', "Four numbers in the four 8-column zones of the line.",
          "The comma moves to the next zone (columns 9, 17, 25).", verified=True),
    ],
    "INPUT": [
        X("Read a number", "10 INPUT N\n20 PRINT N*2", "42", "Run the program, type 21 and press NEWLINE.", verified=True),
        X("Read a string", "10 INPUT A$\n20 PRINT A$", "HELLO",
          "Run the program, type HELLO and press NEWLINE (the quotes appear by themselves).", verified=True),
    ],
    "IF": [
        X("Conditional jump", "IF J = 152 THEN GO TO 60", None, "Jumps to line 60 if J is 152.", manual=True, verified=True),
        X("Comparing strings", '10 INPUT A$\n20 IF A$="Y" THEN PRINT "YES"', "YES",
          "Run the program, type Y and press NEWLINE.", verified=True),
    ],
    "GO TO": [
        X("Endless loop", '10 PRINT "LOOP"\n20 GO TO 10', "LOOP on every line until the screen is full, then 5/10.",
          "Report 5 means the screen is full."),
        X("Missing line", '10 GO TO 15\n20 PRINT "HERE"', "HERE",
          "Line 15 does not exist: execution goes on from the next line, 20.", verified=True),
    ],
    "GO SUB": [
        X("Call a subroutine", '10 GO SUB 100\n20 STOP\n100 PRINT "SUB"\n110 RETURN', "SUB\n9/20", verified=True),
    ],
    "RETURN": [
        X("Return from a subroutine", '10 GO SUB 100\n20 PRINT "BACK"\n30 STOP\n100 RETURN', "BACK\n9/30"),
        X("RETURN without GO SUB", "10 RETURN", "7/10", "Report 7: RETURN without a matching GO SUB.", verified=True),
    ],
    "FOR...TO": [
        X("Expressions as limits", "FOR I = D*10 TO D*200", None, "Start and end can be expressions.", manual=True),
        X("Count from 1 to 3", "10 FOR I=1 TO 3\n20 PRINT I\n30 NEXT I", "1\n2\n3", verified=True),
    ],
    "NEXT": [
        X("End of the loop", "10 FOR I=1 TO 3\n20 PRINT I\n30 NEXT I\n40 PRINT I", "1\n2\n3\n4",
          "After the loop the counter is end+1."),
        X("NEXT without FOR", "10 NEXT I", "1/10", "Report 1: I is not the counter of an active FOR loop.", verified=True),
    ],
    "STOP": [
        X("Stop the program", '10 PRINT "A"\n20 STOP\n30 PRINT "B"', "A\n9/20", "CONTINUE would print B.", verified=True),
    ],
    "DIM": [
        X("Array with a variable size", "DIM A(B)", None, "Creates array A with elements from A(0) to A(B).", manual=True, verified=True),
        X("Use an array", "10 DIM A(5)\n20 LET A(0)=1\n30 LET A(5)=6\n40 PRINT A(0)+A(5)", "7", verified=True),
    ],
    "CLEAR": [
        X("Variables are lost", "10 LET A=5\n20 CLEAR\n30 PRINT A", "2/30",
          "After CLEAR, A no longer exists: report 2, variable not found.", verified=True),
    ],
    "CLS": [
        X("Clear the screen", '10 PRINT "HELLO"\n20 CLS', "An empty screen.", "HELLO is printed and then cleared.", verified=True),
    ],
    "POKE": [
        X("Write and read back a byte", "10 POKE A,123\n20 PRINT PEEK(A)", "123",
          "A must be the address of a free memory location: it depends on the memory fitted and on the program.", verified=True),
    ],
    "RANDOMISE": [
        X("Same numbers every time", "10 RANDOMISE 1\n20 PRINT RND(100)", "The same number every time the program is run.", verified=True),
        X("Different numbers", "10 RANDOMISE\n20 PRINT RND(100)", "A different number at each run.",
          "Without an argument the seed comes from the video frame counter.", verified=True),
        X("Negative seed", "10 RANDOMISE -5\n20 PRINT RND(100)\n30 GO TO 20", "100\n46\n21\n70\n30\n36\n43\n71\n…",
          "-5 is used as the seed 65531.", verified=True),
    ],
    "REM": [
        X("Comment", "10 REM GUESS THE NUMBER", None, "The line has no effect.", verified=True),
    ],
    # ----------------------------------------------------------- functions
    "ABS": [
        X("Absolute value", "PRINT ABS(-5)", "5", verified=True),
    ],
    "CHR$": [
        X("Character from its code", "PRINT CHR$(38)", "A", "In the ZX80 character set A has code 38.", verified=True),
    ],
    "CODE": [
        X("Code of a character", 'PRINT CODE("A")', "38", verified=True),
        X("Only the first character counts", 'PRINT CODE("ZX80")', "63", "Z has code 63.", verified=True),
    ],
    "PEEK": [
        X("Read a byte", "PRINT PEEK(16384)", "A number from 0 to 255.",
          "16384 is the first address of the RAM, where the system variables are.", verified=True),
    ],
    "RND": [
        X("Throw a die", "PRINT RND(6)", "A number from 1 to 6.", verified=True),
        X("A known sequence", "10 RANDOMISE 5\n20 PRINT RND(100)\n30 GO TO 20",
          "1\n46\n84\n93\n10\n4\n82\n59\n69\n86\n16\n90\n54\n27\n69\n97\n94\n97\n62\n45\n92\n54\n52\n…",
          "With the same seed the sequence is always the same; it follows the algorithm in the notes.", verified=True),
        X("Negative argument", "10 RANDOMISE 5\n20 PRINT RND(-10)\n30 GO TO 20",
          "385\n29641\n-11137\n-5037\n5989\n2394\n-12280\n-27507\n-20552\n-9238\n10119\n-7211\n-30416\n17606\n"
          "-20466\n-2617\n-4290\n-2037\n-25164\n28863\n-5507\n-30205\n-31686\n…",
          "-10 is used as 65526: the results go from 1 to 32767 or from -32768 to -10.", verified=True),
    ],
    "STR$": [
        X("Number to string", "STR$(1234)", None, 'Gives the string "1234".', manual=True, verified=True),
        X("Negative number", "PRINT STR$(-56)", "-56", "The minus sign is part of the string.", verified=True),
    ],
    "TL$": [
        X("Remove the first character", 'PRINT TL$("ZX80")', "X80", verified=True),
    ],
    "USR": [
        X("Call machine code", "PRINT USR(A)", "The value of the HL register when the routine returns.",
          "A is the address of a machine code routine ending with RET; if the routine does not change HL, the result is A.", verified=True),
    ],
    # ----------------------------------------------------------- operators
    "**": [
        X("Power", "PRINT 2**10", "1024"),
        X("Overflow", "10 PRINT 2**15", "6/10", "32768 is out of range: report 6, overflow.", verified=True),
    ],
    "-": [
        X("Change of sign", "PRINT -5", "-5", form=1, verified=True),
        X("Subtraction", "PRINT 10-3", "7", form=2, verified=True),
    ],
    "*": [
        X("Multiplication", "PRINT 6*7", "42", verified=True),
    ],
    "/": [
        X("Integer division", "PRINT 7/2", "3", "The result is truncated.", verified=True),
        X("Truncated towards zero", "PRINT -7/2", "-3", verified=True),
    ],
    "+": [
        X("Addition", "PRINT 2+3", "5", verified=True),
    ],
    "=": [
        X("Equal numbers", "PRINT 2=2", "-1", "True gives -1.", form=1, verified=True),
        X("Equal strings", '10 LET A$="YES"\n20 PRINT A$="YES"', "-1", form=2, verified=True),
    ],
    ">": [
        X("Greater than", "PRINT 3>2", "-1", form=1, verified=True),
        X("Chained comparisons", "PRINT 3>2>1", "0", "(3>2)>1 means -1>1, which is false.", form=1, verified=True),
    ],
    "<": [
        X("Less than", "PRINT 3<2", "0", "False gives 0.", form=1, verified=True),
    ],
    "NOT": [
        X("NOT of zero", "PRINT NOT 0", "-1", "Prints -1."),
        X("NOT of a number", "PRINT NOT 5", "-6", "Prints -6: NOT n is -n-1.", verified=True),
    ],
    "AND": [
        X("No bits in common", "PRINT 85 AND 170", "0", "Prints 0: no bits in common.", verified=True),
        X("As a condition", "PRINT (3>2) AND (2>1)", "-1", "-1 AND -1 is -1: true.", verified=True),
    ],
    "OR": [
        X("All the bits", "PRINT 85 OR 170", "255", "Prints 255.", verified=True),
    ],
    "( )": [
        X("Change the order", "PRINT (2+3)*4", "20", "Without parentheses, 2+3*4 gives 14.", verified=True),
    ],
}

REFERENCES = [("FOR...TO", "NEXT", "OPENS_BLOCK"), ("GO SUB", "RETURN", "OPENS_BLOCK"),
              ("STOP", "CONTINUE", "SEE_ALSO"), ("RUN", "CLEAR", "SEE_ALSO"),
              ("CHR$", "CODE", "SEE_ALSO"), ("PEEK", "POKE", "SEE_ALSO"),
              ("RND", "RANDOMISE", "SEE_ALSO"), ("SAVE", "LOAD", "SEE_ALSO")]


# ---------------------------------------------------------------------
# SQL generation
# ---------------------------------------------------------------------
def q(v):
    if v is None:
        return "NULL"
    if isinstance(v, bool):
        return "1" if v else "0"
    if isinstance(v, (int, float)):
        return str(v)
    return "'" + str(v).replace("'", "''") + "'"


def row(table, values):
    columns = ", ".join(values)
    return f"INSERT INTO {table} ({columns}) VALUES ({', '.join(q(v) for v in values.values())});"


def generate():
    out = ["-- " + "=" * 69,
           "--  BASIC 2 BASIC - Sinclair ZX80 BASIC (4K ROM)",
           "--  GENERATED FILE from data/zx80.py: edit that file and regenerate.",
           "-- " + "=" * 69, "", "PRAGMA foreign_keys = ON;", "BEGIN;", ""]
    w = out.append
    layer_id = LAYER["id"]

    w(row("machine", MACHINE))
    w(row("dialect", DIALECT))
    w(row("layer", LAYER))
    w(row("dialect_layer", dict(dialect_id=DIALECT["id"], layer_id=layer_id, position=1)))
    w(row("machine_dialect", dict(machine_id=MACHINE["id"], dialect_id=DIALECT["id"], medium="ROM", is_default=1)))
    w("")
    w(row("charset", dict(machine_id=MACHINE["id"], **CHARSET)))
    for g in zx80_glyphs():
        w(row("glyph", g))
    for sc in zx80_screen_codes():
        w(row("screen_code", sc))
    for cc in zx80_character_codes():
        w(row("character_code", cc))
    w("")
    for area, prologue, epilogue, notes in MEMORY_AREAS:
        w(row("memory_area", dict(layer_id=layer_id, area=area, prologue=prologue, epilogue=epilogue, notes=notes)))
    for k, (name, offset, size, order, descr) in enumerate(PROGRAM_LAYOUT, start=1):
        w(row("program_layout_field", dict(layer_id=layer_id, position=k, name=name, offset=offset, size=size,
                                           byte_order=order, description=descr)))
    for kind, status, notes in LAYER_TABLES:
        w(f"INSERT INTO table_status (table_kind_id, layer_id, status, notes) "
          f"SELECT id, {layer_id}, {q(status)}, {q(notes)} FROM table_kind WHERE code = {q(kind)};")
    for kind, status, notes in MACHINE_TABLES:
        w(f"INSERT INTO table_status (table_kind_id, machine_id, status, notes) "
          f"SELECT id, {MACHINE['id']}, {q(status)}, {q(notes)} FROM table_kind WHERE code = {q(kind)};")
    w("")
    for s in SOURCES:
        w(row("source", dict(zip(("id", "title", "author", "publisher", "year", "kind", "url", "notes"), s))))
    w("")
    type_id = {}
    for t in DATA_TYPES:
        tid, code, name, suffix, cls, mn, mx, nbytes, notes = t
        type_id[code] = tid
        w(row("data_type", dict(id=tid, layer_id=layer_id, code=code, name=name, suffix=suffix,
                                type_class_id=TYPE_CLASS[cls], minimum=mn, maximum=mx, bytes=nbytes, notes=notes)))
    w("")
    variable_kind_id = {}
    for vid, code, name, dtype, dims, rule, pattern, max_length, significant, examples, notes in VARIABLE_KINDS:
        variable_kind_id[code] = vid
        w(row("variable_kind", dict(id=vid, layer_id=layer_id, code=code, name=name, data_type_id=type_id[dtype],
                                    dimensions=dims, name_rule=rule, name_pattern=pattern, max_name_length=max_length, significant_chars=significant, examples=examples,
                                    notes=notes)))
    for vcode, layouts in VARIABLE_LAYOUTS.items():
        vid = next(v[0] for v in VARIABLE_KINDS if v[1] == vcode)
        for n, (lname, fields) in enumerate(layouts, start=1):
            for k, (name, offset, size, order, descr) in enumerate(fields, start=1):
                w(row("variable_layout_field", dict(variable_kind_id=vid, layout=n, layout_name=lname, position=k,
                                                    name=name, offset=offset, size=size, byte_order=order,
                                                    description=descr)))
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
    for code, number, descr in ERRORS:
        w(row("error", dict(layer_id=layer_id, code=code, number=number, message=f"{number}/n", description=descr)))
    w("")
    keyword_id = {}
    assert set(ABBREVIATIONS) <= {k[0] for k in KEYWORDS}, set(ABBREVIATIONS) - {k[0] for k in KEYWORDS}
    for i, (text, tok, notes) in enumerate(KEYWORDS, start=1):
        keyword_id[text] = i
        w(row("keyword", dict(id=i, layer_id=layer_id, text=text, notes=notes)))
        if tok:
            w(row("token", dict(keyword_id=i, hex_value=tok)))
        w(row("abbreviation", dict(keyword_id=i, text=ABBREVIATIONS.get(text, ""))))
    w("")

    counter = dict(entry=0, form=0, par=0, node=0)
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
        eid = entry_id[e["name"]] = counter["entry"]
        w(f"-- {e['name']}")
        w(row("entry", dict(id=eid, layer_id=layer_id, name=e["name"], category_id=CATEGORY[e["cat"]],
                            description=e["descr"], notes=e["notes"])))
        w(row("entry_source", dict(entry_id=eid, source_id=1, page="Appendix II")))
        for k, f in enumerate(e["forms"], start=1):
            counter["form"] += 1
            fid = counter["form"]
            ret = f["ret"]
            w(row("syntax_form", dict(
                id=fid, entry_id=eid, position=k, title=f["title"], description=f["descr"],
                original_syntax=f["orig"], source_id=1, page="Appendix II",
                return_type_id=type_id[ret[0]] if ret else None,
                return_min=ret[1] if ret else None, return_max=ret[2] if ret else None,
                precedence=f["prec"], associativity=f["assoc"],
                operator_class_id=OPERATOR_CLASS[f["op"]] if f["op"] else None)))
            par_ids = {}
            for name in parameter_names(f["tree"], []):
                d = f["par"].get(name, {})
                counter["par"] += 1
                par_ids[name] = counter["par"]
                w(row("parameter", dict(
                    id=counter["par"], form_id=fid, name=name,
                    conversion=d.get("conversion", "NONE"), error_code=d.get("error"),
                    missing_line=d.get("missing_line"), description=d.get("descr"))))
                if "limit" in d:
                    lim = d["limit"]
                    w(row("parameter_limit", dict(parameter_id=counter["par"], minimum=lim[0], maximum=lim[1],
                                                  notes=lim[2] if len(lim) > 2 else None)))
            node(f["tree"], fid, None, 1, par_ids)
            for code, coverage, note in f["actions"]:
                w(f"INSERT INTO form_action (form_id, action_id, coverage, notes) "
                  f"SELECT {fid}, id, {q(coverage)}, {q(note)} FROM action WHERE code = {q(code)};")
        form_ids = {k: counter["form"] - len(e["forms"]) + k for k in range(1, len(e["forms"]) + 1)}
        for k, x in enumerate(EXAMPLES.get(e["name"], []), start=1):
            w(row("example", dict(entry_id=eid, form_id=form_ids[x["form"]] if x["form"] else None,
                                  position=k, title=x["title"], description=x["description"],
                                  code=x["code"], expected_result=x["expected"], verified=1 if x["verified"] else 0,
                                  source_id=1 if x["manual"] else None)))
        w("")

    for a, b, kind in REFERENCES:
        w(row("reference", dict(entry_id=entry_id[a], related_entry_id=entry_id[b], kind=kind)))
    w("")
    w("COMMIT;")
    return "\n".join(out) + "\n"


if __name__ == "__main__":
    target = os.path.join(os.path.dirname(os.path.abspath(__file__)), "zx80.sql")
    with open(target, "w", encoding="utf-8") as f:
        f.write(generate())
    print(f"written {target}")
