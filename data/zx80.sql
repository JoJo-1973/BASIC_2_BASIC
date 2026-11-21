-- =====================================================================
--  BASIC 2 BASIC - Sinclair ZX80 BASIC (4K ROM)
--  GENERATED FILE from data/zx80.py: edit that file and regenerate.
-- =====================================================================

PRAGMA foreign_keys = ON;
BEGIN;

INSERT INTO machine (id, code, name, manufacturer, year, cpu, notes) VALUES (1, 'ZX80', 'Sinclair ZX80', 'Science of Cambridge (Sinclair)', 1980, 'Z80A (NEC µPD780C-1), 3.25 MHz', '1 KB of RAM as standard. The ZX81 8K ROM was available as an upgrade: it is a different dialect.');
INSERT INTO dialect (id, code, name, version, author, year, notes) VALUES (1, 'SINCLAIR_ZX80_4K', 'Sinclair ZX80 BASIC', '4K ROM', 'John Grant (Nine Tiles)', 1980, 'Integer-only BASIC. Statement keywords are entered with a single key.');
INSERT INTO layer (id, code, name, kind, author, year) VALUES (1, 'ZX80_4K_core', 'Sinclair ZX80 BASIC (4K ROM)', 'CORE', 'John Grant (Nine Tiles)', 1980);
INSERT INTO dialect_layer (dialect_id, layer_id, position) VALUES (1, 1, 1);
INSERT INTO machine_dialect (machine_id, dialect_id, medium, is_default) VALUES (1, 1, 'ROM', 1);

INSERT INTO charset (machine_id, id, code, name, width, height, description) VALUES (1, 1, 'ZX80_ROM', 'ROM character set', 8, 8, '64 characters and their inverses; non-printable codes appear as ''?'' and tokens as their keyword.');
INSERT INTO glyph (charset_id, code, bitmap, inverse_of, unicode, name) VALUES (1, 0, '0000000000000000', NULL, ' ', 'space');
INSERT INTO glyph (charset_id, code, bitmap, inverse_of, unicode, name) VALUES (1, 1, '0014140000000000', NULL, '"', 'quote (string terminator)');
INSERT INTO glyph (charset_id, code, bitmap, inverse_of, unicode, name) VALUES (1, 2, 'F0F0F0F0F0F0F0F0', NULL, '▌', 'graphic');
INSERT INTO glyph (charset_id, code, bitmap, inverse_of, unicode, name) VALUES (1, 3, '00000000FFFFFFFF', NULL, '▄', 'graphic');
INSERT INTO glyph (charset_id, code, bitmap, inverse_of, unicode, name) VALUES (1, 4, 'F0F0F0F000000000', NULL, '▘', 'graphic');
INSERT INTO glyph (charset_id, code, bitmap, inverse_of, unicode, name) VALUES (1, 5, '0F0F0F0F00000000', NULL, '▝', 'graphic');
INSERT INTO glyph (charset_id, code, bitmap, inverse_of, unicode, name) VALUES (1, 6, '00000000F0F0F0F0', NULL, '▖', 'graphic');
INSERT INTO glyph (charset_id, code, bitmap, inverse_of, unicode, name) VALUES (1, 7, '000000000F0F0F0F', NULL, '▗', 'graphic');
INSERT INTO glyph (charset_id, code, bitmap, inverse_of, unicode, name) VALUES (1, 8, '0F0F0F0FF0F0F0F0', NULL, '▞', 'graphic');
INSERT INTO glyph (charset_id, code, bitmap, inverse_of, unicode, name) VALUES (1, 9, 'AA55AA55AA55AA55', NULL, '▒', 'graphic');
INSERT INTO glyph (charset_id, code, bitmap, inverse_of, unicode, name) VALUES (1, 10, '00000000AA55AA55', NULL, '🮏', 'graphic');
INSERT INTO glyph (charset_id, code, bitmap, inverse_of, unicode, name) VALUES (1, 11, 'AA55AA5500000000', NULL, '🮎', 'graphic');
INSERT INTO glyph (charset_id, code, bitmap, inverse_of, unicode, name) VALUES (1, 12, '001E217820207F00', NULL, '£', NULL);
INSERT INTO glyph (charset_id, code, bitmap, inverse_of, unicode, name) VALUES (1, 13, '00083E483E093E08', NULL, '$', NULL);
INSERT INTO glyph (charset_id, code, bitmap, inverse_of, unicode, name) VALUES (1, 14, '0000000800000800', NULL, ':', NULL);
INSERT INTO glyph (charset_id, code, bitmap, inverse_of, unicode, name) VALUES (1, 15, '003E410608000800', NULL, '?', NULL);
INSERT INTO glyph (charset_id, code, bitmap, inverse_of, unicode, name) VALUES (1, 16, '0004080808080400', NULL, '(', NULL);
INSERT INTO glyph (charset_id, code, bitmap, inverse_of, unicode, name) VALUES (1, 17, '0010080808081000', NULL, ')', NULL);
INSERT INTO glyph (charset_id, code, bitmap, inverse_of, unicode, name) VALUES (1, 18, '000000003E000000', NULL, '-', NULL);
INSERT INTO glyph (charset_id, code, bitmap, inverse_of, unicode, name) VALUES (1, 19, '000008083E080800', NULL, '+', NULL);
INSERT INTO glyph (charset_id, code, bitmap, inverse_of, unicode, name) VALUES (1, 20, '00002A1C081C2A00', NULL, '*', NULL);
INSERT INTO glyph (charset_id, code, bitmap, inverse_of, unicode, name) VALUES (1, 21, '0000020408102000', NULL, '/', NULL);
INSERT INTO glyph (charset_id, code, bitmap, inverse_of, unicode, name) VALUES (1, 22, '0000003E003E0000', NULL, '=', NULL);
INSERT INTO glyph (charset_id, code, bitmap, inverse_of, unicode, name) VALUES (1, 23, '0000100804081000', NULL, '>', NULL);
INSERT INTO glyph (charset_id, code, bitmap, inverse_of, unicode, name) VALUES (1, 24, '0000040810080400', NULL, '<', NULL);
INSERT INTO glyph (charset_id, code, bitmap, inverse_of, unicode, name) VALUES (1, 25, '0000080000080810', NULL, ';', NULL);
INSERT INTO glyph (charset_id, code, bitmap, inverse_of, unicode, name) VALUES (1, 26, '0000000000080810', NULL, ',', NULL);
INSERT INTO glyph (charset_id, code, bitmap, inverse_of, unicode, name) VALUES (1, 27, '00000000000C0C00', NULL, '.', NULL);
INSERT INTO glyph (charset_id, code, bitmap, inverse_of, unicode, name) VALUES (1, 28, '001C224141221C00', NULL, '0', NULL);
INSERT INTO glyph (charset_id, code, bitmap, inverse_of, unicode, name) VALUES (1, 29, '000C140404041E00', NULL, '1', NULL);
INSERT INTO glyph (charset_id, code, bitmap, inverse_of, unicode, name) VALUES (1, 30, '003E41013E407F00', NULL, '2', NULL);
INSERT INTO glyph (charset_id, code, bitmap, inverse_of, unicode, name) VALUES (1, 31, '003E410601413E00', NULL, '3', NULL);
INSERT INTO glyph (charset_id, code, bitmap, inverse_of, unicode, name) VALUES (1, 32, '000C1424447F0400', NULL, '4', NULL);
INSERT INTO glyph (charset_id, code, bitmap, inverse_of, unicode, name) VALUES (1, 33, '007F407E01413E00', NULL, '5', NULL);
INSERT INTO glyph (charset_id, code, bitmap, inverse_of, unicode, name) VALUES (1, 34, '003E407E41413E00', NULL, '6', NULL);
INSERT INTO glyph (charset_id, code, bitmap, inverse_of, unicode, name) VALUES (1, 35, '007F010204080800', NULL, '7', NULL);
INSERT INTO glyph (charset_id, code, bitmap, inverse_of, unicode, name) VALUES (1, 36, '003E413E41413E00', NULL, '8', NULL);
INSERT INTO glyph (charset_id, code, bitmap, inverse_of, unicode, name) VALUES (1, 37, '003E41413F013E00', NULL, '9', NULL);
INSERT INTO glyph (charset_id, code, bitmap, inverse_of, unicode, name) VALUES (1, 38, '003E41417F414100', NULL, 'A', NULL);
INSERT INTO glyph (charset_id, code, bitmap, inverse_of, unicode, name) VALUES (1, 39, '007E417E41417E00', NULL, 'B', NULL);
INSERT INTO glyph (charset_id, code, bitmap, inverse_of, unicode, name) VALUES (1, 40, '001E214040211E00', NULL, 'C', NULL);
INSERT INTO glyph (charset_id, code, bitmap, inverse_of, unicode, name) VALUES (1, 41, '007C424141427C00', NULL, 'D', NULL);
INSERT INTO glyph (charset_id, code, bitmap, inverse_of, unicode, name) VALUES (1, 42, '007F407C40407F00', NULL, 'E', NULL);
INSERT INTO glyph (charset_id, code, bitmap, inverse_of, unicode, name) VALUES (1, 43, '007F407C40404000', NULL, 'F', NULL);
INSERT INTO glyph (charset_id, code, bitmap, inverse_of, unicode, name) VALUES (1, 44, '001E214047211E00', NULL, 'G', NULL);
INSERT INTO glyph (charset_id, code, bitmap, inverse_of, unicode, name) VALUES (1, 45, '0041417F41414100', NULL, 'H', NULL);
INSERT INTO glyph (charset_id, code, bitmap, inverse_of, unicode, name) VALUES (1, 46, '003E080808083E00', NULL, 'I', NULL);
INSERT INTO glyph (charset_id, code, bitmap, inverse_of, unicode, name) VALUES (1, 47, '0002020242221C00', NULL, 'J', NULL);
INSERT INTO glyph (charset_id, code, bitmap, inverse_of, unicode, name) VALUES (1, 48, '0042447844424100', NULL, 'K', NULL);
INSERT INTO glyph (charset_id, code, bitmap, inverse_of, unicode, name) VALUES (1, 49, '0040404040407F00', NULL, 'L', NULL);
INSERT INTO glyph (charset_id, code, bitmap, inverse_of, unicode, name) VALUES (1, 50, '0041635549414100', NULL, 'M', NULL);
INSERT INTO glyph (charset_id, code, bitmap, inverse_of, unicode, name) VALUES (1, 51, '0061514945434100', NULL, 'N', NULL);
INSERT INTO glyph (charset_id, code, bitmap, inverse_of, unicode, name) VALUES (1, 52, '003E414141413E00', NULL, 'O', NULL);
INSERT INTO glyph (charset_id, code, bitmap, inverse_of, unicode, name) VALUES (1, 53, '007E41417E404000', NULL, 'P', NULL);
INSERT INTO glyph (charset_id, code, bitmap, inverse_of, unicode, name) VALUES (1, 54, '003E414149453E00', NULL, 'Q', NULL);
INSERT INTO glyph (charset_id, code, bitmap, inverse_of, unicode, name) VALUES (1, 55, '007E41417E444200', NULL, 'R', NULL);
INSERT INTO glyph (charset_id, code, bitmap, inverse_of, unicode, name) VALUES (1, 56, '003E403E01413E00', NULL, 'S', NULL);
INSERT INTO glyph (charset_id, code, bitmap, inverse_of, unicode, name) VALUES (1, 57, '007F080808080800', NULL, 'T', NULL);
INSERT INTO glyph (charset_id, code, bitmap, inverse_of, unicode, name) VALUES (1, 58, '0041414141413E00', NULL, 'U', NULL);
INSERT INTO glyph (charset_id, code, bitmap, inverse_of, unicode, name) VALUES (1, 59, '0041414122140800', NULL, 'V', NULL);
INSERT INTO glyph (charset_id, code, bitmap, inverse_of, unicode, name) VALUES (1, 60, '0041414149552200', NULL, 'W', NULL);
INSERT INTO glyph (charset_id, code, bitmap, inverse_of, unicode, name) VALUES (1, 61, '0021120C0C122100', NULL, 'X', NULL);
INSERT INTO glyph (charset_id, code, bitmap, inverse_of, unicode, name) VALUES (1, 62, '0041221C08080800', NULL, 'Y', NULL);
INSERT INTO glyph (charset_id, code, bitmap, inverse_of, unicode, name) VALUES (1, 63, '007F020408107F00', NULL, 'Z', NULL);
INSERT INTO glyph (charset_id, code, bitmap, inverse_of, unicode, name) VALUES (1, 128, 'FFFFFFFFFFFFFFFF', 0, '█', 'inverse space');
INSERT INTO glyph (charset_id, code, bitmap, inverse_of, unicode, name) VALUES (1, 129, 'FFEBEBFFFFFFFFFF', 1, NULL, NULL);
INSERT INTO glyph (charset_id, code, bitmap, inverse_of, unicode, name) VALUES (1, 130, '0F0F0F0F0F0F0F0F', 2, '▐', 'inverse graphic');
INSERT INTO glyph (charset_id, code, bitmap, inverse_of, unicode, name) VALUES (1, 131, 'FFFFFFFF00000000', 3, '▀', 'inverse graphic');
INSERT INTO glyph (charset_id, code, bitmap, inverse_of, unicode, name) VALUES (1, 132, '0F0F0F0FFFFFFFFF', 4, '▟', 'inverse graphic');
INSERT INTO glyph (charset_id, code, bitmap, inverse_of, unicode, name) VALUES (1, 133, 'F0F0F0F0FFFFFFFF', 5, '▙', 'inverse graphic');
INSERT INTO glyph (charset_id, code, bitmap, inverse_of, unicode, name) VALUES (1, 134, 'FFFFFFFF0F0F0F0F', 6, '▜', 'inverse graphic');
INSERT INTO glyph (charset_id, code, bitmap, inverse_of, unicode, name) VALUES (1, 135, 'FFFFFFFFF0F0F0F0', 7, '▛', 'inverse graphic');
INSERT INTO glyph (charset_id, code, bitmap, inverse_of, unicode, name) VALUES (1, 136, 'F0F0F0F00F0F0F0F', 8, '▚', 'inverse graphic');
INSERT INTO glyph (charset_id, code, bitmap, inverse_of, unicode, name) VALUES (1, 137, '55AA55AA55AA55AA', 9, '🮐', 'inverse graphic');
INSERT INTO glyph (charset_id, code, bitmap, inverse_of, unicode, name) VALUES (1, 138, 'FFFFFFFF55AA55AA', 10, '🮑', 'inverse graphic');
INSERT INTO glyph (charset_id, code, bitmap, inverse_of, unicode, name) VALUES (1, 139, '55AA55AAFFFFFFFF', 11, '🮒', 'inverse graphic');
INSERT INTO glyph (charset_id, code, bitmap, inverse_of, unicode, name) VALUES (1, 140, 'FFE1DE87DFDF80FF', 12, NULL, NULL);
INSERT INTO glyph (charset_id, code, bitmap, inverse_of, unicode, name) VALUES (1, 141, 'FFF7C1B7C1F6C1F7', 13, NULL, NULL);
INSERT INTO glyph (charset_id, code, bitmap, inverse_of, unicode, name) VALUES (1, 142, 'FFFFFFF7FFFFF7FF', 14, NULL, NULL);
INSERT INTO glyph (charset_id, code, bitmap, inverse_of, unicode, name) VALUES (1, 143, 'FFC1BEF9F7FFF7FF', 15, NULL, NULL);
INSERT INTO glyph (charset_id, code, bitmap, inverse_of, unicode, name) VALUES (1, 144, 'FFFBF7F7F7F7FBFF', 16, NULL, NULL);
INSERT INTO glyph (charset_id, code, bitmap, inverse_of, unicode, name) VALUES (1, 145, 'FFEFF7F7F7F7EFFF', 17, NULL, NULL);
INSERT INTO glyph (charset_id, code, bitmap, inverse_of, unicode, name) VALUES (1, 146, 'FFFFFFFFC1FFFFFF', 18, NULL, NULL);
INSERT INTO glyph (charset_id, code, bitmap, inverse_of, unicode, name) VALUES (1, 147, 'FFFFF7F7C1F7F7FF', 19, NULL, NULL);
INSERT INTO glyph (charset_id, code, bitmap, inverse_of, unicode, name) VALUES (1, 148, 'FFFFD5E3F7E3D5FF', 20, NULL, NULL);
INSERT INTO glyph (charset_id, code, bitmap, inverse_of, unicode, name) VALUES (1, 149, 'FFFFFDFBF7EFDFFF', 21, NULL, NULL);
INSERT INTO glyph (charset_id, code, bitmap, inverse_of, unicode, name) VALUES (1, 150, 'FFFFFFC1FFC1FFFF', 22, NULL, NULL);
INSERT INTO glyph (charset_id, code, bitmap, inverse_of, unicode, name) VALUES (1, 151, 'FFFFEFF7FBF7EFFF', 23, NULL, NULL);
INSERT INTO glyph (charset_id, code, bitmap, inverse_of, unicode, name) VALUES (1, 152, 'FFFFFBF7EFF7FBFF', 24, NULL, NULL);
INSERT INTO glyph (charset_id, code, bitmap, inverse_of, unicode, name) VALUES (1, 153, 'FFFFF7FFFFF7F7EF', 25, NULL, NULL);
INSERT INTO glyph (charset_id, code, bitmap, inverse_of, unicode, name) VALUES (1, 154, 'FFFFFFFFFFF7F7EF', 26, NULL, NULL);
INSERT INTO glyph (charset_id, code, bitmap, inverse_of, unicode, name) VALUES (1, 155, 'FFFFFFFFFFF3F3FF', 27, NULL, NULL);
INSERT INTO glyph (charset_id, code, bitmap, inverse_of, unicode, name) VALUES (1, 156, 'FFE3DDBEBEDDE3FF', 28, NULL, NULL);
INSERT INTO glyph (charset_id, code, bitmap, inverse_of, unicode, name) VALUES (1, 157, 'FFF3EBFBFBFBE1FF', 29, NULL, NULL);
INSERT INTO glyph (charset_id, code, bitmap, inverse_of, unicode, name) VALUES (1, 158, 'FFC1BEFEC1BF80FF', 30, NULL, NULL);
INSERT INTO glyph (charset_id, code, bitmap, inverse_of, unicode, name) VALUES (1, 159, 'FFC1BEF9FEBEC1FF', 31, NULL, NULL);
INSERT INTO glyph (charset_id, code, bitmap, inverse_of, unicode, name) VALUES (1, 160, 'FFF3EBDBBB80FBFF', 32, NULL, NULL);
INSERT INTO glyph (charset_id, code, bitmap, inverse_of, unicode, name) VALUES (1, 161, 'FF80BF81FEBEC1FF', 33, NULL, NULL);
INSERT INTO glyph (charset_id, code, bitmap, inverse_of, unicode, name) VALUES (1, 162, 'FFC1BF81BEBEC1FF', 34, NULL, NULL);
INSERT INTO glyph (charset_id, code, bitmap, inverse_of, unicode, name) VALUES (1, 163, 'FF80FEFDFBF7F7FF', 35, NULL, NULL);
INSERT INTO glyph (charset_id, code, bitmap, inverse_of, unicode, name) VALUES (1, 164, 'FFC1BEC1BEBEC1FF', 36, NULL, NULL);
INSERT INTO glyph (charset_id, code, bitmap, inverse_of, unicode, name) VALUES (1, 165, 'FFC1BEBEC0FEC1FF', 37, NULL, NULL);
INSERT INTO glyph (charset_id, code, bitmap, inverse_of, unicode, name) VALUES (1, 166, 'FFC1BEBE80BEBEFF', 38, NULL, NULL);
INSERT INTO glyph (charset_id, code, bitmap, inverse_of, unicode, name) VALUES (1, 167, 'FF81BE81BEBE81FF', 39, NULL, NULL);
INSERT INTO glyph (charset_id, code, bitmap, inverse_of, unicode, name) VALUES (1, 168, 'FFE1DEBFBFDEE1FF', 40, NULL, NULL);
INSERT INTO glyph (charset_id, code, bitmap, inverse_of, unicode, name) VALUES (1, 169, 'FF83BDBEBEBD83FF', 41, NULL, NULL);
INSERT INTO glyph (charset_id, code, bitmap, inverse_of, unicode, name) VALUES (1, 170, 'FF80BF83BFBF80FF', 42, NULL, NULL);
INSERT INTO glyph (charset_id, code, bitmap, inverse_of, unicode, name) VALUES (1, 171, 'FF80BF83BFBFBFFF', 43, NULL, NULL);
INSERT INTO glyph (charset_id, code, bitmap, inverse_of, unicode, name) VALUES (1, 172, 'FFE1DEBFB8DEE1FF', 44, NULL, NULL);
INSERT INTO glyph (charset_id, code, bitmap, inverse_of, unicode, name) VALUES (1, 173, 'FFBEBE80BEBEBEFF', 45, NULL, NULL);
INSERT INTO glyph (charset_id, code, bitmap, inverse_of, unicode, name) VALUES (1, 174, 'FFC1F7F7F7F7C1FF', 46, NULL, NULL);
INSERT INTO glyph (charset_id, code, bitmap, inverse_of, unicode, name) VALUES (1, 175, 'FFFDFDFDBDDDE3FF', 47, NULL, NULL);
INSERT INTO glyph (charset_id, code, bitmap, inverse_of, unicode, name) VALUES (1, 176, 'FFBDBB87BBBDBEFF', 48, NULL, NULL);
INSERT INTO glyph (charset_id, code, bitmap, inverse_of, unicode, name) VALUES (1, 177, 'FFBFBFBFBFBF80FF', 49, NULL, NULL);
INSERT INTO glyph (charset_id, code, bitmap, inverse_of, unicode, name) VALUES (1, 178, 'FFBE9CAAB6BEBEFF', 50, NULL, NULL);
INSERT INTO glyph (charset_id, code, bitmap, inverse_of, unicode, name) VALUES (1, 179, 'FF9EAEB6BABCBEFF', 51, NULL, NULL);
INSERT INTO glyph (charset_id, code, bitmap, inverse_of, unicode, name) VALUES (1, 180, 'FFC1BEBEBEBEC1FF', 52, NULL, NULL);
INSERT INTO glyph (charset_id, code, bitmap, inverse_of, unicode, name) VALUES (1, 181, 'FF81BEBE81BFBFFF', 53, NULL, NULL);
INSERT INTO glyph (charset_id, code, bitmap, inverse_of, unicode, name) VALUES (1, 182, 'FFC1BEBEB6BAC1FF', 54, NULL, NULL);
INSERT INTO glyph (charset_id, code, bitmap, inverse_of, unicode, name) VALUES (1, 183, 'FF81BEBE81BBBDFF', 55, NULL, NULL);
INSERT INTO glyph (charset_id, code, bitmap, inverse_of, unicode, name) VALUES (1, 184, 'FFC1BFC1FEBEC1FF', 56, NULL, NULL);
INSERT INTO glyph (charset_id, code, bitmap, inverse_of, unicode, name) VALUES (1, 185, 'FF80F7F7F7F7F7FF', 57, NULL, NULL);
INSERT INTO glyph (charset_id, code, bitmap, inverse_of, unicode, name) VALUES (1, 186, 'FFBEBEBEBEBEC1FF', 58, NULL, NULL);
INSERT INTO glyph (charset_id, code, bitmap, inverse_of, unicode, name) VALUES (1, 187, 'FFBEBEBEDDEBF7FF', 59, NULL, NULL);
INSERT INTO glyph (charset_id, code, bitmap, inverse_of, unicode, name) VALUES (1, 188, 'FFBEBEBEB6AADDFF', 60, NULL, NULL);
INSERT INTO glyph (charset_id, code, bitmap, inverse_of, unicode, name) VALUES (1, 189, 'FFDEEDF3F3EDDEFF', 61, NULL, NULL);
INSERT INTO glyph (charset_id, code, bitmap, inverse_of, unicode, name) VALUES (1, 190, 'FFBEDDE3F7F7F7FF', 62, NULL, NULL);
INSERT INTO glyph (charset_id, code, bitmap, inverse_of, unicode, name) VALUES (1, 191, 'FF80FDFBF7EF80FF', 63, NULL, NULL);
INSERT INTO screen_code (machine_id, code, glyph_code, notes) VALUES (1, 0, 0, NULL);
INSERT INTO screen_code (machine_id, code, glyph_code, notes) VALUES (1, 1, 1, NULL);
INSERT INTO screen_code (machine_id, code, glyph_code, notes) VALUES (1, 2, 2, NULL);
INSERT INTO screen_code (machine_id, code, glyph_code, notes) VALUES (1, 3, 3, NULL);
INSERT INTO screen_code (machine_id, code, glyph_code, notes) VALUES (1, 4, 4, NULL);
INSERT INTO screen_code (machine_id, code, glyph_code, notes) VALUES (1, 5, 5, NULL);
INSERT INTO screen_code (machine_id, code, glyph_code, notes) VALUES (1, 6, 6, NULL);
INSERT INTO screen_code (machine_id, code, glyph_code, notes) VALUES (1, 7, 7, NULL);
INSERT INTO screen_code (machine_id, code, glyph_code, notes) VALUES (1, 8, 8, NULL);
INSERT INTO screen_code (machine_id, code, glyph_code, notes) VALUES (1, 9, 9, NULL);
INSERT INTO screen_code (machine_id, code, glyph_code, notes) VALUES (1, 10, 10, NULL);
INSERT INTO screen_code (machine_id, code, glyph_code, notes) VALUES (1, 11, 11, NULL);
INSERT INTO screen_code (machine_id, code, glyph_code, notes) VALUES (1, 12, 12, NULL);
INSERT INTO screen_code (machine_id, code, glyph_code, notes) VALUES (1, 13, 13, NULL);
INSERT INTO screen_code (machine_id, code, glyph_code, notes) VALUES (1, 14, 14, NULL);
INSERT INTO screen_code (machine_id, code, glyph_code, notes) VALUES (1, 15, 15, NULL);
INSERT INTO screen_code (machine_id, code, glyph_code, notes) VALUES (1, 16, 16, NULL);
INSERT INTO screen_code (machine_id, code, glyph_code, notes) VALUES (1, 17, 17, NULL);
INSERT INTO screen_code (machine_id, code, glyph_code, notes) VALUES (1, 18, 18, NULL);
INSERT INTO screen_code (machine_id, code, glyph_code, notes) VALUES (1, 19, 19, NULL);
INSERT INTO screen_code (machine_id, code, glyph_code, notes) VALUES (1, 20, 20, NULL);
INSERT INTO screen_code (machine_id, code, glyph_code, notes) VALUES (1, 21, 21, NULL);
INSERT INTO screen_code (machine_id, code, glyph_code, notes) VALUES (1, 22, 22, NULL);
INSERT INTO screen_code (machine_id, code, glyph_code, notes) VALUES (1, 23, 23, NULL);
INSERT INTO screen_code (machine_id, code, glyph_code, notes) VALUES (1, 24, 24, NULL);
INSERT INTO screen_code (machine_id, code, glyph_code, notes) VALUES (1, 25, 25, NULL);
INSERT INTO screen_code (machine_id, code, glyph_code, notes) VALUES (1, 26, 26, NULL);
INSERT INTO screen_code (machine_id, code, glyph_code, notes) VALUES (1, 27, 27, NULL);
INSERT INTO screen_code (machine_id, code, glyph_code, notes) VALUES (1, 28, 28, NULL);
INSERT INTO screen_code (machine_id, code, glyph_code, notes) VALUES (1, 29, 29, NULL);
INSERT INTO screen_code (machine_id, code, glyph_code, notes) VALUES (1, 30, 30, NULL);
INSERT INTO screen_code (machine_id, code, glyph_code, notes) VALUES (1, 31, 31, NULL);
INSERT INTO screen_code (machine_id, code, glyph_code, notes) VALUES (1, 32, 32, NULL);
INSERT INTO screen_code (machine_id, code, glyph_code, notes) VALUES (1, 33, 33, NULL);
INSERT INTO screen_code (machine_id, code, glyph_code, notes) VALUES (1, 34, 34, NULL);
INSERT INTO screen_code (machine_id, code, glyph_code, notes) VALUES (1, 35, 35, NULL);
INSERT INTO screen_code (machine_id, code, glyph_code, notes) VALUES (1, 36, 36, NULL);
INSERT INTO screen_code (machine_id, code, glyph_code, notes) VALUES (1, 37, 37, NULL);
INSERT INTO screen_code (machine_id, code, glyph_code, notes) VALUES (1, 38, 38, NULL);
INSERT INTO screen_code (machine_id, code, glyph_code, notes) VALUES (1, 39, 39, NULL);
INSERT INTO screen_code (machine_id, code, glyph_code, notes) VALUES (1, 40, 40, NULL);
INSERT INTO screen_code (machine_id, code, glyph_code, notes) VALUES (1, 41, 41, NULL);
INSERT INTO screen_code (machine_id, code, glyph_code, notes) VALUES (1, 42, 42, NULL);
INSERT INTO screen_code (machine_id, code, glyph_code, notes) VALUES (1, 43, 43, NULL);
INSERT INTO screen_code (machine_id, code, glyph_code, notes) VALUES (1, 44, 44, NULL);
INSERT INTO screen_code (machine_id, code, glyph_code, notes) VALUES (1, 45, 45, NULL);
INSERT INTO screen_code (machine_id, code, glyph_code, notes) VALUES (1, 46, 46, NULL);
INSERT INTO screen_code (machine_id, code, glyph_code, notes) VALUES (1, 47, 47, NULL);
INSERT INTO screen_code (machine_id, code, glyph_code, notes) VALUES (1, 48, 48, NULL);
INSERT INTO screen_code (machine_id, code, glyph_code, notes) VALUES (1, 49, 49, NULL);
INSERT INTO screen_code (machine_id, code, glyph_code, notes) VALUES (1, 50, 50, NULL);
INSERT INTO screen_code (machine_id, code, glyph_code, notes) VALUES (1, 51, 51, NULL);
INSERT INTO screen_code (machine_id, code, glyph_code, notes) VALUES (1, 52, 52, NULL);
INSERT INTO screen_code (machine_id, code, glyph_code, notes) VALUES (1, 53, 53, NULL);
INSERT INTO screen_code (machine_id, code, glyph_code, notes) VALUES (1, 54, 54, NULL);
INSERT INTO screen_code (machine_id, code, glyph_code, notes) VALUES (1, 55, 55, NULL);
INSERT INTO screen_code (machine_id, code, glyph_code, notes) VALUES (1, 56, 56, NULL);
INSERT INTO screen_code (machine_id, code, glyph_code, notes) VALUES (1, 57, 57, NULL);
INSERT INTO screen_code (machine_id, code, glyph_code, notes) VALUES (1, 58, 58, NULL);
INSERT INTO screen_code (machine_id, code, glyph_code, notes) VALUES (1, 59, 59, NULL);
INSERT INTO screen_code (machine_id, code, glyph_code, notes) VALUES (1, 60, 60, NULL);
INSERT INTO screen_code (machine_id, code, glyph_code, notes) VALUES (1, 61, 61, NULL);
INSERT INTO screen_code (machine_id, code, glyph_code, notes) VALUES (1, 62, 62, NULL);
INSERT INTO screen_code (machine_id, code, glyph_code, notes) VALUES (1, 63, 63, NULL);
INSERT INTO screen_code (machine_id, code, glyph_code, notes) VALUES (1, 128, 128, 'Inverse video');
INSERT INTO screen_code (machine_id, code, glyph_code, notes) VALUES (1, 129, 129, 'Inverse video');
INSERT INTO screen_code (machine_id, code, glyph_code, notes) VALUES (1, 130, 130, 'Inverse video');
INSERT INTO screen_code (machine_id, code, glyph_code, notes) VALUES (1, 131, 131, 'Inverse video');
INSERT INTO screen_code (machine_id, code, glyph_code, notes) VALUES (1, 132, 132, 'Inverse video');
INSERT INTO screen_code (machine_id, code, glyph_code, notes) VALUES (1, 133, 133, 'Inverse video');
INSERT INTO screen_code (machine_id, code, glyph_code, notes) VALUES (1, 134, 134, 'Inverse video');
INSERT INTO screen_code (machine_id, code, glyph_code, notes) VALUES (1, 135, 135, 'Inverse video');
INSERT INTO screen_code (machine_id, code, glyph_code, notes) VALUES (1, 136, 136, 'Inverse video');
INSERT INTO screen_code (machine_id, code, glyph_code, notes) VALUES (1, 137, 137, 'Inverse video');
INSERT INTO screen_code (machine_id, code, glyph_code, notes) VALUES (1, 138, 138, 'Inverse video');
INSERT INTO screen_code (machine_id, code, glyph_code, notes) VALUES (1, 139, 139, 'Inverse video');
INSERT INTO screen_code (machine_id, code, glyph_code, notes) VALUES (1, 140, 140, 'Inverse video');
INSERT INTO screen_code (machine_id, code, glyph_code, notes) VALUES (1, 141, 141, 'Inverse video');
INSERT INTO screen_code (machine_id, code, glyph_code, notes) VALUES (1, 142, 142, 'Inverse video');
INSERT INTO screen_code (machine_id, code, glyph_code, notes) VALUES (1, 143, 143, 'Inverse video');
INSERT INTO screen_code (machine_id, code, glyph_code, notes) VALUES (1, 144, 144, 'Inverse video');
INSERT INTO screen_code (machine_id, code, glyph_code, notes) VALUES (1, 145, 145, 'Inverse video');
INSERT INTO screen_code (machine_id, code, glyph_code, notes) VALUES (1, 146, 146, 'Inverse video');
INSERT INTO screen_code (machine_id, code, glyph_code, notes) VALUES (1, 147, 147, 'Inverse video');
INSERT INTO screen_code (machine_id, code, glyph_code, notes) VALUES (1, 148, 148, 'Inverse video');
INSERT INTO screen_code (machine_id, code, glyph_code, notes) VALUES (1, 149, 149, 'Inverse video');
INSERT INTO screen_code (machine_id, code, glyph_code, notes) VALUES (1, 150, 150, 'Inverse video');
INSERT INTO screen_code (machine_id, code, glyph_code, notes) VALUES (1, 151, 151, 'Inverse video');
INSERT INTO screen_code (machine_id, code, glyph_code, notes) VALUES (1, 152, 152, 'Inverse video');
INSERT INTO screen_code (machine_id, code, glyph_code, notes) VALUES (1, 153, 153, 'Inverse video');
INSERT INTO screen_code (machine_id, code, glyph_code, notes) VALUES (1, 154, 154, 'Inverse video');
INSERT INTO screen_code (machine_id, code, glyph_code, notes) VALUES (1, 155, 155, 'Inverse video');
INSERT INTO screen_code (machine_id, code, glyph_code, notes) VALUES (1, 156, 156, 'Inverse video');
INSERT INTO screen_code (machine_id, code, glyph_code, notes) VALUES (1, 157, 157, 'Inverse video');
INSERT INTO screen_code (machine_id, code, glyph_code, notes) VALUES (1, 158, 158, 'Inverse video');
INSERT INTO screen_code (machine_id, code, glyph_code, notes) VALUES (1, 159, 159, 'Inverse video');
INSERT INTO screen_code (machine_id, code, glyph_code, notes) VALUES (1, 160, 160, 'Inverse video');
INSERT INTO screen_code (machine_id, code, glyph_code, notes) VALUES (1, 161, 161, 'Inverse video');
INSERT INTO screen_code (machine_id, code, glyph_code, notes) VALUES (1, 162, 162, 'Inverse video');
INSERT INTO screen_code (machine_id, code, glyph_code, notes) VALUES (1, 163, 163, 'Inverse video');
INSERT INTO screen_code (machine_id, code, glyph_code, notes) VALUES (1, 164, 164, 'Inverse video');
INSERT INTO screen_code (machine_id, code, glyph_code, notes) VALUES (1, 165, 165, 'Inverse video');
INSERT INTO screen_code (machine_id, code, glyph_code, notes) VALUES (1, 166, 166, 'Inverse video');
INSERT INTO screen_code (machine_id, code, glyph_code, notes) VALUES (1, 167, 167, 'Inverse video');
INSERT INTO screen_code (machine_id, code, glyph_code, notes) VALUES (1, 168, 168, 'Inverse video');
INSERT INTO screen_code (machine_id, code, glyph_code, notes) VALUES (1, 169, 169, 'Inverse video');
INSERT INTO screen_code (machine_id, code, glyph_code, notes) VALUES (1, 170, 170, 'Inverse video');
INSERT INTO screen_code (machine_id, code, glyph_code, notes) VALUES (1, 171, 171, 'Inverse video');
INSERT INTO screen_code (machine_id, code, glyph_code, notes) VALUES (1, 172, 172, 'Inverse video');
INSERT INTO screen_code (machine_id, code, glyph_code, notes) VALUES (1, 173, 173, 'Inverse video');
INSERT INTO screen_code (machine_id, code, glyph_code, notes) VALUES (1, 174, 174, 'Inverse video');
INSERT INTO screen_code (machine_id, code, glyph_code, notes) VALUES (1, 175, 175, 'Inverse video');
INSERT INTO screen_code (machine_id, code, glyph_code, notes) VALUES (1, 176, 176, 'Inverse video');
INSERT INTO screen_code (machine_id, code, glyph_code, notes) VALUES (1, 177, 177, 'Inverse video');
INSERT INTO screen_code (machine_id, code, glyph_code, notes) VALUES (1, 178, 178, 'Inverse video');
INSERT INTO screen_code (machine_id, code, glyph_code, notes) VALUES (1, 179, 179, 'Inverse video');
INSERT INTO screen_code (machine_id, code, glyph_code, notes) VALUES (1, 180, 180, 'Inverse video');
INSERT INTO screen_code (machine_id, code, glyph_code, notes) VALUES (1, 181, 181, 'Inverse video');
INSERT INTO screen_code (machine_id, code, glyph_code, notes) VALUES (1, 182, 182, 'Inverse video');
INSERT INTO screen_code (machine_id, code, glyph_code, notes) VALUES (1, 183, 183, 'Inverse video');
INSERT INTO screen_code (machine_id, code, glyph_code, notes) VALUES (1, 184, 184, 'Inverse video');
INSERT INTO screen_code (machine_id, code, glyph_code, notes) VALUES (1, 185, 185, 'Inverse video');
INSERT INTO screen_code (machine_id, code, glyph_code, notes) VALUES (1, 186, 186, 'Inverse video');
INSERT INTO screen_code (machine_id, code, glyph_code, notes) VALUES (1, 187, 187, 'Inverse video');
INSERT INTO screen_code (machine_id, code, glyph_code, notes) VALUES (1, 188, 188, 'Inverse video');
INSERT INTO screen_code (machine_id, code, glyph_code, notes) VALUES (1, 189, 189, 'Inverse video');
INSERT INTO screen_code (machine_id, code, glyph_code, notes) VALUES (1, 190, 190, 'Inverse video');
INSERT INTO screen_code (machine_id, code, glyph_code, notes) VALUES (1, 191, 191, 'Inverse video');
INSERT INTO character_code (layer_id, code, kind, screen_code) VALUES (1, 0, 'PRINTABLE', 0);
INSERT INTO character_code (layer_id, code, kind, screen_code) VALUES (1, 1, 'PRINTABLE', 1);
INSERT INTO character_code (layer_id, code, kind, screen_code) VALUES (1, 2, 'PRINTABLE', 2);
INSERT INTO character_code (layer_id, code, kind, screen_code) VALUES (1, 3, 'PRINTABLE', 3);
INSERT INTO character_code (layer_id, code, kind, screen_code) VALUES (1, 4, 'PRINTABLE', 4);
INSERT INTO character_code (layer_id, code, kind, screen_code) VALUES (1, 5, 'PRINTABLE', 5);
INSERT INTO character_code (layer_id, code, kind, screen_code) VALUES (1, 6, 'PRINTABLE', 6);
INSERT INTO character_code (layer_id, code, kind, screen_code) VALUES (1, 7, 'PRINTABLE', 7);
INSERT INTO character_code (layer_id, code, kind, screen_code) VALUES (1, 8, 'PRINTABLE', 8);
INSERT INTO character_code (layer_id, code, kind, screen_code) VALUES (1, 9, 'PRINTABLE', 9);
INSERT INTO character_code (layer_id, code, kind, screen_code) VALUES (1, 10, 'PRINTABLE', 10);
INSERT INTO character_code (layer_id, code, kind, screen_code) VALUES (1, 11, 'PRINTABLE', 11);
INSERT INTO character_code (layer_id, code, kind, screen_code) VALUES (1, 12, 'PRINTABLE', 12);
INSERT INTO character_code (layer_id, code, kind, screen_code) VALUES (1, 13, 'PRINTABLE', 13);
INSERT INTO character_code (layer_id, code, kind, screen_code) VALUES (1, 14, 'PRINTABLE', 14);
INSERT INTO character_code (layer_id, code, kind, screen_code) VALUES (1, 15, 'PRINTABLE', 15);
INSERT INTO character_code (layer_id, code, kind, screen_code) VALUES (1, 16, 'PRINTABLE', 16);
INSERT INTO character_code (layer_id, code, kind, screen_code) VALUES (1, 17, 'PRINTABLE', 17);
INSERT INTO character_code (layer_id, code, kind, screen_code) VALUES (1, 18, 'PRINTABLE', 18);
INSERT INTO character_code (layer_id, code, kind, screen_code) VALUES (1, 19, 'PRINTABLE', 19);
INSERT INTO character_code (layer_id, code, kind, screen_code) VALUES (1, 20, 'PRINTABLE', 20);
INSERT INTO character_code (layer_id, code, kind, screen_code) VALUES (1, 21, 'PRINTABLE', 21);
INSERT INTO character_code (layer_id, code, kind, screen_code) VALUES (1, 22, 'PRINTABLE', 22);
INSERT INTO character_code (layer_id, code, kind, screen_code) VALUES (1, 23, 'PRINTABLE', 23);
INSERT INTO character_code (layer_id, code, kind, screen_code) VALUES (1, 24, 'PRINTABLE', 24);
INSERT INTO character_code (layer_id, code, kind, screen_code) VALUES (1, 25, 'PRINTABLE', 25);
INSERT INTO character_code (layer_id, code, kind, screen_code) VALUES (1, 26, 'PRINTABLE', 26);
INSERT INTO character_code (layer_id, code, kind, screen_code) VALUES (1, 27, 'PRINTABLE', 27);
INSERT INTO character_code (layer_id, code, kind, screen_code) VALUES (1, 28, 'PRINTABLE', 28);
INSERT INTO character_code (layer_id, code, kind, screen_code) VALUES (1, 29, 'PRINTABLE', 29);
INSERT INTO character_code (layer_id, code, kind, screen_code) VALUES (1, 30, 'PRINTABLE', 30);
INSERT INTO character_code (layer_id, code, kind, screen_code) VALUES (1, 31, 'PRINTABLE', 31);
INSERT INTO character_code (layer_id, code, kind, screen_code) VALUES (1, 32, 'PRINTABLE', 32);
INSERT INTO character_code (layer_id, code, kind, screen_code) VALUES (1, 33, 'PRINTABLE', 33);
INSERT INTO character_code (layer_id, code, kind, screen_code) VALUES (1, 34, 'PRINTABLE', 34);
INSERT INTO character_code (layer_id, code, kind, screen_code) VALUES (1, 35, 'PRINTABLE', 35);
INSERT INTO character_code (layer_id, code, kind, screen_code) VALUES (1, 36, 'PRINTABLE', 36);
INSERT INTO character_code (layer_id, code, kind, screen_code) VALUES (1, 37, 'PRINTABLE', 37);
INSERT INTO character_code (layer_id, code, kind, screen_code) VALUES (1, 38, 'PRINTABLE', 38);
INSERT INTO character_code (layer_id, code, kind, screen_code) VALUES (1, 39, 'PRINTABLE', 39);
INSERT INTO character_code (layer_id, code, kind, screen_code) VALUES (1, 40, 'PRINTABLE', 40);
INSERT INTO character_code (layer_id, code, kind, screen_code) VALUES (1, 41, 'PRINTABLE', 41);
INSERT INTO character_code (layer_id, code, kind, screen_code) VALUES (1, 42, 'PRINTABLE', 42);
INSERT INTO character_code (layer_id, code, kind, screen_code) VALUES (1, 43, 'PRINTABLE', 43);
INSERT INTO character_code (layer_id, code, kind, screen_code) VALUES (1, 44, 'PRINTABLE', 44);
INSERT INTO character_code (layer_id, code, kind, screen_code) VALUES (1, 45, 'PRINTABLE', 45);
INSERT INTO character_code (layer_id, code, kind, screen_code) VALUES (1, 46, 'PRINTABLE', 46);
INSERT INTO character_code (layer_id, code, kind, screen_code) VALUES (1, 47, 'PRINTABLE', 47);
INSERT INTO character_code (layer_id, code, kind, screen_code) VALUES (1, 48, 'PRINTABLE', 48);
INSERT INTO character_code (layer_id, code, kind, screen_code) VALUES (1, 49, 'PRINTABLE', 49);
INSERT INTO character_code (layer_id, code, kind, screen_code) VALUES (1, 50, 'PRINTABLE', 50);
INSERT INTO character_code (layer_id, code, kind, screen_code) VALUES (1, 51, 'PRINTABLE', 51);
INSERT INTO character_code (layer_id, code, kind, screen_code) VALUES (1, 52, 'PRINTABLE', 52);
INSERT INTO character_code (layer_id, code, kind, screen_code) VALUES (1, 53, 'PRINTABLE', 53);
INSERT INTO character_code (layer_id, code, kind, screen_code) VALUES (1, 54, 'PRINTABLE', 54);
INSERT INTO character_code (layer_id, code, kind, screen_code) VALUES (1, 55, 'PRINTABLE', 55);
INSERT INTO character_code (layer_id, code, kind, screen_code) VALUES (1, 56, 'PRINTABLE', 56);
INSERT INTO character_code (layer_id, code, kind, screen_code) VALUES (1, 57, 'PRINTABLE', 57);
INSERT INTO character_code (layer_id, code, kind, screen_code) VALUES (1, 58, 'PRINTABLE', 58);
INSERT INTO character_code (layer_id, code, kind, screen_code) VALUES (1, 59, 'PRINTABLE', 59);
INSERT INTO character_code (layer_id, code, kind, screen_code) VALUES (1, 60, 'PRINTABLE', 60);
INSERT INTO character_code (layer_id, code, kind, screen_code) VALUES (1, 61, 'PRINTABLE', 61);
INSERT INTO character_code (layer_id, code, kind, screen_code) VALUES (1, 62, 'PRINTABLE', 62);
INSERT INTO character_code (layer_id, code, kind, screen_code) VALUES (1, 63, 'PRINTABLE', 63);
INSERT INTO character_code (layer_id, code, kind, screen_code, notes) VALUES (1, 64, 'UNUSED', 15, 'Printed as ''?''');
INSERT INTO character_code (layer_id, code, kind, screen_code, notes) VALUES (1, 65, 'UNUSED', 15, 'Printed as ''?''');
INSERT INTO character_code (layer_id, code, kind, screen_code, notes) VALUES (1, 66, 'UNUSED', 15, 'Printed as ''?''');
INSERT INTO character_code (layer_id, code, kind, screen_code, notes) VALUES (1, 67, 'UNUSED', 15, 'Printed as ''?''');
INSERT INTO character_code (layer_id, code, kind, screen_code, notes) VALUES (1, 68, 'UNUSED', 15, 'Printed as ''?''');
INSERT INTO character_code (layer_id, code, kind, screen_code, notes) VALUES (1, 69, 'UNUSED', 15, 'Printed as ''?''');
INSERT INTO character_code (layer_id, code, kind, screen_code, notes) VALUES (1, 70, 'UNUSED', 15, 'Printed as ''?''');
INSERT INTO character_code (layer_id, code, kind, screen_code, notes) VALUES (1, 71, 'UNUSED', 15, 'Printed as ''?''');
INSERT INTO character_code (layer_id, code, kind, screen_code, notes) VALUES (1, 72, 'UNUSED', 15, 'Printed as ''?''');
INSERT INTO character_code (layer_id, code, kind, screen_code, notes) VALUES (1, 73, 'UNUSED', 15, 'Printed as ''?''');
INSERT INTO character_code (layer_id, code, kind, screen_code, notes) VALUES (1, 74, 'UNUSED', 15, 'Printed as ''?''');
INSERT INTO character_code (layer_id, code, kind, screen_code, notes) VALUES (1, 75, 'UNUSED', 15, 'Printed as ''?''');
INSERT INTO character_code (layer_id, code, kind, screen_code, notes) VALUES (1, 76, 'UNUSED', 15, 'Printed as ''?''');
INSERT INTO character_code (layer_id, code, kind, screen_code, notes) VALUES (1, 77, 'UNUSED', 15, 'Printed as ''?''');
INSERT INTO character_code (layer_id, code, kind, screen_code, notes) VALUES (1, 78, 'UNUSED', 15, 'Printed as ''?''');
INSERT INTO character_code (layer_id, code, kind, screen_code, notes) VALUES (1, 79, 'UNUSED', 15, 'Printed as ''?''');
INSERT INTO character_code (layer_id, code, kind, screen_code, notes) VALUES (1, 80, 'UNUSED', 15, 'Printed as ''?''');
INSERT INTO character_code (layer_id, code, kind, screen_code, notes) VALUES (1, 81, 'UNUSED', 15, 'Printed as ''?''');
INSERT INTO character_code (layer_id, code, kind, screen_code, notes) VALUES (1, 82, 'UNUSED', 15, 'Printed as ''?''');
INSERT INTO character_code (layer_id, code, kind, screen_code, notes) VALUES (1, 83, 'UNUSED', 15, 'Printed as ''?''');
INSERT INTO character_code (layer_id, code, kind, screen_code, notes) VALUES (1, 84, 'UNUSED', 15, 'Printed as ''?''');
INSERT INTO character_code (layer_id, code, kind, screen_code, notes) VALUES (1, 85, 'UNUSED', 15, 'Printed as ''?''');
INSERT INTO character_code (layer_id, code, kind, screen_code, notes) VALUES (1, 86, 'UNUSED', 15, 'Printed as ''?''');
INSERT INTO character_code (layer_id, code, kind, screen_code, notes) VALUES (1, 87, 'UNUSED', 15, 'Printed as ''?''');
INSERT INTO character_code (layer_id, code, kind, screen_code, notes) VALUES (1, 88, 'UNUSED', 15, 'Printed as ''?''');
INSERT INTO character_code (layer_id, code, kind, screen_code, notes) VALUES (1, 89, 'UNUSED', 15, 'Printed as ''?''');
INSERT INTO character_code (layer_id, code, kind, screen_code, notes) VALUES (1, 90, 'UNUSED', 15, 'Printed as ''?''');
INSERT INTO character_code (layer_id, code, kind, screen_code, notes) VALUES (1, 91, 'UNUSED', 15, 'Printed as ''?''');
INSERT INTO character_code (layer_id, code, kind, screen_code, notes) VALUES (1, 92, 'UNUSED', 15, 'Printed as ''?''');
INSERT INTO character_code (layer_id, code, kind, screen_code, notes) VALUES (1, 93, 'UNUSED', 15, 'Printed as ''?''');
INSERT INTO character_code (layer_id, code, kind, screen_code, notes) VALUES (1, 94, 'UNUSED', 15, 'Printed as ''?''');
INSERT INTO character_code (layer_id, code, kind, screen_code, notes) VALUES (1, 95, 'UNUSED', 15, 'Printed as ''?''');
INSERT INTO character_code (layer_id, code, kind, screen_code, notes) VALUES (1, 96, 'UNUSED', 15, 'Printed as ''?''');
INSERT INTO character_code (layer_id, code, kind, screen_code, notes) VALUES (1, 97, 'UNUSED', 15, 'Printed as ''?''');
INSERT INTO character_code (layer_id, code, kind, screen_code, notes) VALUES (1, 98, 'UNUSED', 15, 'Printed as ''?''');
INSERT INTO character_code (layer_id, code, kind, screen_code, notes) VALUES (1, 99, 'UNUSED', 15, 'Printed as ''?''');
INSERT INTO character_code (layer_id, code, kind, screen_code, notes) VALUES (1, 100, 'UNUSED', 15, 'Printed as ''?''');
INSERT INTO character_code (layer_id, code, kind, screen_code, notes) VALUES (1, 101, 'UNUSED', 15, 'Printed as ''?''');
INSERT INTO character_code (layer_id, code, kind, screen_code, notes) VALUES (1, 102, 'UNUSED', 15, 'Printed as ''?''');
INSERT INTO character_code (layer_id, code, kind, screen_code, notes) VALUES (1, 103, 'UNUSED', 15, 'Printed as ''?''');
INSERT INTO character_code (layer_id, code, kind, screen_code, notes) VALUES (1, 104, 'UNUSED', 15, 'Printed as ''?''');
INSERT INTO character_code (layer_id, code, kind, screen_code, notes) VALUES (1, 105, 'UNUSED', 15, 'Printed as ''?''');
INSERT INTO character_code (layer_id, code, kind, screen_code, notes) VALUES (1, 106, 'UNUSED', 15, 'Printed as ''?''');
INSERT INTO character_code (layer_id, code, kind, screen_code, notes) VALUES (1, 107, 'UNUSED', 15, 'Printed as ''?''');
INSERT INTO character_code (layer_id, code, kind, screen_code, notes) VALUES (1, 108, 'UNUSED', 15, 'Printed as ''?''');
INSERT INTO character_code (layer_id, code, kind, screen_code, notes) VALUES (1, 109, 'UNUSED', 15, 'Printed as ''?''');
INSERT INTO character_code (layer_id, code, kind, screen_code, notes) VALUES (1, 110, 'UNUSED', 15, 'Printed as ''?''');
INSERT INTO character_code (layer_id, code, kind, screen_code, notes) VALUES (1, 111, 'UNUSED', 15, 'Printed as ''?''');
INSERT INTO character_code (layer_id, code, kind, screen_code, notes) VALUES (1, 112, 'UNUSED', 15, 'Printed as ''?''');
INSERT INTO character_code (layer_id, code, kind, screen_code, notes) VALUES (1, 113, 'UNUSED', 15, 'Printed as ''?''');
INSERT INTO character_code (layer_id, code, kind, screen_code, notes) VALUES (1, 114, 'UNUSED', 15, 'Printed as ''?''');
INSERT INTO character_code (layer_id, code, kind, screen_code, notes) VALUES (1, 115, 'UNUSED', 15, 'Printed as ''?''');
INSERT INTO character_code (layer_id, code, kind, screen_code, notes) VALUES (1, 116, 'UNUSED', 15, 'Printed as ''?''');
INSERT INTO character_code (layer_id, code, kind, screen_code, notes) VALUES (1, 117, 'UNUSED', 15, 'Printed as ''?''');
INSERT INTO character_code (layer_id, code, kind, screen_code, notes) VALUES (1, 118, 'UNUSED', 15, 'Printed as ''?''');
INSERT INTO character_code (layer_id, code, kind, screen_code, notes) VALUES (1, 119, 'UNUSED', 15, 'Printed as ''?''');
INSERT INTO character_code (layer_id, code, kind, screen_code, notes) VALUES (1, 120, 'UNUSED', 15, 'Printed as ''?''');
INSERT INTO character_code (layer_id, code, kind, screen_code, notes) VALUES (1, 121, 'UNUSED', 15, 'Printed as ''?''');
INSERT INTO character_code (layer_id, code, kind, screen_code, notes) VALUES (1, 122, 'UNUSED', 15, 'Printed as ''?''');
INSERT INTO character_code (layer_id, code, kind, screen_code, notes) VALUES (1, 123, 'UNUSED', 15, 'Printed as ''?''');
INSERT INTO character_code (layer_id, code, kind, screen_code, notes) VALUES (1, 124, 'UNUSED', 15, 'Printed as ''?''');
INSERT INTO character_code (layer_id, code, kind, screen_code, notes) VALUES (1, 125, 'UNUSED', 15, 'Printed as ''?''');
INSERT INTO character_code (layer_id, code, kind, screen_code, notes) VALUES (1, 126, 'UNUSED', 15, 'Printed as ''?''');
INSERT INTO character_code (layer_id, code, kind, screen_code, notes) VALUES (1, 127, 'UNUSED', 15, 'Printed as ''?''');
INSERT INTO character_code (layer_id, code, kind, screen_code) VALUES (1, 128, 'PRINTABLE', 128);
INSERT INTO character_code (layer_id, code, kind, screen_code) VALUES (1, 129, 'PRINTABLE', 129);
INSERT INTO character_code (layer_id, code, kind, screen_code) VALUES (1, 130, 'PRINTABLE', 130);
INSERT INTO character_code (layer_id, code, kind, screen_code) VALUES (1, 131, 'PRINTABLE', 131);
INSERT INTO character_code (layer_id, code, kind, screen_code) VALUES (1, 132, 'PRINTABLE', 132);
INSERT INTO character_code (layer_id, code, kind, screen_code) VALUES (1, 133, 'PRINTABLE', 133);
INSERT INTO character_code (layer_id, code, kind, screen_code) VALUES (1, 134, 'PRINTABLE', 134);
INSERT INTO character_code (layer_id, code, kind, screen_code) VALUES (1, 135, 'PRINTABLE', 135);
INSERT INTO character_code (layer_id, code, kind, screen_code) VALUES (1, 136, 'PRINTABLE', 136);
INSERT INTO character_code (layer_id, code, kind, screen_code) VALUES (1, 137, 'PRINTABLE', 137);
INSERT INTO character_code (layer_id, code, kind, screen_code) VALUES (1, 138, 'PRINTABLE', 138);
INSERT INTO character_code (layer_id, code, kind, screen_code) VALUES (1, 139, 'PRINTABLE', 139);
INSERT INTO character_code (layer_id, code, kind, screen_code) VALUES (1, 140, 'PRINTABLE', 140);
INSERT INTO character_code (layer_id, code, kind, screen_code) VALUES (1, 141, 'PRINTABLE', 141);
INSERT INTO character_code (layer_id, code, kind, screen_code) VALUES (1, 142, 'PRINTABLE', 142);
INSERT INTO character_code (layer_id, code, kind, screen_code) VALUES (1, 143, 'PRINTABLE', 143);
INSERT INTO character_code (layer_id, code, kind, screen_code) VALUES (1, 144, 'PRINTABLE', 144);
INSERT INTO character_code (layer_id, code, kind, screen_code) VALUES (1, 145, 'PRINTABLE', 145);
INSERT INTO character_code (layer_id, code, kind, screen_code) VALUES (1, 146, 'PRINTABLE', 146);
INSERT INTO character_code (layer_id, code, kind, screen_code) VALUES (1, 147, 'PRINTABLE', 147);
INSERT INTO character_code (layer_id, code, kind, screen_code) VALUES (1, 148, 'PRINTABLE', 148);
INSERT INTO character_code (layer_id, code, kind, screen_code) VALUES (1, 149, 'PRINTABLE', 149);
INSERT INTO character_code (layer_id, code, kind, screen_code) VALUES (1, 150, 'PRINTABLE', 150);
INSERT INTO character_code (layer_id, code, kind, screen_code) VALUES (1, 151, 'PRINTABLE', 151);
INSERT INTO character_code (layer_id, code, kind, screen_code) VALUES (1, 152, 'PRINTABLE', 152);
INSERT INTO character_code (layer_id, code, kind, screen_code) VALUES (1, 153, 'PRINTABLE', 153);
INSERT INTO character_code (layer_id, code, kind, screen_code) VALUES (1, 154, 'PRINTABLE', 154);
INSERT INTO character_code (layer_id, code, kind, screen_code) VALUES (1, 155, 'PRINTABLE', 155);
INSERT INTO character_code (layer_id, code, kind, screen_code) VALUES (1, 156, 'PRINTABLE', 156);
INSERT INTO character_code (layer_id, code, kind, screen_code) VALUES (1, 157, 'PRINTABLE', 157);
INSERT INTO character_code (layer_id, code, kind, screen_code) VALUES (1, 158, 'PRINTABLE', 158);
INSERT INTO character_code (layer_id, code, kind, screen_code) VALUES (1, 159, 'PRINTABLE', 159);
INSERT INTO character_code (layer_id, code, kind, screen_code) VALUES (1, 160, 'PRINTABLE', 160);
INSERT INTO character_code (layer_id, code, kind, screen_code) VALUES (1, 161, 'PRINTABLE', 161);
INSERT INTO character_code (layer_id, code, kind, screen_code) VALUES (1, 162, 'PRINTABLE', 162);
INSERT INTO character_code (layer_id, code, kind, screen_code) VALUES (1, 163, 'PRINTABLE', 163);
INSERT INTO character_code (layer_id, code, kind, screen_code) VALUES (1, 164, 'PRINTABLE', 164);
INSERT INTO character_code (layer_id, code, kind, screen_code) VALUES (1, 165, 'PRINTABLE', 165);
INSERT INTO character_code (layer_id, code, kind, screen_code) VALUES (1, 166, 'PRINTABLE', 166);
INSERT INTO character_code (layer_id, code, kind, screen_code) VALUES (1, 167, 'PRINTABLE', 167);
INSERT INTO character_code (layer_id, code, kind, screen_code) VALUES (1, 168, 'PRINTABLE', 168);
INSERT INTO character_code (layer_id, code, kind, screen_code) VALUES (1, 169, 'PRINTABLE', 169);
INSERT INTO character_code (layer_id, code, kind, screen_code) VALUES (1, 170, 'PRINTABLE', 170);
INSERT INTO character_code (layer_id, code, kind, screen_code) VALUES (1, 171, 'PRINTABLE', 171);
INSERT INTO character_code (layer_id, code, kind, screen_code) VALUES (1, 172, 'PRINTABLE', 172);
INSERT INTO character_code (layer_id, code, kind, screen_code) VALUES (1, 173, 'PRINTABLE', 173);
INSERT INTO character_code (layer_id, code, kind, screen_code) VALUES (1, 174, 'PRINTABLE', 174);
INSERT INTO character_code (layer_id, code, kind, screen_code) VALUES (1, 175, 'PRINTABLE', 175);
INSERT INTO character_code (layer_id, code, kind, screen_code) VALUES (1, 176, 'PRINTABLE', 176);
INSERT INTO character_code (layer_id, code, kind, screen_code) VALUES (1, 177, 'PRINTABLE', 177);
INSERT INTO character_code (layer_id, code, kind, screen_code) VALUES (1, 178, 'PRINTABLE', 178);
INSERT INTO character_code (layer_id, code, kind, screen_code) VALUES (1, 179, 'PRINTABLE', 179);
INSERT INTO character_code (layer_id, code, kind, screen_code) VALUES (1, 180, 'PRINTABLE', 180);
INSERT INTO character_code (layer_id, code, kind, screen_code) VALUES (1, 181, 'PRINTABLE', 181);
INSERT INTO character_code (layer_id, code, kind, screen_code) VALUES (1, 182, 'PRINTABLE', 182);
INSERT INTO character_code (layer_id, code, kind, screen_code) VALUES (1, 183, 'PRINTABLE', 183);
INSERT INTO character_code (layer_id, code, kind, screen_code) VALUES (1, 184, 'PRINTABLE', 184);
INSERT INTO character_code (layer_id, code, kind, screen_code) VALUES (1, 185, 'PRINTABLE', 185);
INSERT INTO character_code (layer_id, code, kind, screen_code) VALUES (1, 186, 'PRINTABLE', 186);
INSERT INTO character_code (layer_id, code, kind, screen_code) VALUES (1, 187, 'PRINTABLE', 187);
INSERT INTO character_code (layer_id, code, kind, screen_code) VALUES (1, 188, 'PRINTABLE', 188);
INSERT INTO character_code (layer_id, code, kind, screen_code) VALUES (1, 189, 'PRINTABLE', 189);
INSERT INTO character_code (layer_id, code, kind, screen_code) VALUES (1, 190, 'PRINTABLE', 190);
INSERT INTO character_code (layer_id, code, kind, screen_code) VALUES (1, 191, 'PRINTABLE', 191);
INSERT INTO character_code (layer_id, code, kind, screen_code, notes) VALUES (1, 192, 'UNUSED', 15, 'Printed as ''?''');
INSERT INTO character_code (layer_id, code, kind, screen_code, notes) VALUES (1, 193, 'UNUSED', 15, 'Printed as ''?''');
INSERT INTO character_code (layer_id, code, kind, screen_code, notes) VALUES (1, 194, 'UNUSED', 15, 'Printed as ''?''');
INSERT INTO character_code (layer_id, code, kind, screen_code, notes) VALUES (1, 195, 'UNUSED', 15, 'Printed as ''?''');
INSERT INTO character_code (layer_id, code, kind, screen_code, notes) VALUES (1, 196, 'UNUSED', 15, 'Printed as ''?''');
INSERT INTO character_code (layer_id, code, kind, screen_code, notes) VALUES (1, 197, 'UNUSED', 15, 'Printed as ''?''');
INSERT INTO character_code (layer_id, code, kind, screen_code, notes) VALUES (1, 198, 'UNUSED', 15, 'Printed as ''?''');
INSERT INTO character_code (layer_id, code, kind, screen_code, notes) VALUES (1, 199, 'UNUSED', 15, 'Printed as ''?''');
INSERT INTO character_code (layer_id, code, kind, screen_code, notes) VALUES (1, 200, 'UNUSED', 15, 'Printed as ''?''');
INSERT INTO character_code (layer_id, code, kind, screen_code, notes) VALUES (1, 201, 'UNUSED', 15, 'Printed as ''?''');
INSERT INTO character_code (layer_id, code, kind, screen_code, notes) VALUES (1, 202, 'UNUSED', 15, 'Printed as ''?''');
INSERT INTO character_code (layer_id, code, kind, screen_code, notes) VALUES (1, 203, 'UNUSED', 15, 'Printed as ''?''');
INSERT INTO character_code (layer_id, code, kind, screen_code, notes) VALUES (1, 204, 'UNUSED', 15, 'Printed as ''?''');
INSERT INTO character_code (layer_id, code, kind, screen_code, notes) VALUES (1, 205, 'UNUSED', 15, 'Printed as ''?''');
INSERT INTO character_code (layer_id, code, kind, screen_code, notes) VALUES (1, 206, 'UNUSED', 15, 'Printed as ''?''');
INSERT INTO character_code (layer_id, code, kind, screen_code, notes) VALUES (1, 207, 'UNUSED', 15, 'Printed as ''?''');
INSERT INTO character_code (layer_id, code, kind, screen_code, notes) VALUES (1, 208, 'UNUSED', 15, 'Printed as ''?''');
INSERT INTO character_code (layer_id, code, kind, screen_code, notes) VALUES (1, 209, 'UNUSED', 15, 'Printed as ''?''');
INSERT INTO character_code (layer_id, code, kind, screen_code, notes) VALUES (1, 210, 'UNUSED', 15, 'Printed as ''?''');
INSERT INTO character_code (layer_id, code, kind, screen_code, notes) VALUES (1, 211, 'UNUSED', 15, 'Printed as ''?''');
INSERT INTO character_code (layer_id, code, kind) VALUES (1, 212, 'TOKEN');
INSERT INTO character_code (layer_id, code, kind) VALUES (1, 213, 'TOKEN');
INSERT INTO character_code (layer_id, code, kind) VALUES (1, 214, 'TOKEN');
INSERT INTO character_code (layer_id, code, kind) VALUES (1, 215, 'TOKEN');
INSERT INTO character_code (layer_id, code, kind) VALUES (1, 216, 'TOKEN');
INSERT INTO character_code (layer_id, code, kind) VALUES (1, 217, 'TOKEN');
INSERT INTO character_code (layer_id, code, kind) VALUES (1, 218, 'TOKEN');
INSERT INTO character_code (layer_id, code, kind) VALUES (1, 219, 'TOKEN');
INSERT INTO character_code (layer_id, code, kind) VALUES (1, 220, 'TOKEN');
INSERT INTO character_code (layer_id, code, kind) VALUES (1, 221, 'TOKEN');
INSERT INTO character_code (layer_id, code, kind) VALUES (1, 222, 'TOKEN');
INSERT INTO character_code (layer_id, code, kind) VALUES (1, 223, 'TOKEN');
INSERT INTO character_code (layer_id, code, kind) VALUES (1, 224, 'TOKEN');
INSERT INTO character_code (layer_id, code, kind) VALUES (1, 225, 'TOKEN');
INSERT INTO character_code (layer_id, code, kind) VALUES (1, 226, 'TOKEN');
INSERT INTO character_code (layer_id, code, kind) VALUES (1, 227, 'TOKEN');
INSERT INTO character_code (layer_id, code, kind) VALUES (1, 228, 'TOKEN');
INSERT INTO character_code (layer_id, code, kind) VALUES (1, 229, 'TOKEN');
INSERT INTO character_code (layer_id, code, kind) VALUES (1, 230, 'TOKEN');
INSERT INTO character_code (layer_id, code, kind) VALUES (1, 231, 'TOKEN');
INSERT INTO character_code (layer_id, code, kind) VALUES (1, 232, 'TOKEN');
INSERT INTO character_code (layer_id, code, kind) VALUES (1, 233, 'TOKEN');
INSERT INTO character_code (layer_id, code, kind) VALUES (1, 234, 'TOKEN');
INSERT INTO character_code (layer_id, code, kind) VALUES (1, 235, 'TOKEN');
INSERT INTO character_code (layer_id, code, kind) VALUES (1, 236, 'TOKEN');
INSERT INTO character_code (layer_id, code, kind) VALUES (1, 237, 'TOKEN');
INSERT INTO character_code (layer_id, code, kind) VALUES (1, 238, 'TOKEN');
INSERT INTO character_code (layer_id, code, kind) VALUES (1, 239, 'TOKEN');
INSERT INTO character_code (layer_id, code, kind) VALUES (1, 240, 'TOKEN');
INSERT INTO character_code (layer_id, code, kind, screen_code, notes) VALUES (1, 241, 'UNUSED', 15, 'Printed as ''?''');
INSERT INTO character_code (layer_id, code, kind, screen_code, notes) VALUES (1, 242, 'UNUSED', 15, 'Printed as ''?''');
INSERT INTO character_code (layer_id, code, kind) VALUES (1, 243, 'TOKEN');
INSERT INTO character_code (layer_id, code, kind) VALUES (1, 244, 'TOKEN');
INSERT INTO character_code (layer_id, code, kind, screen_code, notes) VALUES (1, 245, 'UNUSED', 15, 'Printed as ''?''');
INSERT INTO character_code (layer_id, code, kind) VALUES (1, 246, 'TOKEN');
INSERT INTO character_code (layer_id, code, kind) VALUES (1, 247, 'TOKEN');
INSERT INTO character_code (layer_id, code, kind) VALUES (1, 248, 'TOKEN');
INSERT INTO character_code (layer_id, code, kind) VALUES (1, 249, 'TOKEN');
INSERT INTO character_code (layer_id, code, kind) VALUES (1, 250, 'TOKEN');
INSERT INTO character_code (layer_id, code, kind) VALUES (1, 251, 'TOKEN');
INSERT INTO character_code (layer_id, code, kind) VALUES (1, 252, 'TOKEN');
INSERT INTO character_code (layer_id, code, kind) VALUES (1, 253, 'TOKEN');
INSERT INTO character_code (layer_id, code, kind) VALUES (1, 254, 'TOKEN');
INSERT INTO character_code (layer_id, code, kind, screen_code, notes) VALUES (1, 255, 'UNUSED', 15, 'Printed as ''?''');

INSERT INTO table_status (table_kind_id, layer_id, status, notes) SELECT id, 1, 'COMPLETE', NULL FROM table_kind WHERE code = 'CHARACTER_CODES';
INSERT INTO table_status (table_kind_id, layer_id, status, notes) SELECT id, 1, 'TO_DO', NULL FROM table_kind WHERE code = 'KEYBOARD_CODES';
INSERT INTO table_status (table_kind_id, layer_id, status, notes) SELECT id, 1, 'COMPLETE', NULL FROM table_kind WHERE code = 'ERRORS';
INSERT INTO table_status (table_kind_id, layer_id, status, notes) SELECT id, 1, 'COMPLETE', NULL FROM table_kind WHERE code = 'OPERATOR_PRECEDENCE';
INSERT INTO table_status (table_kind_id, layer_id, status, notes) SELECT id, 1, 'TO_DO', NULL FROM table_kind WHERE code = 'VARIABLE_LAYOUT';
INSERT INTO table_status (table_kind_id, layer_id, status, notes) SELECT id, 1, 'TO_DO', NULL FROM table_kind WHERE code = 'PROGRAM_LAYOUT';
INSERT INTO table_status (table_kind_id, layer_id, status, notes) SELECT id, 1, 'NOT_APPLICABLE', 'The ZX80 has no sound.' FROM table_kind WHERE code = 'MUSICAL_NOTES';
INSERT INTO table_status (table_kind_id, machine_id, status, notes) SELECT id, 1, 'COMPLETE', NULL FROM table_kind WHERE code = 'GLYPHS';
INSERT INTO table_status (table_kind_id, machine_id, status, notes) SELECT id, 1, 'COMPLETE', NULL FROM table_kind WHERE code = 'SCREEN_CODES';
INSERT INTO table_status (table_kind_id, machine_id, status, notes) SELECT id, 1, 'NOT_APPLICABLE', 'Black and white display.' FROM table_kind WHERE code = 'COLORS';

INSERT INTO source (id, title, author, publisher, year, kind, url, notes) VALUES (1, 'Sinclair ZX80 Operating Manual - A Course in BASIC Programming', 'Hugo Davenport', 'Science of Cambridge Ltd', 1980, 'MANUAL', NULL, 'Second edition');
INSERT INTO source (id, title, author, publisher, year, kind, url, notes) VALUES (2, 'An Assembly Listing of the ROM of the Sinclair ZX80', 'Geoff Wearmouth', NULL, 2002, 'WEB', NULL, 'Commented disassembly of the 4K ROM');
INSERT INTO source (id, title, author, publisher, year, kind, url, notes) VALUES (3, 'ZX80 character set', 'Wikipedia', NULL, NULL, 'WEB', 'https://en.wikipedia.org/wiki/ZX80_character_set', NULL);

INSERT INTO data_type (id, layer_id, code, name, suffix, type_class_id, minimum, maximum, bytes, notes) VALUES (1, 1, 'INT16', 'Integer', NULL, 2, -32768, 32767, 2, 'The only numeric type. Out of range: error 6.');
INSERT INTO data_type (id, layer_id, code, name, suffix, type_class_id, minimum, maximum, bytes, notes) VALUES (2, 1, 'STRING', 'String', '$', 4, NULL, NULL, NULL, 'Any length, including empty, limited only by memory. The character with code 1 acts as terminator.');

INSERT INTO variable_kind (id, layer_id, code, name, data_type_id, dimensions, name_rule, name_pattern, examples, notes) VALUES (1, 1, 'NUMERIC', 'Numeric variable', 1, 0, 'letter followed by letters or digits', '^[A-Z][A-Z0-9]*$', 'A, PIPPO24', 'No length limit.');
INSERT INTO variable_kind (id, layer_id, code, name, data_type_id, dimensions, name_rule, name_pattern, examples, notes) VALUES (2, 1, 'STRING', 'String variable', 2, 0, 'one letter followed by $', '^[A-Z]\$$', 'A$, Z$', 'At most 26 string variables.');
INSERT INTO variable_kind (id, layer_id, code, name, data_type_id, dimensions, name_rule, name_pattern, examples, notes) VALUES (3, 1, 'NUMERIC_ARRAY', 'Numeric array', 1, 1, 'one letter; an element is written with one integer subscript in parentheses', '^[A-Z]$', 'B(5), F(12)', 'One dimension, subscripts from 0 to n (DIM). An array can have the same name as a variable (not recommended). The manual describes integer arrays only.');
INSERT INTO variable_kind (id, layer_id, code, name, data_type_id, dimensions, name_rule, name_pattern, examples, notes) VALUES (4, 1, 'LOOP_CONTROL', 'Loop control variable', 1, 0, 'one letter', '^[A-Z]$', 'I', NULL);

INSERT INTO parameter_kind (id, layer_id, code, name, nature, type_class_id, variable_kind_id, notes) VALUES (1, 1, 'NUM_LITERAL', 'Numeric literal', 'LITERAL', 1, NULL, NULL);
INSERT INTO parameter_kind (id, layer_id, code, name, nature, type_class_id, variable_kind_id, notes) VALUES (2, 1, 'STR_LITERAL', 'String literal', 'LITERAL', 4, NULL, 'Enclosed in quotes.');
INSERT INTO parameter_kind (id, layer_id, code, name, nature, type_class_id, variable_kind_id, notes) VALUES (3, 1, 'NUM_EXPR', 'Numeric expression', 'EXPRESSION', 1, NULL, NULL);
INSERT INTO parameter_kind (id, layer_id, code, name, nature, type_class_id, variable_kind_id, notes) VALUES (4, 1, 'STR_EXPR', 'String expression', 'EXPRESSION', 4, NULL, NULL);
INSERT INTO parameter_kind (id, layer_id, code, name, nature, type_class_id, variable_kind_id, notes) VALUES (5, 1, 'NUM_VAR', 'Numeric variable name', 'VARIABLE', NULL, 1, NULL);
INSERT INTO parameter_kind (id, layer_id, code, name, nature, type_class_id, variable_kind_id, notes) VALUES (6, 1, 'STR_VAR', 'String variable name', 'VARIABLE', NULL, 2, NULL);
INSERT INTO parameter_kind (id, layer_id, code, name, nature, type_class_id, variable_kind_id, notes) VALUES (7, 1, 'ARRAY_NAME', 'Numeric array name', 'ARRAY_NAME', NULL, 3, NULL);
INSERT INTO parameter_kind (id, layer_id, code, name, nature, type_class_id, variable_kind_id, notes) VALUES (8, 1, 'ARRAY_ELEMENT', 'Numeric array element', 'ARRAY_ELEMENT', NULL, 3, 'E.g. B(3).');
INSERT INTO parameter_kind (id, layer_id, code, name, nature, type_class_id, variable_kind_id, notes) VALUES (9, 1, 'LOOP_VAR', 'Loop control variable name', 'VARIABLE', NULL, 4, NULL);
INSERT INTO parameter_kind (id, layer_id, code, name, nature, type_class_id, variable_kind_id, notes) VALUES (10, 1, 'FREE_TEXT', 'Free text', 'FREE_TEXT', NULL, NULL, NULL);
INSERT INTO parameter_kind (id, layer_id, code, name, nature, type_class_id, variable_kind_id, notes) VALUES (11, 1, 'STATEMENT', 'Statement', 'STATEMENT', NULL, NULL, NULL);
INSERT INTO parameter_kind (id, layer_id, code, name, nature, type_class_id, variable_kind_id, notes) VALUES (12, 1, 'CONDITION', 'Condition', 'CONDITION', 1, NULL, 'Usually a relational expression, whose terms can also be strings (A$="Y"); its numeric value is read with the truth test: 0 = false, otherwise true.');

INSERT INTO feature (layer_id, code, value, description) VALUES (1, 'LINE_NUMBERS', '1-9999', 'Range of line numbers.');
INSERT INTO feature (layer_id, code, value, description) VALUES (1, 'STATEMENTS_PER_LINE', '1', 'One statement per line: there is no '':'' separator.');
INSERT INTO feature (layer_id, code, value, description) VALUES (1, 'ARITHMETIC', '16-bit integer', 'Values from -32768 to 32767; out of range: error 6.');
INSERT INTO feature (layer_id, code, value, description) VALUES (1, 'DIVISION', 'truncates towards zero', NULL);
INSERT INTO feature (layer_id, code, value, description) VALUES (1, 'TRUE_VALUE', '-1', 'Value produced by a true comparison.');
INSERT INTO feature (layer_id, code, value, description) VALUES (1, 'FALSE_VALUE', '0', 'Value produced by a false comparison.');
INSERT INTO feature (layer_id, code, value, description) VALUES (1, 'TRUTH_TEST', 'NONZERO', 'A number used as a condition is true if it is not 0. AND, OR and NOT work bit by bit: NOT 1 = -2, which is true.');
INSERT INTO feature (layer_id, code, value, description) VALUES (1, 'FOR_STEP', 'fixed at 1', 'There is no STEP.');
INSERT INTO feature (layer_id, code, value, description) VALUES (1, 'LET', 'mandatory', 'Every statement starts with a keyword.');
INSERT INTO feature (layer_id, code, value, description) VALUES (1, 'KEYWORD_ENTRY', 'one key for statements and commands', 'With the K cursor the key enters the whole keyword; functions are typed letter by letter.');
INSERT INTO feature (layer_id, code, value, description) VALUES (1, 'ERROR_FORMAT', 'n/m', 'n = code (0 = no error), m = line number.');
INSERT INTO feature (layer_id, code, value, description) VALUES (1, 'SCREEN', '32 columns', 'A comma in PRINT moves to the next zone (4 zones of 8 columns).');

INSERT INTO error (layer_id, code, number, message, description) VALUES (1, 'OK', 0, '0/n', 'No error: command executed, end of program, BREAK pressed, or GO TO a line beyond the end of the program.');
INSERT INTO error (layer_id, code, number, message, description) VALUES (1, 'NEXT_WITHOUT_FOR', 1, '1/n', 'NEXT with a variable that is not the counter of an active FOR loop.');
INSERT INTO error (layer_id, code, number, message, description) VALUES (1, 'VARIABLE_NOT_FOUND', 2, '2/n', 'Undefined variable (also an array that has not been dimensioned).');
INSERT INTO error (layer_id, code, number, message, description) VALUES (1, 'SUBSCRIPT_OUT_OF_RANGE', 3, '3/n', 'Array subscript out of range, or error while computing the subscript.');
INSERT INTO error (layer_id, code, number, message, description) VALUES (1, 'OUT_OF_MEMORY', 4, '4/n', 'Out of memory for a new variable, a longer string or the screen.');
INSERT INTO error (layer_id, code, number, message, description) VALUES (1, 'SCREEN_FULL', 5, '5/n', 'No more room on the screen (PRINT).');
INSERT INTO error (layer_id, code, number, message, description) VALUES (1, 'OVERFLOW', 6, '6/n', 'Result outside the range from -32768 to 32767.');
INSERT INTO error (layer_id, code, number, message, description) VALUES (1, 'RETURN_WITHOUT_GOSUB', 7, '7/n', 'RETURN without a matching GO SUB.');
INSERT INTO error (layer_id, code, number, message, description) VALUES (1, 'INPUT_AS_COMMAND', 8, '8/n', 'INPUT can only be used in a program.');
INSERT INTO error (layer_id, code, number, message, description) VALUES (1, 'STOP', 9, '9/n', 'STOP statement executed; CONTINUE resumes from the next line.');

INSERT INTO keyword (id, layer_id, text, notes) VALUES (1, 1, '"', 'String delimiter. Code used in the program; on screen the character has code 1.');
INSERT INTO token (keyword_id, hex_value) VALUES (1, 'D4');
INSERT INTO keyword (id, layer_id, text, notes) VALUES (2, 1, 'THEN', NULL);
INSERT INTO token (keyword_id, hex_value) VALUES (2, 'D5');
INSERT INTO keyword (id, layer_id, text, notes) VALUES (3, 1, 'TO', NULL);
INSERT INTO token (keyword_id, hex_value) VALUES (3, 'D6');
INSERT INTO keyword (id, layer_id, text, notes) VALUES (4, 1, ';', 'Symbol: code used in the program.');
INSERT INTO token (keyword_id, hex_value) VALUES (4, 'D7');
INSERT INTO keyword (id, layer_id, text, notes) VALUES (5, 1, ',', 'Symbol: code used in the program.');
INSERT INTO token (keyword_id, hex_value) VALUES (5, 'D8');
INSERT INTO keyword (id, layer_id, text, notes) VALUES (6, 1, ')', 'Symbol: code used in the program (on screen 17).');
INSERT INTO token (keyword_id, hex_value) VALUES (6, 'D9');
INSERT INTO keyword (id, layer_id, text, notes) VALUES (7, 1, '(', 'Symbol: code used in the program (on screen 16).');
INSERT INTO token (keyword_id, hex_value) VALUES (7, 'DA');
INSERT INTO keyword (id, layer_id, text, notes) VALUES (8, 1, 'NOT', NULL);
INSERT INTO token (keyword_id, hex_value) VALUES (8, 'DB');
INSERT INTO keyword (id, layer_id, text, notes) VALUES (9, 1, '-', 'Code used in the program (on screen 18).');
INSERT INTO token (keyword_id, hex_value) VALUES (9, 'DC');
INSERT INTO keyword (id, layer_id, text, notes) VALUES (10, 1, '+', 'Code used in the program (on screen 19).');
INSERT INTO token (keyword_id, hex_value) VALUES (10, 'DD');
INSERT INTO keyword (id, layer_id, text, notes) VALUES (11, 1, '*', 'Code used in the program (on screen 20).');
INSERT INTO token (keyword_id, hex_value) VALUES (11, 'DE');
INSERT INTO keyword (id, layer_id, text, notes) VALUES (12, 1, '/', 'Code used in the program (on screen 21).');
INSERT INTO token (keyword_id, hex_value) VALUES (12, 'DF');
INSERT INTO keyword (id, layer_id, text, notes) VALUES (13, 1, 'AND', NULL);
INSERT INTO token (keyword_id, hex_value) VALUES (13, 'E0');
INSERT INTO keyword (id, layer_id, text, notes) VALUES (14, 1, 'OR', NULL);
INSERT INTO token (keyword_id, hex_value) VALUES (14, 'E1');
INSERT INTO keyword (id, layer_id, text, notes) VALUES (15, 1, '**', 'Multi-character operator reduced to a single code.');
INSERT INTO token (keyword_id, hex_value) VALUES (15, 'E2');
INSERT INTO keyword (id, layer_id, text, notes) VALUES (16, 1, '=', 'Code used in the program (on screen 22).');
INSERT INTO token (keyword_id, hex_value) VALUES (16, 'E3');
INSERT INTO keyword (id, layer_id, text, notes) VALUES (17, 1, '>', 'Appendix II of the manual swaps > and < (source [3]).');
INSERT INTO token (keyword_id, hex_value) VALUES (17, 'E4');
INSERT INTO keyword (id, layer_id, text, notes) VALUES (18, 1, '<', 'Appendix II of the manual swaps > and < (source [3]).');
INSERT INTO token (keyword_id, hex_value) VALUES (18, 'E5');
INSERT INTO keyword (id, layer_id, text, notes) VALUES (19, 1, 'LIST', NULL);
INSERT INTO token (keyword_id, hex_value) VALUES (19, 'E6');
INSERT INTO keyword (id, layer_id, text, notes) VALUES (20, 1, 'RETURN', NULL);
INSERT INTO token (keyword_id, hex_value) VALUES (20, 'E7');
INSERT INTO keyword (id, layer_id, text, notes) VALUES (21, 1, 'CLS', NULL);
INSERT INTO token (keyword_id, hex_value) VALUES (21, 'E8');
INSERT INTO keyword (id, layer_id, text, notes) VALUES (22, 1, 'DIM', NULL);
INSERT INTO token (keyword_id, hex_value) VALUES (22, 'E9');
INSERT INTO keyword (id, layer_id, text, notes) VALUES (23, 1, 'SAVE', NULL);
INSERT INTO token (keyword_id, hex_value) VALUES (23, 'EA');
INSERT INTO keyword (id, layer_id, text, notes) VALUES (24, 1, 'FOR', NULL);
INSERT INTO token (keyword_id, hex_value) VALUES (24, 'EB');
INSERT INTO keyword (id, layer_id, text, notes) VALUES (25, 1, 'GO TO', NULL);
INSERT INTO token (keyword_id, hex_value) VALUES (25, 'EC');
INSERT INTO keyword (id, layer_id, text, notes) VALUES (26, 1, 'POKE', NULL);
INSERT INTO token (keyword_id, hex_value) VALUES (26, 'ED');
INSERT INTO keyword (id, layer_id, text, notes) VALUES (27, 1, 'INPUT', NULL);
INSERT INTO token (keyword_id, hex_value) VALUES (27, 'EE');
INSERT INTO keyword (id, layer_id, text, notes) VALUES (28, 1, 'RANDOMISE', NULL);
INSERT INTO token (keyword_id, hex_value) VALUES (28, 'EF');
INSERT INTO keyword (id, layer_id, text, notes) VALUES (29, 1, 'LET', NULL);
INSERT INTO token (keyword_id, hex_value) VALUES (29, 'F0');
INSERT INTO keyword (id, layer_id, text, notes) VALUES (30, 1, 'NEXT', NULL);
INSERT INTO token (keyword_id, hex_value) VALUES (30, 'F3');
INSERT INTO keyword (id, layer_id, text, notes) VALUES (31, 1, 'PRINT', NULL);
INSERT INTO token (keyword_id, hex_value) VALUES (31, 'F4');
INSERT INTO keyword (id, layer_id, text, notes) VALUES (32, 1, 'NEW', NULL);
INSERT INTO token (keyword_id, hex_value) VALUES (32, 'F6');
INSERT INTO keyword (id, layer_id, text, notes) VALUES (33, 1, 'RUN', NULL);
INSERT INTO token (keyword_id, hex_value) VALUES (33, 'F7');
INSERT INTO keyword (id, layer_id, text, notes) VALUES (34, 1, 'STOP', NULL);
INSERT INTO token (keyword_id, hex_value) VALUES (34, 'F8');
INSERT INTO keyword (id, layer_id, text, notes) VALUES (35, 1, 'CONTINUE', NULL);
INSERT INTO token (keyword_id, hex_value) VALUES (35, 'F9');
INSERT INTO keyword (id, layer_id, text, notes) VALUES (36, 1, 'IF', NULL);
INSERT INTO token (keyword_id, hex_value) VALUES (36, 'FA');
INSERT INTO keyword (id, layer_id, text, notes) VALUES (37, 1, 'GO SUB', NULL);
INSERT INTO token (keyword_id, hex_value) VALUES (37, 'FB');
INSERT INTO keyword (id, layer_id, text, notes) VALUES (38, 1, 'LOAD', NULL);
INSERT INTO token (keyword_id, hex_value) VALUES (38, 'FC');
INSERT INTO keyword (id, layer_id, text, notes) VALUES (39, 1, 'CLEAR', NULL);
INSERT INTO token (keyword_id, hex_value) VALUES (39, 'FD');
INSERT INTO keyword (id, layer_id, text, notes) VALUES (40, 1, 'REM', NULL);
INSERT INTO token (keyword_id, hex_value) VALUES (40, 'FE');
INSERT INTO keyword (id, layer_id, text, notes) VALUES (41, 1, 'ABS', 'Function: typed letter by letter, it has no token.');
INSERT INTO keyword (id, layer_id, text, notes) VALUES (42, 1, 'CHR$', 'Function: typed letter by letter, it has no token.');
INSERT INTO keyword (id, layer_id, text, notes) VALUES (43, 1, 'CODE', 'Function: typed letter by letter, it has no token.');
INSERT INTO keyword (id, layer_id, text, notes) VALUES (44, 1, 'PEEK', 'Function: typed letter by letter, it has no token.');
INSERT INTO keyword (id, layer_id, text, notes) VALUES (45, 1, 'RND', 'Function: typed letter by letter, it has no token.');
INSERT INTO keyword (id, layer_id, text, notes) VALUES (46, 1, 'STR$', 'Function: typed letter by letter, it has no token.');
INSERT INTO keyword (id, layer_id, text, notes) VALUES (47, 1, 'TL$', 'Function: typed letter by letter, it has no token.');
INSERT INTO keyword (id, layer_id, text, notes) VALUES (48, 1, 'USR', 'Function: typed letter by letter, it has no token.');

-- LIST
INSERT INTO entry (id, layer_id, name, category_id, description, notes) VALUES (1, 1, 'LIST', 2, 'Lists the program from a given line, which becomes the current line.', NULL);
INSERT INTO entry_source (entry_id, source_id, page) VALUES (1, 1, 'Appendix II');
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, precedence, associativity, operator_class_id) VALUES (1, 1, 1, NULL, NULL, 'LIST n', 1, 'Appendix II', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description) VALUES (1, 1, 'n', 'NONE', NULL, 'NEXT_LINE', 'Line to start from; without an argument it is 0. An error while computing n is not reported.');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (1, 1, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2, 1, 1, 1, 'KEYWORD', 0, NULL, 19);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (3, 1, 1, 2, 'OPTIONAL', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (4, 1, 3, 1, 'PARAMETER', 0, NULL, 1, 3);
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 1, id, 'FULL', NULL FROM action WHERE code = 'PROG_LIST';
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id) VALUES (1, NULL, 1, 'List from a line', 'Line 100 becomes the current line. If it does not exist, the listing starts from the next line.', 'LIST 100', 'The program from line 100 onwards.', 0, NULL);

-- RUN
INSERT INTO entry (id, layer_id, name, category_id, description, notes) VALUES (2, 1, 'RUN', 2, 'Runs the program: same as CLEAR followed by GO TO n.', NULL);
INSERT INTO entry_source (entry_id, source_id, page) VALUES (2, 1, 'Appendix II');
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, precedence, associativity, operator_class_id) VALUES (2, 2, 1, NULL, NULL, 'RUN n', 1, 'Appendix II', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description) VALUES (2, 2, 'n', 'NONE', NULL, 'NEXT_LINE', 'Starting line; without an argument it is 1.');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (5, 2, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (6, 2, 5, 1, 'KEYWORD', 0, NULL, 33);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (7, 2, 5, 2, 'OPTIONAL', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (8, 2, 7, 1, 'PARAMETER', 0, NULL, 2, 3);
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 2, id, 'FULL', 'Also clears the variables' FROM action WHERE code = 'PROG_RUN';
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id) VALUES (2, NULL, 1, 'Run the program', 'Clears the variables and runs the program from the first line.', 'RUN', NULL, 0, NULL);
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id) VALUES (2, NULL, 2, 'Run from a line', 'Clears the variables and runs the program from line 100.', 'RUN 100', NULL, 0, NULL);

-- NEW
INSERT INTO entry (id, layer_id, name, category_id, description, notes) VALUES (3, 1, 'NEW', 2, 'Returns the computer to its power-on state: erases program and variables.', NULL);
INSERT INTO entry_source (entry_id, source_id, page) VALUES (3, 1, 'Appendix II');
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, precedence, associativity, operator_class_id) VALUES (3, 3, 1, NULL, NULL, 'NEW', 1, 'Appendix II', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (9, 3, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (10, 3, 9, 1, 'KEYWORD', 0, NULL, 32);
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 3, id, 'FULL', NULL FROM action WHERE code = 'PROG_NEW';
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id) VALUES (3, NULL, 1, 'Erase everything', 'Program and variables are erased, as at power-on.', 'NEW', 'An empty screen.', 0, NULL);

-- CONTINUE
INSERT INTO entry (id, layer_id, name, category_id, description, notes) VALUES (4, 1, 'CONTINUE', 2, 'Resumes execution from the line of the last n/m report; after STOP (9/m) from line m+1.', NULL);
INSERT INTO entry_source (entry_id, source_id, page) VALUES (4, 1, 'Appendix II');
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, precedence, associativity, operator_class_id) VALUES (4, 4, 1, NULL, NULL, 'CONTINUE', 1, 'Appendix II', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (11, 4, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (12, 4, 11, 1, 'KEYWORD', 0, NULL, 35);
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 4, id, 'FULL', NULL FROM action WHERE code = 'FLOW_CONTINUE';
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id) VALUES (4, NULL, 1, 'Resume after STOP', 'RUN stops at line 10 with report 9/10; CONTINUE resumes from line 20.', '10 STOP
20 PRINT "AGAIN"
RUN
CONTINUE', '9/10
AGAIN', 0, NULL);

-- SAVE
INSERT INTO entry (id, layer_id, name, category_id, description, notes) VALUES (5, 1, 'SAVE', 2, 'Saves system variables, program and variables to tape, preceded by 5 seconds of silence.', 'Meant as a command, not as a program statement.');
INSERT INTO entry_source (entry_id, source_id, page) VALUES (5, 1, 'Appendix II');
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, precedence, associativity, operator_class_id) VALUES (5, 5, 1, NULL, NULL, 'SAVE', 1, 'Appendix II', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (13, 5, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (14, 5, 13, 1, 'KEYWORD', 0, NULL, 23);
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 5, id, 'FULL', 'No file name: it also saves the variables' FROM action WHERE code = 'TAPE_SAVE';
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id) VALUES (5, NULL, 1, 'Save to tape', 'Start the tape recorder in record before pressing NEWLINE: system variables, program and variables are saved.', 'SAVE', NULL, 0, NULL);

-- LOAD
INSERT INTO entry (id, layer_id, name, category_id, description, notes) VALUES (6, 1, 'LOAD', 2, 'Loads from tape system variables, program and variables saved with SAVE.', 'BREAK during the leader keeps the program in memory; BREAK after the data has started is the same as NEW.');
INSERT INTO entry_source (entry_id, source_id, page) VALUES (6, 1, 'Appendix II');
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, precedence, associativity, operator_class_id) VALUES (6, 6, 1, NULL, NULL, 'LOAD', 1, 'Appendix II', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (15, 6, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (16, 6, 15, 1, 'KEYWORD', 0, NULL, 38);
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 6, id, 'FULL', 'No file name: it loads the first program found' FROM action WHERE code = 'TAPE_LOAD';
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id) VALUES (6, NULL, 1, 'Load from tape', 'Start the tape recorder in play: the first program found is loaded with its variables.', 'LOAD', NULL, 0, NULL);

-- LET
INSERT INTO entry (id, layer_id, name, category_id, description, notes) VALUES (7, 1, 'LET', 1, 'Assigns a value to a variable. LET is mandatory.', NULL);
INSERT INTO entry_source (entry_id, source_id, page) VALUES (7, 1, 'Appendix II');
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, precedence, associativity, operator_class_id) VALUES (7, 7, 1, NULL, NULL, NULL, 1, 'Appendix II', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description) VALUES (3, 7, 'variable', 'NONE', NULL, NULL, 'Numeric variable, string variable or array element.');
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description) VALUES (4, 7, 'expression', 'NONE', NULL, NULL, 'Of the same type as the variable.');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (17, 7, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (18, 7, 17, 1, 'KEYWORD', 0, NULL, 29);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (19, 7, 17, 2, 'CHOICE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (20, 7, 19, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (21, 7, 20, 1, 'CHOICE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (22, 7, 21, 1, 'PARAMETER', 0, NULL, 3, 5);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (23, 7, 21, 2, 'PARAMETER', 0, NULL, 3, 8);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (24, 7, 20, 2, 'KEYWORD', 0, NULL, 16);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (25, 7, 20, 3, 'PARAMETER', 0, NULL, 4, 3);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (26, 7, 19, 2, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (27, 7, 26, 1, 'PARAMETER', 0, NULL, 3, 6);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (28, 7, 26, 2, 'KEYWORD', 0, NULL, 16);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (29, 7, 26, 3, 'PARAMETER', 0, NULL, 4, 4);
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 7, id, 'FULL', NULL FROM action WHERE code = 'VAR_LET';
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id) VALUES (7, 7, 1, 'Numeric variable', NULL, '10 LET A=5
20 PRINT A*2', '10', 0, NULL);
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id) VALUES (7, 7, 2, 'String variable', NULL, '10 LET N$="ZX80"
20 PRINT N$', 'ZX80', 0, NULL);
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id) VALUES (7, 7, 3, 'Array element', NULL, '10 DIM B(3)
20 LET B(2)=7
30 PRINT B(2)', '7', 0, NULL);

-- PRINT
INSERT INTO entry (id, layer_id, name, category_id, description, notes) VALUES (8, 1, 'PRINT', 1, 'Writes on the upper part of the screen.', NULL);
INSERT INTO entry_source (entry_id, source_id, page) VALUES (8, 1, 'Appendix II');
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, precedence, associativity, operator_class_id) VALUES (8, 8, 1, NULL, ''';'' joins the items; '','' moves to the next zone (columns 9, 17, 25). A trailing separator suppresses the new line.', 'PRINT list', 1, 'Appendix II', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description) VALUES (5, 8, 'item', 'NONE', NULL, NULL, 'Numeric or string expression. Strings appear without quotes, numbers as with STR$.');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (30, 8, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (31, 8, 30, 1, 'KEYWORD', 0, NULL, 31);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (32, 8, 30, 2, 'OPTIONAL', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (33, 8, 32, 1, 'CHOICE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (34, 8, 33, 1, 'PARAMETER', 0, NULL, 5, 3);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (35, 8, 33, 2, 'PARAMETER', 0, NULL, 5, 4);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, separator, min_occ, max_occ) VALUES (36, 8, 30, 3, 'REPEAT', 1, NULL, NULL, 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (37, 8, 36, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (38, 8, 37, 1, 'CHOICE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (39, 8, 38, 1, 'KEYWORD', 0, NULL, 4);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (40, 8, 38, 2, 'KEYWORD', 0, NULL, 5);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (41, 8, 37, 2, 'OPTIONAL', 1, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (42, 8, 41, 1, 'CHOICE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (43, 8, 42, 1, 'PARAMETER', 0, NULL, 5, 3);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (44, 8, 42, 2, 'PARAMETER', 0, NULL, 5, 4);
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 8, id, 'FULL', NULL FROM action WHERE code = 'IO_PRINT';
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id) VALUES (8, NULL, 1, 'String and number together', 'Prints a string followed by the value of A, without spaces.', 'PRINT "A=";A', NULL, 0, NULL);
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id) VALUES (8, NULL, 2, 'Print zones', 'The comma moves to the next zone (columns 9, 17, 25).', 'PRINT 1,2,3,4', 'Four numbers in the four 8-column zones of the line.', 0, NULL);

-- INPUT
INSERT INTO entry (id, layer_id, name, category_id, description, notes) VALUES (9, 1, 'INPUT', 1, 'Reads a value from the keyboard and assigns it to a variable.', 'Only inside a program: as a command it gives error 8. For a string the quotes appear, and they can be deleted.');
INSERT INTO entry_source (entry_id, source_id, page) VALUES (9, 1, 'Appendix II');
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, precedence, associativity, operator_class_id) VALUES (9, 9, 1, NULL, NULL, 'INPUT dest', 1, 'Appendix II', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description) VALUES (6, 9, 'destination', 'NONE', 'INPUT_AS_COMMAND', NULL, 'Numeric variable, string variable or array element. An expression can be typed.');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (45, 9, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (46, 9, 45, 1, 'KEYWORD', 0, NULL, 27);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (47, 9, 45, 2, 'CHOICE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (48, 9, 47, 1, 'PARAMETER', 0, NULL, 6, 5);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (49, 9, 47, 2, 'PARAMETER', 0, NULL, 6, 6);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (50, 9, 47, 3, 'PARAMETER', 0, NULL, 6, 8);
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 9, id, 'PARTIAL', 'One variable only, no prompt' FROM action WHERE code = 'IO_INPUT';
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id) VALUES (9, NULL, 1, 'Read a number', 'Run the program, type 21 and press NEWLINE.', '10 INPUT N
20 PRINT N*2', '42', 0, NULL);
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id) VALUES (9, NULL, 2, 'Read a string', 'Run the program, type HELLO and press NEWLINE (the quotes appear by themselves).', '10 INPUT A$
20 PRINT A$', 'HELLO', 0, NULL);

-- IF
INSERT INTO entry (id, layer_id, name, category_id, description, notes) VALUES (10, 1, 'IF', 1, 'Executes the statement after THEN if the condition is not zero.', NULL);
INSERT INTO entry_source (entry_id, source_id, page) VALUES (10, 1, 'Appendix II');
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, precedence, associativity, operator_class_id) VALUES (10, 10, 1, NULL, NULL, 'IF n THEN statement', 1, 'Appendix II', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description) VALUES (7, 10, 'condition', 'NONE', NULL, NULL, 'False if 0, true otherwise. Comparisons give -1 or 0.');
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description) VALUES (8, 10, 'statement', 'NONE', NULL, NULL, 'Any statement, with its keyword.');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (51, 10, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (52, 10, 51, 1, 'KEYWORD', 0, NULL, 36);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (53, 10, 51, 2, 'PARAMETER', 0, NULL, 7, 12);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (54, 10, 51, 3, 'KEYWORD', 0, NULL, 2);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (55, 10, 51, 4, 'PARAMETER', 0, NULL, 8, 11);
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 10, id, 'FULL', 'No ELSE' FROM action WHERE code = 'FLOW_IF';
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id) VALUES (10, NULL, 1, 'Conditional jump', 'Jumps to line 60 if J is 152.', 'IF J = 152 THEN GO TO 60', NULL, 0, 1);
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id) VALUES (10, NULL, 2, 'Comparing strings', 'Run the program, type Y and press NEWLINE.', '10 INPUT A$
20 IF A$="Y" THEN PRINT "YES"', 'YES', 0, NULL);

-- GO TO
INSERT INTO entry (id, layer_id, name, category_id, description, notes) VALUES (11, 1, 'GO TO', 1, 'Jumps to the given line.', NULL);
INSERT INTO entry_source (entry_id, source_id, page) VALUES (11, 1, 'Appendix II');
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, precedence, associativity, operator_class_id) VALUES (11, 11, 1, NULL, NULL, 'GO TO n', 1, 'Appendix II', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description) VALUES (9, 11, 'n', 'NONE', NULL, 'NEXT_LINE', 'Line number (also an expression). Beyond the end of the program execution stops with 0/n.');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (56, 11, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (57, 11, 56, 1, 'KEYWORD', 0, NULL, 25);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (58, 11, 56, 2, 'PARAMETER', 0, NULL, 9, 3);
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 11, id, 'FULL', 'Accepts an expression' FROM action WHERE code = 'FLOW_GOTO';
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id) VALUES (11, NULL, 1, 'Endless loop', 'Report 5 means the screen is full.', '10 PRINT "LOOP"
20 GO TO 10', 'LOOP on every line until the screen is full, then 5/10.', 0, NULL);
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id) VALUES (11, NULL, 2, 'Missing line', 'Line 15 does not exist: execution goes on from the next line, 20.', '10 GO TO 15
20 PRINT "HERE"', 'HERE', 0, NULL);

-- GO SUB
INSERT INTO entry (id, layer_id, name, category_id, description, notes) VALUES (12, 1, 'GO SUB', 1, 'Calls the subroutine that starts at the given line; RETURN goes back to the next line.', 'Subroutines can call themselves.');
INSERT INTO entry_source (entry_id, source_id, page) VALUES (12, 1, 'Appendix II');
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, precedence, associativity, operator_class_id) VALUES (12, 12, 1, NULL, NULL, 'GO SUB n', 1, 'Appendix II', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description) VALUES (10, 12, 'n', 'NONE', NULL, 'NEXT_LINE', 'Line number (also an expression). Beyond the end of the program execution stops with 0/n.');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (59, 12, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (60, 12, 59, 1, 'KEYWORD', 0, NULL, 37);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (61, 12, 59, 2, 'PARAMETER', 0, NULL, 10, 3);
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 12, id, 'FULL', 'Accepts an expression' FROM action WHERE code = 'FLOW_GOSUB';
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id) VALUES (12, NULL, 1, 'Call a subroutine', NULL, '10 GO SUB 100
20 STOP
100 PRINT "SUB"
110 RETURN', 'SUB
9/20', 0, NULL);

-- RETURN
INSERT INTO entry (id, layer_id, name, category_id, description, notes) VALUES (13, 1, 'RETURN', 1, 'Goes back to the line after the last GO SUB executed.', 'Without a matching GO SUB: error 7.');
INSERT INTO entry_source (entry_id, source_id, page) VALUES (13, 1, 'Appendix II');
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, precedence, associativity, operator_class_id) VALUES (13, 13, 1, NULL, NULL, 'RETURN', 1, 'Appendix II', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (62, 13, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (63, 13, 62, 1, 'KEYWORD', 0, NULL, 20);
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 13, id, 'FULL', NULL FROM action WHERE code = 'FLOW_RETURN';
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id) VALUES (13, NULL, 1, 'Return from a subroutine', NULL, '10 GO SUB 100
20 PRINT "BACK"
30 STOP
100 RETURN', 'BACK
9/30', 0, NULL);
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id) VALUES (13, NULL, 2, 'RETURN without GO SUB', 'Report 7: RETURN without a matching GO SUB.', '10 RETURN', '7/10', 0, NULL);

-- FOR...TO
INSERT INTO entry (id, layer_id, name, category_id, description, notes) VALUES (14, 1, 'FOR...TO', 1, 'Starts a loop: the counter goes from the start value to the end value in steps of 1.', 'The body is executed at least once. At the end of the loop the counter is end+1. NEXT is matched dynamically.');
INSERT INTO entry_source (entry_id, source_id, page) VALUES (14, 1, 'Appendix II');
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, precedence, associativity, operator_class_id) VALUES (14, 14, 1, NULL, NULL, 'FOR a = n TO n', 1, 'Appendix II', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description) VALUES (11, 14, 'a', 'NONE', NULL, NULL, 'Control variable: a single letter.');
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description) VALUES (12, 14, 'start', 'NONE', NULL, NULL, 'Start value.');
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description) VALUES (13, 14, 'end', 'NONE', NULL, NULL, 'End value.');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (64, 14, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (65, 14, 64, 1, 'KEYWORD', 0, NULL, 24);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (66, 14, 64, 2, 'PARAMETER', 0, NULL, 11, 9);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (67, 14, 64, 3, 'KEYWORD', 0, NULL, 16);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (68, 14, 64, 4, 'PARAMETER', 0, NULL, 12, 3);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (69, 14, 64, 5, 'KEYWORD', 0, NULL, 3);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (70, 14, 64, 6, 'PARAMETER', 0, NULL, 13, 3);
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 14, id, 'PARTIAL', 'Step fixed at 1: there is no STEP' FROM action WHERE code = 'FLOW_FOR';
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id) VALUES (14, NULL, 1, 'Expressions as limits', 'Start and end can be expressions.', 'FOR I = D*10 TO D*200', NULL, 0, 1);
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id) VALUES (14, NULL, 2, 'Count from 1 to 3', NULL, '10 FOR I=1 TO 3
20 PRINT I
30 NEXT I', '1
2
3', 0, NULL);

-- NEXT
INSERT INTO entry (id, layer_id, name, category_id, description, notes) VALUES (15, 1, 'NEXT', 1, 'Increments the counter and goes back to the statement after FOR if it has not passed the end value.', NULL);
INSERT INTO entry_source (entry_id, source_id, page) VALUES (15, 1, 'Appendix II');
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, precedence, associativity, operator_class_id) VALUES (15, 15, 1, NULL, NULL, 'NEXT a', 1, 'Appendix II', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description) VALUES (14, 15, 'a', 'NONE', 'NEXT_WITHOUT_FOR', NULL, 'Control variable of the loop.');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (71, 15, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (72, 15, 71, 1, 'KEYWORD', 0, NULL, 30);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (73, 15, 71, 2, 'PARAMETER', 0, NULL, 14, 9);
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 15, id, 'FULL', NULL FROM action WHERE code = 'FLOW_NEXT';
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id) VALUES (15, NULL, 1, 'End of the loop', 'After the loop the counter is end+1.', '10 FOR I=1 TO 3
20 PRINT I
30 NEXT I
40 PRINT I', '1
2
3
4', 0, NULL);
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id) VALUES (15, NULL, 2, 'NEXT without FOR', 'Report 1: I is not the counter of an active FOR loop.', '10 NEXT I', '1/10', 0, NULL);

-- STOP
INSERT INTO entry (id, layer_id, name, category_id, description, notes) VALUES (16, 1, 'STOP', 1, 'Stops the program with code 9; CONTINUE resumes from the next line.', NULL);
INSERT INTO entry_source (entry_id, source_id, page) VALUES (16, 1, 'Appendix II');
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, precedence, associativity, operator_class_id) VALUES (16, 16, 1, NULL, NULL, 'STOP', 1, 'Appendix II', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (74, 16, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (75, 16, 74, 1, 'KEYWORD', 0, NULL, 34);
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 16, id, 'FULL', NULL FROM action WHERE code = 'FLOW_STOP';
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id) VALUES (16, NULL, 1, 'Stop the program', 'CONTINUE would print B.', '10 PRINT "A"
20 STOP
30 PRINT "B"', 'A
9/20', 0, NULL);

-- DIM
INSERT INTO entry (id, layer_id, name, category_id, description, notes) VALUES (17, 1, 'DIM', 1, 'Creates an array with subscripts from 0 to n.', 'If the array already exists, the new space is reserved but the old array is still used.');
INSERT INTO entry_source (entry_id, source_id, page) VALUES (17, 1, 'Appendix II');
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, precedence, associativity, operator_class_id) VALUES (17, 17, 1, NULL, NULL, 'DIM a(n)', 1, 'Appendix II', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description) VALUES (15, 17, 'a', 'NONE', NULL, NULL, 'Array name: a single letter.');
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description) VALUES (16, 17, 'n', 'NONE', NULL, NULL, 'Highest subscript: the array has n+1 elements.');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (76, 17, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (77, 17, 76, 1, 'KEYWORD', 0, NULL, 22);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (78, 17, 76, 2, 'PARAMETER', 0, NULL, 15, 7);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (79, 17, 76, 3, 'KEYWORD', 1, NULL, 7);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (80, 17, 76, 4, 'PARAMETER', 1, NULL, 16, 3);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (81, 17, 76, 5, 'KEYWORD', 1, NULL, 6);
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 17, id, 'PARTIAL', 'One dimension only, integers only' FROM action WHERE code = 'VAR_DIM';
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id) VALUES (17, NULL, 1, 'Array with a variable size', 'Creates array A with elements from A(0) to A(B).', 'DIM A(B)', NULL, 0, 1);
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id) VALUES (17, NULL, 2, 'Use an array', NULL, '10 DIM A(5)
20 LET A(0)=1
30 LET A(5)=6
40 PRINT A(0)+A(5)', '7', 0, NULL);

-- CLEAR
INSERT INTO entry (id, layer_id, name, category_id, description, notes) VALUES (18, 1, 'CLEAR', 1, 'Clears all variables.', NULL);
INSERT INTO entry_source (entry_id, source_id, page) VALUES (18, 1, 'Appendix II');
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, precedence, associativity, operator_class_id) VALUES (18, 18, 1, NULL, NULL, 'CLEAR', 1, 'Appendix II', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (82, 18, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (83, 18, 82, 1, 'KEYWORD', 0, NULL, 39);
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 18, id, 'FULL', NULL FROM action WHERE code = 'VAR_CLEAR';
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id) VALUES (18, NULL, 1, 'Variables are lost', 'After CLEAR, A no longer exists: report 2, variable not found.', '10 LET A=5
20 CLEAR
30 PRINT A', '2/30', 0, NULL);

-- CLS
INSERT INTO entry (id, layer_id, name, category_id, description, notes) VALUES (19, 1, 'CLS', 1, 'Clears the upper part of the screen.', NULL);
INSERT INTO entry_source (entry_id, source_id, page) VALUES (19, 1, 'Appendix II');
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, precedence, associativity, operator_class_id) VALUES (19, 19, 1, NULL, NULL, 'CLS', 1, 'Appendix II', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (84, 19, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (85, 19, 84, 1, 'KEYWORD', 0, NULL, 21);
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 19, id, 'FULL', NULL FROM action WHERE code = 'SCREEN_CLS';
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id) VALUES (19, NULL, 1, 'Clear the screen', 'HELLO is printed and then cleared.', '10 PRINT "HELLO"
20 CLS', 'An empty screen.', 0, NULL);

-- POKE
INSERT INTO entry (id, layer_id, name, category_id, description, notes) VALUES (20, 1, 'POKE', 1, 'Writes a byte to memory.', NULL);
INSERT INTO entry_source (entry_id, source_id, page) VALUES (20, 1, 'Appendix II');
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, precedence, associativity, operator_class_id) VALUES (20, 20, 1, NULL, NULL, 'POKE n,v', 1, 'Appendix II', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description) VALUES (17, 20, 'address', 'NONE', NULL, NULL, 'Memory address.');
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description) VALUES (18, 20, 'value', 'NONE', NULL, NULL, 'Value written modulo 256.');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (86, 20, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (87, 20, 86, 1, 'KEYWORD', 0, NULL, 26);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (88, 20, 86, 2, 'PARAMETER', 0, NULL, 17, 3);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (89, 20, 86, 3, 'KEYWORD', 1, NULL, 5);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (90, 20, 86, 4, 'PARAMETER', 1, NULL, 18, 3);
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 20, id, 'FULL', NULL FROM action WHERE code = 'MEM_POKE';
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id) VALUES (20, NULL, 1, 'Write and read back a byte', 'A must be the address of a free memory location: it depends on the memory fitted and on the program.', '10 POKE A,123
20 PRINT PEEK(A)', '123', 0, NULL);

-- RANDOMISE
INSERT INTO entry (id, layer_id, name, category_id, description, notes) VALUES (21, 1, 'RANDOMISE', 1, 'Seeds the random number generator.', NULL);
INSERT INTO entry_source (entry_id, source_id, page) VALUES (21, 1, 'Appendix II');
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, precedence, associativity, operator_class_id) VALUES (21, 21, 1, NULL, NULL, 'RANDOMISE n', 1, 'Appendix II', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description) VALUES (19, 21, 'n', 'NONE', NULL, NULL, 'Seed. Without an argument, or with 0, the video frame counter is used.');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (91, 21, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (92, 21, 91, 1, 'KEYWORD', 0, NULL, 28);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (93, 21, 91, 2, 'OPTIONAL', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (94, 21, 93, 1, 'PARAMETER', 0, NULL, 19, 3);
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 21, id, 'FULL', NULL FROM action WHERE code = 'RND_SEED';
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id) VALUES (21, NULL, 1, 'Same numbers every time', NULL, '10 RANDOMISE 1
20 PRINT RND(100)', 'The same number every time the program is run.', 0, NULL);
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id) VALUES (21, NULL, 2, 'Different numbers', 'Without an argument the seed comes from the video frame counter.', '10 RANDOMISE
20 PRINT RND(100)', 'A different number at each run.', 0, NULL);

-- REM
INSERT INTO entry (id, layer_id, name, category_id, description, notes) VALUES (22, 1, 'REM', 1, 'Comment: it has no effect.', NULL);
INSERT INTO entry_source (entry_id, source_id, page) VALUES (22, 1, 'Appendix II');
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, precedence, associativity, operator_class_id) VALUES (22, 22, 1, NULL, NULL, 'REM', 1, 'Appendix II', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description) VALUES (20, 22, 'text', 'NONE', NULL, NULL, 'Any text.');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (95, 22, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (96, 22, 95, 1, 'KEYWORD', 0, NULL, 40);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (97, 22, 95, 2, 'OPTIONAL', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (98, 22, 97, 1, 'PARAMETER', 0, NULL, 20, 10);
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 22, id, 'FULL', NULL FROM action WHERE code = 'PROG_REM';
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id) VALUES (22, NULL, 1, 'Comment', 'The line has no effect.', '10 REM GUESS THE NUMBER', NULL, 0, NULL);

-- ABS
INSERT INTO entry (id, layer_id, name, category_id, description, notes) VALUES (23, 1, 'ABS', 3, 'Absolute value.', NULL);
INSERT INTO entry_source (entry_id, source_id, page) VALUES (23, 1, 'Appendix II');
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, precedence, associativity, operator_class_id) VALUES (23, 23, 1, NULL, NULL, 'ABS(n)', 1, 'Appendix II', 1, 0, 32767, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description) VALUES (21, 23, 'n', 'NONE', NULL, NULL, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (99, 23, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (100, 23, 99, 1, 'KEYWORD', 0, NULL, 41);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (101, 23, 99, 2, 'KEYWORD', 1, NULL, 7);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (102, 23, 99, 3, 'PARAMETER', 1, NULL, 21, 3);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (103, 23, 99, 4, 'KEYWORD', 1, NULL, 6);
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 23, id, 'FULL', NULL FROM action WHERE code = 'MATH_ABS';
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id) VALUES (23, NULL, 1, 'Absolute value', NULL, 'PRINT ABS(-5)', '5', 0, NULL);

-- CHR$
INSERT INTO entry (id, layer_id, name, category_id, description, notes) VALUES (24, 1, 'CHR$', 3, 'Character with the given code.', NULL);
INSERT INTO entry_source (entry_id, source_id, page) VALUES (24, 1, 'Appendix II');
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, precedence, associativity, operator_class_id) VALUES (24, 24, 1, NULL, NULL, 'CHR$(n)', 1, 'Appendix II', 2, NULL, NULL, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description) VALUES (22, 24, 'n', 'NONE', NULL, NULL, 'Character code. CHR$(1) gives the empty string; CHR$(212) gives the quote.');
INSERT INTO parameter_limit (parameter_id, minimum, maximum, notes) VALUES (22, 0, 255, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (104, 24, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (105, 24, 104, 1, 'KEYWORD', 0, NULL, 42);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (106, 24, 104, 2, 'KEYWORD', 1, NULL, 7);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (107, 24, 104, 3, 'PARAMETER', 1, NULL, 22, 3);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (108, 24, 104, 4, 'KEYWORD', 1, NULL, 6);
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 24, id, 'FULL', 'The ZX80''s own character set, not ASCII' FROM action WHERE code = 'STR_CHR';
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id) VALUES (24, NULL, 1, 'Character from its code', 'In the ZX80 character set A has code 38.', 'PRINT CHR$(38)', 'A', 0, NULL);

-- CODE
INSERT INTO entry (id, layer_id, name, category_id, description, notes) VALUES (25, 1, 'CODE', 3, 'Code of the first character of a string.', NULL);
INSERT INTO entry_source (entry_id, source_id, page) VALUES (25, 1, 'Appendix II');
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, precedence, associativity, operator_class_id) VALUES (25, 25, 1, NULL, NULL, 'CODE(s)', 1, 'Appendix II', 1, 0, 255, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description) VALUES (23, 25, 's', 'NONE', NULL, NULL, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (109, 25, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (110, 25, 109, 1, 'KEYWORD', 0, NULL, 43);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (111, 25, 109, 2, 'KEYWORD', 1, NULL, 7);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (112, 25, 109, 3, 'PARAMETER', 1, NULL, 23, 4);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (113, 25, 109, 4, 'KEYWORD', 1, NULL, 6);
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 25, id, 'FULL', 'The ZX80''s own character set, not ASCII' FROM action WHERE code = 'STR_CODE';
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id) VALUES (25, NULL, 1, 'Code of a character', NULL, 'PRINT CODE("A")', '38', 0, NULL);
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id) VALUES (25, NULL, 2, 'Only the first character counts', 'Z has code 63.', 'PRINT CODE("ZX80")', '63', 0, NULL);

-- PEEK
INSERT INTO entry (id, layer_id, name, category_id, description, notes) VALUES (26, 1, 'PEEK', 3, 'Byte stored at the given address.', NULL);
INSERT INTO entry_source (entry_id, source_id, page) VALUES (26, 1, 'Appendix II');
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, precedence, associativity, operator_class_id) VALUES (26, 26, 1, NULL, NULL, 'PEEK(n)', 1, 'Appendix II', 1, 0, 255, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description) VALUES (24, 26, 'n', 'NONE', NULL, NULL, 'Memory address.');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (114, 26, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (115, 26, 114, 1, 'KEYWORD', 0, NULL, 44);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (116, 26, 114, 2, 'KEYWORD', 1, NULL, 7);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (117, 26, 114, 3, 'PARAMETER', 1, NULL, 24, 3);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (118, 26, 114, 4, 'KEYWORD', 1, NULL, 6);
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 26, id, 'FULL', NULL FROM action WHERE code = 'MEM_PEEK';
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id) VALUES (26, NULL, 1, 'Read a byte', '16384 is the first address of the RAM, where the system variables are.', 'PRINT PEEK(16384)', 'A number from 0 to 255.', 0, NULL);

-- RND
INSERT INTO entry (id, layer_id, name, category_id, description, notes) VALUES (27, 1, 'RND', 3, 'Random integer.', NULL);
INSERT INTO entry_source (entry_id, source_id, page) VALUES (27, 1, 'Appendix II');
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, precedence, associativity, operator_class_id) VALUES (27, 27, 1, NULL, NULL, 'RND(n)', 1, 'Appendix II', 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description) VALUES (25, 27, 'n', 'NONE', NULL, NULL, 'With n>0 the result goes from 1 to n; with n<0 from -32768 to n-1; with n=0 it is 1.');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (119, 27, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (120, 27, 119, 1, 'KEYWORD', 0, NULL, 45);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (121, 27, 119, 2, 'KEYWORD', 1, NULL, 7);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (122, 27, 119, 3, 'PARAMETER', 1, NULL, 25, 3);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (123, 27, 119, 4, 'KEYWORD', 1, NULL, 6);
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 27, id, 'FULL', 'Integer from 1 to n' FROM action WHERE code = 'RND_VALUE';
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id) VALUES (27, NULL, 1, 'Throw a die', NULL, 'PRINT RND(6)', 'A number from 1 to 6.', 0, NULL);

-- STR$
INSERT INTO entry (id, layer_id, name, category_id, description, notes) VALUES (28, 1, 'STR$', 3, 'Number converted to a decimal string (1 to 6 characters, including any minus sign).', NULL);
INSERT INTO entry_source (entry_id, source_id, page) VALUES (28, 1, 'Appendix II');
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, precedence, associativity, operator_class_id) VALUES (28, 28, 1, NULL, NULL, 'STR$(n)', 1, 'Appendix II', 2, NULL, NULL, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description) VALUES (26, 28, 'n', 'NONE', NULL, NULL, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (124, 28, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (125, 28, 124, 1, 'KEYWORD', 0, NULL, 46);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (126, 28, 124, 2, 'KEYWORD', 1, NULL, 7);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (127, 28, 124, 3, 'PARAMETER', 1, NULL, 26, 3);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (128, 28, 124, 4, 'KEYWORD', 1, NULL, 6);
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 28, id, 'FULL', NULL FROM action WHERE code = 'STR_FROM_NUM';
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id) VALUES (28, NULL, 1, 'Number to string', 'Gives the string "1234".', 'STR$(1234)', NULL, 0, 1);
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id) VALUES (28, NULL, 2, 'Negative number', 'The minus sign is part of the string.', 'PRINT STR$(-56)', '-56', 0, NULL);

-- TL$
INSERT INTO entry (id, layer_id, name, category_id, description, notes) VALUES (29, 1, 'TL$', 3, 'The string without its first character.', NULL);
INSERT INTO entry_source (entry_id, source_id, page) VALUES (29, 1, 'Appendix II');
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, precedence, associativity, operator_class_id) VALUES (29, 29, 1, NULL, NULL, 'TL$(s)', 1, 'Appendix II', 2, NULL, NULL, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description) VALUES (27, 29, 's', 'NONE', NULL, NULL, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (129, 29, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (130, 29, 129, 1, 'KEYWORD', 0, NULL, 47);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (131, 29, 129, 2, 'KEYWORD', 1, NULL, 7);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (132, 29, 129, 3, 'PARAMETER', 1, NULL, 27, 4);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (133, 29, 129, 4, 'KEYWORD', 1, NULL, 6);
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 29, id, 'PARTIAL', 'Only removes the first character' FROM action WHERE code = 'STR_SUBSTRING';
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id) VALUES (29, NULL, 1, 'Remove the first character', NULL, 'PRINT TL$("ZX80")', 'X80', 0, NULL);

-- USR
INSERT INTO entry (id, layer_id, name, category_id, description, notes) VALUES (30, 1, 'USR', 3, 'Calls a machine code routine and returns its value.', NULL);
INSERT INTO entry_source (entry_id, source_id, page) VALUES (30, 1, 'Appendix II');
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, precedence, associativity, operator_class_id) VALUES (30, 30, 1, NULL, NULL, 'USR(n)', 1, 'Appendix II', 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description) VALUES (28, 30, 'n', 'NONE', NULL, NULL, 'Address of the routine.');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (134, 30, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (135, 30, 134, 1, 'KEYWORD', 0, NULL, 48);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (136, 30, 134, 2, 'KEYWORD', 1, NULL, 7);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (137, 30, 134, 3, 'PARAMETER', 1, NULL, 28, 3);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (138, 30, 134, 4, 'KEYWORD', 1, NULL, 6);
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 30, id, 'FULL', 'Returns HL, or n if HL does not change' FROM action WHERE code = 'MEM_CALL';
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id) VALUES (30, NULL, 1, 'Call machine code', 'A is the address of a machine code routine ending with RET; if the routine does not change HL, the result is A.', 'PRINT USR(A)', 'The value of the HL register when the routine returns.', 0, NULL);

-- **
INSERT INTO entry (id, layer_id, name, category_id, description, notes) VALUES (31, 1, '**', 4, 'Raise to a power.', NULL);
INSERT INTO entry_source (entry_id, source_id, page) VALUES (31, 1, 'Appendix II');
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, precedence, associativity, operator_class_id) VALUES (31, 31, 1, NULL, NULL, NULL, 1, 'Appendix II', 1, NULL, NULL, 10, 'LEFT', 1);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description) VALUES (29, 31, 'a', 'NONE', NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description) VALUES (30, 31, 'b', 'NONE', NULL, NULL, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (139, 31, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (140, 31, 139, 1, 'PARAMETER', 0, NULL, 29, 3);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (141, 31, 139, 2, 'KEYWORD', 0, NULL, 15);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (142, 31, 139, 3, 'PARAMETER', 0, NULL, 30, 3);
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 31, id, 'FULL', NULL FROM action WHERE code = 'OP_POWER';
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id) VALUES (31, NULL, 1, 'Power', NULL, 'PRINT 2**10', '1024', 0, NULL);
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id) VALUES (31, NULL, 2, 'Overflow', '32768 is out of range: report 6, overflow.', '10 PRINT 2**15', '6/10', 0, NULL);

-- -
INSERT INTO entry (id, layer_id, name, category_id, description, notes) VALUES (32, 1, '-', 4, 'Change of sign and subtraction.', NULL);
INSERT INTO entry_source (entry_id, source_id, page) VALUES (32, 1, 'Appendix II');
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, precedence, associativity, operator_class_id) VALUES (32, 32, 1, 'Change of sign', NULL, NULL, 1, 'Appendix II', 1, NULL, NULL, 9, NULL, 1);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description) VALUES (31, 32, 'a', 'NONE', NULL, NULL, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (143, 32, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (144, 32, 143, 1, 'KEYWORD', 0, NULL, 9);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (145, 32, 143, 2, 'PARAMETER', 1, NULL, 31, 3);
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 32, id, 'FULL', NULL FROM action WHERE code = 'OP_NEG';
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, precedence, associativity, operator_class_id) VALUES (33, 32, 2, 'Subtraction', NULL, NULL, 1, 'Appendix II', 1, NULL, NULL, 6, 'LEFT', 1);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description) VALUES (32, 33, 'a', 'NONE', NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description) VALUES (33, 33, 'b', 'NONE', NULL, NULL, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (146, 33, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (147, 33, 146, 1, 'PARAMETER', 0, NULL, 32, 3);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (148, 33, 146, 2, 'KEYWORD', 0, NULL, 9);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (149, 33, 146, 3, 'PARAMETER', 0, NULL, 33, 3);
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 33, id, 'FULL', NULL FROM action WHERE code = 'OP_SUB';
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id) VALUES (32, 32, 1, 'Change of sign', NULL, 'PRINT -5', '-5', 0, NULL);
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id) VALUES (32, 33, 2, 'Subtraction', NULL, 'PRINT 10-3', '7', 0, NULL);

-- *
INSERT INTO entry (id, layer_id, name, category_id, description, notes) VALUES (33, 1, '*', 4, 'Multiplication.', NULL);
INSERT INTO entry_source (entry_id, source_id, page) VALUES (33, 1, 'Appendix II');
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, precedence, associativity, operator_class_id) VALUES (34, 33, 1, NULL, NULL, NULL, 1, 'Appendix II', 1, NULL, NULL, 8, 'LEFT', 1);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description) VALUES (34, 34, 'a', 'NONE', NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description) VALUES (35, 34, 'b', 'NONE', NULL, NULL, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (150, 34, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (151, 34, 150, 1, 'PARAMETER', 0, NULL, 34, 3);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (152, 34, 150, 2, 'KEYWORD', 0, NULL, 11);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (153, 34, 150, 3, 'PARAMETER', 0, NULL, 35, 3);
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 34, id, 'FULL', NULL FROM action WHERE code = 'OP_MUL';
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id) VALUES (33, NULL, 1, 'Multiplication', NULL, 'PRINT 6*7', '42', 0, NULL);

-- /
INSERT INTO entry (id, layer_id, name, category_id, description, notes) VALUES (34, 1, '/', 4, 'Integer division, truncated towards zero.', NULL);
INSERT INTO entry_source (entry_id, source_id, page) VALUES (34, 1, 'Appendix II');
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, precedence, associativity, operator_class_id) VALUES (35, 34, 1, NULL, NULL, NULL, 1, 'Appendix II', 1, NULL, NULL, 7, 'LEFT', 1);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description) VALUES (36, 35, 'a', 'NONE', NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description) VALUES (37, 35, 'b', 'NONE', NULL, NULL, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (154, 35, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (155, 35, 154, 1, 'PARAMETER', 0, NULL, 36, 3);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (156, 35, 154, 2, 'KEYWORD', 0, NULL, 12);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (157, 35, 154, 3, 'PARAMETER', 0, NULL, 37, 3);
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 35, id, 'PARTIAL', 'Integer division only' FROM action WHERE code = 'OP_DIV';
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id) VALUES (34, NULL, 1, 'Integer division', 'The result is truncated.', 'PRINT 7/2', '3', 0, NULL);
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id) VALUES (34, NULL, 2, 'Truncated towards zero', NULL, 'PRINT -7/2', '-3', 0, NULL);

-- +
INSERT INTO entry (id, layer_id, name, category_id, description, notes) VALUES (35, 1, '+', 4, 'Addition.', NULL);
INSERT INTO entry_source (entry_id, source_id, page) VALUES (35, 1, 'Appendix II');
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, precedence, associativity, operator_class_id) VALUES (36, 35, 1, NULL, NULL, NULL, 1, 'Appendix II', 1, NULL, NULL, 6, 'LEFT', 1);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description) VALUES (38, 36, 'a', 'NONE', NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description) VALUES (39, 36, 'b', 'NONE', NULL, NULL, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (158, 36, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (159, 36, 158, 1, 'PARAMETER', 0, NULL, 38, 3);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (160, 36, 158, 2, 'KEYWORD', 0, NULL, 10);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (161, 36, 158, 3, 'PARAMETER', 0, NULL, 39, 3);
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 36, id, 'FULL', NULL FROM action WHERE code = 'OP_ADD';
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id) VALUES (35, NULL, 1, 'Addition', NULL, 'PRINT 2+3', '5', 0, NULL);

-- =
INSERT INTO entry (id, layer_id, name, category_id, description, notes) VALUES (36, 1, '=', 4, 'Equal: -1 if true, 0 if false.', NULL);
INSERT INTO entry_source (entry_id, source_id, page) VALUES (36, 1, 'Appendix II');
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, precedence, associativity, operator_class_id) VALUES (37, 36, 1, 'Between numbers', NULL, NULL, 1, 'Appendix II', 1, -1, 0, 5, 'LEFT', 6);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description) VALUES (40, 37, 'a', 'NONE', NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description) VALUES (41, 37, 'b', 'NONE', NULL, NULL, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (162, 37, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (163, 37, 162, 1, 'PARAMETER', 0, NULL, 40, 3);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (164, 37, 162, 2, 'KEYWORD', 0, NULL, 16);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (165, 37, 162, 3, 'PARAMETER', 0, NULL, 41, 3);
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 37, id, 'FULL', NULL FROM action WHERE code = 'OP_EQ';
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, precedence, associativity, operator_class_id) VALUES (38, 36, 2, 'Between strings', NULL, 's=s', 1, 'Appendix II', 1, -1, 0, 5, 'LEFT', 6);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description) VALUES (42, 38, 's1', 'NONE', NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description) VALUES (43, 38, 's2', 'NONE', NULL, NULL, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (166, 38, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (167, 38, 166, 1, 'PARAMETER', 0, NULL, 42, 4);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (168, 38, 166, 2, 'KEYWORD', 0, NULL, 16);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (169, 38, 166, 3, 'PARAMETER', 0, NULL, 43, 4);
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 38, id, 'FULL', NULL FROM action WHERE code = 'OP_EQ';
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id) VALUES (36, 37, 1, 'Equal numbers', 'True gives -1.', 'PRINT 2=2', '-1', 0, NULL);
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id) VALUES (36, 38, 2, 'Equal strings', NULL, '10 LET A$="YES"
20 PRINT A$="YES"', '-1', 0, NULL);

-- >
INSERT INTO entry (id, layer_id, name, category_id, description, notes) VALUES (37, 1, '>', 4, 'Greater than: -1 if true, 0 if false.', NULL);
INSERT INTO entry_source (entry_id, source_id, page) VALUES (37, 1, 'Appendix II');
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, precedence, associativity, operator_class_id) VALUES (39, 37, 1, 'Between numbers', NULL, NULL, 1, 'Appendix II', 1, -1, 0, 5, 'LEFT', 6);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description) VALUES (44, 39, 'a', 'NONE', NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description) VALUES (45, 39, 'b', 'NONE', NULL, NULL, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (170, 39, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (171, 39, 170, 1, 'PARAMETER', 0, NULL, 44, 3);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (172, 39, 170, 2, 'KEYWORD', 0, NULL, 17);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (173, 39, 170, 3, 'PARAMETER', 0, NULL, 45, 3);
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 39, id, 'FULL', NULL FROM action WHERE code = 'OP_GT';
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, precedence, associativity, operator_class_id) VALUES (40, 37, 2, 'Between strings', NULL, 's>s', 1, 'Appendix II', 1, -1, 0, 5, 'LEFT', 6);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description) VALUES (46, 40, 's1', 'NONE', NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description) VALUES (47, 40, 's2', 'NONE', NULL, NULL, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (174, 40, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (175, 40, 174, 1, 'PARAMETER', 0, NULL, 46, 4);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (176, 40, 174, 2, 'KEYWORD', 0, NULL, 17);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (177, 40, 174, 3, 'PARAMETER', 0, NULL, 47, 4);
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 40, id, 'FULL', NULL FROM action WHERE code = 'OP_GT';
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id) VALUES (37, 39, 1, 'Greater than', NULL, 'PRINT 3>2', '-1', 0, NULL);
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id) VALUES (37, 39, 2, 'Chained comparisons', '(3>2)>1 means -1>1, which is false.', 'PRINT 3>2>1', '0', 0, NULL);

-- <
INSERT INTO entry (id, layer_id, name, category_id, description, notes) VALUES (38, 1, '<', 4, 'Less than: -1 if true, 0 if false.', NULL);
INSERT INTO entry_source (entry_id, source_id, page) VALUES (38, 1, 'Appendix II');
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, precedence, associativity, operator_class_id) VALUES (41, 38, 1, 'Between numbers', NULL, NULL, 1, 'Appendix II', 1, -1, 0, 5, 'LEFT', 6);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description) VALUES (48, 41, 'a', 'NONE', NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description) VALUES (49, 41, 'b', 'NONE', NULL, NULL, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (178, 41, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (179, 41, 178, 1, 'PARAMETER', 0, NULL, 48, 3);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (180, 41, 178, 2, 'KEYWORD', 0, NULL, 18);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (181, 41, 178, 3, 'PARAMETER', 0, NULL, 49, 3);
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 41, id, 'FULL', NULL FROM action WHERE code = 'OP_LT';
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, precedence, associativity, operator_class_id) VALUES (42, 38, 2, 'Between strings', NULL, 's<s', 1, 'Appendix II', 1, -1, 0, 5, 'LEFT', 6);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description) VALUES (50, 42, 's1', 'NONE', NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description) VALUES (51, 42, 's2', 'NONE', NULL, NULL, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (182, 42, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (183, 42, 182, 1, 'PARAMETER', 0, NULL, 50, 4);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (184, 42, 182, 2, 'KEYWORD', 0, NULL, 18);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (185, 42, 182, 3, 'PARAMETER', 0, NULL, 51, 4);
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 42, id, 'FULL', NULL FROM action WHERE code = 'OP_LT';
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id) VALUES (38, 41, 1, 'Less than', 'False gives 0.', 'PRINT 3<2', '0', 0, NULL);

-- NOT
INSERT INTO entry (id, layer_id, name, category_id, description, notes) VALUES (39, 1, 'NOT', 4, 'Bitwise negation: NOT n is -n-1.', 'With truth values (comparisons give -1 if true, 0 if false) it also behaves as a conditional operator: this is a side effect of working bit by bit on signed 16-bit integers, the only numeric type. On the ZX81 and the ZX Spectrum AND, OR and NOT work differently.');
INSERT INTO entry_source (entry_id, source_id, page) VALUES (39, 1, 'Appendix II');
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, precedence, associativity, operator_class_id) VALUES (43, 39, 1, NULL, NULL, NULL, 1, 'Appendix II', 1, NULL, NULL, 4, NULL, 2);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description) VALUES (52, 43, 'a', 'NONE', NULL, NULL, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (186, 43, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (187, 43, 186, 1, 'KEYWORD', 0, NULL, 8);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (188, 43, 186, 2, 'PARAMETER', 0, NULL, 52, 3);
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 43, id, 'FULL', 'Bitwise' FROM action WHERE code = 'OP_NOT';
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id) VALUES (39, NULL, 1, 'NOT of zero', 'Prints -1.', 'PRINT NOT 0', '-1', 0, NULL);
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id) VALUES (39, NULL, 2, 'NOT of a number', 'Prints -6: NOT n is -n-1.', 'PRINT NOT 5', '-6', 0, NULL);

-- AND
INSERT INTO entry (id, layer_id, name, category_id, description, notes) VALUES (40, 1, 'AND', 4, 'Bitwise conjunction.', 'With truth values (comparisons give -1 if true, 0 if false) it also behaves as a conditional operator: this is a side effect of working bit by bit on signed 16-bit integers, the only numeric type. On the ZX81 and the ZX Spectrum AND, OR and NOT work differently.');
INSERT INTO entry_source (entry_id, source_id, page) VALUES (40, 1, 'Appendix II');
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, precedence, associativity, operator_class_id) VALUES (44, 40, 1, NULL, NULL, NULL, 1, 'Appendix II', 1, NULL, NULL, 3, 'LEFT', 2);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description) VALUES (53, 44, 'a', 'NONE', NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description) VALUES (54, 44, 'b', 'NONE', NULL, NULL, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (189, 44, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (190, 44, 189, 1, 'PARAMETER', 0, NULL, 53, 3);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (191, 44, 189, 2, 'KEYWORD', 0, NULL, 13);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (192, 44, 189, 3, 'PARAMETER', 0, NULL, 54, 3);
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 44, id, 'FULL', 'Bitwise' FROM action WHERE code = 'OP_AND';
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id) VALUES (40, NULL, 1, 'No bits in common', 'Prints 0: no bits in common.', 'PRINT 85 AND 170', '0', 0, NULL);
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id) VALUES (40, NULL, 2, 'As a condition', '-1 AND -1 is -1: true.', 'PRINT (3>2) AND (2>1)', '-1', 0, NULL);

-- OR
INSERT INTO entry (id, layer_id, name, category_id, description, notes) VALUES (41, 1, 'OR', 4, 'Bitwise disjunction.', 'With truth values (comparisons give -1 if true, 0 if false) it also behaves as a conditional operator: this is a side effect of working bit by bit on signed 16-bit integers, the only numeric type. On the ZX81 and the ZX Spectrum AND, OR and NOT work differently.');
INSERT INTO entry_source (entry_id, source_id, page) VALUES (41, 1, 'Appendix II');
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, precedence, associativity, operator_class_id) VALUES (45, 41, 1, NULL, NULL, NULL, 1, 'Appendix II', 1, NULL, NULL, 2, 'LEFT', 2);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description) VALUES (55, 45, 'a', 'NONE', NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description) VALUES (56, 45, 'b', 'NONE', NULL, NULL, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (193, 45, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (194, 45, 193, 1, 'PARAMETER', 0, NULL, 55, 3);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (195, 45, 193, 2, 'KEYWORD', 0, NULL, 14);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (196, 45, 193, 3, 'PARAMETER', 0, NULL, 56, 3);
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 45, id, 'FULL', 'Bitwise' FROM action WHERE code = 'OP_OR';
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id) VALUES (41, NULL, 1, 'All the bits', 'Prints 255.', 'PRINT 85 OR 170', '255', 0, NULL);

-- ( )
INSERT INTO entry (id, layer_id, name, category_id, description, notes) VALUES (42, 1, '( )', 4, 'Parentheses: the expression inside is evaluated before what surrounds it.', NULL);
INSERT INTO entry_source (entry_id, source_id, page) VALUES (42, 1, 'Appendix II');
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, precedence, associativity, operator_class_id) VALUES (46, 42, 1, NULL, NULL, NULL, 1, 'Appendix II', NULL, NULL, NULL, NULL, NULL, 8);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description) VALUES (57, 46, 'e', 'NONE', NULL, NULL, 'Numeric or string expression.');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (197, 46, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, text) VALUES (198, 46, 197, 1, 'LITERAL', 0, NULL, '(');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (199, 46, 197, 2, 'CHOICE', 1, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (200, 46, 199, 1, 'PARAMETER', 1, NULL, 57, 3);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (201, 46, 199, 2, 'PARAMETER', 1, NULL, 57, 4);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, text) VALUES (202, 46, 197, 3, 'LITERAL', 1, NULL, ')');
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id) VALUES (42, NULL, 1, 'Change the order', 'Without parentheses, 2+3*4 gives 14.', 'PRINT (2+3)*4', '20', 0, NULL);

INSERT INTO reference (entry_id, related_entry_id, kind) VALUES (14, 15, 'OPENS_BLOCK');
INSERT INTO reference (entry_id, related_entry_id, kind) VALUES (12, 13, 'OPENS_BLOCK');
INSERT INTO reference (entry_id, related_entry_id, kind) VALUES (16, 4, 'SEE_ALSO');
INSERT INTO reference (entry_id, related_entry_id, kind) VALUES (2, 18, 'SEE_ALSO');
INSERT INTO reference (entry_id, related_entry_id, kind) VALUES (24, 25, 'SEE_ALSO');
INSERT INTO reference (entry_id, related_entry_id, kind) VALUES (26, 20, 'SEE_ALSO');
INSERT INTO reference (entry_id, related_entry_id, kind) VALUES (27, 21, 'SEE_ALSO');
INSERT INTO reference (entry_id, related_entry_id, kind) VALUES (5, 6, 'SEE_ALSO');

COMMIT;
