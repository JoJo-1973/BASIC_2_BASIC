-- =====================================================================
--  BASIC 2 BASIC - Test data
--  Used to test the schema (layers, translator, syntax tree).
--  These are NOT encyclopedia data: years, limits and tokens must be
--  checked against the sources before they are considered final.
--
--  Requires data/base.sql. Loaded with:  python build_database.py --test
-- =====================================================================

PRAGMA foreign_keys = ON;
BEGIN;

-- machine
INSERT INTO machine (id, code, name, manufacturer, year, cpu) VALUES (1, 'PET2001', 'PET 2001', 'Commodore', 1977, '6502');
INSERT INTO machine (id, code, name, manufacturer, year, cpu) VALUES (2, 'C64', 'Commodore 64', 'Commodore', 1982, '6510');
INSERT INTO machine (id, code, name, manufacturer, year, cpu) VALUES (3, 'C128', 'Commodore 128', 'Commodore', 1985, '8502 + Z80');
INSERT INTO machine (id, code, name, manufacturer, year, cpu) VALUES (4, 'ZX_SPECTRUM_48K', 'ZX Spectrum 48K', 'Sinclair', 1982, 'Z80A');
INSERT INTO machine (id, code, name, manufacturer, year, cpu) VALUES (5, 'IBM_PC', 'IBM PC and compatibles', 'IBM', 1981, '8088');

-- dialect
INSERT INTO dialect (id, code, name, version) VALUES (1, 'CBM_BASIC_1.0', 'Commodore BASIC', '1.0');
INSERT INTO dialect (id, code, name, version) VALUES (2, 'CBM_BASIC_2.0', 'Commodore BASIC', '2.0');
INSERT INTO dialect (id, code, name) VALUES (3, 'SIMONS_BASIC', 'Simons'' BASIC');
INSERT INTO dialect (id, code, name, version) VALUES (4, 'CBM_BASIC_7.0', 'Commodore BASIC', '7.0');
INSERT INTO dialect (id, code, name) VALUES (5, 'SINCLAIR_BASIC_48K', 'Sinclair BASIC (48K)');
INSERT INTO dialect (id, code, name) VALUES (6, 'GW_BASIC', 'GW-BASIC');

-- machine_dialect
INSERT INTO machine_dialect (machine_id, dialect_id, medium, is_default) VALUES (1, 1, 'ROM', 1);
INSERT INTO machine_dialect (machine_id, dialect_id, medium, is_default) VALUES (2, 2, 'ROM', 1);
INSERT INTO machine_dialect (machine_id, dialect_id, medium, is_default) VALUES (2, 3, 'CARTRIDGE', 0);
INSERT INTO machine_dialect (machine_id, dialect_id, medium, is_default) VALUES (3, 4, 'ROM', 1);
INSERT INTO machine_dialect (machine_id, dialect_id, medium, is_default, notes) VALUES (3, 2, 'ROM', 0, 'C64 mode');
INSERT INTO machine_dialect (machine_id, dialect_id, medium, is_default) VALUES (4, 5, 'ROM', 1);
INSERT INTO machine_dialect (machine_id, dialect_id, medium, is_default) VALUES (5, 6, 'DISK', 1);

-- layer
INSERT INTO layer (id, code, name, kind) VALUES (1, 'BASIC_1.0_core', 'Commodore BASIC 1.0', 'CORE');
INSERT INTO layer (id, code, name, kind) VALUES (2, 'BASIC_2.0_layer', 'BASIC 2.0 differences', 'LAYER');
INSERT INTO layer (id, code, name, kind) VALUES (3, 'Simons_BASIC_layer', 'Simons'' BASIC extensions', 'LAYER');
INSERT INTO layer (id, code, name, kind) VALUES (4, 'BASIC_3.5_layer', 'BASIC 3.5 extensions', 'LAYER');
INSERT INTO layer (id, code, name, kind) VALUES (5, 'BASIC_7.0_layer', 'BASIC 7.0 extensions', 'LAYER');
INSERT INTO layer (id, code, name, kind) VALUES (6, 'Sinclair_48K_core', 'Sinclair BASIC 48K', 'CORE');
INSERT INTO layer (id, code, name, kind) VALUES (7, 'GW-BASIC_core', 'GW-BASIC', 'CORE');

-- dialect_layer
INSERT INTO dialect_layer (dialect_id, layer_id, position) VALUES (1, 1, 1);
INSERT INTO dialect_layer (dialect_id, layer_id, position) VALUES (2, 1, 1);
INSERT INTO dialect_layer (dialect_id, layer_id, position) VALUES (2, 2, 2);
INSERT INTO dialect_layer (dialect_id, layer_id, position) VALUES (3, 1, 1);
INSERT INTO dialect_layer (dialect_id, layer_id, position) VALUES (3, 2, 2);
INSERT INTO dialect_layer (dialect_id, layer_id, position) VALUES (3, 3, 3);
INSERT INTO dialect_layer (dialect_id, layer_id, position) VALUES (4, 1, 1);
INSERT INTO dialect_layer (dialect_id, layer_id, position) VALUES (4, 2, 2);
INSERT INTO dialect_layer (dialect_id, layer_id, position) VALUES (4, 4, 3);
INSERT INTO dialect_layer (dialect_id, layer_id, position) VALUES (4, 5, 4);
INSERT INTO dialect_layer (dialect_id, layer_id, position) VALUES (5, 6, 1);
INSERT INTO dialect_layer (dialect_id, layer_id, position) VALUES (6, 7, 1);

-- feature
INSERT INTO feature (id, layer_id, feature_kind_id, value, operation, notes) VALUES (1, 1, 2, 'Yes', 'ADD', NULL);
INSERT INTO feature (id, layer_id, feature_kind_id, value, operation, notes) VALUES (2, 1, 3, ':', 'ADD', NULL);

-- data_type
INSERT INTO data_type (id, layer_id, code, name, type_class_id, minimum, maximum, bytes, operation) VALUES (1, 1, 'FLOAT5', 'Real', 3, -1.70141183e+38, 1.70141183e+38, 5, 'ADD');
INSERT INTO data_type (id, layer_id, code, name, suffix, type_class_id, minimum, maximum, bytes, operation) VALUES (2, 1, 'INT16', 'Integer', '%', 2, -32768.0, 32767.0, 2, 'ADD');
INSERT INTO data_type (id, layer_id, code, name, suffix, type_class_id, max_length, operation) VALUES (3, 1, 'STRING', 'String', '$', 4, 255, 'ADD');
INSERT INTO data_type (id, layer_id, code, name, type_class_id, bytes, operation) VALUES (10, 6, 'NUMBER', 'Number', 3, 5, 'ADD');
INSERT INTO data_type (id, layer_id, code, name, suffix, type_class_id, operation) VALUES (11, 6, 'STRING', 'String', '$', 4, 'ADD');
INSERT INTO data_type (id, layer_id, code, name, suffix, type_class_id, bytes, operation) VALUES (20, 7, 'SINGLE', 'Single precision', '!', 3, 4, 'ADD');
INSERT INTO data_type (id, layer_id, code, name, suffix, type_class_id, bytes, operation) VALUES (21, 7, 'DOUBLE', 'Double precision', '#', 3, 8, 'ADD');
INSERT INTO data_type (id, layer_id, code, name, suffix, type_class_id, minimum, maximum, bytes, operation) VALUES (22, 7, 'INTEGER', 'Integer', '%', 2, -32768.0, 32767.0, 2, 'ADD');
INSERT INTO data_type (id, layer_id, code, name, suffix, type_class_id, max_length, operation) VALUES (23, 7, 'STRING', 'String', '$', 4, 255, 'ADD');

-- parameter_kind (minimal set for the test data)
INSERT INTO parameter_kind (id, layer_id, code, name, nature, type_class_id) VALUES (1, 1, 'NUM_LITERAL', 'Numeric literal', 'LITERAL', 1);
INSERT INTO parameter_kind (id, layer_id, code, name, nature, type_class_id) VALUES (2, 1, 'STR_LITERAL', 'String literal', 'LITERAL', 4);
INSERT INTO parameter_kind (id, layer_id, code, name, nature, type_class_id) VALUES (3, 1, 'NUM_EXPR', 'Numeric expression', 'EXPRESSION', 1);
INSERT INTO parameter_kind (id, layer_id, code, name, nature, type_class_id) VALUES (4, 1, 'STR_EXPR', 'String expression', 'EXPRESSION', 4);
INSERT INTO parameter_kind (id, layer_id, code, name, nature) VALUES (5, 1, 'VAR', 'Variable name', 'VARIABLE');
INSERT INTO parameter_kind (id, layer_id, code, name, nature, type_class_id) VALUES (6, 6, 'NUM_LITERAL', 'Numeric literal', 'LITERAL', 1);
INSERT INTO parameter_kind (id, layer_id, code, name, nature, type_class_id) VALUES (7, 6, 'STR_LITERAL', 'String literal', 'LITERAL', 4);
INSERT INTO parameter_kind (id, layer_id, code, name, nature, type_class_id) VALUES (8, 6, 'NUM_EXPR', 'Numeric expression', 'EXPRESSION', 1);
INSERT INTO parameter_kind (id, layer_id, code, name, nature, type_class_id) VALUES (9, 6, 'STR_EXPR', 'String expression', 'EXPRESSION', 4);
INSERT INTO parameter_kind (id, layer_id, code, name, nature) VALUES (10, 6, 'VAR', 'Variable name', 'VARIABLE');
INSERT INTO parameter_kind (id, layer_id, code, name, nature, type_class_id) VALUES (11, 7, 'NUM_LITERAL', 'Numeric literal', 'LITERAL', 1);
INSERT INTO parameter_kind (id, layer_id, code, name, nature, type_class_id) VALUES (12, 7, 'STR_LITERAL', 'String literal', 'LITERAL', 4);
INSERT INTO parameter_kind (id, layer_id, code, name, nature, type_class_id) VALUES (13, 7, 'NUM_EXPR', 'Numeric expression', 'EXPRESSION', 1);
INSERT INTO parameter_kind (id, layer_id, code, name, nature, type_class_id) VALUES (14, 7, 'STR_EXPR', 'String expression', 'EXPRESSION', 4);
INSERT INTO parameter_kind (id, layer_id, code, name, nature) VALUES (15, 7, 'VAR', 'Variable name', 'VARIABLE');

-- keyword
INSERT INTO keyword (id, layer_id, text, operation) VALUES (1, 1, 'PRINT', 'ADD');
INSERT INTO keyword (id, layer_id, text, operation) VALUES (2, 1, 'GOTO', 'ADD');
INSERT INTO keyword (id, layer_id, text, operation) VALUES (3, 1, 'TO', 'ADD');
INSERT INTO keyword (id, layer_id, text, operation) VALUES (4, 1, 'ON', 'ADD');
INSERT INTO keyword (id, layer_id, text, operation) VALUES (5, 1, 'FOR', 'ADD');
INSERT INTO keyword (id, layer_id, text, operation) VALUES (6, 1, 'NEXT', 'ADD');
INSERT INTO keyword (id, layer_id, text, operation) VALUES (7, 1, 'STEP', 'ADD');
INSERT INTO keyword (id, layer_id, text, operation) VALUES (8, 1, 'INPUT', 'ADD');
INSERT INTO keyword (id, layer_id, text, operation) VALUES (9, 1, 'SIN', 'ADD');
INSERT INTO keyword (id, layer_id, text, operation) VALUES (20, 6, 'DRAW', 'ADD');
INSERT INTO keyword (id, layer_id, text, operation) VALUES (21, 6, 'CIRCLE', 'ADD');
INSERT INTO keyword (id, layer_id, text, operation) VALUES (22, 6, 'PLOT', 'ADD');
INSERT INTO keyword (id, layer_id, text, operation) VALUES (23, 6, 'GO TO', 'ADD');
INSERT INTO keyword (id, layer_id, text, operation) VALUES (30, 7, 'LINE', 'ADD');
INSERT INTO keyword (id, layer_id, text, operation) VALUES (31, 7, 'CIRCLE', 'ADD');
INSERT INTO keyword (id, layer_id, text, operation) VALUES (32, 7, 'INPUT', 'ADD');
INSERT INTO keyword (id, layer_id, text, operation) VALUES (40, 4, 'BOX', 'ADD');
INSERT INTO keyword (id, layer_id, text, operation) VALUES (41, 4, 'DIRECTORY', 'ADD');

-- token
INSERT INTO token (id, keyword_id, hex_value) VALUES (1, 1, '99');
INSERT INTO token (id, keyword_id, hex_value) VALUES (2, 2, '89');
INSERT INTO token (id, keyword_id, hex_value) VALUES (3, 3, 'A4');
INSERT INTO token (id, keyword_id, hex_value) VALUES (4, 4, '91');
INSERT INTO token (id, keyword_id, hex_value) VALUES (5, 5, '81');
INSERT INTO token (id, keyword_id, hex_value) VALUES (6, 6, '82');
INSERT INTO token (id, keyword_id, hex_value) VALUES (7, 7, 'A9');
INSERT INTO token (id, keyword_id, hex_value) VALUES (8, 8, '85');
INSERT INTO token (id, keyword_id, hex_value) VALUES (9, 9, 'BF');
INSERT INTO token (id, keyword_id, hex_value) VALUES (10, 20, 'FC');
INSERT INTO token (id, keyword_id, hex_value) VALUES (11, 21, 'D8');
INSERT INTO token (id, keyword_id, hex_value) VALUES (12, 22, 'F6');
INSERT INTO token (id, keyword_id, hex_value) VALUES (13, 23, 'EC');

-- abbreviation
INSERT INTO abbreviation (id, keyword_id, text) VALUES (1, 1, '?');
INSERT INTO abbreviation (id, keyword_id, text) VALUES (2, 2, 'G{SHIFT}O');

-- error
INSERT INTO error (id, layer_id, code, message, operation) VALUES (1, 1, 'ILLEGAL_QUANTITY', 'ILLEGAL QUANTITY', 'ADD');

-- entry
INSERT INTO entry (id, layer_id, name, category_id, operation, description) VALUES (1, 1, 'PRINT', 1, 'ADD', 'Prints on the screen');
INSERT INTO entry (id, layer_id, name, category_id, operation, description) VALUES (2, 1, 'FOR...TO...STEP', 1, 'ADD', 'Start of a loop');
INSERT INTO entry (id, layer_id, name, category_id, operation, description) VALUES (3, 1, 'NEXT', 1, 'ADD', 'End of a loop');
INSERT INTO entry (id, layer_id, name, category_id, operation, description) VALUES (5, 1, 'SIN', 3, 'ADD', 'Sine of an angle in radians');
INSERT INTO entry (id, layer_id, name, category_id, operation, description) VALUES (10, 6, 'DRAW', 1, 'ADD', 'Draws a line or an arc from the current position');
INSERT INTO entry (id, layer_id, name, category_id, operation, description) VALUES (11, 6, 'CIRCLE', 1, 'ADD', 'Draws a circle');
INSERT INTO entry (id, layer_id, name, category_id, operation, description) VALUES (20, 7, 'LINE', 1, 'ADD', 'Draws lines and rectangles');
INSERT INTO entry (id, layer_id, name, category_id, operation, description) VALUES (21, 7, 'CIRCLE', 1, 'ADD', 'Draws circles, arcs and ellipses');
INSERT INTO entry (id, layer_id, name, category_id, operation, description) VALUES (25, 7, 'INPUT', 1, 'ADD', 'Reads values from the keyboard');
INSERT INTO entry (id, layer_id, name, category_id, operation, description) VALUES (30, 4, 'BOX', 1, 'ADD', 'Draws a rectangle, optionally rotated and filled');
INSERT INTO entry (id, layer_id, name, category_id, operation, description) VALUES (31, 4, 'DIRECTORY', 2, 'ADD', 'Shows the disk contents');

-- syntax_form
INSERT INTO syntax_form (id, entry_id, position, original_syntax, return_type_id, return_min, return_max, return_min_inclusive, return_max_inclusive) VALUES (51, 5, 1, 'SIN(x)', 1, -1.0, 1.0, 1, 1);
INSERT INTO syntax_form (id, entry_id, position, title, original_syntax, return_min_inclusive, return_max_inclusive) VALUES (101, 10, 1, 'Line', 'DRAW x,y', 1, 1);
INSERT INTO syntax_form (id, entry_id, position, title, original_syntax, return_min_inclusive, return_max_inclusive) VALUES (102, 10, 2, 'Arc', 'DRAW x,y,a', 1, 1);
INSERT INTO syntax_form (id, entry_id, position, title, original_syntax, return_min_inclusive, return_max_inclusive) VALUES (111, 11, 1, 'Circle', 'CIRCLE x,y,r', 1, 1);
INSERT INTO syntax_form (id, entry_id, position, title, original_syntax, return_min_inclusive, return_max_inclusive) VALUES (201, 20, 1, 'Line', 'LINE [(x1,y1)]-(x2,y2)[,color]', 1, 1);
INSERT INTO syntax_form (id, entry_id, position, title, original_syntax, return_min_inclusive, return_max_inclusive) VALUES (202, 20, 2, 'Rectangle', 'LINE [(x1,y1)]-(x2,y2),[color],B', 1, 1);
INSERT INTO syntax_form (id, entry_id, position, title, original_syntax, return_min_inclusive, return_max_inclusive) VALUES (203, 20, 3, 'Filled rectangle', 'LINE [(x1,y1)]-(x2,y2),[color],BF', 1, 1);
INSERT INTO syntax_form (id, entry_id, position, title, original_syntax, return_min_inclusive, return_max_inclusive) VALUES (211, 21, 1, 'Circle', 'CIRCLE (x,y),r[,color]', 1, 1);
INSERT INTO syntax_form (id, entry_id, position, title, original_syntax, return_min_inclusive, return_max_inclusive) VALUES (212, 21, 2, 'Arc', 'CIRCLE (x,y),r,[color],start,end', 1, 1);
INSERT INTO syntax_form (id, entry_id, position, title, original_syntax, return_min_inclusive, return_max_inclusive) VALUES (213, 21, 3, 'Ellipse', 'CIRCLE (x,y),r,[color],[start],[end],aspect', 1, 1);
INSERT INTO syntax_form (id, entry_id, position, original_syntax, return_min_inclusive, return_max_inclusive) VALUES (251, 25, 1, 'INPUT[;]["prompt";] variable[,variable]...', 1, 1);
INSERT INTO syntax_form (id, entry_id, position, original_syntax, return_min_inclusive, return_max_inclusive) VALUES (301, 30, 1, 'BOX [color source], X1, Y1[,X2,Y2][,[angle][,paint]]', 1, 1);
INSERT INTO syntax_form (id, entry_id, position, original_syntax, return_min_inclusive, return_max_inclusive) VALUES (311, 31, 1, 'DIRECTORY [Ddrive][<ON | ,> Udevice number] [,wildcard]', 1, 1);

-- construct
INSERT INTO construct (id, layer_id, code, name, description, operation) VALUES (31, 4, 'COORDINATE', 'Coordinate pair', 'Absolute, relative on one or both axes, or polar relative to the graphics cursor', 'ADD');

-- parameter
INSERT INTO parameter (id, form_id, name, conversion) VALUES (511, 51, 'x', 'NONE');
INSERT INTO parameter (id, form_id, name, conversion) VALUES (1011, 101, 'x', 'ROUND');
INSERT INTO parameter (id, form_id, name, conversion) VALUES (1012, 101, 'y', 'ROUND');
INSERT INTO parameter (id, form_id, name, conversion) VALUES (1021, 102, 'x', 'ROUND');
INSERT INTO parameter (id, form_id, name, conversion) VALUES (1022, 102, 'y', 'ROUND');
INSERT INTO parameter (id, form_id, name, conversion) VALUES (1023, 102, 'a', 'NONE');
INSERT INTO parameter (id, form_id, name, conversion, description) VALUES (2511, 251, '"prompt"', 'NONE', 'Message; with a comma no question mark appears');
INSERT INTO parameter (id, form_id, name, conversion, description) VALUES (2512, 251, 'variable', 'NONE', 'Simple variable or array element');
INSERT INTO parameter (id, form_id, name, conversion, error_code, description) VALUES (3011, 301, 'color source', 'TRUNCATE', 'ILLEGAL_QUANTITY', '0 background, 1 foreground, 2 multicolor 1, 3 multicolor 2');
INSERT INTO parameter (id, form_id, name, construct_type_id, conversion, description) VALUES (3012, 301, 'X1,Y1', 31, 'NONE', 'First corner');
INSERT INTO parameter (id, form_id, name, construct_type_id, conversion, description) VALUES (3013, 301, 'X2,Y2', 31, 'NONE', 'Opposite corner (default: graphics cursor)');
INSERT INTO parameter (id, form_id, name, conversion, description) VALUES (3014, 301, 'angle', 'NONE', 'Rotation in degrees');
INSERT INTO parameter (id, form_id, name, conversion, error_code, description) VALUES (3015, 301, 'paint', 'TRUNCATE', 'ILLEGAL_QUANTITY', '0 empty, 1 filled');
INSERT INTO parameter (id, construct_id, name, conversion) VALUES (3111, 31, 'x', 'TRUNCATE');
INSERT INTO parameter (id, construct_id, name, conversion) VALUES (3112, 31, 'y', 'TRUNCATE');
INSERT INTO parameter (id, construct_id, name, conversion) VALUES (3113, 31, 'distance', 'TRUNCATE');
INSERT INTO parameter (id, construct_id, name, conversion) VALUES (3114, 31, 'angle', 'NONE');
INSERT INTO parameter (id, form_id, name, conversion, description) VALUES (3121, 311, 'drive', 'TRUNCATE', 'Drive number');
INSERT INTO parameter (id, form_id, name, conversion, description) VALUES (3122, 311, 'device number', 'TRUNCATE', 'Device number');
INSERT INTO parameter (id, form_id, name, conversion, description) VALUES (3123, 311, 'wildcard', 'NONE', 'File name mask');

-- parameter_limit
INSERT INTO parameter_limit (id, parameter_id, minimum, maximum, min_inclusive, max_inclusive) VALUES (1, 3011, 0.0, 3.0, 1, 1);
INSERT INTO parameter_limit (id, parameter_id, minimum, maximum, min_inclusive, max_inclusive) VALUES (2, 3015, 0.0, 1.0, 1, 1);
INSERT INTO parameter_limit (id, parameter_id, minimum, maximum, min_inclusive, max_inclusive) VALUES (3, 3121, 0.0, 1.0, 1, 1);
INSERT INTO parameter_limit (id, parameter_id, minimum, maximum, min_inclusive, max_inclusive) VALUES (4, 3122, 8.0, 11.0, 1, 1);

-- syntax_node
INSERT INTO syntax_node (id, form_id, position, kind, attached, only_if_preceded) VALUES (501, 51, 1, 'SEQUENCE', 0, 0);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, keyword_id, attached, only_if_preceded) VALUES (502, 51, 501, 1, 'KEYWORD', 9, 0, 0);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, text, attached, only_if_preceded) VALUES (503, 51, 501, 2, 'LITERAL', '(', 1, 0);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, parameter_id, attached, only_if_preceded, parameter_kind_id) VALUES (504, 51, 501, 3, 'PARAMETER', 511, 1, 0, 3);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, text, attached, only_if_preceded) VALUES (505, 51, 501, 4, 'LITERAL', ')', 1, 0);
INSERT INTO syntax_node (id, form_id, position, kind, attached, only_if_preceded) VALUES (1001, 101, 1, 'SEQUENCE', 0, 0);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, keyword_id, attached, only_if_preceded) VALUES (1002, 101, 1001, 1, 'KEYWORD', 20, 0, 0);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, parameter_id, attached, only_if_preceded, parameter_kind_id) VALUES (1003, 101, 1001, 2, 'PARAMETER', 1011, 0, 0, 8);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, text, attached, only_if_preceded) VALUES (1004, 101, 1001, 3, 'LITERAL', ',', 1, 0);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, parameter_id, attached, only_if_preceded, parameter_kind_id) VALUES (1005, 101, 1001, 4, 'PARAMETER', 1012, 1, 0, 8);
INSERT INTO syntax_node (id, form_id, position, kind, attached, only_if_preceded) VALUES (1011, 102, 1, 'SEQUENCE', 0, 0);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, keyword_id, attached, only_if_preceded) VALUES (1012, 102, 1011, 1, 'KEYWORD', 20, 0, 0);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, parameter_id, attached, only_if_preceded, parameter_kind_id) VALUES (1013, 102, 1011, 2, 'PARAMETER', 1021, 0, 0, 8);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, text, attached, only_if_preceded) VALUES (1014, 102, 1011, 3, 'LITERAL', ',', 1, 0);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, parameter_id, attached, only_if_preceded, parameter_kind_id) VALUES (1015, 102, 1011, 4, 'PARAMETER', 1022, 1, 0, 8);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, text, attached, only_if_preceded) VALUES (1016, 102, 1011, 5, 'LITERAL', ',', 1, 0);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, parameter_id, attached, only_if_preceded, parameter_kind_id) VALUES (1017, 102, 1011, 6, 'PARAMETER', 1023, 1, 0, 8);
INSERT INTO syntax_node (id, form_id, position, kind, attached, only_if_preceded) VALUES (2501, 251, 1, 'SEQUENCE', 0, 0);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, keyword_id, attached, only_if_preceded) VALUES (2502, 251, 2501, 1, 'KEYWORD', 32, 0, 0);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, only_if_preceded) VALUES (2503, 251, 2501, 2, 'OPTIONAL', 1, 0);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, text, attached, only_if_preceded) VALUES (2504, 251, 2503, 1, 'LITERAL', ';', 1, 0);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, only_if_preceded) VALUES (2505, 251, 2501, 3, 'OPTIONAL', 0, 0);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, only_if_preceded) VALUES (2506, 251, 2505, 1, 'SEQUENCE', 0, 0);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, parameter_id, attached, only_if_preceded, parameter_kind_id) VALUES (2507, 251, 2506, 1, 'PARAMETER', 2511, 0, 0, 12);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, only_if_preceded) VALUES (2508, 251, 2506, 2, 'CHOICE', 1, 0);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, text, attached, only_if_preceded) VALUES (2509, 251, 2508, 1, 'LITERAL', ';', 0, 0);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, text, attached, only_if_preceded) VALUES (2510, 251, 2508, 2, 'LITERAL', ',', 0, 0);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, only_if_preceded, separator, min_occ) VALUES (2511, 251, 2501, 4, 'REPEAT', 0, 0, ',', 1);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, parameter_id, attached, only_if_preceded, parameter_kind_id) VALUES (2512, 251, 2511, 1, 'PARAMETER', 2512, 0, 0, 15);
INSERT INTO syntax_node (id, form_id, position, kind, attached, only_if_preceded) VALUES (3001, 301, 1, 'SEQUENCE', 0, 0);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, keyword_id, attached, only_if_preceded) VALUES (3002, 301, 3001, 1, 'KEYWORD', 40, 0, 0);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, only_if_preceded) VALUES (3003, 301, 3001, 2, 'OPTIONAL', 0, 0);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, parameter_id, attached, only_if_preceded, parameter_kind_id) VALUES (3004, 301, 3003, 1, 'PARAMETER', 3011, 0, 0, 3);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, text, attached, only_if_preceded) VALUES (3005, 301, 3001, 3, 'LITERAL', ',', 1, 0);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, parameter_id, attached, only_if_preceded) VALUES (3006, 301, 3001, 4, 'PARAMETER', 3012, 0, 0);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, only_if_preceded) VALUES (3007, 301, 3001, 5, 'OPTIONAL', 1, 0);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, only_if_preceded) VALUES (3008, 301, 3007, 1, 'SEQUENCE', 0, 0);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, text, attached, only_if_preceded) VALUES (3009, 301, 3008, 1, 'LITERAL', ',', 1, 0);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, parameter_id, attached, only_if_preceded) VALUES (3010, 301, 3008, 2, 'PARAMETER', 3013, 1, 0);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, only_if_preceded) VALUES (3011, 301, 3001, 6, 'OPTIONAL', 1, 0);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, only_if_preceded) VALUES (3012, 301, 3011, 1, 'SEQUENCE', 0, 0);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, text, attached, only_if_preceded) VALUES (3013, 301, 3012, 1, 'LITERAL', ',', 1, 0);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, only_if_preceded) VALUES (3014, 301, 3012, 2, 'OPTIONAL', 1, 0);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, parameter_id, attached, only_if_preceded, parameter_kind_id) VALUES (3015, 301, 3014, 1, 'PARAMETER', 3014, 0, 0, 3);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, only_if_preceded) VALUES (3016, 301, 3012, 3, 'OPTIONAL', 1, 0);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, only_if_preceded) VALUES (3017, 301, 3016, 1, 'SEQUENCE', 0, 0);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, text, attached, only_if_preceded) VALUES (3018, 301, 3017, 1, 'LITERAL', ',', 1, 0);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, parameter_id, attached, only_if_preceded, parameter_kind_id) VALUES (3019, 301, 3017, 2, 'PARAMETER', 3015, 1, 0, 3);
INSERT INTO syntax_node (id, construct_id, position, kind, attached, only_if_preceded) VALUES (3101, 31, 1, 'CHOICE', 0, 0);
INSERT INTO syntax_node (id, construct_id, parent_id, position, kind, attached, only_if_preceded, meaning) VALUES (3102, 31, 3101, 1, 'SEQUENCE', 0, 0, 'Cartesian');
INSERT INTO syntax_node (id, construct_id, parent_id, position, kind, attached, only_if_preceded) VALUES (3103, 31, 3102, 1, 'OPTIONAL', 0, 0);
INSERT INTO syntax_node (id, construct_id, parent_id, position, kind, attached, only_if_preceded) VALUES (3104, 31, 3103, 1, 'CHOICE', 0, 0);
INSERT INTO syntax_node (id, construct_id, parent_id, position, kind, text, attached, only_if_preceded, meaning) VALUES (3105, 31, 3104, 1, 'LITERAL', '+', 0, 0, 'Relative on x');
INSERT INTO syntax_node (id, construct_id, parent_id, position, kind, text, attached, only_if_preceded, meaning) VALUES (3106, 31, 3104, 2, 'LITERAL', '-', 0, 0, 'Relative on x');
INSERT INTO syntax_node (id, construct_id, parent_id, position, kind, parameter_id, attached, only_if_preceded, parameter_kind_id) VALUES (3107, 31, 3102, 2, 'PARAMETER', 3111, 1, 0, 3);
INSERT INTO syntax_node (id, construct_id, parent_id, position, kind, text, attached, only_if_preceded) VALUES (3108, 31, 3102, 3, 'LITERAL', ',', 1, 0);
INSERT INTO syntax_node (id, construct_id, parent_id, position, kind, attached, only_if_preceded) VALUES (3109, 31, 3102, 4, 'OPTIONAL', 1, 0);
INSERT INTO syntax_node (id, construct_id, parent_id, position, kind, attached, only_if_preceded) VALUES (3110, 31, 3109, 1, 'CHOICE', 0, 0);
INSERT INTO syntax_node (id, construct_id, parent_id, position, kind, text, attached, only_if_preceded, meaning) VALUES (3111, 31, 3110, 1, 'LITERAL', '+', 0, 0, 'Relative on y');
INSERT INTO syntax_node (id, construct_id, parent_id, position, kind, text, attached, only_if_preceded, meaning) VALUES (3112, 31, 3110, 2, 'LITERAL', '-', 0, 0, 'Relative on y');
INSERT INTO syntax_node (id, construct_id, parent_id, position, kind, parameter_id, attached, only_if_preceded, parameter_kind_id) VALUES (3113, 31, 3102, 5, 'PARAMETER', 3112, 1, 0, 3);
INSERT INTO syntax_node (id, construct_id, parent_id, position, kind, attached, only_if_preceded, meaning) VALUES (3114, 31, 3101, 2, 'SEQUENCE', 0, 0, 'Polar');
INSERT INTO syntax_node (id, construct_id, parent_id, position, kind, parameter_id, attached, only_if_preceded, parameter_kind_id) VALUES (3115, 31, 3114, 1, 'PARAMETER', 3113, 0, 0, 3);
INSERT INTO syntax_node (id, construct_id, parent_id, position, kind, text, attached, only_if_preceded) VALUES (3116, 31, 3114, 2, 'LITERAL', ';', 1, 0);
INSERT INTO syntax_node (id, construct_id, parent_id, position, kind, parameter_id, attached, only_if_preceded, parameter_kind_id) VALUES (3117, 31, 3114, 3, 'PARAMETER', 3114, 1, 0, 3);
INSERT INTO syntax_node (id, form_id, position, kind, attached, only_if_preceded) VALUES (3201, 311, 1, 'SEQUENCE', 0, 0);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, keyword_id, attached, only_if_preceded) VALUES (3202, 311, 3201, 1, 'KEYWORD', 41, 0, 0);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, only_if_preceded, separator) VALUES (3203, 311, 3201, 2, 'LIST', 0, 0, ',');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, only_if_preceded) VALUES (3210, 311, 3203, 1, 'SEQUENCE', 0, 0);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, text, attached, only_if_preceded) VALUES (3211, 311, 3210, 1, 'LITERAL', 'D', 0, 0);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, only_if_preceded) VALUES (3212, 311, 3210, 2, 'CHOICE', 1, 0);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, parameter_id, attached, only_if_preceded, parameter_kind_id) VALUES (3213, 311, 3212, 1, 'PARAMETER', 3121, 1, 0, 1);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, only_if_preceded) VALUES (3214, 311, 3212, 2, 'SEQUENCE', 1, 0);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, text, attached, only_if_preceded) VALUES (3215, 311, 3214, 1, 'LITERAL', '(', 1, 0);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, parameter_id, attached, only_if_preceded, parameter_kind_id) VALUES (3216, 311, 3214, 2, 'PARAMETER', 3121, 1, 0, 3);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, text, attached, only_if_preceded) VALUES (3217, 311, 3214, 3, 'LITERAL', ')', 1, 0);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, only_if_preceded) VALUES (3220, 311, 3203, 2, 'SEQUENCE', 0, 0);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, only_if_preceded) VALUES (3221, 311, 3220, 1, 'CHOICE', 0, 1);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, keyword_id, attached, only_if_preceded) VALUES (3222, 311, 3221, 1, 'KEYWORD', 4, 0, 0);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, text, attached, only_if_preceded) VALUES (3223, 311, 3221, 2, 'LITERAL', ',', 0, 0);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, text, attached, only_if_preceded) VALUES (3224, 311, 3220, 2, 'LITERAL', 'U', 0, 0);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, only_if_preceded) VALUES (3225, 311, 3220, 3, 'CHOICE', 1, 0);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, parameter_id, attached, only_if_preceded, parameter_kind_id) VALUES (3226, 311, 3225, 1, 'PARAMETER', 3122, 1, 0, 1);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, only_if_preceded) VALUES (3227, 311, 3225, 2, 'SEQUENCE', 1, 0);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, text, attached, only_if_preceded) VALUES (3228, 311, 3227, 1, 'LITERAL', '(', 1, 0);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, parameter_id, attached, only_if_preceded, parameter_kind_id) VALUES (3229, 311, 3227, 2, 'PARAMETER', 3122, 1, 0, 3);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, text, attached, only_if_preceded) VALUES (3230, 311, 3227, 3, 'LITERAL', ')', 1, 0);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, only_if_preceded) VALUES (3240, 311, 3203, 3, 'CHOICE', 0, 0);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, parameter_id, attached, only_if_preceded, parameter_kind_id) VALUES (3241, 311, 3240, 1, 'PARAMETER', 3123, 0, 0, 2);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, only_if_preceded) VALUES (3242, 311, 3240, 2, 'SEQUENCE', 0, 0);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, text, attached, only_if_preceded) VALUES (3243, 311, 3242, 1, 'LITERAL', '(', 1, 0);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, parameter_id, attached, only_if_preceded, parameter_kind_id) VALUES (3244, 311, 3242, 2, 'PARAMETER', 3123, 1, 0, 4);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, text, attached, only_if_preceded) VALUES (3245, 311, 3242, 3, 'LITERAL', ')', 1, 0);

-- form_action
INSERT INTO form_action (form_id, action_id, coverage) VALUES (51, 9, 'FULL');
INSERT INTO form_action (form_id, action_id, coverage, notes) VALUES (101, 1, 'FULL', 'Coordinates relative to the current position');
INSERT INTO form_action (form_id, action_id, coverage, notes) VALUES (102, 2, 'FULL', 'Relative coordinates; a = angle of the arc');
INSERT INTO form_action (form_id, action_id, coverage) VALUES (111, 5, 'FULL');
INSERT INTO form_action (form_id, action_id, coverage, notes) VALUES (201, 1, 'FULL', 'Absolute coordinates');
INSERT INTO form_action (form_id, action_id, coverage) VALUES (202, 3, 'FULL');
INSERT INTO form_action (form_id, action_id, coverage) VALUES (203, 4, 'FULL');
INSERT INTO form_action (form_id, action_id, coverage) VALUES (211, 5, 'FULL');
INSERT INTO form_action (form_id, action_id, coverage, notes) VALUES (212, 2, 'FULL', 'Start and end angles');
INSERT INTO form_action (form_id, action_id, coverage) VALUES (213, 6, 'FULL');
INSERT INTO form_action (form_id, action_id, coverage) VALUES (251, 8, 'FULL');
INSERT INTO form_action (form_id, action_id, coverage, notes) VALUES (301, 3, 'FULL', 'paint = 0');
INSERT INTO form_action (form_id, action_id, coverage, notes) VALUES (301, 4, 'FULL', 'paint = 1');
INSERT INTO form_action (form_id, action_id, coverage) VALUES (311, 7, 'FULL');

-- reference
INSERT INTO reference (entry_id, related_entry_id, kind) VALUES (2, 3, 'OPENS_BLOCK');

COMMIT;
