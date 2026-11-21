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
 (13,'COMPARE','Comparisons');

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
 -- flow control
 (30,'FLOW_GOTO','Jump to a line',4,NULL),
 (31,'FLOW_GOSUB','Subroutine call',4,NULL),
 (32,'FLOW_RETURN','Return from subroutine',4,NULL),
 (33,'FLOW_IF','Conditional execution',4,NULL),
 (34,'FLOW_FOR','Start of a counted loop',4,'With start value, end value and step'),
 (35,'FLOW_NEXT','End of a counted loop',4,NULL),
 (36,'FLOW_STOP','Stop the program',4,NULL),
 (37,'FLOW_CONTINUE','Resume after a stop',4,NULL),
 -- program
 (40,'PROG_LIST','List the program',5,NULL),
 (41,'PROG_RUN','Run the program',5,NULL),
 (42,'PROG_NEW','Erase the program',5,NULL),
 (43,'PROG_REM','Comment',5,NULL),
 -- variables
 (50,'VAR_LET','Assignment',6,NULL),
 (51,'VAR_CLEAR','Clear all variables',6,NULL),
 (52,'VAR_DIM','Declare an array',6,'With one or more dimensions, of any type'),
 -- screen
 (60,'SCREEN_CLS','Clear the screen',7,NULL),
 -- memory
 (70,'MEM_POKE','Write a byte to memory',8,NULL),
 (71,'MEM_PEEK','Read a byte from memory',8,NULL),
 (72,'MEM_CALL','Call a machine code routine',8,NULL),
 -- tape
 (80,'TAPE_SAVE','Save the program',9,NULL),
 (81,'TAPE_LOAD','Load the program',9,NULL),
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
 -- strings
 (110,'STR_CHR','Character from its code',11,NULL),
 (111,'STR_CODE','Code of a character',11,NULL),
 (112,'STR_FROM_NUM','Number converted to a string',11,NULL),
 (113,'STR_SUBSTRING','Part of a string',11,'Extracts any substring'),
 -- logic and comparisons
 (120,'OP_NOT','Logical negation',12,NULL),
 (121,'OP_AND','Logical conjunction',12,NULL),
 (122,'OP_OR','Logical disjunction',12,NULL),
 (130,'OP_EQ','Equal',13,NULL),
 (131,'OP_GT','Greater than',13,NULL),
 (132,'OP_LT','Less than',13,NULL);

COMMIT;
