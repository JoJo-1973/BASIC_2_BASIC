-- =====================================================================
--  BASIC 2 BASIC - Base data
--  Vocabularies shared by all dialects: type classes, categories,
--  operator classes, table kinds (the tables that always exist), action
--  groups and actions.
--  Loaded by build_database.py right after schema.sql.
--  Action ids 1-9 and group ids 1-3 are also used by test_data.sql:
--  do not change them.
-- =====================================================================

PRAGMA foreign_keys = ON;
BEGIN;

INSERT INTO type_class (id, code, description) VALUES
 (1,'NUMERIC','Any numeric type'),
 (2,'INTEGER','Integers only'),
 (3,'REAL','Floating point'),
 (4,'STRING','Strings'),
 (5,'ANY','Any type'),
 (6,'BOOLEAN','Native boolean: TRUE or FALSE (few dialects; most use numbers, see the features TRUE_VALUE, FALSE_VALUE, TRUTH_TEST)');

INSERT INTO category (id, code, name) VALUES
 (1,'STATEMENT','Statement'),
 (2,'COMMAND','Direct command'),
 (3,'FUNCTION','Function'),
 (4,'OPERATOR','Operator'),
 (5,'SYSTEM_VARIABLE','System variable'),
 (6,'RESERVED_VARIABLE','Reserved variable');

INSERT INTO operator_class (id, code, name, position, description) VALUES
 (1,'ARITHMETIC','Arithmetic',1,'+, -, *, /, power, change of sign'),
 (2,'BITWISE','Bitwise',2,'AND, OR, NOT and similar when they work on single bits'),
 (3,'CONDITIONAL','Conditional',3,'With TRUE = -1 and FALSE = 0: TRUE AND e = e, FALSE AND e = FALSE, TRUE OR e = TRUE, FALSE OR e = e, NOT TRUE = FALSE, NOT FALSE = TRUE; in general NOT e = -e-1'),
 (4,'LOGICAL','Logical',4,'AND, OR, NOT when they work on boolean expressions'),
 (5,'MEMORY','Memory',5,'Direct memory access (e.g. ! ? $ in BBC BASIC)'),
 (6,'RELATIONAL','Relational',6,'Comparisons: =, <, >, <=, >=, <>'),
 (7,'STRING','String',7,'Concatenation (+ or &) and slicing (, or TO)'),
 (8,'GROUPING','Grouping',8,'Parentheses');

-- The tables that always exist (see table_status), in display order.
INSERT INTO table_kind (id, code, name, scope, position, description) VALUES
 (3,'GLYPHS','Glyphs','MACHINE',1,'Bitmaps of the character sets (tables charset, glyph)'),
 (4,'CHARACTER_CODES','Character codes','DIALECT',2,'ASCII, PETSCII, ATASCII, ...: what each code means (table character_code)'),
 (5,'SCREEN_CODES','Screen codes','MACHINE',3,'Values in video memory and the glyph they show (table screen_code)'),
 (6,'KEYBOARD_CODES','Keyboard codes','DIALECT',4,'Codes given by the keys, keywords entered by the keys (table key_code)'),
 (2,'ERRORS','Error messages','DIALECT',5,'Table error'),
 (7,'OPERATOR_PRECEDENCE','Operator precedence','DIALECT',6,'From syntax_form.precedence and associativity (view v_operator_precedence)'),
 (8,'VARIABLE_LAYOUT','Variables in memory','DIALECT',7,'Fields of each variable type (table variable_layout_field)'),
 (9,'PROGRAM_LAYOUT','Program in memory','DIALECT',8,'Fields of a program line (table program_layout_field)'),
 (1,'COLORS','Color codes and attributes','MACHINE',9,'Tables color and attribute'),
 (10,'MUSICAL_NOTES','Musical notes','DIALECT',10,'Value of each note in the sound statements (table musical_note)');

INSERT INTO action_group (id, code, name) VALUES
 (1,'GRAPHICS','Graphics'),
 (2,'IO','Input/output'),
 (3,'MATH','Mathematics'),
 (4,'FLOW','Flow control'),
 (5,'PROGRAM','Program management'),
 (6,'VARIABLES','Variables and arrays'),
 (7,'SCREEN','Screen'),
 (8,'MEMORY','Memory and machine code'),
 (9,'TAPE','Tape and disk'),
 (10,'RANDOM','Random numbers'),
 (11,'STRING','Strings'),
 (12,'LOGIC','Logical operators'),
 (13,'COMPARE','Comparisons'),
 (14,'MATRIX','Matrices'),
 (15,'FUNCTIONS','User functions'),
 (16,'SESSION','Session');

INSERT INTO action (id, code, name, group_id, description) VALUES
 (1,'PLOT_LINE','Draw a line',1,NULL),
 (2,'PLOT_ARC','Draw an arc',1,NULL),
 (3,'PLOT_RECT','Draw an empty rectangle',1,NULL),
 (4,'PLOT_BOX','Draw a filled rectangle',1,NULL),
 (5,'PLOT_CIRCLE','Draw a circle',1,NULL),
 (6,'PLOT_ELLIPSE','Draw an ellipse',1,NULL),
 (7,'DISK_DIRECTORY','Show the disk contents',9,NULL),
 (8,'IO_INPUT','Read values from the keyboard',2,NULL),
 (9,'MATH_SIN','Sine',3,NULL),
 -- input/output
 (20,'IO_PRINT','Write to the screen',2,NULL),
 (21,'IO_KEY','Read a key without waiting',2,'Gives the character of the key pressed, or nothing'),
 (22,'IO_FORMAT','Format of the displayed numbers',2,'Number of significant digits or decimal places'),
 (23,'IO_PRINTER','Send the output to the printer',2,NULL),
 (24,'IO_POSITION','Output from a given position',2,'Position of the next item on the display'),
 -- flow control
 (30,'FLOW_GOTO','Jump to a line',4,NULL),
 (31,'FLOW_GOSUB','Subroutine call',4,NULL),
 (32,'FLOW_RETURN','Return from subroutine',4,NULL),
 (33,'FLOW_IF','Conditional execution',4,NULL),
 (34,'FLOW_FOR','Start of a counted loop',4,'With start value, end value and step'),
 (35,'FLOW_NEXT','End of a counted loop',4,NULL),
 (36,'FLOW_STOP','Stop the program',4,NULL),
 (37,'FLOW_CONTINUE','Resume after a stop',4,NULL),
 (38,'FLOW_END','End the program',4,NULL),
 -- program
 (40,'PROG_LIST','List the program',5,NULL),
 (41,'PROG_RUN','Run the program',5,NULL),
 (42,'PROG_NEW','Erase the program',5,NULL),
 (43,'PROG_REM','Comment',5,NULL),
 -- variables
 (50,'VAR_LET','Assignment',6,NULL),
 (51,'VAR_CLEAR','Clear all variables',6,NULL),
 (52,'VAR_DIM','Declare an array',6,'With one or more dimensions, of any type'),
 (53,'VAR_RESERVE','Reserve memory for variables',6,'Turns program memory into variable memory'),
 -- screen
 (60,'SCREEN_CLS','Clear the screen',7,NULL),
 -- memory
 (70,'MEM_POKE','Write a byte to memory',8,NULL),
 (71,'MEM_PEEK','Read a byte from memory',8,NULL),
 (72,'MEM_CALL','Call a machine code routine',8,NULL),
 -- tape
 (80,'TAPE_SAVE','Save the program',9,NULL),
 (81,'TAPE_LOAD','Load the program',9,NULL),
 (82,'TAPE_VERIFY','Verify a recording',9,NULL),
 (83,'TAPE_SAVE_DATA','Save variables',9,NULL),
 (84,'TAPE_LOAD_DATA','Load variables',9,NULL),
 -- random numbers
 (90,'RND_SEED','Seed the random numbers',10,NULL),
 (91,'RND_VALUE','Random number',10,NULL),
 -- mathematics
 (100,'MATH_ABS','Absolute value',3,NULL),
 (101,'OP_POWER','Raise to a power',3,NULL),
 (102,'OP_NEG','Change of sign',3,NULL),
 (103,'OP_MUL','Multiplication',3,NULL),
 (104,'OP_DIV','Division',3,NULL),
 (105,'OP_ADD','Addition',3,NULL),
 (106,'OP_SUB','Subtraction',3,NULL),
 (107,'MATH_ANGLE_UNIT','Choose the angle unit',3,'Degrees, radians or gradians'),
 -- strings
 (110,'STR_CHR','Character from its code',11,NULL),
 (111,'STR_CODE','Code of a character',11,NULL),
 (112,'STR_FROM_NUM','Number converted to a string',11,NULL),
 (113,'STR_SUBSTRING','Part of a string',11,'Extracts any substring'),
 (114,'STR_LEN','Length of a string',11,NULL),
 (115,'STR_TO_NUM','String converted to a number',11,NULL),
 (116,'STR_CONCAT','Join two strings',11,NULL),
 -- logic and comparisons
 (120,'OP_NOT','Logical negation',12,NULL),
 (121,'OP_AND','Logical conjunction',12,NULL),
 (122,'OP_OR','Logical disjunction',12,NULL),
 (130,'OP_EQ','Equal (numbers)',13,'Comparison of two numbers; strings are OP_STR_EQ'),
 (131,'OP_GT','Greater than (numbers)',13,NULL),
 (132,'OP_LT','Less than (numbers)',13,NULL),
 (133,'OP_NE','Not equal (numbers)',13,NULL),
 (134,'OP_GE','Greater than or equal (numbers)',13,NULL),
 (135,'OP_LE','Less than or equal (numbers)',13,NULL),
 (136,'OP_STR_EQ','Equal (strings)',13,'Comparison of two strings: dialects whose relations take only numbers have no equivalent'),
 (137,'OP_STR_GT','Greater than (strings)',13,NULL),
 (138,'OP_STR_LT','Less than (strings)',13,NULL),
 (139,'OP_STR_NE','Not equal (strings)',13,NULL),
 -- more mathematics
 (140,'MATH_COS','Cosine',3,NULL),
 (141,'MATH_TAN','Tangent',3,NULL),
 (142,'MATH_ASN','Arc sine',3,NULL),
 (143,'MATH_ACS','Arc cosine',3,NULL),
 (144,'MATH_ATN','Arc tangent',3,NULL),
 (145,'MATH_SQR','Square root',3,NULL),
 (146,'MATH_EXP','Exponential',3,'e raised to a power'),
 (147,'MATH_LN','Natural logarithm',3,NULL),
 (148,'MATH_LOG','Common logarithm',3,NULL),
 (149,'MATH_INT','Integer part',3,'Largest integer not greater than the value'),
 (150,'MATH_FRAC','Fractional part',3,NULL),
 (151,'MATH_SGN','Sign',3,NULL),
 (152,'MATH_ROUND','Round to a given digit',3,NULL),
 (153,'MATH_PI','The constant pi',3,NULL),
 -- data in the program, user functions, more flow control (Dartmouth BASIC)
 (160,'DATA_READ','Read values from the data list',6,'Takes the next values of the DATA statements'),
 (161,'DATA_DEFINE','Data list in the program',6,'Values written in the program for READ'),
 (162,'DATA_RESTORE','Restart the data list',6,'The next READ takes the first value again'),
 (163,'FN_DEFINE','Define a function',15,NULL),
 (164,'FN_CALL','Call a user function',15,NULL),
 (165,'FN_END','End of a multi-line function',15,NULL),
 (166,'FLOW_ON_GOTO','Computed jump',4,'Jump to the n-th line of a list'),
 (167,'MATH_COT','Cotangent',3,NULL),
 (168,'STR_TO_CODES','String converted to character codes',11,'All the characters at once, e.g. into an array'),
 (169,'STR_FROM_CODES','String built from character codes',11,'All the characters at once, e.g. from an array'),
 -- program, disk and session
 (170,'PROG_BREAK','Interrupt the running program',5,NULL),
 (171,'PROG_RENAME','Rename the program',5,NULL),
 (172,'DISK_DELETE','Delete a saved program',9,NULL),
 (173,'SESSION_START','Start a session',16,'Sign on to a time-sharing system'),
 (174,'SESSION_END','End a session',16,NULL),
 (175,'PROG_LENGTH','Size of the program',5,NULL),
 (176,'SYSTEM_SELECT','Choose the language system',16,'e.g. BASIC or ALGOL on a time-sharing system'),
 (177,'IO_NEW_PAGE','Start a new page',2,'On a printer'),
 -- matrices
 (180,'MAT_READ','Read a matrix from the data list',14,NULL),
 (181,'MAT_PRINT','Print a matrix',14,NULL),
 (182,'MAT_INPUT','Read a matrix from the keyboard',14,NULL),
 (183,'MAT_ADD','Matrix addition',14,NULL),
 (184,'MAT_SUB','Matrix subtraction',14,NULL),
 (185,'MAT_MUL','Matrix multiplication',14,NULL),
 (186,'MAT_SCALAR','Multiply a matrix by a number',14,NULL),
 (187,'MAT_ZERO','Zero matrix',14,NULL),
 (188,'MAT_ONES','Matrix of ones',14,NULL),
 (189,'MAT_IDENTITY','Identity matrix',14,NULL),
 (190,'MAT_TRANSPOSE','Transpose of a matrix',14,NULL),
 (191,'MAT_INVERSE','Inverse of a matrix',14,NULL),
 (192,'MAT_COPY','Copy a matrix',14,NULL),
 (193,'MAT_DET','Determinant of a matrix',14,NULL),
 (194,'MAT_INPUT_COUNT','Number of values read by a matrix input',14,NULL),
 -- more comparisons and grouping
 (195,'OP_STR_GE','Greater than or equal (strings)',13,NULL),
 (196,'OP_STR_LE','Less than or equal (strings)',13,NULL),
 (197,'OP_GROUP','Evaluate first (parentheses)',3,'The expression in parentheses is computed before what surrounds it');

COMMIT;

-- Feature catalogue: the questions every dialect answers (table feature).
INSERT INTO feature_section (id, code, name, position) VALUES
 (1,'PROGRAM','Program lines and statements',1),
 (2,'TRUTH_VALUES','Truth values',2),
 (3,'NUMBERS','Numbers',3),
 (4,'LOOPS','FOR loops',4),
 (5,'KEYBOARD','Keyboard',5),
 (6,'OUTPUT','Screen output',6);

INSERT INTO feature_kind (id, code, section_id, position, name, answers, description) VALUES
 (1,'LINE_NUMBERS',1,1,'Range of line numbers','e.g. 1-9999, 0-63999',NULL),
 (2,'MULTIPLE_STATEMENTS',1,2,'Multiple statements per line','No / Yes',NULL),
 (3,'STATEMENT_SEPARATOR',1,3,'Statement separator','None / : / & / ::','Character written between two statements on the same line.'),
 (4,'LET',1,4,'LET keyword','Mandatory / Optional','Whether an assignment must start with LET.'),
 (5,'TRUE_VALUE',2,1,'Value produced by a true comparison','-1 / 1 / TRUE',NULL),
 (6,'FALSE_VALUE',2,2,'Value produced by a false comparison','0 / FALSE',NULL),
 (7,'TRUTH_TEST',2,3,'How a value used as a condition is read','NONZERO / ...','NONZERO: a number is true if it is not 0. Some dialects also read the empty string as false.'),
 (8,'INTEGER_CONVERSION',3,1,'Conversion of non-integer values to integers','e.g. Truncation towards zero','The algorithm used when a statement or an operator needs an integer and gets a non-integer value; implementations usually use the same one everywhere.'),
 (9,'FOR_RUNS_ONCE',4,1,'The body of a FOR loop is always executed at least once','Yes / No',NULL),
 (10,'FOR_VARIABLE_CHANGEABLE',4,2,'The loop variable can be changed inside the loop','Yes / No',NULL),
 (11,'MODAL_KEYBOARD',5,1,'Modal keyboard for entering keywords','Yes / No / Both','Yes: a key enters a whole keyword, depending on the current mode (e.g. the K cursor); Both: keywords can also be typed letter by letter.'),
 (12,'TAB_ZONE_WIDTH',6,1,'Width of the fixed tabulation zones','e.g. 8 columns, 10 columns','The separator that moves to the next zone is described in the PRINT entry.'),
 (13,'VARIABLE_TAB_STOPS',6,2,'Variable tab stops','No / Yes','Tab stops that can be set and changed (e.g. with control codes), alongside the fixed zones.');

-- Rules that link actions to the tables an entry uses (view v_entry_table_kind).
-- Transcoding -> character codes; variable assignment, creation and deletion
-- (also the FOR loop variable) -> variables in memory; jumps to program lines
-- (also RUN n, LIST n, CONTINUE, RETURN) and saving/loading programs (not
-- generic memory blocks) -> program in memory. Operators are found from their precedence;
-- colors, musical notes and redefined characters from parameter.table_kind_id.
INSERT INTO action_table_kind (action_id, table_kind_id)
SELECT a.id, k.id FROM action a JOIN table_kind k ON
     (a.code IN ('STR_CHR', 'STR_CODE') AND k.code = 'CHARACTER_CODES')
  OR (a.code IN ('VAR_LET', 'IO_INPUT', 'FLOW_FOR', 'FLOW_NEXT', 'VAR_DIM', 'VAR_CLEAR', 'DATA_READ')
      AND k.code = 'VARIABLE_LAYOUT')
  OR (a.code IN ('FLOW_GOTO', 'FLOW_GOSUB', 'FLOW_ON_GOTO', 'PROG_RUN', 'PROG_LIST', 'FLOW_CONTINUE', 'FLOW_RETURN',
                 'TAPE_SAVE', 'TAPE_LOAD') AND k.code = 'PROGRAM_LAYOUT');

-- Notes derived from the dialect features (view v_entry_feature_note).
INSERT INTO feature_note_rule (feature_kind_id, selector, selector_value, target)
SELECT k.id, r.selector, r.selector_value, r.target
FROM feature_kind k JOIN (
          SELECT 'LINE_NUMBERS' AS code, 'LINE_PARAMETER' AS selector, NULL AS selector_value, 'ALLOWED' AS target
    UNION ALL SELECT 'LET', 'ACTION', 'VAR_LET', 'NOTE'
    UNION ALL SELECT 'TRUE_VALUE', 'OPERATOR_CLASS', 'RELATIONAL', 'RETURN'
    UNION ALL SELECT 'FALSE_VALUE', 'OPERATOR_CLASS', 'RELATIONAL', 'RETURN'
    UNION ALL SELECT 'TRUE_VALUE', 'OPERATOR_CLASS', 'LOGICAL', 'RETURN'
    UNION ALL SELECT 'FALSE_VALUE', 'OPERATOR_CLASS', 'LOGICAL', 'RETURN'
    UNION ALL SELECT 'TRUTH_TEST', 'OPERATOR_CLASS', 'LOGICAL', 'NOTE'
    UNION ALL SELECT 'TRUE_VALUE', 'OPERATOR_CLASS', 'CONDITIONAL', 'RETURN'
    UNION ALL SELECT 'FALSE_VALUE', 'OPERATOR_CLASS', 'CONDITIONAL', 'RETURN'
    UNION ALL SELECT 'TRUTH_TEST', 'OPERATOR_CLASS', 'CONDITIONAL', 'NOTE'
    UNION ALL SELECT 'TRUE_VALUE', 'OPERATOR_CLASS', 'BITWISE', 'NOTE'
    UNION ALL SELECT 'FALSE_VALUE', 'OPERATOR_CLASS', 'BITWISE', 'NOTE'
    UNION ALL SELECT 'TRUTH_TEST', 'OPERATOR_CLASS', 'BITWISE', 'NOTE'
    UNION ALL SELECT 'TRUTH_TEST', 'PARAMETER_NATURE', 'CONDITION', 'ALLOWED'
    UNION ALL SELECT 'FOR_RUNS_ONCE', 'ACTION', 'FLOW_FOR', 'NOTE'
    UNION ALL SELECT 'FOR_VARIABLE_CHANGEABLE', 'ACTION', 'FLOW_FOR', 'NOTE'
    UNION ALL SELECT 'FOR_RUNS_ONCE', 'ACTION', 'FLOW_NEXT', 'NOTE'
    UNION ALL SELECT 'FOR_VARIABLE_CHANGEABLE', 'ACTION', 'FLOW_NEXT', 'NOTE'
    UNION ALL SELECT 'TAB_ZONE_WIDTH', 'ACTION', 'IO_PRINT', 'NOTE'
    UNION ALL SELECT 'VARIABLE_TAB_STOPS', 'ACTION', 'IO_PRINT', 'NOTE'
) r ON r.code = k.code;
