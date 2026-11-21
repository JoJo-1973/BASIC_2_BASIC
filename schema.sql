-- =====================================================================
--  BASIC 2 BASIC - Encyclopedia of 8-bit BASIC dialects
--  Database schema (SQLite 3.37 or later: STRICT tables, window
--  functions and WITH RECURSIVE)
--
--  Conventions
--  * Every table has a surrogate key "id" and, where useful, a stable,
--    readable "code" (e.g. 'C64', 'PLOT_LINE').
--  * Tables that follow the layers have layer_id + operation
--    (ADD / REPLACE / REMOVE) + redefines_id. The layer with the highest
--    "position" in the dialect wins; REMOVE hides the row.
--  * An optional machine_id = valid on all machines; when set, the row
--    applies to that machine only and overrides the general one.
--  * Booleans are INTEGER 0/1.
--  * All tables are STRICT: SQLite rejects values of the wrong type
--    (e.g. text in an INTEGER column) instead of silently converting them.
--
--  Run with:  python build_database.py   (or: sqlite3 basic2basic.db < schema.sql)
-- =====================================================================

PRAGMA foreign_keys = ON;

-- ---------------------------------------------------------------------
-- 1. MACHINES, DIALECTS, LAYERS
-- ---------------------------------------------------------------------

CREATE TABLE machine (
    id            INTEGER PRIMARY KEY,
    code          TEXT    NOT NULL UNIQUE,        -- 'C64', 'ZX_SPECTRUM_48K'
    name          TEXT    NOT NULL,
    manufacturer  TEXT,
    year          INTEGER,
    cpu           TEXT,
    notes         TEXT
) STRICT;

CREATE TABLE dialect (
    id          INTEGER PRIMARY KEY,
    code        TEXT    NOT NULL UNIQUE,          -- 'CBM_BASIC_2.0', 'SIMONS_BASIC'
    name        TEXT    NOT NULL,
    version     TEXT,
    author      TEXT,
    year        INTEGER,
    notes       TEXT
) STRICT;

CREATE TABLE machine_dialect (
    machine_id  INTEGER NOT NULL REFERENCES machine(id) ON DELETE CASCADE,
    dialect_id  INTEGER NOT NULL REFERENCES dialect(id) ON DELETE CASCADE,
    medium      TEXT    NOT NULL DEFAULT 'ROM'
                CHECK (medium IN ('ROM','CARTRIDGE','DISK','TAPE','OTHER')),
    is_default  INTEGER NOT NULL DEFAULT 0 CHECK (is_default IN (0,1)),
    notes       TEXT,
    PRIMARY KEY (machine_id, dialect_id)
) STRICT;

CREATE TABLE layer (
    id          INTEGER PRIMARY KEY,
    code        TEXT    NOT NULL UNIQUE,          -- 'BASIC_1.0_core', 'Simons_BASIC_layer'
    name        TEXT    NOT NULL,
    kind        TEXT    NOT NULL CHECK (kind IN ('CORE','LAYER')),
    author      TEXT,
    year        INTEGER,
    notes       TEXT
) STRICT;

-- A dialect is an ordered stack of layers (position 1 = core).
CREATE TABLE dialect_layer (
    dialect_id  INTEGER NOT NULL REFERENCES dialect(id) ON DELETE CASCADE,
    layer_id    INTEGER NOT NULL REFERENCES layer(id),
    position    INTEGER NOT NULL CHECK (position >= 1),
    PRIMARY KEY (dialect_id, layer_id),
    UNIQUE (dialect_id, position)
) STRICT;

-- Dialect features that are not keywords
-- (significant characters in names, line number range, ...).
CREATE TABLE feature (
    id            INTEGER PRIMARY KEY,
    layer_id      INTEGER NOT NULL REFERENCES layer(id),
    code          TEXT    NOT NULL,               -- 'LINE_NUMBERS'
    value         TEXT,
    operation     TEXT    NOT NULL DEFAULT 'ADD'
                  CHECK (operation IN ('ADD','REPLACE','REMOVE')),
    redefines_id  INTEGER REFERENCES feature(id),
    description   TEXT,
    UNIQUE (layer_id, code)
) STRICT;

-- ---------------------------------------------------------------------
-- 2. SOURCES
-- ---------------------------------------------------------------------

CREATE TABLE source (
    id          INTEGER PRIMARY KEY,
    title       TEXT    NOT NULL,
    author      TEXT,
    publisher   TEXT,
    year        INTEGER,
    kind        TEXT,                             -- 'MANUAL', 'BOOK', 'MAGAZINE', 'WEB'
    url         TEXT,
    notes       TEXT
) STRICT;

-- ---------------------------------------------------------------------
-- 3. DATA TYPES
-- ---------------------------------------------------------------------

-- Families shared by all dialects (they do not follow the layers).
CREATE TABLE type_class (
    id          INTEGER PRIMARY KEY,
    code        TEXT    NOT NULL UNIQUE,          -- NUMERIC, INTEGER, REAL, STRING, BOOLEAN, ANY
    description TEXT
) STRICT;

-- Concrete types of a dialect (they follow the layers).
CREATE TABLE data_type (
    id             INTEGER PRIMARY KEY,
    layer_id       INTEGER NOT NULL REFERENCES layer(id),
    code           TEXT    NOT NULL,              -- 'FLOAT5', 'INT16', 'STRING'
    name           TEXT    NOT NULL,
    suffix         TEXT,                          -- '%', '$', '!', '#', NULL
    type_class_id  INTEGER NOT NULL REFERENCES type_class(id),
    minimum        REAL,
    maximum        REAL,
    max_length     INTEGER,                       -- for strings
    precision      TEXT,                          -- '9 digits', ...
    bytes          INTEGER,
    operation      TEXT    NOT NULL DEFAULT 'ADD'
                   CHECK (operation IN ('ADD','REPLACE','REMOVE')),
    redefines_id   INTEGER REFERENCES data_type(id),
    notes          TEXT,
    UNIQUE (layer_id, code)
) STRICT;

-- Variable types of a dialect (they follow the layers). They differ by
-- naming rule, number of dimensions and memory representation
-- (e.g. ZX80: numeric, string, numeric array, loop control variable).
CREATE TABLE variable_kind (
    id             INTEGER PRIMARY KEY,
    layer_id       INTEGER NOT NULL REFERENCES layer(id),
    code           TEXT    NOT NULL,              -- 'NUMERIC', 'STRING', 'NUMERIC_ARRAY'
    name           TEXT    NOT NULL,
    data_type_id   INTEGER NOT NULL REFERENCES data_type(id),   -- type of the value / elements
    dimensions     INTEGER NOT NULL DEFAULT 0 CHECK (dimensions >= 0),  -- 0 = scalar; arrays: max dimensions
    name_rule      TEXT,                          -- naming rule, in words
    name_pattern   TEXT,                          -- optional regular expression for the name
    examples       TEXT,                          -- 'A, PIPPO24'
    notes          TEXT,
    operation      TEXT    NOT NULL DEFAULT 'ADD'
                   CHECK (operation IN ('ADD','REPLACE','REMOVE')),
    redefines_id   INTEGER REFERENCES variable_kind(id),
    UNIQUE (layer_id, code)
) STRICT;

-- Variables in memory: the fields of each variable type, in order.
CREATE TABLE variable_layout_field (
    id                INTEGER PRIMARY KEY,
    variable_kind_id  INTEGER NOT NULL REFERENCES variable_kind(id) ON DELETE CASCADE,
    position          INTEGER NOT NULL,
    name              TEXT    NOT NULL,
    offset            INTEGER,                        -- bytes from the start (NULL = variable)
    size              INTEGER,                        -- bytes (NULL = variable)
    byte_order        TEXT    CHECK (byte_order IN ('BIG','LITTLE')),
    description       TEXT,
    UNIQUE (variable_kind_id, position)
) STRICT;

-- ---------------------------------------------------------------------
-- 4. LEXICAL LEVEL: KEYWORDS, TOKENS, ABBREVIATIONS
-- ---------------------------------------------------------------------

CREATE TABLE keyword (
    id            INTEGER PRIMARY KEY,
    layer_id      INTEGER NOT NULL REFERENCES layer(id),
    text          TEXT    NOT NULL COLLATE NOCASE,   -- 'PRINT', 'GO TO', 'TO'
    operation     TEXT    NOT NULL DEFAULT 'ADD'
                  CHECK (operation IN ('ADD','REPLACE','REMOVE')),
    redefines_id  INTEGER REFERENCES keyword(id),
    notes         TEXT,
    UNIQUE (layer_id, text)
) STRICT;

-- Byte sequence in hexadecimal: '99' or 'FE02' (2-byte token).
CREATE TABLE token (
    id          INTEGER PRIMARY KEY,
    keyword_id  INTEGER NOT NULL REFERENCES keyword(id) ON DELETE CASCADE,
    machine_id  INTEGER REFERENCES machine(id),
    hex_value   TEXT    NOT NULL
                CHECK (length(hex_value) % 2 = 0
                       AND hex_value NOT GLOB '*[^0-9A-F]*'),
    notes       TEXT
) STRICT;
CREATE UNIQUE INDEX ux_token_general ON token(keyword_id) WHERE machine_id IS NULL;
CREATE UNIQUE INDEX ux_token_machine ON token(keyword_id, machine_id) WHERE machine_id IS NOT NULL;

-- Key notation: P{SHIFT}R, P{CBM}R, ...
CREATE TABLE abbreviation (
    id          INTEGER PRIMARY KEY,
    keyword_id  INTEGER NOT NULL REFERENCES keyword(id) ON DELETE CASCADE,
    machine_id  INTEGER REFERENCES machine(id),
    text        TEXT    NOT NULL,
    notes       TEXT
) STRICT;

-- ---------------------------------------------------------------------
-- 5. AUXILIARY TABLES (colors, errors, character sets, ...)
-- ---------------------------------------------------------------------

-- Catalogue of the tables that always exist for every dialect (DIALECT
-- scope: on the layers) or machine (MACHINE scope), even when not defined
-- for a particular combination (see table_status).
CREATE TABLE table_kind (
    id          INTEGER PRIMARY KEY,
    code        TEXT    NOT NULL UNIQUE,          -- 'COLORS', 'ERRORS', 'GLYPHS', ...
    name        TEXT    NOT NULL,
    scope       TEXT    NOT NULL CHECK (scope IN ('DIALECT','MACHINE')),
    position    INTEGER NOT NULL DEFAULT 1,       -- display order
    description TEXT
) STRICT;

-- State of each table for a layer (DIALECT scope) or a machine (MACHINE scope):
--  NOT_APPLICABLE  the table does not exist there (e.g. ZX80: no colors)
--  TO_DO           not entered yet
--  PARTIAL / COMPLETE
-- notes: remarks valid for the whole table (e.g. the C64 frequency formula).
CREATE TABLE table_status (
    id             INTEGER PRIMARY KEY,
    table_kind_id  INTEGER NOT NULL REFERENCES table_kind(id),
    layer_id       INTEGER REFERENCES layer(id),
    machine_id     INTEGER REFERENCES machine(id),
    status         TEXT    NOT NULL CHECK (status IN ('NOT_APPLICABLE','TO_DO','PARTIAL','COMPLETE')),
    notes          TEXT,
    CHECK ((layer_id IS NULL) <> (machine_id IS NULL))
) STRICT;
CREATE UNIQUE INDEX ux_table_status_layer   ON table_status(table_kind_id, layer_id)   WHERE layer_id IS NOT NULL;
CREATE UNIQUE INDEX ux_table_status_machine ON table_status(table_kind_id, machine_id) WHERE machine_id IS NOT NULL;

-- Optional one-off tables for special cases (e.g. the C128 escape
-- sequences): a generic grid of text cells, on a layer or a machine.
CREATE TABLE custom_table (
    id           INTEGER PRIMARY KEY,
    code         TEXT    NOT NULL UNIQUE,         -- 'C128_ESCAPE_SEQUENCES'
    title        TEXT    NOT NULL,
    description  TEXT,
    layer_id     INTEGER REFERENCES layer(id),
    machine_id   INTEGER REFERENCES machine(id),
    position     INTEGER NOT NULL DEFAULT 1,
    CHECK ((layer_id IS NULL) <> (machine_id IS NULL))
) STRICT;

CREATE TABLE custom_column (
    table_id  INTEGER NOT NULL REFERENCES custom_table(id) ON DELETE CASCADE,
    position  INTEGER NOT NULL,
    header    TEXT    NOT NULL,
    PRIMARY KEY (table_id, position)
) STRICT;

CREATE TABLE custom_row (
    id        INTEGER PRIMARY KEY,
    table_id  INTEGER NOT NULL REFERENCES custom_table(id) ON DELETE CASCADE,
    position  INTEGER NOT NULL,
    UNIQUE (table_id, position)
) STRICT;

CREATE TABLE custom_cell (
    row_id           INTEGER NOT NULL REFERENCES custom_row(id) ON DELETE CASCADE,
    column_position  INTEGER NOT NULL,
    value            TEXT,
    PRIMARY KEY (row_id, column_position)
) STRICT;

-- DIALECT scope: follows the layers.
CREATE TABLE error (
    id            INTEGER PRIMARY KEY,
    layer_id      INTEGER NOT NULL REFERENCES layer(id),
    code          TEXT    NOT NULL,               -- stable key: 'ILLEGAL_QUANTITY'
    number        INTEGER,                        -- error number, if any
    message       TEXT    NOT NULL,               -- text shown: 'ILLEGAL QUANTITY'
    operation     TEXT    NOT NULL DEFAULT 'ADD'
                  CHECK (operation IN ('ADD','REPLACE','REMOVE')),
    redefines_id  INTEGER REFERENCES error(id),
    description   TEXT,
    UNIQUE (layer_id, code)
) STRICT;

-- Character codes (DIALECT scope, they follow the layers): what each code
-- means for the BASIC (ASCII, PETSCII, ATASCII, the ZX80 set, ...). An
-- extension can give a meaning to control codes (Simons' BASIC, Super
-- Expander); mode distinguishes codes that change with the video mode
-- (C128: 40/80 columns; NULL = all modes).
--  PRINTABLE  prints the screen code screen_code
--  CONTROL    performs action (clear screen, color, cursor, ...)
--  TOKEN      prints the keyword whose token has this code
--  UNUSED     no meaning; screen_code = what is printed, if anything (ZX80: '?')
CREATE TABLE character_code (
    id            INTEGER PRIMARY KEY,
    layer_id      INTEGER NOT NULL REFERENCES layer(id),
    code          INTEGER NOT NULL CHECK (code >= 0),
    mode          TEXT,
    kind          TEXT    NOT NULL CHECK (kind IN ('PRINTABLE','CONTROL','TOKEN','UNUSED')),
    screen_code   INTEGER,
    action        TEXT,                               -- for CONTROL
    name          TEXT,
    notes         TEXT,
    operation     TEXT    NOT NULL DEFAULT 'ADD'
                  CHECK (operation IN ('ADD','REPLACE','REMOVE')),
    redefines_id  INTEGER REFERENCES character_code(id),
    CHECK (kind <> 'PRINTABLE' OR screen_code IS NOT NULL),
    CHECK (kind = 'CONTROL' OR action IS NULL)
) STRICT;
CREATE UNIQUE INDEX ux_character_code_all  ON character_code(layer_id, code) WHERE mode IS NULL;
CREATE UNIQUE INDEX ux_character_code_mode ON character_code(layer_id, code, mode) WHERE mode IS NOT NULL;

-- Keyboard codes (DIALECT scope): the code the BASIC gives for a key, also
-- for keys without a character code (PgUp, NumLock with INKEY in GW-BASIC or
-- BBC BASIC), and the keyword a key enters (ZX80 K mode).
CREATE TABLE key_code (
    id            INTEGER PRIMARY KEY,
    layer_id      INTEGER NOT NULL REFERENCES layer(id),
    machine_id    INTEGER REFERENCES machine(id),     -- NULL = all machines
    key           TEXT    NOT NULL,                   -- key label: 'A', 'PgUp', 'NEWLINE'
    modifier      TEXT,                               -- 'SHIFT', 'CTRL', 'K mode', ...
    code          INTEGER,                            -- value returned when the key is read
    read_with     TEXT,                               -- how it is read: 'INKEY', 'INKEY$', ...
    keyword_id    INTEGER REFERENCES keyword(id),     -- keyword entered by the key
    notes         TEXT,
    operation     TEXT    NOT NULL DEFAULT 'ADD'
                  CHECK (operation IN ('ADD','REPLACE','REMOVE')),
    redefines_id  INTEGER REFERENCES key_code(id)
) STRICT;

-- Musical notes (DIALECT scope): the value written in the sound statement
-- for each note (e.g. ZX Spectrum BEEP: semitones from middle C). When the
-- statement wants a frequency (C64) the formula goes in table_status.notes.
CREATE TABLE musical_note (
    id            INTEGER PRIMARY KEY,
    layer_id      INTEGER NOT NULL REFERENCES layer(id),
    machine_id    INTEGER REFERENCES machine(id),     -- NULL = all machines
    note          TEXT    NOT NULL,                   -- 'C', 'C#', 'D', ...
    octave        INTEGER,
    value         REAL,                               -- value used by the statement
    frequency_hz  REAL,
    notes         TEXT,
    operation     TEXT    NOT NULL DEFAULT 'ADD'
                  CHECK (operation IN ('ADD','REPLACE','REMOVE')),
    redefines_id  INTEGER REFERENCES musical_note(id)
) STRICT;

-- Program in memory (DIALECT scope): the fields of a program line, in order
-- (line number, length or link, text, terminator, ...).
CREATE TABLE program_layout_field (
    id            INTEGER PRIMARY KEY,
    layer_id      INTEGER NOT NULL REFERENCES layer(id),
    position      INTEGER NOT NULL,
    name          TEXT    NOT NULL,
    offset        INTEGER,                            -- bytes from the start of the line (NULL = variable)
    size          INTEGER,                            -- bytes (NULL = variable)
    byte_order    TEXT    CHECK (byte_order IN ('BIG','LITTLE')),
    description   TEXT,
    operation     TEXT    NOT NULL DEFAULT 'ADD'
                  CHECK (operation IN ('ADD','REPLACE','REMOVE')),
    redefines_id  INTEGER REFERENCES program_layout_field(id),
    UNIQUE (layer_id, position)
) STRICT;

-- MACHINE scope.
CREATE TABLE color (
    id          INTEGER PRIMARY KEY,
    machine_id  INTEGER NOT NULL REFERENCES machine(id) ON DELETE CASCADE,
    code        INTEGER NOT NULL,
    name        TEXT    NOT NULL,
    rgb         TEXT,                             -- '#RRGGBB'
    notes       TEXT,
    UNIQUE (machine_id, code)
) STRICT;

-- Character sets of a machine (a machine can have more than one,
-- e.g. upper case/graphics and lower/upper case on the C64).
-- National variants: a set with base_charset_id holds ONLY the glyphs that
-- differ from its base set; the others are inherited (v_effective_glyph).
-- E.g. C128: 'C128_UPPER_GFX' (base) <- 'C128_UPPER_GFX_DE' (language 'de').
CREATE TABLE charset (
    id               INTEGER PRIMARY KEY,
    machine_id       INTEGER NOT NULL REFERENCES machine(id) ON DELETE CASCADE,
    code             TEXT    NOT NULL,            -- 'ZX80_ROM'
    name             TEXT    NOT NULL,
    base_charset_id  INTEGER REFERENCES charset(id),   -- set it inherits from
    language         TEXT,                        -- 'it', 'de', 'fr', 'es', ... (NULL = none)
    width            INTEGER NOT NULL DEFAULT 8 CHECK (width > 0),    -- pixels
    height           INTEGER NOT NULL DEFAULT 8 CHECK (height > 0),
    description      TEXT,
    UNIQUE (machine_id, code),
    CHECK (base_charset_id IS NULL OR base_charset_id <> id)
) STRICT;

-- Glyphs of a character set: one bitmap per glyph number (position in the
-- character set). bitmap: one row per group of bytes, in hexadecimal, bit 7 =
-- leftmost pixel; length = height * ceil(width/8) * 2 (checked by the triggers).
CREATE TABLE glyph (
    id          INTEGER PRIMARY KEY,
    charset_id  INTEGER NOT NULL REFERENCES charset(id) ON DELETE CASCADE,
    code        INTEGER NOT NULL CHECK (code >= 0),     -- glyph number
    bitmap      TEXT    NOT NULL CHECK (bitmap NOT GLOB '*[^0-9A-F]*'),
    inverse_of  INTEGER,                                -- glyph number of the same shape in normal video
    unicode     TEXT,                                   -- Unicode equivalent of the shape, if any
    name        TEXT,
    notes       TEXT,
    UNIQUE (charset_id, code)
) STRICT;

CREATE TRIGGER tr_glyph_bitmap_ins BEFORE INSERT ON glyph
WHEN length(NEW.bitmap) <>
     (SELECT height * ((width + 7) / 8) * 2 FROM charset WHERE id = NEW.charset_id)
BEGIN
    SELECT RAISE(ABORT, 'glyph: bitmap length does not match the character set');
END;

CREATE TRIGGER tr_glyph_bitmap_upd BEFORE UPDATE OF bitmap, charset_id ON glyph
WHEN length(NEW.bitmap) <>
     (SELECT height * ((width + 7) / 8) * 2 FROM charset WHERE id = NEW.charset_id)
BEGIN
    SELECT RAISE(ABORT, 'glyph: bitmap length does not match the character set');
END;

-- Screen codes (MACHINE scope): the values in video memory and the glyph
-- each one shows. Codes missing from the table are not used.
CREATE TABLE screen_code (
    id          INTEGER PRIMARY KEY,
    machine_id  INTEGER NOT NULL REFERENCES machine(id) ON DELETE CASCADE,
    code        INTEGER NOT NULL CHECK (code >= 0),
    glyph_code  INTEGER NOT NULL,                       -- glyph number in the active character set
    inverse     INTEGER NOT NULL DEFAULT 0 CHECK (inverse IN (0,1)),   -- inverted by the hardware
    notes       TEXT,
    UNIQUE (machine_id, code)
) STRICT;

-- Color attributes (MACHINE scope), next to the color codes (table color):
-- e.g. INK, PAPER, BRIGHT, FLASH on the ZX Spectrum.
CREATE TABLE attribute (
    id           INTEGER PRIMARY KEY,
    machine_id   INTEGER NOT NULL REFERENCES machine(id) ON DELETE CASCADE,
    position     INTEGER NOT NULL DEFAULT 1,
    name         TEXT    NOT NULL,                      -- 'INK', 'FLASH'
    bits         TEXT,                                  -- bits of the attribute byte: '0-2', '7'
    description  TEXT,
    notes        TEXT
) STRICT;

-- ---------------------------------------------------------------------
-- 6. SYNTACTIC LEVEL: ENTRIES AND FORMS
-- ---------------------------------------------------------------------

CREATE TABLE category (
    id          INTEGER PRIMARY KEY,
    code        TEXT    NOT NULL UNIQUE,          -- STATEMENT, COMMAND, FUNCTION, OPERATOR, ...
    name        TEXT    NOT NULL
) STRICT;

-- Operator classes (shared vocabulary, does not follow the layers). The
-- class belongs to the form: the same symbol can be arithmetic and string
-- (+), or bitwise, logical or conditional (AND) depending on the dialect.
CREATE TABLE operator_class (
    id          INTEGER PRIMARY KEY,
    code        TEXT    NOT NULL UNIQUE,          -- ARITHMETIC, BITWISE, CONDITIONAL, ...
    name        TEXT    NOT NULL,
    position    INTEGER NOT NULL DEFAULT 1,       -- display order
    description TEXT
) STRICT;

CREATE TABLE entry (
    id                INTEGER PRIMARY KEY,
    layer_id          INTEGER NOT NULL REFERENCES layer(id),
    name              TEXT    NOT NULL COLLATE NOCASE,  -- 'ON...GOTO', 'MID$'
    category_id       INTEGER NOT NULL REFERENCES category(id),
    operation         TEXT    NOT NULL DEFAULT 'ADD'
                      CHECK (operation IN ('ADD','REPLACE','REMOVE')),
    redefines_id      INTEGER REFERENCES entry(id),
    description       TEXT,
    difference_notes  TEXT,                       -- what changes from redefines_id
    notes             TEXT,
    UNIQUE (layer_id, name, category_id),
    CHECK (operation = 'ADD' OR redefines_id IS NOT NULL)
) STRICT;

-- Each form has its own syntax tree (syntax_node with form_id and
-- parent_id NULL = root). What changes the ACTION is a form of its own;
-- what only changes the way of writing is a choice inside the tree.
CREATE TABLE syntax_form (
    id                    INTEGER PRIMARY KEY,
    entry_id              INTEGER NOT NULL REFERENCES entry(id) ON DELETE CASCADE,
    position              INTEGER NOT NULL DEFAULT 1,
    title                 TEXT,                   -- 'Arc', 'Filled box'
    description           TEXT,
    original_syntax       TEXT,                   -- as written in the manual
    source_id             INTEGER REFERENCES source(id),
    page                  TEXT,
    -- returned value (functions, operators, system variables)
    return_type_id        INTEGER REFERENCES data_type(id),
    return_min            REAL,
    return_max            REAL,
    return_min_inclusive  INTEGER NOT NULL DEFAULT 1 CHECK (return_min_inclusive IN (0,1)),
    return_max_inclusive  INTEGER NOT NULL DEFAULT 1 CHECK (return_max_inclusive IN (0,1)),
    -- operators: precedence in the dialect (higher number = evaluated first,
    -- as in the manuals; e.g. ZX80: ** 10 ... OR 2). It belongs to the form
    -- because the same symbol can have different precedences (unary - 9,
    -- binary - 6).
    precedence            INTEGER CHECK (precedence IS NULL OR precedence >= 1),
    associativity         TEXT    CHECK (associativity IN ('LEFT','RIGHT')),  -- at equal precedence
    operator_class_id     INTEGER REFERENCES operator_class(id),
    UNIQUE (entry_id, position)
) STRICT;

-- Reusable sub-grammars (e.g. the coordinate pair of BASIC 7.0).
CREATE TABLE construct (
    id            INTEGER PRIMARY KEY,
    layer_id      INTEGER NOT NULL REFERENCES layer(id),
    code          TEXT    NOT NULL,               -- 'COORDINATE'
    name          TEXT    NOT NULL,
    description   TEXT,
    operation     TEXT    NOT NULL DEFAULT 'ADD'
                  CHECK (operation IN ('ADD','REPLACE','REMOVE')),
    redefines_id  INTEGER REFERENCES construct(id),
    UNIQUE (layer_id, code)
) STRICT;

-- ---------------------------------------------------------------------
-- 7. PARAMETERS (meaning: limits, conversion, error)
-- ---------------------------------------------------------------------
-- Three different notions of "type":
--  * data_type      the values (ZX80: integer [-32768, 32767], string)
--  * variable_kind  the variables (ZX80: numeric, string, numeric array, loop control)
--  * parameter_kind what is written for a parameter (numeric expression,
--                   string literal, numeric variable name, ...); it is set on
--                   each PARAMETER node of the syntax tree, so the same
--                   parameter can accept several kinds (choices in the tree).
-- The limits of the data type come from data_type; parameter_limit holds
-- the stricter limits imposed by the statement.

-- Parameter types of a dialect (they follow the layers): what can be
-- written where a parameter is expected.
--  LITERAL        literal of the type class (e.g. numeric literal, string literal)
--  EXPRESSION     expression of the type class
--  VARIABLE       name of a variable of variable_kind (NULL = any variable)
--  ARRAY_NAME     name of an array of variable_kind (e.g. DIM A(10): A)
--  ARRAY_ELEMENT  array element, name with subscripts (e.g. B(3))
--  FREE_TEXT      any text (e.g. after REM)
--  STATEMENT      a whole statement (e.g. after THEN)
--  CONDITION      expression reduced to a truth value (e.g. after IF): usually
--                 relational, its terms can also be strings (A$="Y"); the value
--                 is read with the dialect's truth test (features TRUE_VALUE,
--                 FALSE_VALUE, TRUTH_TEST) or is a native boolean
CREATE TABLE parameter_kind (
    id                INTEGER PRIMARY KEY,
    layer_id          INTEGER NOT NULL REFERENCES layer(id),
    code              TEXT    NOT NULL,           -- 'NUM_EXPR', 'STR_LITERAL', 'LOOP_VAR'
    name              TEXT    NOT NULL,
    nature            TEXT    NOT NULL CHECK (nature IN
                      ('LITERAL','EXPRESSION','CONDITION','VARIABLE','ARRAY_NAME',
                       'ARRAY_ELEMENT','FREE_TEXT','STATEMENT')),
    type_class_id     INTEGER REFERENCES type_class(id),      -- LITERAL, EXPRESSION, CONDITION
    variable_kind_id  INTEGER REFERENCES variable_kind(id),   -- VARIABLE, ARRAY_NAME, ARRAY_ELEMENT
    notes             TEXT,
    operation         TEXT    NOT NULL DEFAULT 'ADD'
                      CHECK (operation IN ('ADD','REPLACE','REMOVE')),
    redefines_id      INTEGER REFERENCES parameter_kind(id),
    UNIQUE (layer_id, code),
    CHECK (nature NOT IN ('LITERAL','EXPRESSION','CONDITION') OR type_class_id IS NOT NULL),
    CHECK (nature IN ('LITERAL','EXPRESSION','CONDITION') OR type_class_id IS NULL),
    CHECK (nature IN ('VARIABLE','ARRAY_NAME','ARRAY_ELEMENT') OR variable_kind_id IS NULL)
) STRICT;

CREATE TABLE parameter (
    id                 INTEGER PRIMARY KEY,
    form_id            INTEGER REFERENCES syntax_form(id) ON DELETE CASCADE,
    construct_id       INTEGER REFERENCES construct(id) ON DELETE CASCADE,
    name               TEXT    NOT NULL,          -- as shown in the syntax
    construct_type_id  INTEGER REFERENCES construct(id),    -- the parameter is a construct
    conversion         TEXT    NOT NULL DEFAULT 'NONE'
                       CHECK (conversion IN ('NONE','TRUNCATE','ROUND')),
    table_kind_id      INTEGER REFERENCES table_kind(id),   -- e.g. COLORS
    error_code         TEXT,                      -- error when out of range (error.code)
    -- line numbers: what happens when the line does not exist
    --   NEXT_LINE  the next existing line is used (ZX80 GO TO, LIST, ...)
    --   ERROR      an error is reported
    missing_line       TEXT    CHECK (missing_line IN ('NEXT_LINE','ERROR')),
    description        TEXT,
    CHECK ((form_id IS NULL) <> (construct_id IS NULL))
) STRICT;

CREATE TABLE parameter_limit (
    id             INTEGER PRIMARY KEY,
    parameter_id   INTEGER NOT NULL REFERENCES parameter(id) ON DELETE CASCADE,
    machine_id     INTEGER REFERENCES machine(id),
    minimum        REAL,
    maximum        REAL,
    min_inclusive  INTEGER NOT NULL DEFAULT 1 CHECK (min_inclusive IN (0,1)),
    max_inclusive  INTEGER NOT NULL DEFAULT 1 CHECK (max_inclusive IN (0,1)),
    notes          TEXT                           -- limits that depend on the context
) STRICT;

-- Discrete, non-contiguous values (e.g. SCREEN 0,1,2).
CREATE TABLE allowed_value (
    id            INTEGER PRIMARY KEY,
    parameter_id  INTEGER NOT NULL REFERENCES parameter(id) ON DELETE CASCADE,
    machine_id    INTEGER REFERENCES machine(id),
    value         TEXT    NOT NULL,
    meaning       TEXT
) STRICT;

-- ---------------------------------------------------------------------
-- 8. SYNTAX TREE (form: how it is written)
-- ---------------------------------------------------------------------
--  SEQUENCE   children one after the other
--  CHOICE     exactly one of the children                  < a | b >
--  OPTIONAL   optional content (one child)                 [ ... ]
--  REPEAT     one child repeated min..max times, with "separator"   ...
--  LIST       all children optional; the separator appears only between
--             present items (separator column, or a first node of the
--             child with only_if_preceded = 1, e.g. <ON | ,>)
--  LITERAL    literal text: , ; ( ) + - D U ...
--  KEYWORD    reference to keyword
--  PARAMETER  reference to parameter, written as parameter_kind (NULL only
--             when the parameter is a construct)
--  CONSTRUCT  inserts the tree of a construct
-- ---------------------------------------------------------------------

CREATE TABLE syntax_node (
    id                INTEGER PRIMARY KEY,
    form_id           INTEGER REFERENCES syntax_form(id) ON DELETE CASCADE,
    construct_id      INTEGER REFERENCES construct(id) ON DELETE CASCADE,
    parent_id         INTEGER REFERENCES syntax_node(id) ON DELETE CASCADE,
    position          INTEGER NOT NULL DEFAULT 1,
    kind              TEXT    NOT NULL CHECK (kind IN
                      ('SEQUENCE','CHOICE','OPTIONAL','REPEAT','LIST',
                       'LITERAL','KEYWORD','PARAMETER','CONSTRUCT')),
    text              TEXT,
    keyword_id        INTEGER REFERENCES keyword(id),
    parameter_id      INTEGER REFERENCES parameter(id),
    construct_ref_id  INTEGER REFERENCES construct(id),
    parameter_kind_id INTEGER REFERENCES parameter_kind(id),
    attached          INTEGER NOT NULL DEFAULT 0 CHECK (attached IN (0,1)),
    only_if_preceded  INTEGER NOT NULL DEFAULT 0 CHECK (only_if_preceded IN (0,1)),
    separator         TEXT,
    min_occ           INTEGER,
    max_occ           INTEGER,                    -- NULL = unlimited
    meaning           TEXT,                       -- e.g. '+' = relative position
    notes             TEXT,
    CHECK ((form_id IS NULL) <> (construct_id IS NULL)),
    CHECK (kind <> 'LITERAL'   OR text             IS NOT NULL),
    CHECK (kind <> 'KEYWORD'   OR keyword_id       IS NOT NULL),
    CHECK (kind <> 'PARAMETER' OR parameter_id     IS NOT NULL),
    CHECK (kind <> 'CONSTRUCT' OR construct_ref_id IS NOT NULL),
    CHECK (kind = 'PARAMETER' OR parameter_kind_id IS NULL),
    UNIQUE (parent_id, position)
) STRICT;
CREATE UNIQUE INDEX ux_root_form      ON syntax_node(form_id)      WHERE parent_id IS NULL AND form_id IS NOT NULL;
CREATE UNIQUE INDEX ux_root_construct ON syntax_node(construct_id) WHERE parent_id IS NULL AND construct_id IS NOT NULL;
CREATE INDEX ix_node_parent ON syntax_node(parent_id);

-- ---------------------------------------------------------------------
-- 9. ACTIONS (equivalences between dialects)
-- ---------------------------------------------------------------------

CREATE TABLE action_group (
    id          INTEGER PRIMARY KEY,
    code        TEXT    NOT NULL UNIQUE,          -- 'GRAPHICS', 'FLOW', 'SOUND'
    name        TEXT    NOT NULL
) STRICT;

CREATE TABLE action (
    id          INTEGER PRIMARY KEY,
    code        TEXT    NOT NULL UNIQUE,          -- 'PLOT_LINE'
    name        TEXT    NOT NULL,
    group_id    INTEGER REFERENCES action_group(id),
    description TEXT
) STRICT;

CREATE TABLE form_action (
    form_id     INTEGER NOT NULL REFERENCES syntax_form(id) ON DELETE CASCADE,
    action_id   INTEGER NOT NULL REFERENCES action(id),
    coverage    TEXT    NOT NULL DEFAULT 'FULL' CHECK (coverage IN ('FULL','PARTIAL')),
    notes       TEXT,                             -- e.g. 'relative coordinates'
    PRIMARY KEY (form_id, action_id)
) STRICT;

-- ---------------------------------------------------------------------
-- 10. MANUAL CONTENTS
-- ---------------------------------------------------------------------

-- Usage examples: ideally one or more for every entry.
CREATE TABLE example (
    id               INTEGER PRIMARY KEY,
    entry_id         INTEGER NOT NULL REFERENCES entry(id) ON DELETE CASCADE,
    form_id          INTEGER REFERENCES syntax_form(id),   -- form shown, if relevant
    machine_id       INTEGER REFERENCES machine(id),       -- machine, if relevant
    position         INTEGER NOT NULL DEFAULT 1,
    title            TEXT,
    description      TEXT,
    code             TEXT    NOT NULL,                     -- example code (one or more lines)
    expected_result  TEXT,                                 -- what appears on screen, or what happens
    -- 0 = to be verified (e.g. on an emulator); every example written by
    -- Claude starts at 0 and only the editor sets it to 1
    verified         INTEGER NOT NULL DEFAULT 0 CHECK (verified IN (0,1)),
    source_id        INTEGER REFERENCES source(id),        -- where the example comes from, if any
    page             TEXT
) STRICT;

-- OPENS_BLOCK: the entry opens, the related entry closes (FOR -> NEXT).
CREATE TABLE reference (
    entry_id          INTEGER NOT NULL REFERENCES entry(id) ON DELETE CASCADE,
    related_entry_id  INTEGER NOT NULL REFERENCES entry(id) ON DELETE CASCADE,
    kind              TEXT    NOT NULL DEFAULT 'SEE_ALSO'
                      CHECK (kind IN ('SEE_ALSO','OPENS_BLOCK')),
    PRIMARY KEY (entry_id, related_entry_id, kind)
) STRICT;

CREATE TABLE entry_source (
    entry_id   INTEGER NOT NULL REFERENCES entry(id) ON DELETE CASCADE,
    source_id  INTEGER NOT NULL REFERENCES source(id),
    page       TEXT,
    notes      TEXT,
    PRIMARY KEY (entry_id, source_id)
) STRICT;

-- =====================================================================
-- VIEWS: dialects rebuilt from their layers
-- =====================================================================

CREATE VIEW v_dialect_entry AS
WITH candidates AS (
    SELECT dl.dialect_id, e.id AS entry_id, e.layer_id, dl.position AS layer_position,
           e.name, e.category_id, e.operation,
           ROW_NUMBER() OVER (PARTITION BY dl.dialect_id, e.name, e.category_id
                              ORDER BY dl.position DESC) AS rn
    FROM dialect_layer dl
    JOIN entry e ON e.layer_id = dl.layer_id
)
SELECT dialect_id, entry_id, layer_id, layer_position, name, category_id
FROM candidates WHERE rn = 1 AND operation <> 'REMOVE';

CREATE VIEW v_dialect_keyword AS
WITH candidates AS (
    SELECT dl.dialect_id, k.id AS keyword_id, k.layer_id, k.text, k.operation,
           ROW_NUMBER() OVER (PARTITION BY dl.dialect_id, k.text
                              ORDER BY dl.position DESC) AS rn
    FROM dialect_layer dl
    JOIN keyword k ON k.layer_id = dl.layer_id
)
SELECT dialect_id, keyword_id, layer_id, text
FROM candidates WHERE rn = 1 AND operation <> 'REMOVE';

CREATE VIEW v_dialect_data_type AS
WITH candidates AS (
    SELECT dl.dialect_id, t.id AS data_type_id, t.layer_id, t.code, t.operation,
           ROW_NUMBER() OVER (PARTITION BY dl.dialect_id, t.code
                              ORDER BY dl.position DESC) AS rn
    FROM dialect_layer dl
    JOIN data_type t ON t.layer_id = dl.layer_id
)
SELECT dialect_id, data_type_id, layer_id, code
FROM candidates WHERE rn = 1 AND operation <> 'REMOVE';

CREATE VIEW v_dialect_error AS
WITH candidates AS (
    SELECT dl.dialect_id, e.id AS error_id, e.layer_id, e.code, e.operation,
           ROW_NUMBER() OVER (PARTITION BY dl.dialect_id, e.code
                              ORDER BY dl.position DESC) AS rn
    FROM dialect_layer dl
    JOIN error e ON e.layer_id = dl.layer_id
)
SELECT dialect_id, error_id, layer_id, code
FROM candidates WHERE rn = 1 AND operation <> 'REMOVE';

CREATE VIEW v_dialect_construct AS
WITH candidates AS (
    SELECT dl.dialect_id, c.id AS construct_id, c.layer_id, c.code, c.operation,
           ROW_NUMBER() OVER (PARTITION BY dl.dialect_id, c.code
                              ORDER BY dl.position DESC) AS rn
    FROM dialect_layer dl
    JOIN construct c ON c.layer_id = dl.layer_id
)
SELECT dialect_id, construct_id, layer_id, code
FROM candidates WHERE rn = 1 AND operation <> 'REMOVE';

CREATE VIEW v_dialect_feature AS
WITH candidates AS (
    SELECT dl.dialect_id, f.id AS feature_id, f.layer_id, f.code, f.value,
           f.operation,
           ROW_NUMBER() OVER (PARTITION BY dl.dialect_id, f.code
                              ORDER BY dl.position DESC) AS rn
    FROM dialect_layer dl
    JOIN feature f ON f.layer_id = dl.layer_id
)
SELECT dialect_id, feature_id, layer_id, code, value
FROM candidates WHERE rn = 1 AND operation <> 'REMOVE';

CREATE VIEW v_dialect_variable_kind AS
WITH candidates AS (
    SELECT dl.dialect_id, v.id AS variable_kind_id, v.layer_id, v.code, v.operation,
           ROW_NUMBER() OVER (PARTITION BY dl.dialect_id, v.code
                              ORDER BY dl.position DESC) AS rn
    FROM dialect_layer dl
    JOIN variable_kind v ON v.layer_id = dl.layer_id
)
SELECT dialect_id, variable_kind_id, layer_id, code
FROM candidates WHERE rn = 1 AND operation <> 'REMOVE';

CREATE VIEW v_dialect_parameter_kind AS
WITH candidates AS (
    SELECT dl.dialect_id, p.id AS parameter_kind_id, p.layer_id, p.code, p.operation,
           ROW_NUMBER() OVER (PARTITION BY dl.dialect_id, p.code
                              ORDER BY dl.position DESC) AS rn
    FROM dialect_layer dl
    JOIN parameter_kind p ON p.layer_id = dl.layer_id
)
SELECT dialect_id, parameter_kind_id, layer_id, code
FROM candidates WHERE rn = 1 AND operation <> 'REMOVE';

-- Effective token on each machine that hosts the dialect:
-- the machine-specific one first, then the general one.
CREATE VIEW v_machine_token AS
SELECT md.machine_id, k.dialect_id, k.keyword_id, k.text,
       COALESCE(
         (SELECT t.hex_value FROM token t
           WHERE t.keyword_id = k.keyword_id AND t.machine_id = md.machine_id),
         (SELECT t.hex_value FROM token t
           WHERE t.keyword_id = k.keyword_id AND t.machine_id IS NULL)
       ) AS hex_value
FROM machine_dialect md
JOIN v_dialect_keyword k ON k.dialect_id = md.dialect_id;

-- Effective glyphs of every character set, national variants included:
-- for each glyph number, the glyph of the nearest set in the chain
-- set -> base -> ...; source_charset_id tells which set it comes from.
CREATE VIEW v_effective_glyph AS
WITH RECURSIVE chain (charset_id, ancestor_id, distance) AS (
    SELECT id, id, 0 FROM charset
    UNION ALL
    SELECT c.charset_id, s.base_charset_id, c.distance + 1
    FROM chain c
    JOIN charset s ON s.id = c.ancestor_id
    WHERE s.base_charset_id IS NOT NULL AND c.distance < 16
),
candidates AS (
    SELECT c.charset_id, g.charset_id AS source_charset_id, g.code, g.bitmap,
           g.inverse_of, g.unicode, g.name, g.notes,
           ROW_NUMBER() OVER (PARTITION BY c.charset_id, g.code ORDER BY c.distance) AS rn
    FROM chain c
    JOIN glyph g ON g.charset_id = c.ancestor_id
)
SELECT charset_id, source_charset_id, code, bitmap, inverse_of, unicode, name, notes
FROM candidates WHERE rn = 1;

-- Character codes of a dialect rebuilt from its layers.
CREATE VIEW v_dialect_character_code AS
WITH candidates AS (
    SELECT dl.dialect_id, c.id AS character_code_id, c.layer_id, c.code, c.mode, c.operation,
           ROW_NUMBER() OVER (PARTITION BY dl.dialect_id, c.code, c.mode
                              ORDER BY dl.position DESC) AS rn
    FROM dialect_layer dl
    JOIN character_code c ON c.layer_id = dl.layer_id
)
SELECT dialect_id, character_code_id, layer_id, code, mode
FROM candidates WHERE rn = 1 AND operation <> 'REMOVE';

-- Keyboard codes, musical notes and program line layout of a dialect,
-- rebuilt from its layers.
CREATE VIEW v_dialect_key_code AS
WITH candidates AS (
    SELECT dl.dialect_id, k.id AS key_code_id, k.layer_id, k.operation,
           ROW_NUMBER() OVER (PARTITION BY dl.dialect_id, k.key, k.modifier, k.machine_id
                              ORDER BY dl.position DESC) AS rn
    FROM dialect_layer dl
    JOIN key_code k ON k.layer_id = dl.layer_id
)
SELECT dialect_id, key_code_id, layer_id FROM candidates WHERE rn = 1 AND operation <> 'REMOVE';

CREATE VIEW v_dialect_musical_note AS
WITH candidates AS (
    SELECT dl.dialect_id, n.id AS musical_note_id, n.layer_id, n.operation,
           ROW_NUMBER() OVER (PARTITION BY dl.dialect_id, n.note, n.octave, n.machine_id
                              ORDER BY dl.position DESC) AS rn
    FROM dialect_layer dl
    JOIN musical_note n ON n.layer_id = dl.layer_id
)
SELECT dialect_id, musical_note_id, layer_id FROM candidates WHERE rn = 1 AND operation <> 'REMOVE';

CREATE VIEW v_dialect_program_layout AS
WITH candidates AS (
    SELECT dl.dialect_id, p.id AS field_id, p.layer_id, p.position, p.operation,
           ROW_NUMBER() OVER (PARTITION BY dl.dialect_id, p.position
                              ORDER BY dl.position DESC) AS rn
    FROM dialect_layer dl
    JOIN program_layout_field p ON p.layer_id = dl.layer_id
)
SELECT dialect_id, field_id, layer_id, position FROM candidates WHERE rn = 1 AND operation <> 'REMOVE';

-- What each character code shows on each machine that hosts the dialect,
-- in each of its character sets: character code -> screen code -> glyph.
CREATE VIEW v_character AS
SELECT md.machine_id, md.dialect_id, s.id AS charset_id, s.code AS charset_code, s.language,
       c.code, c.mode, c.kind, c.screen_code, c.action, c.name AS code_name, c.notes AS code_notes,
       sc.glyph_code, sc.inverse,
       g.bitmap, g.unicode, g.name, g.inverse_of, g.source_charset_id,
       CASE WHEN c.kind = 'TOKEN' THEN
            (SELECT t.text FROM v_machine_token t
              WHERE t.machine_id = md.machine_id AND t.dialect_id = md.dialect_id
                AND t.hex_value = printf('%02X', c.code))
       END AS token_text
FROM machine_dialect md
JOIN v_dialect_character_code dc ON dc.dialect_id = md.dialect_id
JOIN character_code c            ON c.id = dc.character_code_id
JOIN charset s                   ON s.machine_id = md.machine_id
LEFT JOIN screen_code sc         ON sc.machine_id = md.machine_id AND sc.code = c.screen_code
LEFT JOIN v_effective_glyph g    ON g.charset_id = s.id AND g.code = sc.glyph_code;

-- Operator precedence of each dialect, highest first.
CREATE VIEW v_operator_precedence AS
SELECT de.dialect_id, de.entry_id, f.id AS form_id, de.name, f.title,
       f.precedence, f.associativity, f.operator_class_id
FROM v_dialect_entry de
JOIN syntax_form f ON f.entry_id = de.entry_id
WHERE f.precedence IS NOT NULL;

-- =====================================================================
-- VIEWS: the translator
-- =====================================================================

-- Pairs of forms of different dialects that share an action.
CREATE VIEW v_equivalence AS
SELECT fr.dialect_id AS from_dialect_id, fr.entry_id AS from_entry_id, fa.id AS from_form_id,
       t.dialect_id  AS to_dialect_id,   t.entry_id  AS to_entry_id,   fb.id AS to_form_id,
       xa.action_id,
       xa.coverage AS from_coverage, xb.coverage AS to_coverage
FROM v_dialect_entry fr
JOIN syntax_form fa  ON fa.entry_id = fr.entry_id
JOIN form_action xa  ON xa.form_id = fa.id
JOIN form_action xb  ON xb.action_id = xa.action_id
JOIN syntax_form fb  ON fb.id = xb.form_id
JOIN v_dialect_entry t ON t.entry_id = fb.entry_id
WHERE t.dialect_id <> fr.dialect_id;

-- Actions of a form that have no equivalent in the target dialect.
CREATE VIEW v_uncovered_action AS
SELECT fr.dialect_id AS from_dialect_id, fr.entry_id AS from_entry_id, fa.id AS from_form_id,
       d.id AS to_dialect_id, xa.action_id
FROM v_dialect_entry fr
JOIN syntax_form fa ON fa.entry_id = fr.entry_id
JOIN form_action xa ON xa.form_id = fa.id
JOIN dialect d      ON d.id <> fr.dialect_id
WHERE NOT EXISTS (
    SELECT 1
    FROM form_action xb
    JOIN syntax_form fb    ON fb.id = xb.form_id
    JOIN v_dialect_entry t ON t.entry_id = fb.entry_id AND t.dialect_id = d.id
    WHERE xb.action_id = xa.action_id
);
