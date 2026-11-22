-- =====================================================================
--  BASIC 2 BASIC - Dartmouth BASIC, editions 1 to 4
--  GENERATED FILE from data/dartmouth.py: edit that file and regenerate.
-- =====================================================================

PRAGMA foreign_keys = ON;
BEGIN;

INSERT INTO machine (id, code, name, manufacturer, year, cpu, notes) VALUES (200001, 'GE225', 'General Electric GE-225', 'General Electric', NULL, 'GE-225 (20-bit words)', 'With a Datanet-30 communications computer handling the Teletype terminals (Model 33 and 35), the first Dartmouth Time-Sharing System: the first BASIC programs ran on it on 1 May 1964. Replaced by the faster GE-235 around June 1964 (source [5]).');
INSERT INTO machine (id, code, name, manufacturer, year, cpu, notes) VALUES (200002, 'GE235', 'General Electric GE-235', 'General Electric', NULL, 'GE-235 (20-bit words: three 6-bit characters)', 'The faster GE-225, with the Datanet-30: the Dartmouth Time-Sharing System from mid-1964 to 1967 (Phase I). Floating point of about 30 bits of mantissa (nine to ten digits), binary exponent from -256 to 255 (source [6]). The DTSS-Win simulator [8] emulates this machine. GE sold the GE-235 with the Datanet-30 as the GE-265, with a copy of the Dartmouth system, from early 1965 [9].');
INSERT INTO machine (id, code, name, manufacturer, year, cpu, notes) VALUES (200003, 'GE635', 'General Electric GE-635', 'General Electric', NULL, 'GE-635 (36-bit words)', 'Installed at Dartmouth in late 1966 and early 1967; GE''s Phase I operating system ran on it from September 1967. Dartmouth wrote the compilers: the 4th edition, first an experimental version of spring 1967, was the BASIC of this machine [9]. The 3rd edition stayed on the GE-235.');
INSERT INTO layer (id, code, name, kind, author, year, notes) VALUES (200001, 'DARTMOUTH_1ED_core', 'Dartmouth BASIC, 1st edition', 'CORE', 'John G. Kemeny, Thomas E. Kurtz', 1964, 'May 1964. The manual [1] describes 9 statements besides END; GOSUB, RETURN, DIM, REM, RND, INT and the arrays (its Part II, not available) are taken from the October 1964 manual [2]. Kurtz [9], quoting the complete manual of June 1964, confirms the 14 statements (LET, PRINT, END, FOR, NEXT, GO TO, IF...THEN, DEF, READ, DATA, DIM, GOSUB, RETURN, REM) and the 10 functions.');
INSERT INTO layer (id, code, name, kind, author, year, notes) VALUES (200002, 'DARTMOUTH_2ED_layer', 'Dartmouth BASIC, 2nd edition', 'LAYER', 'John G. Kemeny, Thomas E. Kurtz', 1964, 'October 1964 [2]: STOP, the semicolon in PRINT, subscripts from 0, more commands.');
INSERT INTO layer (id, code, name, kind, author, year, notes) VALUES (200003, 'DARTMOUTH_3ED_layer', 'Dartmouth BASIC, 3rd edition', 'LAYER', 'John G. Kemeny, Thomas E. Kurtz', 1966, '1966. From the GE manual of January 1967 [3] and Wikipedia [5] (the Dartmouth manual is not available): INPUT, RESTORE, MAT, SGN, INT as floor, unary minus after the power, run-time messages, nested GOSUB. Kurtz [9] confirms INPUT, MAT, SGN, RESTORE, INT as floor and the unary minus (p. 40 of the 1966 manual), and says that Dartmouth stopped developing this version in 1965: this is why the compiler of February 1965 (DTSS-Win) already behaves like it.');
INSERT INTO layer (id, code, name, kind, author, year, notes) VALUES (200004, 'DARTMOUTH_4ED_layer', 'Dartmouth BASIC, 4th edition', 'LAYER', 'Dartmouth College', 1968, 'January 1968 [4], GE-635: strings, ON...GO TO, TAB, RANDOMIZE, CHANGE, multi-line DEF, MAT INPUT, NUM, DET, COT, RESTORE* and RESTORE$. According to Kurtz [9] most of it ran from spring 1967 on the GE-635, described in the Supplement to the 3rd edition manual; the manual of 1968 added only multi-line DEF and CHANGE. Designed with GE, which suggested the strings.');
INSERT INTO layer (id, code, name, kind, author, year, notes) VALUES (200005, 'DARTMOUTH_CARD_layer', 'Card BASIC', 'LAYER', 'John G. Kemeny, Thomas E. Kurtz', 1964, 'October 1964 [2] chapter IV, pp. 50-52: the 2nd edition run from punched cards, with the output on the high-speed printer. Relations written as three-letter words, labels between single quotes, data on cards after END, PAGE and MAT.');
INSERT INTO dialect (id, code, name, version, author, year, notes) VALUES (200001, 'DARTMOUTH_BASIC_1', 'Dartmouth BASIC (1st edition)', '1st edition', 'John G. Kemeny, Thomas E. Kurtz', 1964, 'The original BASIC, compiled (compile and go) on the Dartmouth Time-Sharing System and used from Teletype terminals. Only numbers: strings can be printed as labels, not stored.');
INSERT INTO dialect_layer (dialect_id, layer_id, position) VALUES (200001, 200001, 1);
INSERT INTO machine_dialect (machine_id, dialect_id, medium, is_default, notes) VALUES (200001, 200001, 'OTHER', 1, 'Compiler on the time-sharing system.');
INSERT INTO machine_dialect (machine_id, dialect_id, medium, is_default, notes) VALUES (200002, 200001, 'OTHER', 0, 'Compiler on the time-sharing system.');
INSERT INTO dialect (id, code, name, version, author, year, notes) VALUES (200002, 'DARTMOUTH_BASIC_2', 'Dartmouth BASIC (2nd edition)', '2nd edition', 'John G. Kemeny, Thomas E. Kurtz', 1964, 'The October 1964 version. The same manual describes Card BASIC (batch, with MAT), entered as its own dialect.');
INSERT INTO dialect_layer (dialect_id, layer_id, position) VALUES (200002, 200001, 1);
INSERT INTO dialect_layer (dialect_id, layer_id, position) VALUES (200002, 200002, 2);
INSERT INTO machine_dialect (machine_id, dialect_id, medium, is_default, notes) VALUES (200002, 200002, 'OTHER', 1, 'Compiler on the time-sharing system.');
INSERT INTO dialect (id, code, name, version, author, year, notes) VALUES (200003, 'DARTMOUTH_BASIC_3', 'Dartmouth BASIC (3rd edition)', '3rd edition', 'John G. Kemeny, Thomas E. Kurtz', 1966, 'The first version called an "edition"; INPUT makes programs interactive. GE-235 only: Dartmouth stopped developing it in 1965, knowing it would move to the GE-635, and it stayed in use until autumn 1967 [9].');
INSERT INTO dialect_layer (dialect_id, layer_id, position) VALUES (200003, 200001, 1);
INSERT INTO dialect_layer (dialect_id, layer_id, position) VALUES (200003, 200002, 2);
INSERT INTO dialect_layer (dialect_id, layer_id, position) VALUES (200003, 200003, 3);
INSERT INTO machine_dialect (machine_id, dialect_id, medium, is_default, notes) VALUES (200002, 200003, 'OTHER', 1, 'Compiler on the time-sharing system.');
INSERT INTO dialect (id, code, name, version, author, year, notes) VALUES (200004, 'DARTMOUTH_BASIC_4', 'Dartmouth BASIC (4th edition)', '4th edition', 'Dartmouth College', 1968, 'The version most later BASICs descend from: string variables, ON...GO TO, TAB, RANDOMIZE.');
INSERT INTO dialect_layer (dialect_id, layer_id, position) VALUES (200004, 200001, 1);
INSERT INTO dialect_layer (dialect_id, layer_id, position) VALUES (200004, 200002, 2);
INSERT INTO dialect_layer (dialect_id, layer_id, position) VALUES (200004, 200003, 3);
INSERT INTO dialect_layer (dialect_id, layer_id, position) VALUES (200004, 200004, 4);
INSERT INTO machine_dialect (machine_id, dialect_id, medium, is_default, notes) VALUES (200003, 200004, 'OTHER', 1, 'Compiler on the time-sharing system.');
INSERT INTO dialect (id, code, name, version, author, year, notes) VALUES (200005, 'DARTMOUTH_CARD_BASIC', 'Dartmouth Card BASIC', 'October 1964', 'John G. Kemeny, Thomas E. Kurtz', 1964, 'A parallel version of the 2nd edition for decks of punched cards: longer programs, no limit on the data, faster output on the high-speed printer, matrix statements [2] p. 50.');
INSERT INTO dialect_layer (dialect_id, layer_id, position) VALUES (200005, 200001, 1);
INSERT INTO dialect_layer (dialect_id, layer_id, position) VALUES (200005, 200002, 2);
INSERT INTO dialect_layer (dialect_id, layer_id, position) VALUES (200005, 200005, 3);
INSERT INTO machine_dialect (machine_id, dialect_id, medium, is_default, notes) VALUES (200002, 200005, 'OTHER', 1, 'Compiler on the time-sharing system.');
INSERT INTO charset (id, machine_id, code, name, language, width, height, description) VALUES (200001, 200001, 'ASR33_GE225', 'Teletype ASR-33, US print head (reconstruction)', 'us', 24, 24, 'Reconstruction: the ASR-33 printed with a type cylinder, so these bitmaps are rasterized from the TrueType font "TeleType ASR 33 UK" (c) 2015 David Bonham, drawn from photographs of Teletype listings. 64 glyphs, codes 32-95 of ASCII-1963, no lower case.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200001, 32, '000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000', ' ', 'SPACE', 'Space', 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200001, 33, '000000000000003C00007E00007E00007E00007C00007C00003C00007E00007C00007C00007C00003C00003800001800003C00007E00007E00007E00007C00003C00000000000000', '!', 'EXCLAMATION MARK', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200001, 34, '00000000000001C1C007E7C007C3E007C3C003C7C003C3C003C7C003C180018100000000000000000000000000000000000000000000000000000000000000000000000000000000', '"', 'QUOTATION MARK', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200001, 35, '000000000000000000001CC0001DC000198000398000198000338001FFE0007F8000670003FF8007FF8003FF0001CC0003DC00039C0003FC00033800011000000000000000000000', '#', 'NUMBER SIGN', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200001, 36, '000000000000003C0000FF0003FF8007FBC003B8C007380007B80003F80001FC0000FF80003F800039E00038E00038E00038E00639E007FFC007FF8001FE00001C00000000000000', '$', 'DOLLAR SIGN', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200001, 37, '000000000000027B8003FFC007F7800621800E33000F770007F60003DE00001C00001C000038000070000073C000EFE001EEE001CE7003CEF003CFE0038FE0020280000000000000', '%', 'PERCENT SIGN', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200001, 38, '000000000000001C00003F00007F80007380007380007380007700007F0000FE0001FC0007F86007DCF0071FF00707C00F9F8007DFC007FFF003FDF000F060008000000000000000', '&', 'AMPERSAND', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200001, 39, '000000000000001800007E00007E00007E00007E00003E00003C00003C00001C00000C00000000000000000000000000000000000000000000000000000000000000000000000000', '''', 'APOSTROPHE', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200001, 40, '000000000000000200001F00001F00003E0000380000700000700000E00000E00000E00000E00000F00000F000007800007C00003F00003F00001F00000E00000200000000000000', '(', 'LEFT PARENTHESIS', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200001, 41, '00000000000000E00000F000007800003C00001E00001E00000E00000700000700000700000700000F00000F00000E00001E00003E00007C0000F80001F00000C000000000000000', ')', 'RIGHT PARENTHESIS', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200001, 42, '0000000000000000000000000018000038000018000718E007D9E003FFE001FF80007F0000FF8007FFE007DBE00718E0003C00003800003800000000000000000000000000000000', '*', 'ASTERISK', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200001, 43, '000000000000000000000000000000003800003C00003C00007C0001FC0007FFF00FFFF007FFF0007C00003C00003C00007C00003C00003000000000000000000000000000000000', '+', 'PLUS SIGN', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200001, 44, '000000000000000000000000000000000000000000000000000000000000000000000000000400001F00001F80000F80000F00001F0000FF0000FE0001F80000F000000000000000', ',', 'COMMA', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200001, 45, '00000000000000000000000000000000000000000000000000000003FFE007FFE00FFFF007FFF003FFE0010000000000000000000000000000000000000000000000000000000000', '-', 'HYPHEN-MINUS', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200001, 46, '000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000003C00003E00003E00003C00001C00000000000000000000000000', '.', 'FULL STOP', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200001, 47, '0000000000000000400000E00001E00003E00003C0000780000F80001F00001E00003E00007C0000F80000F00001F00003E00003E00007C000078000070000030000000000000000', '/', 'SOLIDUS', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200001, 48, '000000000000007E0000FF0001FF8001E78003C78001C78001C38001C38001C38001C38001C38001838001C78001C78001C3C001C3C001FF8001FF00007E00001800000000000000', '0', 'DIGIT ZERO', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200001, 49, '000000000000001800003C00007E00007C00003C00001C00003C00001C00001C00001C00003C00003C00003C00003C00003C00003C00007E00007F0000FF00007E00000000000000', '1', 'DIGIT ONE', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200001, 50, '00000000000000180000FE0001FF8003C7C00781C00701C00601E00701E00001E00003C0003F8000FF0001F00003C0000380000700E007FFE007FFE003FFE0013900000000000000', '2', 'DIGIT TWO', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200001, 51, '000000000000007E0000FF8001FFC003C3C00380C00000C00001C00003C00007C00007800007C00001E00001E00300E00780E00781E007FFC003FFC000FF80003C00000000000000', '3', 'DIGIT THREE', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200001, 52, '000000000000001800003C000038000038C00079E000F1E000F0E001E1E003C1E003C1E00780E00F81E00FC1E00FFFF00FFFF80FEBE00003F00007F00003F0000060000000000000', '4', 'DIGIT FOUR', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200001, 53, '000000000000007F8001FFC003FFC003800003000003000003880003FF0003FF800397C00003C00001E00001E00000E00601E00703C007FFC003FF8003FF00007E00000000000000', '5', 'DIGIT FIVE', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200001, 54, '000000000000000E00003E00007E0000F80001E00001C00003800003FF0007FF8007C7C00781C00700E00700E00700E00700E00381C003F7C001FF8000FF00004E00000000000000', '6', 'DIGIT SIX', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200001, 55, '00000000000003FFC003FFE007FFC00783C00703C0020780000780000F00000F00000E00001E00001C00001C00003C00003800003800003800007800003800003000000000000000', '7', 'DIGIT SEVEN', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200001, 56, '00000000000000FC0001FEC003FFC00381C00703C007038007078003CF0003FF0001FF8003B7C00781C00700E00700E00700E00781E003FFC003FFC001FF80007E00000000000000', '8', 'DIGIT EIGHT', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200001, 57, '000000000000007C0001FF0003FF8003D3C00781C00700E00700E00700E00301E00383E001FFC001FFE0007FC0000380000F80001F00003F0000FC0001F80000E000000000000000', '9', 'DIGIT NINE', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200001, 58, '000000000000000000000000000000000000003C00007E00007E00007E00007E00003C00000000000000001800003E00007E00007E00007E00007C00003800000000000000000000', ':', 'COLON', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200001, 59, '000000000000000000001E00001F00003F00003F80003F00001E00000C00000000001E00003F00003F00003F00001F00003E0000FC0001FC0001F000008000000000000000000000', ';', 'SEMICOLON', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200001, 60, '0000000000000000000000000000600000F0000FF0007FE001FF4007FC000FC0000F80000FF00003FE0000FF80001FF00003F00001E0000000000000000000000000000000000000', '<', 'LESS-THAN SIGN', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200001, 61, '00000000000000000000000000000000000000000000000003FFC003FFC00001800000000136C003FFC003FFC0000000000000000000000000000000000000000000000000000000', '=', 'EQUALS SIGN', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200001, 62, '00000000000000000000000000000003800003E00003F80001FF00007F80001FC00007E0000FE0001FC000FF0003FC0003F00003E000018000000000000000000000000000000000', '>', 'GREATER-THAN SIGN', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200001, 63, '00000000000000300000FE0001FF8003FFC003C3C00381C00103C0000780000FC0001F80001F00001C00001C00001800000000001000003E00003E00003E00003C00000000000000', '?', 'QUESTION MARK', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200001, 64, '000000000000003C0000FF0001FF8003C3C00301C0031CC0073EE007FFE006F7E00667C006C7E007E7E007FFC0077FC0071C0003810003C78001FF8000FF00007C00000000000000', '@', 'COMMERCIAL AT', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200001, 65, '000000000000001000003800003C00007E0000EE0000E70001C3000183800181800183C00301C00301C007FFC007FFE0071BE00700E00700F00F81F01F83F80F01F0000000000000', 'A', 'LATIN CAPITAL LETTER A', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200001, 66, '0000000000000300000FFF800FFFE00788E00300700380700380700380F003B1E003FFE003FFE00383F00300700300780380700700700F41F00FFFE00FFFC00FFF80000000000000', 'B', 'LATIN CAPITAL LETTER B', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200001, 67, '000000000000000C0000FFC001FFC003C3E00381E00300E00700000700000700000700000700000700000700400780E00781E00381E003E7C001FF8000FF80007E00000000000000', 'C', 'LATIN CAPITAL LETTER C', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200001, 68, '00000000000001DE000FFF800FFF800701E00701E00700600380700700700380700380700380700380700380700380700780E00783E007FFC00FFF800FFF0007E000000000000000', 'D', 'LATIN CAPITAL LETTER D', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200001, 69, '00000000000007FFC00FFFE00FDFF00300F0038060038000038800039E0003FE0003FE0003DE00038E000384000380200380700380700FFFF00FFFF00FFFE0020080000000000000', 'E', 'LATIN CAPITAL LETTER E', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200001, 70, '0000000000000FFFC00FFFF00FFFF00F80F0078060038000038C0003BE0003FE0003FE0003FE00039E000784000380000380000780000FC0000FC0000FC000058000000000000000', 'F', 'LATIN CAPITAL LETTER F', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200001, 71, '000000000000003F8000FFC001FFC001C3C00381C00300C00300000700000701000307C0030FE00707E00700E00780E00781E00381E003E7E001FFE000FFE0007EC0000000000000', 'G', 'LATIN CAPITAL LETTER G', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200001, 72, '0000000000000F81F01F83F81F83F80781F00700E00781E007C1E0037FE007FFE003FFE007F7E00781E00781E00781E00781E00781F00FC3F01FC3F81F81F00700F0000000000000', 'H', 'LATIN CAPITAL LETTER H', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200001, 73, '000000000000007F0000FF0001FF0000FE00003C00003800003800003800003C00003800003800003800003C00003C00003C00007C0000FF0001FF8001FF8000FF00000000000000', 'I', 'LATIN CAPITAL LETTER I', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200001, 74, '0000000000000001000003E00003F00003E00001C00001C00001C00001C00000C00000C00381C00781C007C1C007C1C00741C007C7C007FFC001FF00007C00000800000000000000', 'J', 'LATIN CAPITAL LETTER J', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200001, 75, '0000000000000681E00F83F00F83F00303C0030780038F80030E00031E0003BE0003FE0003F70003C7000387000387800383C00703E00F83F00FC3F00783F0010060000000000000', 'K', 'LATIN CAPITAL LETTER K', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200001, 76, '0000000000000FC0000FC00007C00007800003800003800003800003800003800003C00003800003800003800003807003C07807FFF00FFFF01FFFF007FFF0000000000000000000', 'L', 'LATIN CAPITAL LETTER L', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200001, 77, '0000000000000A00000E00F00F01F00F83E00F83E007C7E00EE7E00EEFE00E7EE00E7CE00E3C600E3C600E1CE00E08E00600E00F00E00F01E01FC3F81F83F80601E0000000000000', 'M', 'LATIN CAPITAL LETTER M', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200001, 78, '0000000000000F00D00F83F00FC1F007E0F007E0E007F07006F8F00778F00738F0061CF0071CF0061EF0071EF0070FE00707F00787E00FC3E00FC3E00FC1C0000000000000000000', 'N', 'LATIN CAPITAL LETTER N', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200001, 79, '00000000000001FF8003FFC007AFE00700E00600600200E00700E00700E00600E00780E00700E00700E00780E00700E00700E00700E00799E003FFE003FFC001FF80000000000000', 'O', 'LATIN CAPITAL LETTER O', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200001, 80, '00000000000007FE000FFFC00FFFE00FFFF00F01F00300F00380700380F80381F003A7F001FFC003FFC003A7000380000780000700000F80000FC0000FC000068000000000000000', 'P', 'LATIN CAPITAL LETTER P', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200001, 81, '000000000000007C0000FF0001FF800387C00701C00701C00601C00601C00E01E00600E00600E00E79E00678E0063DE0061FC0078FC003EFC003FFF001FFF0003FE0000000000000', 'Q', 'LATIN CAPITAL LETTER Q', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200001, 82, '0000000000000C00000FFF000FFF000FFFC00701C00300E00300E00301E00307C003FF8003FF0003DF000303000303000301800301C00781E00F81F00F81F8020020000000000000', 'R', 'LATIN CAPITAL LETTER R', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200001, 83, '00000000000000180000FF8001FFC003C7C003818003800003800003C00001FC0000FF00003F800003C00001C00000E00000E00301C007FFC007FF8007FF00023C00000000000000', 'S', 'LATIN CAPITAL LETTER S', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200001, 84, '00000000000003FAC007FFE00FFFE00FFFF00E3CF0063860003C00001C00001800001800003800003800003800003800003800003800007E0000FE0000FE00003000000000000000', 'T', 'LATIN CAPITAL LETTER T', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200001, 85, '0000000000000F00F01FC3F80F81F80701F00700E00700E00700E00700E00700E00700E00700E00700E00700E00700E00780E00380C003F7C001FF8001FF00003000000000000000', 'U', 'LATIN CAPITAL LETTER U', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200001, 86, '0000000000000700E00FC3F81FC3F807C1F80380E00380E00380E00380E00381E003C1C001C3C001E3C001F7C000E78000FF80007F00007F00007E00003C00001800000000000000', 'V', 'LATIN CAPITAL LETTER V', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200001, 87, '0000000000000000600F81F00FC3F80F81F00700E00700E00701E00710E00711C00339C0033CC003FDC003FFC003FFC001FFC001EF8001FF8001EF8000E700004200000000000000', 'W', 'LATIN CAPITAL LETTER W', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200001, 88, '0000000000000F81E00F81F80F81F001C1C001E38000E78000F600001E00001C00003C00003E00007E0000E70000C3800183800381C00F00E00F81F01F81F00501F0000000000000', 'X', 'LATIN CAPITAL LETTER X', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200001, 89, '0000000000000400C00F81F01F83F80F83F00783E003C3C001E78000FF0000FF00007E00003C00003C00001C00003C00001C00001800003C00007E00007E00003E00000000000000', 'Y', 'LATIN CAPITAL LETTER Y', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200001, 90, '000000000000001F8003FF8007FF8007FF80070780021F00001E00003C0000780000700000E00001C00001C0000380200780E00781E007FFF007FFF007FFE00753C0000000000000', 'Z', 'LATIN CAPITAL LETTER Z', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200001, 91, '00000000000000380000FF0000FF0001FE0000E00000E00000E00000E00000E00000E00000E00001E00000E00001E00000E00001E00000FF0000FF8000FF00003C00000000000000', '[', 'LEFT SQUARE BRACKET', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200001, 92, '00000000000003000007800007800003C00003C00001E00001F00000F800007800007C00003E00001F00000F000007800007C00007E00003E00001E00000E0000000000000000000', '\', 'REVERSE SOLIDUS', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200001, 93, '00000000000000FE0000FF0000FF80006F00000780000700000700000700000780000700000700000700000700000700000700000700007F0001FF0000FF0000EE00000000000000', ']', 'RIGHT SQUARE BRACKET', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200001, 94, '000000000000000000001000003C00007E0000FF8001FF0000FF00003D00003C00003C00003C00001C00003C00003C00003C00001C00000800000000000000000000000000000000', '↑', 'UPWARDS ARROW', 'Up arrow', 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200001, 95, '00000000000000000000000000000000000000000000000001C00003E00007FFC007FFE003FFE003E08001C000004000000000000000000000000000000000000000000000000000', '←', 'LEFTWARDS ARROW', 'Back arrow', 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO charset (id, machine_id, base_charset_id, code, name, language, width, height, description) VALUES (200011, 200001, 200001, 'ASR33_UK_GE225', 'Teletype ASR-33, UK print head (reconstruction)', 'uk', 24, 24, 'Variant of the US set: the pound sign in place of $ (code 36); the other glyphs are inherited. Reconstruction from the same font, made for the ICL 2903 emulator, which imitates an ASR-33 with a UK print head.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200011, 36, '00000000000000F80001FE00030F0002030003000003000001800001C00001F00001F80001F80000300000300001F00003F00007780007FBE007FFE001FFC0014F80000000000000', '£', 'POUND SIGN', 'Pound sign', 'UK print head: in place of $. Reconstruction from a TrueType font.');
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200001, 32, 32);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200001, 33, 33);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200001, 34, 34);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200001, 35, 35);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200001, 36, 36);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200001, 37, 37);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200001, 38, 38);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200001, 39, 39);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200001, 40, 40);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200001, 41, 41);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200001, 42, 42);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200001, 43, 43);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200001, 44, 44);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200001, 45, 45);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200001, 46, 46);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200001, 47, 47);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200001, 48, 48);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200001, 49, 49);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200001, 50, 50);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200001, 51, 51);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200001, 52, 52);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200001, 53, 53);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200001, 54, 54);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200001, 55, 55);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200001, 56, 56);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200001, 57, 57);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200001, 58, 58);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200001, 59, 59);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200001, 60, 60);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200001, 61, 61);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200001, 62, 62);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200001, 63, 63);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200001, 64, 64);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200001, 65, 65);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200001, 66, 66);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200001, 67, 67);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200001, 68, 68);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200001, 69, 69);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200001, 70, 70);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200001, 71, 71);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200001, 72, 72);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200001, 73, 73);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200001, 74, 74);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200001, 75, 75);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200001, 76, 76);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200001, 77, 77);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200001, 78, 78);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200001, 79, 79);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200001, 80, 80);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200001, 81, 81);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200001, 82, 82);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200001, 83, 83);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200001, 84, 84);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200001, 85, 85);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200001, 86, 86);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200001, 87, 87);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200001, 88, 88);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200001, 89, 89);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200001, 90, 90);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200001, 91, 91);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200001, 92, 92);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200001, 93, 93);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200001, 94, 94);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200001, 95, 95);
INSERT INTO table_status (table_kind_id, machine_id, status, notes) SELECT id, 200001, 'COMPLETE', '**Reconstruction**: the Teletype ASR-33 printed with a type cylinder, so there are no original bitmaps. The 64 glyphs (US print head, with the UK variant that has the pound sign in place of $) are rasterized from the TrueType font "TeleType ASR 33 UK" (© 2015 David Bonham), drawn from photographs of Teletype listings.' FROM table_kind WHERE code = 'GLYPHS';
INSERT INTO table_status (table_kind_id, machine_id, status, notes) SELECT id, 200001, 'COMPLETE', 'No screen: output on paper. These rows only link each printed code (32-95) to the glyph with the same number.' FROM table_kind WHERE code = 'SCREEN_CODES';
INSERT INTO table_status (table_kind_id, machine_id, status, notes) SELECT id, 200001, 'NOT_APPLICABLE', 'Output on paper.' FROM table_kind WHERE code = 'COLORS';
INSERT INTO charset (id, machine_id, code, name, language, width, height, description) VALUES (200002, 200002, 'ASR33_GE235', 'Teletype ASR-33, US print head (reconstruction)', 'us', 24, 24, 'Reconstruction: the ASR-33 printed with a type cylinder, so these bitmaps are rasterized from the TrueType font "TeleType ASR 33 UK" (c) 2015 David Bonham, drawn from photographs of Teletype listings. 64 glyphs, codes 32-95 of ASCII-1963, no lower case.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200002, 32, '000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000', ' ', 'SPACE', 'Space', 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200002, 33, '000000000000003C00007E00007E00007E00007C00007C00003C00007E00007C00007C00007C00003C00003800001800003C00007E00007E00007E00007C00003C00000000000000', '!', 'EXCLAMATION MARK', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200002, 34, '00000000000001C1C007E7C007C3E007C3C003C7C003C3C003C7C003C180018100000000000000000000000000000000000000000000000000000000000000000000000000000000', '"', 'QUOTATION MARK', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200002, 35, '000000000000000000001CC0001DC000198000398000198000338001FFE0007F8000670003FF8007FF8003FF0001CC0003DC00039C0003FC00033800011000000000000000000000', '#', 'NUMBER SIGN', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200002, 36, '000000000000003C0000FF0003FF8007FBC003B8C007380007B80003F80001FC0000FF80003F800039E00038E00038E00038E00639E007FFC007FF8001FE00001C00000000000000', '$', 'DOLLAR SIGN', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200002, 37, '000000000000027B8003FFC007F7800621800E33000F770007F60003DE00001C00001C000038000070000073C000EFE001EEE001CE7003CEF003CFE0038FE0020280000000000000', '%', 'PERCENT SIGN', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200002, 38, '000000000000001C00003F00007F80007380007380007380007700007F0000FE0001FC0007F86007DCF0071FF00707C00F9F8007DFC007FFF003FDF000F060008000000000000000', '&', 'AMPERSAND', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200002, 39, '000000000000001800007E00007E00007E00007E00003E00003C00003C00001C00000C00000000000000000000000000000000000000000000000000000000000000000000000000', '''', 'APOSTROPHE', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200002, 40, '000000000000000200001F00001F00003E0000380000700000700000E00000E00000E00000E00000F00000F000007800007C00003F00003F00001F00000E00000200000000000000', '(', 'LEFT PARENTHESIS', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200002, 41, '00000000000000E00000F000007800003C00001E00001E00000E00000700000700000700000700000F00000F00000E00001E00003E00007C0000F80001F00000C000000000000000', ')', 'RIGHT PARENTHESIS', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200002, 42, '0000000000000000000000000018000038000018000718E007D9E003FFE001FF80007F0000FF8007FFE007DBE00718E0003C00003800003800000000000000000000000000000000', '*', 'ASTERISK', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200002, 43, '000000000000000000000000000000003800003C00003C00007C0001FC0007FFF00FFFF007FFF0007C00003C00003C00007C00003C00003000000000000000000000000000000000', '+', 'PLUS SIGN', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200002, 44, '000000000000000000000000000000000000000000000000000000000000000000000000000400001F00001F80000F80000F00001F0000FF0000FE0001F80000F000000000000000', ',', 'COMMA', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200002, 45, '00000000000000000000000000000000000000000000000000000003FFE007FFE00FFFF007FFF003FFE0010000000000000000000000000000000000000000000000000000000000', '-', 'HYPHEN-MINUS', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200002, 46, '000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000003C00003E00003E00003C00001C00000000000000000000000000', '.', 'FULL STOP', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200002, 47, '0000000000000000400000E00001E00003E00003C0000780000F80001F00001E00003E00007C0000F80000F00001F00003E00003E00007C000078000070000030000000000000000', '/', 'SOLIDUS', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200002, 48, '000000000000007E0000FF0001FF8001E78003C78001C78001C38001C38001C38001C38001C38001838001C78001C78001C3C001C3C001FF8001FF00007E00001800000000000000', '0', 'DIGIT ZERO', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200002, 49, '000000000000001800003C00007E00007C00003C00001C00003C00001C00001C00001C00003C00003C00003C00003C00003C00003C00007E00007F0000FF00007E00000000000000', '1', 'DIGIT ONE', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200002, 50, '00000000000000180000FE0001FF8003C7C00781C00701C00601E00701E00001E00003C0003F8000FF0001F00003C0000380000700E007FFE007FFE003FFE0013900000000000000', '2', 'DIGIT TWO', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200002, 51, '000000000000007E0000FF8001FFC003C3C00380C00000C00001C00003C00007C00007800007C00001E00001E00300E00780E00781E007FFC003FFC000FF80003C00000000000000', '3', 'DIGIT THREE', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200002, 52, '000000000000001800003C000038000038C00079E000F1E000F0E001E1E003C1E003C1E00780E00F81E00FC1E00FFFF00FFFF80FEBE00003F00007F00003F0000060000000000000', '4', 'DIGIT FOUR', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200002, 53, '000000000000007F8001FFC003FFC003800003000003000003880003FF0003FF800397C00003C00001E00001E00000E00601E00703C007FFC003FF8003FF00007E00000000000000', '5', 'DIGIT FIVE', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200002, 54, '000000000000000E00003E00007E0000F80001E00001C00003800003FF0007FF8007C7C00781C00700E00700E00700E00700E00381C003F7C001FF8000FF00004E00000000000000', '6', 'DIGIT SIX', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200002, 55, '00000000000003FFC003FFE007FFC00783C00703C0020780000780000F00000F00000E00001E00001C00001C00003C00003800003800003800007800003800003000000000000000', '7', 'DIGIT SEVEN', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200002, 56, '00000000000000FC0001FEC003FFC00381C00703C007038007078003CF0003FF0001FF8003B7C00781C00700E00700E00700E00781E003FFC003FFC001FF80007E00000000000000', '8', 'DIGIT EIGHT', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200002, 57, '000000000000007C0001FF0003FF8003D3C00781C00700E00700E00700E00301E00383E001FFC001FFE0007FC0000380000F80001F00003F0000FC0001F80000E000000000000000', '9', 'DIGIT NINE', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200002, 58, '000000000000000000000000000000000000003C00007E00007E00007E00007E00003C00000000000000001800003E00007E00007E00007E00007C00003800000000000000000000', ':', 'COLON', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200002, 59, '000000000000000000001E00001F00003F00003F80003F00001E00000C00000000001E00003F00003F00003F00001F00003E0000FC0001FC0001F000008000000000000000000000', ';', 'SEMICOLON', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200002, 60, '0000000000000000000000000000600000F0000FF0007FE001FF4007FC000FC0000F80000FF00003FE0000FF80001FF00003F00001E0000000000000000000000000000000000000', '<', 'LESS-THAN SIGN', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200002, 61, '00000000000000000000000000000000000000000000000003FFC003FFC00001800000000136C003FFC003FFC0000000000000000000000000000000000000000000000000000000', '=', 'EQUALS SIGN', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200002, 62, '00000000000000000000000000000003800003E00003F80001FF00007F80001FC00007E0000FE0001FC000FF0003FC0003F00003E000018000000000000000000000000000000000', '>', 'GREATER-THAN SIGN', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200002, 63, '00000000000000300000FE0001FF8003FFC003C3C00381C00103C0000780000FC0001F80001F00001C00001C00001800000000001000003E00003E00003E00003C00000000000000', '?', 'QUESTION MARK', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200002, 64, '000000000000003C0000FF0001FF8003C3C00301C0031CC0073EE007FFE006F7E00667C006C7E007E7E007FFC0077FC0071C0003810003C78001FF8000FF00007C00000000000000', '@', 'COMMERCIAL AT', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200002, 65, '000000000000001000003800003C00007E0000EE0000E70001C3000183800181800183C00301C00301C007FFC007FFE0071BE00700E00700F00F81F01F83F80F01F0000000000000', 'A', 'LATIN CAPITAL LETTER A', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200002, 66, '0000000000000300000FFF800FFFE00788E00300700380700380700380F003B1E003FFE003FFE00383F00300700300780380700700700F41F00FFFE00FFFC00FFF80000000000000', 'B', 'LATIN CAPITAL LETTER B', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200002, 67, '000000000000000C0000FFC001FFC003C3E00381E00300E00700000700000700000700000700000700000700400780E00781E00381E003E7C001FF8000FF80007E00000000000000', 'C', 'LATIN CAPITAL LETTER C', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200002, 68, '00000000000001DE000FFF800FFF800701E00701E00700600380700700700380700380700380700380700380700380700780E00783E007FFC00FFF800FFF0007E000000000000000', 'D', 'LATIN CAPITAL LETTER D', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200002, 69, '00000000000007FFC00FFFE00FDFF00300F0038060038000038800039E0003FE0003FE0003DE00038E000384000380200380700380700FFFF00FFFF00FFFE0020080000000000000', 'E', 'LATIN CAPITAL LETTER E', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200002, 70, '0000000000000FFFC00FFFF00FFFF00F80F0078060038000038C0003BE0003FE0003FE0003FE00039E000784000380000380000780000FC0000FC0000FC000058000000000000000', 'F', 'LATIN CAPITAL LETTER F', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200002, 71, '000000000000003F8000FFC001FFC001C3C00381C00300C00300000700000701000307C0030FE00707E00700E00780E00781E00381E003E7E001FFE000FFE0007EC0000000000000', 'G', 'LATIN CAPITAL LETTER G', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200002, 72, '0000000000000F81F01F83F81F83F80781F00700E00781E007C1E0037FE007FFE003FFE007F7E00781E00781E00781E00781E00781F00FC3F01FC3F81F81F00700F0000000000000', 'H', 'LATIN CAPITAL LETTER H', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200002, 73, '000000000000007F0000FF0001FF0000FE00003C00003800003800003800003C00003800003800003800003C00003C00003C00007C0000FF0001FF8001FF8000FF00000000000000', 'I', 'LATIN CAPITAL LETTER I', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200002, 74, '0000000000000001000003E00003F00003E00001C00001C00001C00001C00000C00000C00381C00781C007C1C007C1C00741C007C7C007FFC001FF00007C00000800000000000000', 'J', 'LATIN CAPITAL LETTER J', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200002, 75, '0000000000000681E00F83F00F83F00303C0030780038F80030E00031E0003BE0003FE0003F70003C7000387000387800383C00703E00F83F00FC3F00783F0010060000000000000', 'K', 'LATIN CAPITAL LETTER K', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200002, 76, '0000000000000FC0000FC00007C00007800003800003800003800003800003800003C00003800003800003800003807003C07807FFF00FFFF01FFFF007FFF0000000000000000000', 'L', 'LATIN CAPITAL LETTER L', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200002, 77, '0000000000000A00000E00F00F01F00F83E00F83E007C7E00EE7E00EEFE00E7EE00E7CE00E3C600E3C600E1CE00E08E00600E00F00E00F01E01FC3F81F83F80601E0000000000000', 'M', 'LATIN CAPITAL LETTER M', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200002, 78, '0000000000000F00D00F83F00FC1F007E0F007E0E007F07006F8F00778F00738F0061CF0071CF0061EF0071EF0070FE00707F00787E00FC3E00FC3E00FC1C0000000000000000000', 'N', 'LATIN CAPITAL LETTER N', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200002, 79, '00000000000001FF8003FFC007AFE00700E00600600200E00700E00700E00600E00780E00700E00700E00780E00700E00700E00700E00799E003FFE003FFC001FF80000000000000', 'O', 'LATIN CAPITAL LETTER O', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200002, 80, '00000000000007FE000FFFC00FFFE00FFFF00F01F00300F00380700380F80381F003A7F001FFC003FFC003A7000380000780000700000F80000FC0000FC000068000000000000000', 'P', 'LATIN CAPITAL LETTER P', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200002, 81, '000000000000007C0000FF0001FF800387C00701C00701C00601C00601C00E01E00600E00600E00E79E00678E0063DE0061FC0078FC003EFC003FFF001FFF0003FE0000000000000', 'Q', 'LATIN CAPITAL LETTER Q', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200002, 82, '0000000000000C00000FFF000FFF000FFFC00701C00300E00300E00301E00307C003FF8003FF0003DF000303000303000301800301C00781E00F81F00F81F8020020000000000000', 'R', 'LATIN CAPITAL LETTER R', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200002, 83, '00000000000000180000FF8001FFC003C7C003818003800003800003C00001FC0000FF00003F800003C00001C00000E00000E00301C007FFC007FF8007FF00023C00000000000000', 'S', 'LATIN CAPITAL LETTER S', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200002, 84, '00000000000003FAC007FFE00FFFE00FFFF00E3CF0063860003C00001C00001800001800003800003800003800003800003800003800007E0000FE0000FE00003000000000000000', 'T', 'LATIN CAPITAL LETTER T', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200002, 85, '0000000000000F00F01FC3F80F81F80701F00700E00700E00700E00700E00700E00700E00700E00700E00700E00700E00780E00380C003F7C001FF8001FF00003000000000000000', 'U', 'LATIN CAPITAL LETTER U', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200002, 86, '0000000000000700E00FC3F81FC3F807C1F80380E00380E00380E00380E00381E003C1C001C3C001E3C001F7C000E78000FF80007F00007F00007E00003C00001800000000000000', 'V', 'LATIN CAPITAL LETTER V', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200002, 87, '0000000000000000600F81F00FC3F80F81F00700E00700E00701E00710E00711C00339C0033CC003FDC003FFC003FFC001FFC001EF8001FF8001EF8000E700004200000000000000', 'W', 'LATIN CAPITAL LETTER W', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200002, 88, '0000000000000F81E00F81F80F81F001C1C001E38000E78000F600001E00001C00003C00003E00007E0000E70000C3800183800381C00F00E00F81F01F81F00501F0000000000000', 'X', 'LATIN CAPITAL LETTER X', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200002, 89, '0000000000000400C00F81F01F83F80F83F00783E003C3C001E78000FF0000FF00007E00003C00003C00001C00003C00001C00001800003C00007E00007E00003E00000000000000', 'Y', 'LATIN CAPITAL LETTER Y', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200002, 90, '000000000000001F8003FF8007FF8007FF80070780021F00001E00003C0000780000700000E00001C00001C0000380200780E00781E007FFF007FFF007FFE00753C0000000000000', 'Z', 'LATIN CAPITAL LETTER Z', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200002, 91, '00000000000000380000FF0000FF0001FE0000E00000E00000E00000E00000E00000E00000E00001E00000E00001E00000E00001E00000FF0000FF8000FF00003C00000000000000', '[', 'LEFT SQUARE BRACKET', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200002, 92, '00000000000003000007800007800003C00003C00001E00001F00000F800007800007C00003E00001F00000F000007800007C00007E00003E00001E00000E0000000000000000000', '\', 'REVERSE SOLIDUS', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200002, 93, '00000000000000FE0000FF0000FF80006F00000780000700000700000700000780000700000700000700000700000700000700000700007F0001FF0000FF0000EE00000000000000', ']', 'RIGHT SQUARE BRACKET', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200002, 94, '000000000000000000001000003C00007E0000FF8001FF0000FF00003D00003C00003C00003C00001C00003C00003C00003C00001C00000800000000000000000000000000000000', '↑', 'UPWARDS ARROW', 'Up arrow', 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200002, 95, '00000000000000000000000000000000000000000000000001C00003E00007FFC007FFE003FFE003E08001C000004000000000000000000000000000000000000000000000000000', '←', 'LEFTWARDS ARROW', 'Back arrow', 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO charset (id, machine_id, base_charset_id, code, name, language, width, height, description) VALUES (200012, 200002, 200002, 'ASR33_UK_GE235', 'Teletype ASR-33, UK print head (reconstruction)', 'uk', 24, 24, 'Variant of the US set: the pound sign in place of $ (code 36); the other glyphs are inherited. Reconstruction from the same font, made for the ICL 2903 emulator, which imitates an ASR-33 with a UK print head.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200012, 36, '00000000000000F80001FE00030F0002030003000003000001800001C00001F00001F80001F80000300000300001F00003F00007780007FBE007FFE001FFC0014F80000000000000', '£', 'POUND SIGN', 'Pound sign', 'UK print head: in place of $. Reconstruction from a TrueType font.');
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200002, 32, 32);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200002, 33, 33);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200002, 34, 34);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200002, 35, 35);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200002, 36, 36);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200002, 37, 37);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200002, 38, 38);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200002, 39, 39);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200002, 40, 40);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200002, 41, 41);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200002, 42, 42);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200002, 43, 43);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200002, 44, 44);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200002, 45, 45);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200002, 46, 46);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200002, 47, 47);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200002, 48, 48);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200002, 49, 49);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200002, 50, 50);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200002, 51, 51);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200002, 52, 52);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200002, 53, 53);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200002, 54, 54);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200002, 55, 55);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200002, 56, 56);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200002, 57, 57);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200002, 58, 58);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200002, 59, 59);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200002, 60, 60);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200002, 61, 61);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200002, 62, 62);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200002, 63, 63);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200002, 64, 64);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200002, 65, 65);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200002, 66, 66);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200002, 67, 67);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200002, 68, 68);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200002, 69, 69);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200002, 70, 70);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200002, 71, 71);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200002, 72, 72);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200002, 73, 73);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200002, 74, 74);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200002, 75, 75);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200002, 76, 76);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200002, 77, 77);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200002, 78, 78);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200002, 79, 79);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200002, 80, 80);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200002, 81, 81);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200002, 82, 82);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200002, 83, 83);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200002, 84, 84);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200002, 85, 85);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200002, 86, 86);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200002, 87, 87);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200002, 88, 88);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200002, 89, 89);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200002, 90, 90);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200002, 91, 91);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200002, 92, 92);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200002, 93, 93);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200002, 94, 94);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200002, 95, 95);
INSERT INTO table_status (table_kind_id, machine_id, status, notes) SELECT id, 200002, 'COMPLETE', '**Reconstruction**: the Teletype ASR-33 printed with a type cylinder, so there are no original bitmaps. The 64 glyphs (US print head, with the UK variant that has the pound sign in place of $) are rasterized from the TrueType font "TeleType ASR 33 UK" (© 2015 David Bonham), drawn from photographs of Teletype listings.' FROM table_kind WHERE code = 'GLYPHS';
INSERT INTO table_status (table_kind_id, machine_id, status, notes) SELECT id, 200002, 'COMPLETE', 'No screen: output on paper. These rows only link each printed code (32-95) to the glyph with the same number.' FROM table_kind WHERE code = 'SCREEN_CODES';
INSERT INTO table_status (table_kind_id, machine_id, status, notes) SELECT id, 200002, 'NOT_APPLICABLE', 'Output on paper.' FROM table_kind WHERE code = 'COLORS';
INSERT INTO charset (id, machine_id, code, name, language, width, height, description) VALUES (200003, 200003, 'ASR33_GE635', 'Teletype ASR-33, US print head (reconstruction)', 'us', 24, 24, 'Reconstruction: the ASR-33 printed with a type cylinder, so these bitmaps are rasterized from the TrueType font "TeleType ASR 33 UK" (c) 2015 David Bonham, drawn from photographs of Teletype listings. 64 glyphs, codes 32-95 of ASCII-1963, no lower case.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200003, 32, '000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000', ' ', 'SPACE', 'Space', 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200003, 33, '000000000000003C00007E00007E00007E00007C00007C00003C00007E00007C00007C00007C00003C00003800001800003C00007E00007E00007E00007C00003C00000000000000', '!', 'EXCLAMATION MARK', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200003, 34, '00000000000001C1C007E7C007C3E007C3C003C7C003C3C003C7C003C180018100000000000000000000000000000000000000000000000000000000000000000000000000000000', '"', 'QUOTATION MARK', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200003, 35, '000000000000000000001CC0001DC000198000398000198000338001FFE0007F8000670003FF8007FF8003FF0001CC0003DC00039C0003FC00033800011000000000000000000000', '#', 'NUMBER SIGN', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200003, 36, '000000000000003C0000FF0003FF8007FBC003B8C007380007B80003F80001FC0000FF80003F800039E00038E00038E00038E00639E007FFC007FF8001FE00001C00000000000000', '$', 'DOLLAR SIGN', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200003, 37, '000000000000027B8003FFC007F7800621800E33000F770007F60003DE00001C00001C000038000070000073C000EFE001EEE001CE7003CEF003CFE0038FE0020280000000000000', '%', 'PERCENT SIGN', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200003, 38, '000000000000001C00003F00007F80007380007380007380007700007F0000FE0001FC0007F86007DCF0071FF00707C00F9F8007DFC007FFF003FDF000F060008000000000000000', '&', 'AMPERSAND', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200003, 39, '000000000000001800007E00007E00007E00007E00003E00003C00003C00001C00000C00000000000000000000000000000000000000000000000000000000000000000000000000', '''', 'APOSTROPHE', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200003, 40, '000000000000000200001F00001F00003E0000380000700000700000E00000E00000E00000E00000F00000F000007800007C00003F00003F00001F00000E00000200000000000000', '(', 'LEFT PARENTHESIS', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200003, 41, '00000000000000E00000F000007800003C00001E00001E00000E00000700000700000700000700000F00000F00000E00001E00003E00007C0000F80001F00000C000000000000000', ')', 'RIGHT PARENTHESIS', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200003, 42, '0000000000000000000000000018000038000018000718E007D9E003FFE001FF80007F0000FF8007FFE007DBE00718E0003C00003800003800000000000000000000000000000000', '*', 'ASTERISK', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200003, 43, '000000000000000000000000000000003800003C00003C00007C0001FC0007FFF00FFFF007FFF0007C00003C00003C00007C00003C00003000000000000000000000000000000000', '+', 'PLUS SIGN', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200003, 44, '000000000000000000000000000000000000000000000000000000000000000000000000000400001F00001F80000F80000F00001F0000FF0000FE0001F80000F000000000000000', ',', 'COMMA', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200003, 45, '00000000000000000000000000000000000000000000000000000003FFE007FFE00FFFF007FFF003FFE0010000000000000000000000000000000000000000000000000000000000', '-', 'HYPHEN-MINUS', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200003, 46, '000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000003C00003E00003E00003C00001C00000000000000000000000000', '.', 'FULL STOP', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200003, 47, '0000000000000000400000E00001E00003E00003C0000780000F80001F00001E00003E00007C0000F80000F00001F00003E00003E00007C000078000070000030000000000000000', '/', 'SOLIDUS', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200003, 48, '000000000000007E0000FF0001FF8001E78003C78001C78001C38001C38001C38001C38001C38001838001C78001C78001C3C001C3C001FF8001FF00007E00001800000000000000', '0', 'DIGIT ZERO', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200003, 49, '000000000000001800003C00007E00007C00003C00001C00003C00001C00001C00001C00003C00003C00003C00003C00003C00003C00007E00007F0000FF00007E00000000000000', '1', 'DIGIT ONE', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200003, 50, '00000000000000180000FE0001FF8003C7C00781C00701C00601E00701E00001E00003C0003F8000FF0001F00003C0000380000700E007FFE007FFE003FFE0013900000000000000', '2', 'DIGIT TWO', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200003, 51, '000000000000007E0000FF8001FFC003C3C00380C00000C00001C00003C00007C00007800007C00001E00001E00300E00780E00781E007FFC003FFC000FF80003C00000000000000', '3', 'DIGIT THREE', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200003, 52, '000000000000001800003C000038000038C00079E000F1E000F0E001E1E003C1E003C1E00780E00F81E00FC1E00FFFF00FFFF80FEBE00003F00007F00003F0000060000000000000', '4', 'DIGIT FOUR', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200003, 53, '000000000000007F8001FFC003FFC003800003000003000003880003FF0003FF800397C00003C00001E00001E00000E00601E00703C007FFC003FF8003FF00007E00000000000000', '5', 'DIGIT FIVE', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200003, 54, '000000000000000E00003E00007E0000F80001E00001C00003800003FF0007FF8007C7C00781C00700E00700E00700E00700E00381C003F7C001FF8000FF00004E00000000000000', '6', 'DIGIT SIX', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200003, 55, '00000000000003FFC003FFE007FFC00783C00703C0020780000780000F00000F00000E00001E00001C00001C00003C00003800003800003800007800003800003000000000000000', '7', 'DIGIT SEVEN', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200003, 56, '00000000000000FC0001FEC003FFC00381C00703C007038007078003CF0003FF0001FF8003B7C00781C00700E00700E00700E00781E003FFC003FFC001FF80007E00000000000000', '8', 'DIGIT EIGHT', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200003, 57, '000000000000007C0001FF0003FF8003D3C00781C00700E00700E00700E00301E00383E001FFC001FFE0007FC0000380000F80001F00003F0000FC0001F80000E000000000000000', '9', 'DIGIT NINE', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200003, 58, '000000000000000000000000000000000000003C00007E00007E00007E00007E00003C00000000000000001800003E00007E00007E00007E00007C00003800000000000000000000', ':', 'COLON', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200003, 59, '000000000000000000001E00001F00003F00003F80003F00001E00000C00000000001E00003F00003F00003F00001F00003E0000FC0001FC0001F000008000000000000000000000', ';', 'SEMICOLON', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200003, 60, '0000000000000000000000000000600000F0000FF0007FE001FF4007FC000FC0000F80000FF00003FE0000FF80001FF00003F00001E0000000000000000000000000000000000000', '<', 'LESS-THAN SIGN', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200003, 61, '00000000000000000000000000000000000000000000000003FFC003FFC00001800000000136C003FFC003FFC0000000000000000000000000000000000000000000000000000000', '=', 'EQUALS SIGN', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200003, 62, '00000000000000000000000000000003800003E00003F80001FF00007F80001FC00007E0000FE0001FC000FF0003FC0003F00003E000018000000000000000000000000000000000', '>', 'GREATER-THAN SIGN', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200003, 63, '00000000000000300000FE0001FF8003FFC003C3C00381C00103C0000780000FC0001F80001F00001C00001C00001800000000001000003E00003E00003E00003C00000000000000', '?', 'QUESTION MARK', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200003, 64, '000000000000003C0000FF0001FF8003C3C00301C0031CC0073EE007FFE006F7E00667C006C7E007E7E007FFC0077FC0071C0003810003C78001FF8000FF00007C00000000000000', '@', 'COMMERCIAL AT', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200003, 65, '000000000000001000003800003C00007E0000EE0000E70001C3000183800181800183C00301C00301C007FFC007FFE0071BE00700E00700F00F81F01F83F80F01F0000000000000', 'A', 'LATIN CAPITAL LETTER A', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200003, 66, '0000000000000300000FFF800FFFE00788E00300700380700380700380F003B1E003FFE003FFE00383F00300700300780380700700700F41F00FFFE00FFFC00FFF80000000000000', 'B', 'LATIN CAPITAL LETTER B', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200003, 67, '000000000000000C0000FFC001FFC003C3E00381E00300E00700000700000700000700000700000700000700400780E00781E00381E003E7C001FF8000FF80007E00000000000000', 'C', 'LATIN CAPITAL LETTER C', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200003, 68, '00000000000001DE000FFF800FFF800701E00701E00700600380700700700380700380700380700380700380700380700780E00783E007FFC00FFF800FFF0007E000000000000000', 'D', 'LATIN CAPITAL LETTER D', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200003, 69, '00000000000007FFC00FFFE00FDFF00300F0038060038000038800039E0003FE0003FE0003DE00038E000384000380200380700380700FFFF00FFFF00FFFE0020080000000000000', 'E', 'LATIN CAPITAL LETTER E', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200003, 70, '0000000000000FFFC00FFFF00FFFF00F80F0078060038000038C0003BE0003FE0003FE0003FE00039E000784000380000380000780000FC0000FC0000FC000058000000000000000', 'F', 'LATIN CAPITAL LETTER F', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200003, 71, '000000000000003F8000FFC001FFC001C3C00381C00300C00300000700000701000307C0030FE00707E00700E00780E00781E00381E003E7E001FFE000FFE0007EC0000000000000', 'G', 'LATIN CAPITAL LETTER G', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200003, 72, '0000000000000F81F01F83F81F83F80781F00700E00781E007C1E0037FE007FFE003FFE007F7E00781E00781E00781E00781E00781F00FC3F01FC3F81F81F00700F0000000000000', 'H', 'LATIN CAPITAL LETTER H', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200003, 73, '000000000000007F0000FF0001FF0000FE00003C00003800003800003800003C00003800003800003800003C00003C00003C00007C0000FF0001FF8001FF8000FF00000000000000', 'I', 'LATIN CAPITAL LETTER I', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200003, 74, '0000000000000001000003E00003F00003E00001C00001C00001C00001C00000C00000C00381C00781C007C1C007C1C00741C007C7C007FFC001FF00007C00000800000000000000', 'J', 'LATIN CAPITAL LETTER J', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200003, 75, '0000000000000681E00F83F00F83F00303C0030780038F80030E00031E0003BE0003FE0003F70003C7000387000387800383C00703E00F83F00FC3F00783F0010060000000000000', 'K', 'LATIN CAPITAL LETTER K', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200003, 76, '0000000000000FC0000FC00007C00007800003800003800003800003800003800003C00003800003800003800003807003C07807FFF00FFFF01FFFF007FFF0000000000000000000', 'L', 'LATIN CAPITAL LETTER L', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200003, 77, '0000000000000A00000E00F00F01F00F83E00F83E007C7E00EE7E00EEFE00E7EE00E7CE00E3C600E3C600E1CE00E08E00600E00F00E00F01E01FC3F81F83F80601E0000000000000', 'M', 'LATIN CAPITAL LETTER M', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200003, 78, '0000000000000F00D00F83F00FC1F007E0F007E0E007F07006F8F00778F00738F0061CF0071CF0061EF0071EF0070FE00707F00787E00FC3E00FC3E00FC1C0000000000000000000', 'N', 'LATIN CAPITAL LETTER N', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200003, 79, '00000000000001FF8003FFC007AFE00700E00600600200E00700E00700E00600E00780E00700E00700E00780E00700E00700E00700E00799E003FFE003FFC001FF80000000000000', 'O', 'LATIN CAPITAL LETTER O', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200003, 80, '00000000000007FE000FFFC00FFFE00FFFF00F01F00300F00380700380F80381F003A7F001FFC003FFC003A7000380000780000700000F80000FC0000FC000068000000000000000', 'P', 'LATIN CAPITAL LETTER P', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200003, 81, '000000000000007C0000FF0001FF800387C00701C00701C00601C00601C00E01E00600E00600E00E79E00678E0063DE0061FC0078FC003EFC003FFF001FFF0003FE0000000000000', 'Q', 'LATIN CAPITAL LETTER Q', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200003, 82, '0000000000000C00000FFF000FFF000FFFC00701C00300E00300E00301E00307C003FF8003FF0003DF000303000303000301800301C00781E00F81F00F81F8020020000000000000', 'R', 'LATIN CAPITAL LETTER R', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200003, 83, '00000000000000180000FF8001FFC003C7C003818003800003800003C00001FC0000FF00003F800003C00001C00000E00000E00301C007FFC007FF8007FF00023C00000000000000', 'S', 'LATIN CAPITAL LETTER S', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200003, 84, '00000000000003FAC007FFE00FFFE00FFFF00E3CF0063860003C00001C00001800001800003800003800003800003800003800003800007E0000FE0000FE00003000000000000000', 'T', 'LATIN CAPITAL LETTER T', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200003, 85, '0000000000000F00F01FC3F80F81F80701F00700E00700E00700E00700E00700E00700E00700E00700E00700E00700E00780E00380C003F7C001FF8001FF00003000000000000000', 'U', 'LATIN CAPITAL LETTER U', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200003, 86, '0000000000000700E00FC3F81FC3F807C1F80380E00380E00380E00380E00381E003C1C001C3C001E3C001F7C000E78000FF80007F00007F00007E00003C00001800000000000000', 'V', 'LATIN CAPITAL LETTER V', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200003, 87, '0000000000000000600F81F00FC3F80F81F00700E00700E00701E00710E00711C00339C0033CC003FDC003FFC003FFC001FFC001EF8001FF8001EF8000E700004200000000000000', 'W', 'LATIN CAPITAL LETTER W', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200003, 88, '0000000000000F81E00F81F80F81F001C1C001E38000E78000F600001E00001C00003C00003E00007E0000E70000C3800183800381C00F00E00F81F01F81F00501F0000000000000', 'X', 'LATIN CAPITAL LETTER X', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200003, 89, '0000000000000400C00F81F01F83F80F83F00783E003C3C001E78000FF0000FF00007E00003C00003C00001C00003C00001C00001800003C00007E00007E00003E00000000000000', 'Y', 'LATIN CAPITAL LETTER Y', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200003, 90, '000000000000001F8003FF8007FF8007FF80070780021F00001E00003C0000780000700000E00001C00001C0000380200780E00781E007FFF007FFF007FFE00753C0000000000000', 'Z', 'LATIN CAPITAL LETTER Z', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200003, 91, '00000000000000380000FF0000FF0001FE0000E00000E00000E00000E00000E00000E00000E00001E00000E00001E00000E00001E00000FF0000FF8000FF00003C00000000000000', '[', 'LEFT SQUARE BRACKET', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200003, 92, '00000000000003000007800007800003C00003C00001E00001F00000F800007800007C00003E00001F00000F000007800007C00007E00003E00001E00000E0000000000000000000', '\', 'REVERSE SOLIDUS', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200003, 93, '00000000000000FE0000FF0000FF80006F00000780000700000700000700000780000700000700000700000700000700000700000700007F0001FF0000FF0000EE00000000000000', ']', 'RIGHT SQUARE BRACKET', NULL, 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200003, 94, '000000000000000000001000003C00007E0000FF8001FF0000FF00003D00003C00003C00003C00001C00003C00003C00003C00001C00000800000000000000000000000000000000', '↑', 'UPWARDS ARROW', 'Up arrow', 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200003, 95, '00000000000000000000000000000000000000000000000001C00003E00007FFC007FFE003FFE003E08001C000004000000000000000000000000000000000000000000000000000', '←', 'LEFTWARDS ARROW', 'Back arrow', 'Reconstruction from a TrueType font, not an original bitmap.');
INSERT INTO charset (id, machine_id, base_charset_id, code, name, language, width, height, description) VALUES (200013, 200003, 200003, 'ASR33_UK_GE635', 'Teletype ASR-33, UK print head (reconstruction)', 'uk', 24, 24, 'Variant of the US set: the pound sign in place of $ (code 36); the other glyphs are inherited. Reconstruction from the same font, made for the ICL 2903 emulator, which imitates an ASR-33 with a UK print head.');
INSERT INTO glyph (charset_id, code, bitmap, unicode, unicode_name, name, notes) VALUES (200013, 36, '00000000000000F80001FE00030F0002030003000003000001800001C00001F00001F80001F80000300000300001F00003F00007780007FBE007FFE001FFC0014F80000000000000', '£', 'POUND SIGN', 'Pound sign', 'UK print head: in place of $. Reconstruction from a TrueType font.');
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200003, 32, 32);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200003, 33, 33);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200003, 34, 34);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200003, 35, 35);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200003, 36, 36);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200003, 37, 37);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200003, 38, 38);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200003, 39, 39);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200003, 40, 40);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200003, 41, 41);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200003, 42, 42);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200003, 43, 43);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200003, 44, 44);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200003, 45, 45);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200003, 46, 46);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200003, 47, 47);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200003, 48, 48);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200003, 49, 49);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200003, 50, 50);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200003, 51, 51);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200003, 52, 52);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200003, 53, 53);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200003, 54, 54);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200003, 55, 55);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200003, 56, 56);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200003, 57, 57);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200003, 58, 58);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200003, 59, 59);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200003, 60, 60);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200003, 61, 61);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200003, 62, 62);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200003, 63, 63);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200003, 64, 64);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200003, 65, 65);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200003, 66, 66);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200003, 67, 67);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200003, 68, 68);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200003, 69, 69);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200003, 70, 70);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200003, 71, 71);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200003, 72, 72);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200003, 73, 73);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200003, 74, 74);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200003, 75, 75);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200003, 76, 76);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200003, 77, 77);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200003, 78, 78);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200003, 79, 79);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200003, 80, 80);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200003, 81, 81);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200003, 82, 82);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200003, 83, 83);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200003, 84, 84);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200003, 85, 85);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200003, 86, 86);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200003, 87, 87);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200003, 88, 88);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200003, 89, 89);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200003, 90, 90);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200003, 91, 91);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200003, 92, 92);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200003, 93, 93);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200003, 94, 94);
INSERT INTO screen_code (machine_id, code, glyph_code) VALUES (200003, 95, 95);
INSERT INTO table_status (table_kind_id, machine_id, status, notes) SELECT id, 200003, 'COMPLETE', '**Reconstruction**: the Teletype ASR-33 printed with a type cylinder, so there are no original bitmaps. The 64 glyphs (US print head, with the UK variant that has the pound sign in place of $) are rasterized from the TrueType font "TeleType ASR 33 UK" (© 2015 David Bonham), drawn from photographs of Teletype listings.' FROM table_kind WHERE code = 'GLYPHS';
INSERT INTO table_status (table_kind_id, machine_id, status, notes) SELECT id, 200003, 'COMPLETE', 'No screen: output on paper. These rows only link each printed code (32-95) to the glyph with the same number.' FROM table_kind WHERE code = 'SCREEN_CODES';
INSERT INTO table_status (table_kind_id, machine_id, status, notes) SELECT id, 200003, 'NOT_APPLICABLE', 'Output on paper.' FROM table_kind WHERE code = 'COLORS';
INSERT INTO source (id, title, author, publisher, year, kind, url, notes) VALUES (200001, 'BASIC Instruction Manual, May 1964 (First Draft)', 'John G. Kemeny, Thomas E. Kurtz', 'Dartmouth College Computation Center', 1964, 'MANUAL', 'https://www.dartmouth.edu/basicfifty/basicmanual_1964.pdf', 'The first manual, Part I "For beginners" only (pages 1-22): 9 statements besides END; Part II (four more statements, RND, INT, vectors and matrices) is not in the reprint. Facsimile published by T. E. Kurtz in 2000. Local copy: data/sources/basicmanual_1964.pdf (scan; the pages cited are the printed ones).');
INSERT INTO source (id, title, author, publisher, year, kind, url, notes) VALUES (200002, 'BASIC (1 October 1964)', 'John G. Kemeny, Thomas E. Kurtz', 'Dartmouth College Computation Center', 1964, 'MANUAL', 'https://bitsavers.org/pdf/dartmouth/dtss/196410_BASIC.pdf', 'The 2nd edition manual, 57 pages: 15 statements, error stops (appendix A), limitations (appendix B); chapter IV describes Card BASIC with MAT.');
INSERT INTO source (id, title, author, publisher, year, kind, url, notes) VALUES (200003, 'BASIC Language Reference Manual (June 1965, rev. January 1967)', NULL, 'General Electric Information Service Department', 1967, 'MANUAL', 'https://ftp.mirrorservice.org/sites/www.bitsavers.org/pdf/ge/MarkI_Timesharing/202026A_BASIC_Language_Reference_Manual_Jan1967.pdf', 'Dartmouth''s BASIC on the GE-235 as sold by GE (publication IPC-202026A). Used for the 3rd edition, whose Dartmouth manual is not available: INPUT, RESTORE, MAT, INT as floor, run-time error messages, limitations.');
INSERT INTO source (id, title, author, publisher, year, kind, url, notes) VALUES (200004, 'BASIC, 4th Edition (January 1968)', 'Dartmouth College', 'Dartmouth Publications', 1968, 'MANUAL', 'https://archive.org/stream/bitsavers_dartmouthB_3679804/BASIC_4th_Edition_Jan68_djvu.txt', 'GE-635 version. Read in the text version; local copy of the scan: data/sources/BASIC_4th_Edition_Jan68.pdf.');
INSERT INTO source (id, title, author, publisher, year, kind, url, notes) VALUES (200005, 'Dartmouth BASIC', NULL, 'Wikipedia', NULL, 'WEB', 'https://en.wikipedia.org/wiki/Dartmouth_BASIC', 'History of the editions: what each one added.');
INSERT INTO source (id, title, author, publisher, year, kind, url, notes) VALUES (200006, 'Dartmouth BASIC: summary of language and commands', 'Thomas E. Kurtz', 'Dartmouth College', 2005, 'WEB', 'https://www.dartmouth.edu/basicfifty/commands.html', 'Summary of the original BASIC as run by the DTSS simulator: 15 statements, precision of the GE-225/235, unary minus before the power.');
INSERT INTO source (id, title, author, publisher, year, kind, url, notes) VALUES (200007, 'Dartmouth BASIC compiler listings (BA-1, BA-2, BA-3)', 'transcribed by Thomas E. Kurtz', NULL, 1965, 'WEB', 'https://dtss.dartmouth.edu/proofed/BASIC/', 'GE-235 assembly source headed "telebasic rev. 1, basic and teach combined, 8 feb 65": between the 2nd and the 3rd edition (it already has INPUT).');
INSERT INTO source (id, title, author, publisher, year, kind, url, notes) VALUES (200008, 'DTSS-Win simulator', 'Thomas E. Kurtz', 'Dartmouth College', 2007, 'WEB', 'https://dtss.dartmouth.edu/DTSS-Win.zip', 'True BASIC simulation of the GE-235 running the original BASIC compiler (BASICCOMPILER.TRU, machine code) and Algol. Local copy kept by the editor.');
INSERT INTO source (id, title, author, publisher, year, kind, url, notes) VALUES (200009, 'BASIC (in History of Programming Languages, ed. R. L. Wexelblat)', 'Thomas E. Kurtz', 'Academic Press', 1981, 'BOOK', 'https://doi.org/10.1145/800025.1198404', 'Kurtz''s paper for the ACM HOPL conference of 1978, pp. 515-537: the design of each edition from the 1st to the 6th. It quotes the complete 1st edition manual (June 1964, with Part II: pages 25, 31, 37, 39), the 3rd edition manual (1966) and its Supplement (1967). Local copy: data/sources/Kurtz.pdf.');

-- ================= layer DARTMOUTH_1ED_core
INSERT INTO character_code (id, layer_id, code, evidence, kind) VALUES (200000, 200001, 0, 'INFERRED', 'UNUSED');
INSERT INTO character_code (id, layer_id, code, evidence, kind) VALUES (200001, 200001, 1, 'INFERRED', 'UNUSED');
INSERT INTO character_code (id, layer_id, code, evidence, kind) VALUES (200002, 200001, 2, 'INFERRED', 'UNUSED');
INSERT INTO character_code (id, layer_id, code, evidence, kind) VALUES (200003, 200001, 3, 'INFERRED', 'UNUSED');
INSERT INTO character_code (id, layer_id, code, evidence, kind, name, action) VALUES (200004, 200001, 4, 'INFERRED', 'CONTROL', 'EOT', 'End of transmission');
INSERT INTO character_code (id, layer_id, code, evidence, kind) VALUES (200005, 200001, 5, 'INFERRED', 'UNUSED');
INSERT INTO character_code (id, layer_id, code, evidence, kind) VALUES (200006, 200001, 6, 'INFERRED', 'UNUSED');
INSERT INTO character_code (id, layer_id, code, evidence, kind, name, action) VALUES (200007, 200001, 7, 'INFERRED', 'CONTROL', 'BELL', 'Rings the bell of the Teletype');
INSERT INTO character_code (id, layer_id, code, evidence, kind) VALUES (200008, 200001, 8, 'INFERRED', 'UNUSED');
INSERT INTO character_code (id, layer_id, code, evidence, kind) VALUES (200009, 200001, 9, 'INFERRED', 'UNUSED');
INSERT INTO character_code (id, layer_id, code, evidence, kind, name, action) VALUES (200010, 200001, 10, 'INFERRED', 'CONTROL', 'LF', 'Line feed');
INSERT INTO character_code (id, layer_id, code, evidence, kind) VALUES (200011, 200001, 11, 'INFERRED', 'UNUSED');
INSERT INTO character_code (id, layer_id, code, evidence, kind) VALUES (200012, 200001, 12, 'INFERRED', 'UNUSED');
INSERT INTO character_code (id, layer_id, code, evidence, kind, name, action) VALUES (200013, 200001, 13, 'INFERRED', 'CONTROL', 'CR', 'Carriage return');
INSERT INTO character_code (id, layer_id, code, evidence, kind) VALUES (200014, 200001, 14, 'INFERRED', 'UNUSED');
INSERT INTO character_code (id, layer_id, code, evidence, kind) VALUES (200015, 200001, 15, 'INFERRED', 'UNUSED');
INSERT INTO character_code (id, layer_id, code, evidence, kind) VALUES (200016, 200001, 16, 'INFERRED', 'UNUSED');
INSERT INTO character_code (id, layer_id, code, evidence, kind) VALUES (200017, 200001, 17, 'INFERRED', 'UNUSED');
INSERT INTO character_code (id, layer_id, code, evidence, kind) VALUES (200018, 200001, 18, 'INFERRED', 'UNUSED');
INSERT INTO character_code (id, layer_id, code, evidence, kind) VALUES (200019, 200001, 19, 'INFERRED', 'UNUSED');
INSERT INTO character_code (id, layer_id, code, evidence, kind) VALUES (200020, 200001, 20, 'INFERRED', 'UNUSED');
INSERT INTO character_code (id, layer_id, code, evidence, kind) VALUES (200021, 200001, 21, 'INFERRED', 'UNUSED');
INSERT INTO character_code (id, layer_id, code, evidence, kind) VALUES (200022, 200001, 22, 'INFERRED', 'UNUSED');
INSERT INTO character_code (id, layer_id, code, evidence, kind) VALUES (200023, 200001, 23, 'INFERRED', 'UNUSED');
INSERT INTO character_code (id, layer_id, code, evidence, kind) VALUES (200024, 200001, 24, 'INFERRED', 'UNUSED');
INSERT INTO character_code (id, layer_id, code, evidence, kind) VALUES (200025, 200001, 25, 'INFERRED', 'UNUSED');
INSERT INTO character_code (id, layer_id, code, evidence, kind) VALUES (200026, 200001, 26, 'INFERRED', 'UNUSED');
INSERT INTO character_code (id, layer_id, code, evidence, kind) VALUES (200027, 200001, 27, 'INFERRED', 'UNUSED');
INSERT INTO character_code (id, layer_id, code, evidence, kind) VALUES (200028, 200001, 28, 'INFERRED', 'UNUSED');
INSERT INTO character_code (id, layer_id, code, evidence, kind) VALUES (200029, 200001, 29, 'INFERRED', 'UNUSED');
INSERT INTO character_code (id, layer_id, code, evidence, kind) VALUES (200030, 200001, 30, 'INFERRED', 'UNUSED');
INSERT INTO character_code (id, layer_id, code, evidence, kind) VALUES (200031, 200001, 31, 'INFERRED', 'UNUSED');
INSERT INTO character_code (id, layer_id, code, evidence, kind, screen_code) VALUES (200032, 200001, 32, 'INFERRED', 'PRINTABLE', 32);
INSERT INTO character_code (id, layer_id, code, evidence, kind, screen_code) VALUES (200033, 200001, 33, 'INFERRED', 'PRINTABLE', 33);
INSERT INTO character_code (id, layer_id, code, evidence, kind, screen_code) VALUES (200034, 200001, 34, 'INFERRED', 'PRINTABLE', 34);
INSERT INTO character_code (id, layer_id, code, evidence, kind, screen_code) VALUES (200035, 200001, 35, 'INFERRED', 'PRINTABLE', 35);
INSERT INTO character_code (id, layer_id, code, evidence, kind, screen_code) VALUES (200036, 200001, 36, 'INFERRED', 'PRINTABLE', 36);
INSERT INTO character_code (id, layer_id, code, evidence, kind, screen_code) VALUES (200037, 200001, 37, 'INFERRED', 'PRINTABLE', 37);
INSERT INTO character_code (id, layer_id, code, evidence, kind, screen_code) VALUES (200038, 200001, 38, 'INFERRED', 'PRINTABLE', 38);
INSERT INTO character_code (id, layer_id, code, evidence, kind, screen_code) VALUES (200039, 200001, 39, 'INFERRED', 'PRINTABLE', 39);
INSERT INTO character_code (id, layer_id, code, evidence, kind, screen_code) VALUES (200040, 200001, 40, 'INFERRED', 'PRINTABLE', 40);
INSERT INTO character_code (id, layer_id, code, evidence, kind, screen_code) VALUES (200041, 200001, 41, 'INFERRED', 'PRINTABLE', 41);
INSERT INTO character_code (id, layer_id, code, evidence, kind, screen_code) VALUES (200042, 200001, 42, 'INFERRED', 'PRINTABLE', 42);
INSERT INTO character_code (id, layer_id, code, evidence, kind, screen_code) VALUES (200043, 200001, 43, 'INFERRED', 'PRINTABLE', 43);
INSERT INTO character_code (id, layer_id, code, evidence, kind, screen_code) VALUES (200044, 200001, 44, 'INFERRED', 'PRINTABLE', 44);
INSERT INTO character_code (id, layer_id, code, evidence, kind, screen_code) VALUES (200045, 200001, 45, 'INFERRED', 'PRINTABLE', 45);
INSERT INTO character_code (id, layer_id, code, evidence, kind, screen_code) VALUES (200046, 200001, 46, 'INFERRED', 'PRINTABLE', 46);
INSERT INTO character_code (id, layer_id, code, evidence, kind, screen_code) VALUES (200047, 200001, 47, 'INFERRED', 'PRINTABLE', 47);
INSERT INTO character_code (id, layer_id, code, evidence, kind, screen_code) VALUES (200048, 200001, 48, 'INFERRED', 'PRINTABLE', 48);
INSERT INTO character_code (id, layer_id, code, evidence, kind, screen_code) VALUES (200049, 200001, 49, 'INFERRED', 'PRINTABLE', 49);
INSERT INTO character_code (id, layer_id, code, evidence, kind, screen_code) VALUES (200050, 200001, 50, 'INFERRED', 'PRINTABLE', 50);
INSERT INTO character_code (id, layer_id, code, evidence, kind, screen_code) VALUES (200051, 200001, 51, 'INFERRED', 'PRINTABLE', 51);
INSERT INTO character_code (id, layer_id, code, evidence, kind, screen_code) VALUES (200052, 200001, 52, 'INFERRED', 'PRINTABLE', 52);
INSERT INTO character_code (id, layer_id, code, evidence, kind, screen_code) VALUES (200053, 200001, 53, 'INFERRED', 'PRINTABLE', 53);
INSERT INTO character_code (id, layer_id, code, evidence, kind, screen_code) VALUES (200054, 200001, 54, 'INFERRED', 'PRINTABLE', 54);
INSERT INTO character_code (id, layer_id, code, evidence, kind, screen_code) VALUES (200055, 200001, 55, 'INFERRED', 'PRINTABLE', 55);
INSERT INTO character_code (id, layer_id, code, evidence, kind, screen_code) VALUES (200056, 200001, 56, 'INFERRED', 'PRINTABLE', 56);
INSERT INTO character_code (id, layer_id, code, evidence, kind, screen_code) VALUES (200057, 200001, 57, 'INFERRED', 'PRINTABLE', 57);
INSERT INTO character_code (id, layer_id, code, evidence, kind, screen_code) VALUES (200058, 200001, 58, 'INFERRED', 'PRINTABLE', 58);
INSERT INTO character_code (id, layer_id, code, evidence, kind, screen_code) VALUES (200059, 200001, 59, 'INFERRED', 'PRINTABLE', 59);
INSERT INTO character_code (id, layer_id, code, evidence, kind, screen_code) VALUES (200060, 200001, 60, 'INFERRED', 'PRINTABLE', 60);
INSERT INTO character_code (id, layer_id, code, evidence, kind, screen_code) VALUES (200061, 200001, 61, 'INFERRED', 'PRINTABLE', 61);
INSERT INTO character_code (id, layer_id, code, evidence, kind, screen_code) VALUES (200062, 200001, 62, 'INFERRED', 'PRINTABLE', 62);
INSERT INTO character_code (id, layer_id, code, evidence, kind, screen_code) VALUES (200063, 200001, 63, 'INFERRED', 'PRINTABLE', 63);
INSERT INTO character_code (id, layer_id, code, evidence, kind, screen_code) VALUES (200064, 200001, 64, 'INFERRED', 'PRINTABLE', 64);
INSERT INTO character_code (id, layer_id, code, evidence, kind, screen_code) VALUES (200065, 200001, 65, 'INFERRED', 'PRINTABLE', 65);
INSERT INTO character_code (id, layer_id, code, evidence, kind, screen_code) VALUES (200066, 200001, 66, 'INFERRED', 'PRINTABLE', 66);
INSERT INTO character_code (id, layer_id, code, evidence, kind, screen_code) VALUES (200067, 200001, 67, 'INFERRED', 'PRINTABLE', 67);
INSERT INTO character_code (id, layer_id, code, evidence, kind, screen_code) VALUES (200068, 200001, 68, 'INFERRED', 'PRINTABLE', 68);
INSERT INTO character_code (id, layer_id, code, evidence, kind, screen_code) VALUES (200069, 200001, 69, 'INFERRED', 'PRINTABLE', 69);
INSERT INTO character_code (id, layer_id, code, evidence, kind, screen_code) VALUES (200070, 200001, 70, 'INFERRED', 'PRINTABLE', 70);
INSERT INTO character_code (id, layer_id, code, evidence, kind, screen_code) VALUES (200071, 200001, 71, 'INFERRED', 'PRINTABLE', 71);
INSERT INTO character_code (id, layer_id, code, evidence, kind, screen_code) VALUES (200072, 200001, 72, 'INFERRED', 'PRINTABLE', 72);
INSERT INTO character_code (id, layer_id, code, evidence, kind, screen_code) VALUES (200073, 200001, 73, 'INFERRED', 'PRINTABLE', 73);
INSERT INTO character_code (id, layer_id, code, evidence, kind, screen_code) VALUES (200074, 200001, 74, 'INFERRED', 'PRINTABLE', 74);
INSERT INTO character_code (id, layer_id, code, evidence, kind, screen_code) VALUES (200075, 200001, 75, 'INFERRED', 'PRINTABLE', 75);
INSERT INTO character_code (id, layer_id, code, evidence, kind, screen_code) VALUES (200076, 200001, 76, 'INFERRED', 'PRINTABLE', 76);
INSERT INTO character_code (id, layer_id, code, evidence, kind, screen_code) VALUES (200077, 200001, 77, 'INFERRED', 'PRINTABLE', 77);
INSERT INTO character_code (id, layer_id, code, evidence, kind, screen_code) VALUES (200078, 200001, 78, 'INFERRED', 'PRINTABLE', 78);
INSERT INTO character_code (id, layer_id, code, evidence, kind, screen_code) VALUES (200079, 200001, 79, 'INFERRED', 'PRINTABLE', 79);
INSERT INTO character_code (id, layer_id, code, evidence, kind, screen_code) VALUES (200080, 200001, 80, 'INFERRED', 'PRINTABLE', 80);
INSERT INTO character_code (id, layer_id, code, evidence, kind, screen_code) VALUES (200081, 200001, 81, 'INFERRED', 'PRINTABLE', 81);
INSERT INTO character_code (id, layer_id, code, evidence, kind, screen_code) VALUES (200082, 200001, 82, 'INFERRED', 'PRINTABLE', 82);
INSERT INTO character_code (id, layer_id, code, evidence, kind, screen_code) VALUES (200083, 200001, 83, 'INFERRED', 'PRINTABLE', 83);
INSERT INTO character_code (id, layer_id, code, evidence, kind, screen_code) VALUES (200084, 200001, 84, 'INFERRED', 'PRINTABLE', 84);
INSERT INTO character_code (id, layer_id, code, evidence, kind, screen_code) VALUES (200085, 200001, 85, 'INFERRED', 'PRINTABLE', 85);
INSERT INTO character_code (id, layer_id, code, evidence, kind, screen_code) VALUES (200086, 200001, 86, 'INFERRED', 'PRINTABLE', 86);
INSERT INTO character_code (id, layer_id, code, evidence, kind, screen_code) VALUES (200087, 200001, 87, 'INFERRED', 'PRINTABLE', 87);
INSERT INTO character_code (id, layer_id, code, evidence, kind, screen_code) VALUES (200088, 200001, 88, 'INFERRED', 'PRINTABLE', 88);
INSERT INTO character_code (id, layer_id, code, evidence, kind, screen_code) VALUES (200089, 200001, 89, 'INFERRED', 'PRINTABLE', 89);
INSERT INTO character_code (id, layer_id, code, evidence, kind, screen_code) VALUES (200090, 200001, 90, 'INFERRED', 'PRINTABLE', 90);
INSERT INTO character_code (id, layer_id, code, evidence, kind, screen_code) VALUES (200091, 200001, 91, 'INFERRED', 'PRINTABLE', 91);
INSERT INTO character_code (id, layer_id, code, evidence, kind, screen_code) VALUES (200092, 200001, 92, 'INFERRED', 'PRINTABLE', 92);
INSERT INTO character_code (id, layer_id, code, evidence, kind, screen_code) VALUES (200093, 200001, 93, 'INFERRED', 'PRINTABLE', 93);
INSERT INTO character_code (id, layer_id, code, evidence, kind, screen_code, notes) VALUES (200094, 200001, 94, 'INFERRED', 'PRINTABLE', 94, 'The power operator (circumflex in later ASCII).');
INSERT INTO character_code (id, layer_id, code, evidence, kind, screen_code, notes) VALUES (200095, 200001, 95, 'INFERRED', 'PRINTABLE', 95, 'Back arrow: "useful on output" [4] p. 68 (underscore in later ASCII).');
INSERT INTO character_code (id, layer_id, code, evidence, kind, notes) VALUES (200096, 200001, 96, 'INFERRED', 'UNUSED', 'Lower case: not on the ASR-33 (64 characters); on some Teletypes these codes duplicate the upper-case ones [4] p. 68.');
INSERT INTO character_code (id, layer_id, code, evidence, kind, notes) VALUES (200097, 200001, 97, 'INFERRED', 'UNUSED', 'Lower case: not on the ASR-33 (64 characters); on some Teletypes these codes duplicate the upper-case ones [4] p. 68.');
INSERT INTO character_code (id, layer_id, code, evidence, kind, notes) VALUES (200098, 200001, 98, 'INFERRED', 'UNUSED', 'Lower case: not on the ASR-33 (64 characters); on some Teletypes these codes duplicate the upper-case ones [4] p. 68.');
INSERT INTO character_code (id, layer_id, code, evidence, kind, notes) VALUES (200099, 200001, 99, 'INFERRED', 'UNUSED', 'Lower case: not on the ASR-33 (64 characters); on some Teletypes these codes duplicate the upper-case ones [4] p. 68.');
INSERT INTO character_code (id, layer_id, code, evidence, kind, notes) VALUES (200100, 200001, 100, 'INFERRED', 'UNUSED', 'Lower case: not on the ASR-33 (64 characters); on some Teletypes these codes duplicate the upper-case ones [4] p. 68.');
INSERT INTO character_code (id, layer_id, code, evidence, kind, notes) VALUES (200101, 200001, 101, 'INFERRED', 'UNUSED', 'Lower case: not on the ASR-33 (64 characters); on some Teletypes these codes duplicate the upper-case ones [4] p. 68.');
INSERT INTO character_code (id, layer_id, code, evidence, kind, notes) VALUES (200102, 200001, 102, 'INFERRED', 'UNUSED', 'Lower case: not on the ASR-33 (64 characters); on some Teletypes these codes duplicate the upper-case ones [4] p. 68.');
INSERT INTO character_code (id, layer_id, code, evidence, kind, notes) VALUES (200103, 200001, 103, 'INFERRED', 'UNUSED', 'Lower case: not on the ASR-33 (64 characters); on some Teletypes these codes duplicate the upper-case ones [4] p. 68.');
INSERT INTO character_code (id, layer_id, code, evidence, kind, notes) VALUES (200104, 200001, 104, 'INFERRED', 'UNUSED', 'Lower case: not on the ASR-33 (64 characters); on some Teletypes these codes duplicate the upper-case ones [4] p. 68.');
INSERT INTO character_code (id, layer_id, code, evidence, kind, notes) VALUES (200105, 200001, 105, 'INFERRED', 'UNUSED', 'Lower case: not on the ASR-33 (64 characters); on some Teletypes these codes duplicate the upper-case ones [4] p. 68.');
INSERT INTO character_code (id, layer_id, code, evidence, kind, notes) VALUES (200106, 200001, 106, 'INFERRED', 'UNUSED', 'Lower case: not on the ASR-33 (64 characters); on some Teletypes these codes duplicate the upper-case ones [4] p. 68.');
INSERT INTO character_code (id, layer_id, code, evidence, kind, notes) VALUES (200107, 200001, 107, 'INFERRED', 'UNUSED', 'Lower case: not on the ASR-33 (64 characters); on some Teletypes these codes duplicate the upper-case ones [4] p. 68.');
INSERT INTO character_code (id, layer_id, code, evidence, kind, notes) VALUES (200108, 200001, 108, 'INFERRED', 'UNUSED', 'Lower case: not on the ASR-33 (64 characters); on some Teletypes these codes duplicate the upper-case ones [4] p. 68.');
INSERT INTO character_code (id, layer_id, code, evidence, kind, notes) VALUES (200109, 200001, 109, 'INFERRED', 'UNUSED', 'Lower case: not on the ASR-33 (64 characters); on some Teletypes these codes duplicate the upper-case ones [4] p. 68.');
INSERT INTO character_code (id, layer_id, code, evidence, kind, notes) VALUES (200110, 200001, 110, 'INFERRED', 'UNUSED', 'Lower case: not on the ASR-33 (64 characters); on some Teletypes these codes duplicate the upper-case ones [4] p. 68.');
INSERT INTO character_code (id, layer_id, code, evidence, kind, notes) VALUES (200111, 200001, 111, 'INFERRED', 'UNUSED', 'Lower case: not on the ASR-33 (64 characters); on some Teletypes these codes duplicate the upper-case ones [4] p. 68.');
INSERT INTO character_code (id, layer_id, code, evidence, kind, notes) VALUES (200112, 200001, 112, 'INFERRED', 'UNUSED', 'Lower case: not on the ASR-33 (64 characters); on some Teletypes these codes duplicate the upper-case ones [4] p. 68.');
INSERT INTO character_code (id, layer_id, code, evidence, kind, notes) VALUES (200113, 200001, 113, 'INFERRED', 'UNUSED', 'Lower case: not on the ASR-33 (64 characters); on some Teletypes these codes duplicate the upper-case ones [4] p. 68.');
INSERT INTO character_code (id, layer_id, code, evidence, kind, notes) VALUES (200114, 200001, 114, 'INFERRED', 'UNUSED', 'Lower case: not on the ASR-33 (64 characters); on some Teletypes these codes duplicate the upper-case ones [4] p. 68.');
INSERT INTO character_code (id, layer_id, code, evidence, kind, notes) VALUES (200115, 200001, 115, 'INFERRED', 'UNUSED', 'Lower case: not on the ASR-33 (64 characters); on some Teletypes these codes duplicate the upper-case ones [4] p. 68.');
INSERT INTO character_code (id, layer_id, code, evidence, kind, notes) VALUES (200116, 200001, 116, 'INFERRED', 'UNUSED', 'Lower case: not on the ASR-33 (64 characters); on some Teletypes these codes duplicate the upper-case ones [4] p. 68.');
INSERT INTO character_code (id, layer_id, code, evidence, kind, notes) VALUES (200117, 200001, 117, 'INFERRED', 'UNUSED', 'Lower case: not on the ASR-33 (64 characters); on some Teletypes these codes duplicate the upper-case ones [4] p. 68.');
INSERT INTO character_code (id, layer_id, code, evidence, kind, notes) VALUES (200118, 200001, 118, 'INFERRED', 'UNUSED', 'Lower case: not on the ASR-33 (64 characters); on some Teletypes these codes duplicate the upper-case ones [4] p. 68.');
INSERT INTO character_code (id, layer_id, code, evidence, kind, notes) VALUES (200119, 200001, 119, 'INFERRED', 'UNUSED', 'Lower case: not on the ASR-33 (64 characters); on some Teletypes these codes duplicate the upper-case ones [4] p. 68.');
INSERT INTO character_code (id, layer_id, code, evidence, kind, notes) VALUES (200120, 200001, 120, 'INFERRED', 'UNUSED', 'Lower case: not on the ASR-33 (64 characters); on some Teletypes these codes duplicate the upper-case ones [4] p. 68.');
INSERT INTO character_code (id, layer_id, code, evidence, kind, notes) VALUES (200121, 200001, 121, 'INFERRED', 'UNUSED', 'Lower case: not on the ASR-33 (64 characters); on some Teletypes these codes duplicate the upper-case ones [4] p. 68.');
INSERT INTO character_code (id, layer_id, code, evidence, kind, notes) VALUES (200122, 200001, 122, 'INFERRED', 'UNUSED', 'Lower case: not on the ASR-33 (64 characters); on some Teletypes these codes duplicate the upper-case ones [4] p. 68.');
INSERT INTO character_code (id, layer_id, code, evidence, kind, notes) VALUES (200123, 200001, 123, 'INFERRED', 'UNUSED', 'Lower case: not on the ASR-33 (64 characters); on some Teletypes these codes duplicate the upper-case ones [4] p. 68.');
INSERT INTO character_code (id, layer_id, code, evidence, kind, notes) VALUES (200124, 200001, 124, 'INFERRED', 'UNUSED', 'Lower case: not on the ASR-33 (64 characters); on some Teletypes these codes duplicate the upper-case ones [4] p. 68.');
INSERT INTO character_code (id, layer_id, code, evidence, kind, notes) VALUES (200125, 200001, 125, 'INFERRED', 'UNUSED', 'Lower case: not on the ASR-33 (64 characters); on some Teletypes these codes duplicate the upper-case ones [4] p. 68.');
INSERT INTO character_code (id, layer_id, code, evidence, kind, notes) VALUES (200126, 200001, 126, 'INFERRED', 'UNUSED', 'Lower case: not on the ASR-33 (64 characters); on some Teletypes these codes duplicate the upper-case ones [4] p. 68.');
INSERT INTO character_code (id, layer_id, code, evidence, kind, name, action) VALUES (200127, 200001, 127, 'INFERRED', 'CONTROL', 'RUB-OUT', 'Tape use only');
INSERT INTO table_status (table_kind_id, layer_id, status, notes) SELECT id, 200001, 'COMPLETE', 'The codes of the Teletype ASR-33 (ASCII-1963, 64 printable characters, upper case only), INFERRED: no statement shows them before CHANGE in the 4th edition, whose table [4] p. 68 gives the same codes. The internal code of the GE-235 is not entered. DTSS-Win keeps statements typed in lower case in the listing but rejects them at RUN (`ILLEGAL INSTRUCTION IN 10`); it prints ( and [ of a label alike, as [.' FROM table_kind WHERE code = 'CHARACTER_CODES';
INSERT INTO table_status (table_kind_id, layer_id, status, notes) SELECT id, 200001, 'NOT_APPLICABLE', 'No statement reads the keyboard.' FROM table_kind WHERE code = 'KEYBOARD_CODES';
INSERT INTO table_status (table_kind_id, layer_id, status, notes) SELECT id, 200001, 'PARTIAL', 'Printed with the line number: `ILLEGAL FORMULA IN 30` [1] p. 19 (some messages without it, e.g. `NO DATA`). The May manual shows five messages; the others are from [2].' FROM table_kind WHERE code = 'ERRORS';
INSERT INTO table_status (table_kind_id, layer_id, status, notes) SELECT id, 200001, 'COMPLETE', 'Parentheses, then the change of sign (before the power, source [6]), the power, * and /, + and -, left to right at the same level [2] p. 10.' FROM table_kind WHERE code = 'OPERATOR_PRECEDENCE';
INSERT INTO table_status (table_kind_id, layer_id, status, notes) SELECT id, 200001, 'TO_DO', 'Compiled program: to be taken from the listings [7].' FROM table_kind WHERE code = 'VARIABLE_LAYOUT';
INSERT INTO table_status (table_kind_id, layer_id, status, notes) SELECT id, 200001, 'TO_DO', 'The program is kept as text; its format on the disk is to be taken from the listings [7].' FROM table_kind WHERE code = 'PROGRAM_LAYOUT';
INSERT INTO table_status (table_kind_id, layer_id, status, notes) SELECT id, 200001, 'NOT_APPLICABLE', 'No sound.' FROM table_kind WHERE code = 'MUSICAL_NOTES';
INSERT INTO data_type (id, layer_id, code, name, suffix, type_class_id, minimum, maximum, max_length, precision, operation, redefines_id, notes) VALUES (200001, 200001, 'REAL', 'Number', NULL, 3, -5.7896e+76, 5.7896e+76, NULL, '9 digits', 'ADD', NULL, 'Floating point on the GE-225/235: about 30 bits of mantissa (the manual says up to 9 digits, "the limit of accuracy of the computer"), binary exponent from -256 to 255 (source [6]), so magnitudes from about 4.31809E-78 to 5.78960E76 (the limits printed in the GE manual [3], p. 37). A constant has up to 9 digits, a decimal point and a minus sign, and can be followed by E and a power of ten: `5E1`, `2.39E-12` [1] p. 5.');
INSERT INTO variable_kind (id, layer_id, code, name, data_type_id, dimensions, name_rule, name_pattern, max_name_length, significant_chars, examples, notes, operation, redefines_id) VALUES (200001, 200001, 'NUMERIC', 'Variable', 200001, 0, 'one letter, or one letter followed by one digit', '^[A-Z][0-9]?$', 2, 0, 'A, X, N5, X0, K9', '286 names. Only capital letters exist on the Teletype [1] p. 5. The manual does not say what an unassigned variable holds; Kurtz [9] says that variables were first set to zero in the 4th edition.', 'ADD', NULL);
INSERT INTO variable_kind (id, layer_id, code, name, data_type_id, dimensions, name_rule, name_pattern, max_name_length, significant_chars, examples, notes, operation, redefines_id) VALUES (200002, 200001, 'LIST', 'List', 200001, 1, 'one letter followed by a subscript in parentheses', '^[A-Z]$', 1, 0, 'A(5), B(I+1)', 'A one-dimensional array (vector). Part II of the manual [1] is missing: from the 2nd edition manual [2] and from source [5], whose description of the 1st edition is that a list needs no DIM up to 10 elements, numbered **from 1 to 10** (subscript 0 came with the 2nd edition). Kurtz [9] confirms it: without DIM, subscripts 1-10 in each dimension. A letter can be a simple variable and a list at the same time, not a list and a table.', 'ADD', NULL);
INSERT INTO variable_kind (id, layer_id, code, name, data_type_id, dimensions, name_rule, name_pattern, max_name_length, significant_chars, examples, notes, operation, redefines_id) VALUES (200003, 200001, 'TABLE', 'Table', 200001, 2, 'one letter followed by two subscripts in parentheses', '^[A-Z]$', 1, 0, 'B(1,1), M(I,J)', 'A two-dimensional array (matrix). Inferred from the 2nd edition manual [2] (Part II of [1] is missing): subscripts from 1 to 10 without DIM, as for the lists.', 'ADD', NULL);
INSERT INTO parameter_kind (id, layer_id, code, name, nature, type_class_id, variable_kind_id, notes, operation, redefines_id) VALUES (200001, 200001, 'NUM_LITERAL', 'Number', 'LITERAL', 1, NULL, 'Up to 9 digits, decimal point, sign, E and exponent.', 'ADD', NULL);
INSERT INTO parameter_kind (id, layer_id, code, name, nature, type_class_id, variable_kind_id, notes, operation, redefines_id) VALUES (200002, 200001, 'LINE_NUMBER', 'Line number', 'LITERAL', 2, NULL, '1 to 99999, written as digits.', 'ADD', NULL);
INSERT INTO parameter_kind (id, layer_id, code, name, nature, type_class_id, variable_kind_id, notes, operation, redefines_id) VALUES (200003, 200001, 'LABEL', 'Label', 'LITERAL', 4, NULL, 'Text in quotes, printed as it is.', 'ADD', NULL);
INSERT INTO parameter_kind (id, layer_id, code, name, nature, type_class_id, variable_kind_id, notes, operation, redefines_id) VALUES (200004, 200001, 'FN_LETTER', 'Function letter', 'LITERAL', 4, NULL, 'One letter A-Z, written right after FN: FNA to FNZ.', 'ADD', NULL);
INSERT INTO parameter_kind (id, layer_id, code, name, nature, type_class_id, variable_kind_id, notes, operation, redefines_id) VALUES (200005, 200001, 'NUM_EXPR', 'Formula', 'EXPRESSION', 1, NULL, 'Numbers, variables, list and table elements, functions and the operators + - * / ↑, with parentheses.', 'ADD', NULL);
INSERT INTO parameter_kind (id, layer_id, code, name, nature, type_class_id, variable_kind_id, notes, operation, redefines_id) VALUES (200006, 200001, 'NUM_VAR', 'Variable', 'VARIABLE', NULL, 200001, NULL, 'ADD', NULL);
INSERT INTO parameter_kind (id, layer_id, code, name, nature, type_class_id, variable_kind_id, notes, operation, redefines_id) VALUES (200007, 200001, 'LIST_ELEMENT', 'List element', 'ARRAY_ELEMENT', NULL, 200002, 'E.g. A(I).', 'ADD', NULL);
INSERT INTO parameter_kind (id, layer_id, code, name, nature, type_class_id, variable_kind_id, notes, operation, redefines_id) VALUES (200008, 200001, 'TABLE_ELEMENT', 'Table element', 'ARRAY_ELEMENT', NULL, 200003, 'E.g. B(I,J).', 'ADD', NULL);
INSERT INTO parameter_kind (id, layer_id, code, name, nature, type_class_id, variable_kind_id, notes, operation, redefines_id) VALUES (200009, 200001, 'ANY_VAR', 'Variable or element', 'VARIABLE', NULL, NULL, 'A variable or an element of a list or table.', 'ADD', NULL);
INSERT INTO parameter_kind (id, layer_id, code, name, nature, type_class_id, variable_kind_id, notes, operation, redefines_id) VALUES (200010, 200001, 'ARRAY_NAME', 'List or table name', 'ARRAY_NAME', NULL, NULL, 'One letter.', 'ADD', NULL);
INSERT INTO parameter_kind (id, layer_id, code, name, nature, type_class_id, variable_kind_id, notes, operation, redefines_id) VALUES (200011, 200001, 'CONDITION', 'Relation', 'CONDITION', 1, NULL, 'Two formulas joined by one relation: = < <= > >= <>. Only after IF; it produces no value.', 'ADD', NULL);
INSERT INTO parameter_kind (id, layer_id, code, name, nature, type_class_id, variable_kind_id, notes, operation, redefines_id) VALUES (200012, 200001, 'FREE_TEXT', 'Remark', 'FREE_TEXT', NULL, NULL, 'Any text up to the end of the line.', 'ADD', NULL);
INSERT INTO feature (layer_id, feature_kind_id, value, verified, notes, operation, redefines_id) SELECT 200001, id, '1-99999', 0, 'Called instruction numbers; statements are run in the order of their numbers, whatever the order they were typed in [1] p. 4. A line with the number of an existing one replaces it; a number alone deletes the line [1] p. 19.', 'ADD', NULL FROM feature_kind WHERE code = 'LINE_NUMBERS';
INSERT INTO feature (layer_id, feature_kind_id, value, verified, notes, operation, redefines_id) SELECT 200001, id, 'No', 0, 'One statement per line.', 'ADD', NULL FROM feature_kind WHERE code = 'MULTIPLE_STATEMENTS';
INSERT INTO feature (layer_id, feature_kind_id, value, verified, notes, operation, redefines_id) SELECT 200001, id, 'None', 0, NULL, 'ADD', NULL FROM feature_kind WHERE code = 'STATEMENT_SEPARATOR';
INSERT INTO feature (layer_id, feature_kind_id, value, verified, notes, operation, redefines_id) SELECT 200001, id, 'Mandatory', 0, 'Every assignment starts with LET: `10 A=5*5` is not a statement (source [5]).', 'ADD', NULL FROM feature_kind WHERE code = 'LET';
INSERT INTO feature (layer_id, feature_kind_id, value, verified, notes, operation, redefines_id) SELECT 200001, id, 'None', 0, 'Relations can only be written in IF...THEN: they produce no value.', 'ADD', NULL FROM feature_kind WHERE code = 'TRUE_VALUE';
INSERT INTO feature (layer_id, feature_kind_id, value, verified, notes, operation, redefines_id) SELECT 200001, id, 'None', 0, 'Relations can only be written in IF...THEN: they produce no value.', 'ADD', NULL FROM feature_kind WHERE code = 'FALSE_VALUE';
INSERT INTO feature (layer_id, feature_kind_id, value, verified, notes, operation, redefines_id) SELECT 200001, id, 'Relation only', 0, 'IF needs a relation between two formulas; a formula alone is not a condition.', 'ADD', NULL FROM feature_kind WHERE code = 'TRUTH_TEST';
INSERT INTO feature (layer_id, feature_kind_id, value, verified, notes, operation, redefines_id) SELECT 200001, id, 'Not stated', 0, 'The manuals do not say what happens to a subscript that is not an integer. INT truncates towards zero (see INT).', 'ADD', NULL FROM feature_kind WHERE code = 'INTEGER_CONVERSION';
INSERT INTO feature (layer_id, feature_kind_id, value, verified, notes, operation, redefines_id) SELECT 200001, id, 'No', 0, 'Inferred from the 2nd edition manual [2] pp. 13-14: a loop whose start is already past the final value is not executed at all; the May manual does not say.', 'ADD', NULL FROM feature_kind WHERE code = 'FOR_RUNS_ONCE';
INSERT INTO feature (layer_id, feature_kind_id, value, verified, notes, operation, redefines_id) SELECT 200001, id, 'Not stated', 0, NULL, 'ADD', NULL FROM feature_kind WHERE code = 'FOR_VARIABLE_CHANGEABLE';
INSERT INTO feature (layer_id, feature_kind_id, value, verified, notes, operation, redefines_id) SELECT 200001, id, 'No', 0, 'Teletype keyboard: everything is typed letter by letter.', 'ADD', NULL FROM feature_kind WHERE code = 'MODAL_KEYBOARD';
INSERT INTO feature (layer_id, feature_kind_id, value, verified, notes, operation, redefines_id) SELECT 200001, id, '15 columns', 0, 'Five zones of 15 characters on a 75-character line: from the 2nd edition manual [2] p. 31; the May manual only shows that commas separate the printed values.', 'ADD', NULL FROM feature_kind WHERE code = 'TAB_ZONE_WIDTH';
INSERT INTO feature (layer_id, feature_kind_id, value, verified, notes, operation, redefines_id) SELECT 200001, id, 'No', 0, NULL, 'ADD', NULL FROM feature_kind WHERE code = 'VARIABLE_TAB_STOPS';
INSERT INTO error (id, layer_id, code, message, operation, redefines_id, description) VALUES (200001, 200001, 'ILLEGAL_FORMULA', 'ILLEGAL FORMULA', 'ADD', NULL, 'The commonest error: missing parentheses, illegal variable names, missing multiplication signs, illegal numbers. Shown in [1] p. 19.');
INSERT INTO error (id, layer_id, code, message, operation, redefines_id, description) VALUES (200002, 200001, 'INCORRECT_FORMAT', 'INCORRECT FORMAT', 'ADD', NULL, 'The form of the statement is wrong, especially IF...THEN and FOR. Shown in [1] p. 19.');
INSERT INTO error (id, layer_id, code, message, operation, redefines_id, description) VALUES (200003, 200001, 'END_NOT_LAST', 'END IS NOT LAST', 'ADD', NULL, 'A statement has a number greater than END (also two END statements). Shown in [1] p. 19.');
INSERT INTO error (id, layer_id, code, message, operation, redefines_id, description) VALUES (200004, 200001, 'UNDEFINED_NUMBER', 'UNDEFINED NUMBER', 'ADD', NULL, 'GO TO or IF...THEN names a line number that does not exist. Shown in [1] p. 19.');
INSERT INTO error (id, layer_id, code, message, operation, redefines_id, description) VALUES (200005, 200001, 'NO_DATA', 'NO DATA', 'ADD', NULL, 'The program has READ but no DATA statement. Shown in [1] p. 19.');
INSERT INTO error (id, layer_id, code, message, operation, redefines_id, description) VALUES (200006, 200001, 'DIMENSION_TOO_LARGE', 'DIMENSION TOO LARGE', 'ADD', NULL, 'From [2].');
INSERT INTO error (id, layer_id, code, message, operation, redefines_id, description) VALUES (200007, 200001, 'ILLEGAL_CONSTANT', 'ILLEGAL CONSTANT', 'ADD', NULL, 'More than nine digits, or a number of the wrong form. From [2].');
INSERT INTO error (id, layer_id, code, message, operation, redefines_id, description) VALUES (200008, 200001, 'ILLEGAL_RELATION', 'ILLEGAL RELATION', 'ADD', NULL, 'The relation of an IF...THEN is wrong. From [2].');
INSERT INTO error (id, layer_id, code, message, operation, redefines_id, description) VALUES (200009, 200001, 'ILLEGAL_LINE_NUMBER', 'ILLEGAL LINE NUMBER', 'ADD', NULL, 'A line number of the wrong form or of more than five digits. From [2].');
INSERT INTO error (id, layer_id, code, message, operation, redefines_id, description) VALUES (200010, 200001, 'ILLEGAL_INSTRUCTION', 'ILLEGAL INSTRUCTION', 'ADD', NULL, 'The word after the line number is not a statement. From [2].');
INSERT INTO error (id, layer_id, code, message, operation, redefines_id, description) VALUES (200011, 200001, 'ILLEGAL_VARIABLE', 'ILLEGAL VARIABLE', 'ADD', NULL, 'From [2].');
INSERT INTO error (id, layer_id, code, message, operation, redefines_id, description) VALUES (200012, 200001, 'NO_END', 'NO END INSTRUCTION', 'ADD', NULL, 'From [2].');
INSERT INTO error (id, layer_id, code, message, operation, redefines_id, description) VALUES (200013, 200001, 'UNDEFINED_FUNCTION', 'UNDEFINED FUNCTION', 'ADD', NULL, 'A function FN is used but never defined with DEF. From [2].');
INSERT INTO error (id, layer_id, code, message, operation, redefines_id, description) VALUES (200014, 200001, 'PROGRAM_TOO_LONG', 'PROGRAM TOO LONG', 'ADD', NULL, 'From [2].');
INSERT INTO error (id, layer_id, code, message, operation, redefines_id, description) VALUES (200015, 200001, 'TOO_MUCH_DATA', 'TOO MUCH DATA', 'ADD', NULL, 'From [2].');
INSERT INTO error (id, layer_id, code, message, operation, redefines_id, description) VALUES (200016, 200001, 'TOO_MANY_LABELS', 'TOO MANY LABELS', 'ADD', NULL, 'The labels to print are too long altogether. From [2].');
INSERT INTO error (id, layer_id, code, message, operation, redefines_id, description) VALUES (200017, 200001, 'TOO_MANY_LOOPS', 'TOO MANY LOOPS', 'ADD', NULL, 'More than 26 FOR loops. From [2].');
INSERT INTO error (id, layer_id, code, message, operation, redefines_id, description) VALUES (200018, 200001, 'NOT_MATCH_WITH_FOR', 'NOT MATCH WITH FOR', 'ADD', NULL, 'NEXT with the wrong variable, or loops not nested properly. From [2].');
INSERT INTO error (id, layer_id, code, message, operation, redefines_id, description) VALUES (200019, 200001, 'FOR_WITHOUT_NEXT', 'FOR WITHOUT NEXT', 'ADD', NULL, 'From [2].');
INSERT INTO error (id, layer_id, code, message, operation, redefines_id, description) VALUES (200020, 200001, 'CUT_PROGRAM_OR_DIMS', 'CUT PROGRAM OR DIMS', 'ADD', NULL, 'The program and the arrays do not fit together. From [2] (the same message in [3] and [4]).');
INSERT INTO error (id, layer_id, code, message, operation, redefines_id, description) VALUES (200021, 200001, 'SUBSCRIPT_ERROR', 'SUBSCRIPT ERROR', 'ADD', NULL, 'A subscript outside the range given by DIM, or outside the default range without DIM. From [2].');
INSERT INTO error (id, layer_id, code, message, operation, redefines_id, description) VALUES (200022, 200001, 'ILLEGAL_RETURN', 'ILLEGAL RETURN', 'ADD', NULL, 'RETURN before any GOSUB. From [2].');
INSERT INTO error_rule (layer_id, selector, selector_value, error_code, cause, verified) VALUES (200001, 'PARAMETER_KIND', 'NUM_EXPR', 'ILLEGAL_FORMULA', 'The formula is not written correctly.', 0);
INSERT INTO error_rule (layer_id, selector, selector_value, error_code, cause, verified) VALUES (200001, 'PARAMETER_KIND', 'NUM_EXPR', 'UNDEFINED_FUNCTION', 'The formula uses an FN function that is never defined.', 0);
INSERT INTO error_rule (layer_id, selector, selector_value, error_code, cause, verified) VALUES (200001, 'PARAMETER_KIND', 'CONDITION', 'ILLEGAL_RELATION', 'The relation is not one of = < <= > >= <>.', 0);
INSERT INTO error_rule (layer_id, selector, selector_value, error_code, cause, verified) VALUES (200001, 'PARAMETER_KIND', 'LIST_ELEMENT', 'SUBSCRIPT_ERROR', 'The subscript is outside the range of the list.', 0);
INSERT INTO error_rule (layer_id, selector, selector_value, error_code, cause, verified) VALUES (200001, 'PARAMETER_KIND', 'TABLE_ELEMENT', 'SUBSCRIPT_ERROR', 'A subscript is outside the range of the table.', 0);
INSERT INTO error_rule (layer_id, selector, selector_value, error_code, cause, verified) VALUES (200001, 'PARAMETER_KIND', 'NUM_LITERAL', 'ILLEGAL_CONSTANT', 'More than nine digits, or a number of the wrong form.', 0);
INSERT INTO keyword (id, layer_id, text, notes) VALUES (200001, 200001, 'HELLO', NULL);
INSERT INTO keyword (id, layer_id, text, notes) VALUES (200002, 200001, 'RUN', NULL);
INSERT INTO keyword (id, layer_id, text, notes) VALUES (200003, 200001, 'LIST', NULL);
INSERT INTO keyword (id, layer_id, text, notes) VALUES (200004, 200001, 'SAVE', NULL);
INSERT INTO keyword (id, layer_id, text, notes) VALUES (200005, 200001, 'STOP', NULL);
INSERT INTO keyword (id, layer_id, text, notes) VALUES (200006, 200001, 'LET', NULL);
INSERT INTO keyword (id, layer_id, text, notes) VALUES (200007, 200001, 'PRINT', NULL);
INSERT INTO keyword (id, layer_id, text, notes) VALUES (200008, 200001, 'END', NULL);
INSERT INTO keyword (id, layer_id, text, notes) VALUES (200009, 200001, 'FOR', NULL);
INSERT INTO keyword (id, layer_id, text, notes) VALUES (200010, 200001, 'TO', NULL);
INSERT INTO keyword (id, layer_id, text, notes) VALUES (200011, 200001, 'STEP', NULL);
INSERT INTO keyword (id, layer_id, text, notes) VALUES (200012, 200001, 'NEXT', NULL);
INSERT INTO keyword (id, layer_id, text, notes) VALUES (200013, 200001, 'GO TO', 'Spaces do not count: also written GOTO, as in the examples of [1].');
INSERT INTO keyword (id, layer_id, text, notes) VALUES (200014, 200001, 'IF', NULL);
INSERT INTO keyword (id, layer_id, text, notes) VALUES (200015, 200001, 'THEN', NULL);
INSERT INTO keyword (id, layer_id, text, notes) VALUES (200016, 200001, 'DEF', NULL);
INSERT INTO keyword (id, layer_id, text, notes) VALUES (200017, 200001, 'FN', 'Followed by one letter: FNA to FNZ.');
INSERT INTO keyword (id, layer_id, text, notes) VALUES (200018, 200001, 'READ', NULL);
INSERT INTO keyword (id, layer_id, text, notes) VALUES (200019, 200001, 'DATA', NULL);
INSERT INTO keyword (id, layer_id, text, notes) VALUES (200020, 200001, 'GOSUB', NULL);
INSERT INTO keyword (id, layer_id, text, notes) VALUES (200021, 200001, 'RETURN', NULL);
INSERT INTO keyword (id, layer_id, text, notes) VALUES (200022, 200001, 'DIM', NULL);
INSERT INTO keyword (id, layer_id, text, notes) VALUES (200023, 200001, 'REM', NULL);
INSERT INTO keyword (id, layer_id, text, notes) VALUES (200024, 200001, 'SIN', NULL);
INSERT INTO keyword (id, layer_id, text, notes) VALUES (200025, 200001, 'COS', NULL);
INSERT INTO keyword (id, layer_id, text, notes) VALUES (200026, 200001, 'TAN', NULL);
INSERT INTO keyword (id, layer_id, text, notes) VALUES (200027, 200001, 'ATN', NULL);
INSERT INTO keyword (id, layer_id, text, notes) VALUES (200028, 200001, 'EXP', NULL);
INSERT INTO keyword (id, layer_id, text, notes) VALUES (200029, 200001, 'LOG', NULL);
INSERT INTO keyword (id, layer_id, text, notes) VALUES (200030, 200001, 'SQR', NULL);
INSERT INTO keyword (id, layer_id, text, notes) VALUES (200031, 200001, 'ABS', NULL);
INSERT INTO keyword (id, layer_id, text, notes) VALUES (200032, 200001, 'RND', NULL);
INSERT INTO keyword (id, layer_id, text, notes) VALUES (200033, 200001, 'INT', NULL);
INSERT INTO keyword (id, layer_id, text, notes) VALUES (200034, 200001, '+', NULL);
INSERT INTO keyword (id, layer_id, text, notes) VALUES (200035, 200001, '-', NULL);
INSERT INTO keyword (id, layer_id, text, notes) VALUES (200036, 200001, '*', NULL);
INSERT INTO keyword (id, layer_id, text, notes) VALUES (200037, 200001, '/', NULL);
INSERT INTO keyword (id, layer_id, text, notes) VALUES (200038, 200001, '↑', 'Power: an upward arrow on the Teletype (^ in ASCII).');
INSERT INTO keyword (id, layer_id, text, notes) VALUES (200039, 200001, '=', 'Assignment in LET, relation in IF.');
INSERT INTO keyword (id, layer_id, text, notes) VALUES (200040, 200001, '<', NULL);
INSERT INTO keyword (id, layer_id, text, notes) VALUES (200041, 200001, '<=', NULL);
INSERT INTO keyword (id, layer_id, text, notes) VALUES (200042, 200001, '>', NULL);
INSERT INTO keyword (id, layer_id, text, notes) VALUES (200043, 200001, '>=', NULL);
INSERT INTO keyword (id, layer_id, text, notes) VALUES (200044, 200001, '<>', 'Not equal ("less or greater").');

-- HELLO (COMMAND)
INSERT INTO entry (id, layer_id, name, category_id, operation, redefines_id, description, difference_notes, notes) VALUES (200001, 200001, 'HELLO', 2, 'ADD', NULL, 'Starts a session: the system asks for the user number, the problem name, the system and whether the program is new or old.', NULL, 'The dialogue of [1] p. 17 (the user''s answers after the dashes):

```
USER NO.--446425
PROBLEM NO.--M36-2
SYSTEM--BASIC
TYPE OR OLD--TYPE
READY.
```

The problem name has up to 6 letters, digits or symbols. TYPE starts a new program, OLD brings back a saved one. HELLO is typed only to start a new problem, not to correct a program.');
INSERT INTO entry_source (entry_id, source_id, page) VALUES (200001, 200001, '16-18');
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, return_min_inclusive, return_max_inclusive, precedence, associativity, operator_class_id, evidence) VALUES (200001, 200001, 1, NULL, NULL, 'HELLO', 200001, '16-18', NULL, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000001, 200001, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000002, 200001, 2000001, 1, 'KEYWORD', 0, NULL, 200001);
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 200001, id, 'FULL', NULL FROM action WHERE code = 'SESSION_START';
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id, page) VALUES (200001, NULL, 1, 'Start a session', 'The system goes on with PROBLEM NO., SYSTEM, TYPE OR OLD.', 'HELLO', 'USER NO.--', 0, 200001, '17');

-- RUN (COMMAND)
INSERT INTO entry (id, layer_id, name, category_id, operation, redefines_id, description, difference_notes, notes) VALUES (200002, 200001, 'RUN', 2, 'ADD', NULL, 'Compiles and runs the program.', NULL, 'The answers are preceded by the user number and the problem name, and followed by the time used, rounded to the second: `TIME: 0 SECS.` [1] p. 17. Errors found while compiling are printed instead of the answers.');
INSERT INTO entry_source (entry_id, source_id, page) VALUES (200002, 200001, '17');
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, return_min_inclusive, return_max_inclusive, precedence, associativity, operator_class_id, evidence) VALUES (200002, 200002, 1, NULL, NULL, 'RUN', 200001, '17', NULL, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000003, 200002, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000004, 200002, 2000003, 1, 'KEYWORD', 0, NULL, 200002);
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 200002, id, 'FULL', NULL FROM action WHERE code = 'PROG_RUN';

-- LIST (COMMAND)
INSERT INTO entry (id, layer_id, name, category_id, operation, redefines_id, description, difference_notes, notes) VALUES (200003, 200001, 'LIST', 2, 'ADD', NULL, 'Types the current version of the program.', NULL, NULL);
INSERT INTO entry_source (entry_id, source_id, page) VALUES (200003, 200001, '18');
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, return_min_inclusive, return_max_inclusive, precedence, associativity, operator_class_id, evidence) VALUES (200003, 200003, 1, NULL, NULL, 'LIST', 200001, '18', NULL, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000005, 200003, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000006, 200003, 2000005, 1, 'KEYWORD', 0, NULL, 200003);
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 200003, id, 'FULL', NULL FROM action WHERE code = 'PROG_LIST';

-- SAVE (COMMAND)
INSERT INTO entry (id, layer_id, name, category_id, operation, redefines_id, description, difference_notes, notes) VALUES (200004, 200001, 'SAVE', 2, 'ADD', NULL, 'Keeps the program on the disk, under its problem name.', NULL, 'A saved program stays available for about a month; it is called back with HELLO and the answer OLD [1] p. 18.');
INSERT INTO entry_source (entry_id, source_id, page) VALUES (200004, 200001, '18');
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, return_min_inclusive, return_max_inclusive, precedence, associativity, operator_class_id, evidence) VALUES (200004, 200004, 1, NULL, NULL, 'SAVE', 200001, '18', NULL, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000007, 200004, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000008, 200004, 2000007, 1, 'KEYWORD', 0, NULL, 200004);
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 200004, id, 'FULL', 'On the disk of the time-sharing system' FROM action WHERE code = 'TAPE_SAVE';

-- STOP (COMMAND)
INSERT INTO entry (id, layer_id, name, category_id, operation, redefines_id, description, difference_notes, notes) VALUES (200005, 200001, 'STOP', 2, 'ADD', NULL, 'Stops whatever is going on, even while the Teletype is typing at full speed.', NULL, 'The letters do not show until the typing has stopped, but the command works [1] p. 18.');
INSERT INTO entry_source (entry_id, source_id, page) VALUES (200005, 200001, '18');
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, return_min_inclusive, return_max_inclusive, precedence, associativity, operator_class_id, evidence) VALUES (200005, 200005, 1, NULL, NULL, 'STOP', 200001, '18', NULL, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000009, 200005, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000010, 200005, 2000009, 1, 'KEYWORD', 0, NULL, 200005);
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 200005, id, 'FULL', NULL FROM action WHERE code = 'PROG_BREAK';

-- LET (STATEMENT)
INSERT INTO entry (id, layer_id, name, category_id, operation, redefines_id, description, difference_notes, notes) VALUES (200006, 200001, 'LET', 1, 'ADD', NULL, 'Computes the value of a formula and gives it to a variable.', NULL, '`LET X = X + 2` increases X by 2: LET computes the formula and *calls the answer* V [1] p. 7.');
INSERT INTO entry_source (entry_id, source_id, page) VALUES (200006, 200001, '7');
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, return_min_inclusive, return_max_inclusive, precedence, associativity, operator_class_id, evidence) VALUES (200006, 200006, 1, NULL, NULL, 'LET V = F', 200001, '7', NULL, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200001, 200006, 'variable', 'NONE', NULL, NULL, 'A variable or an element of a list or table.', 'MANUAL');
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200002, 200006, 'formula', 'NONE', NULL, NULL, 'Any formula.', 'MANUAL');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000011, 200006, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000012, 200006, 2000011, 1, 'KEYWORD', 0, NULL, 200006);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000013, 200006, 2000011, 2, 'CHOICE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000014, 200006, 2000013, 1, 'PARAMETER', 0, NULL, 200001, 200006);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000015, 200006, 2000013, 2, 'PARAMETER', 0, NULL, 200001, 200007);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000016, 200006, 2000013, 3, 'PARAMETER', 0, NULL, 200001, 200008);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000017, 200006, 2000011, 3, 'KEYWORD', 0, NULL, 200039);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000018, 200006, 2000011, 4, 'PARAMETER', 0, NULL, 200002, 200005);
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 200006, id, 'FULL', NULL FROM action WHERE code = 'VAR_LET';
INSERT INTO entry_error (entry_id, form_id, parameter_id, error_code, operation, cause, verified, position) VALUES (200006, NULL, NULL, 'ILLEGAL_VARIABLE', 'ADD', 'The name on the left is not a variable.', 0, 1);
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id, page) VALUES (200006, NULL, 1, 'Increase a variable', NULL, '10 LET X = 2
20 LET X = X + 2
30 PRINT X
40 END', '4', 0, NULL, NULL);

-- PRINT (STATEMENT)
INSERT INTO entry (id, layer_id, name, category_id, operation, redefines_id, description, difference_notes, notes) VALUES (200007, 200001, 'PRINT', 1, 'ADD', NULL, 'Types the values of formulas and labels on a line.', NULL, 'Five values fit on a line, in zones of 15 characters (from [2]); the May manual shows the rule only by examples. Whether a final comma keeps the next PRINT on the same line is stated only in [2].

DTSS-Win (compiler of February 1965) prints the round brackets of a label as square ones: `PRINT "()"` and `PRINT "[]"` both print `[]`. The cause (the internal code of the GE-235 or the simulator) is not known.');
INSERT INTO entry_source (entry_id, source_id, page) VALUES (200007, 200001, '7-8');
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, return_min_inclusive, return_max_inclusive, precedence, associativity, operator_class_id, evidence) VALUES (200007, 200007, 1, NULL, 'Commas separate the items. A label can be followed directly by a formula: `PRINT "ROOTS =" S+T`. PRINT alone skips a line.', 'PRINT', 200001, '7-8', NULL, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200003, 200007, 'label', 'NONE', NULL, NULL, 'Text in quotes, typed as it is.', 'MANUAL');
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200004, 200007, 'formula', 'NONE', NULL, NULL, 'Any formula: its value is typed.', 'MANUAL');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000019, 200007, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000020, 200007, 2000019, 1, 'KEYWORD', 0, NULL, 200007);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000021, 200007, 2000019, 2, 'OPTIONAL', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000022, 200007, 2000021, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000023, 200007, 2000022, 1, 'CHOICE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000024, 200007, 2000023, 1, 'PARAMETER', 0, NULL, 200003, 200003);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000025, 200007, 2000023, 2, 'PARAMETER', 0, NULL, 200004, 200005);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000026, 200007, 2000023, 3, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000027, 200007, 2000026, 1, 'PARAMETER', 0, NULL, 200003, 200003);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000028, 200007, 2000026, 2, 'PARAMETER', 0, NULL, 200004, 200005);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, separator, min_occ, max_occ) VALUES (2000029, 200007, 2000022, 2, 'REPEAT', 0, NULL, NULL, 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000030, 200007, 2000029, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, text) VALUES (2000031, 200007, 2000030, 1, 'LITERAL', 0, NULL, ',');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000032, 200007, 2000030, 2, 'CHOICE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000033, 200007, 2000032, 1, 'PARAMETER', 0, NULL, 200003, 200003);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000034, 200007, 2000032, 2, 'PARAMETER', 0, NULL, 200004, 200005);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000035, 200007, 2000032, 3, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000036, 200007, 2000035, 1, 'PARAMETER', 0, NULL, 200003, 200003);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000037, 200007, 2000035, 2, 'PARAMETER', 0, NULL, 200004, 200005);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000038, 200007, 2000022, 3, 'OPTIONAL', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, text) VALUES (2000039, 200007, 2000038, 1, 'LITERAL', 0, NULL, ',');
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 200007, id, 'FULL', NULL FROM action WHERE code = 'IO_PRINT';
INSERT INTO entry_error (entry_id, form_id, parameter_id, error_code, operation, cause, verified, position) VALUES (200007, NULL, NULL, 'TOO_MANY_LABELS', 'ADD', 'The labels of the program are too long altogether (from [2]).', 0, 1);
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id, page) VALUES (200007, NULL, 1, 'Values and a label', NULL, '5 PRINT "SINE OF 30, 60, 90 DEGREES."
10 LET P = 3.14159265
20 PRINT SIN(P/6), SIN(P/3), SIN(P/2)
30 END', 'SINE OF 30, 60, 90 DEGREES.
 .5            .866025       1.', 0, 200001, '8');
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id, page) VALUES (200007, NULL, 2, 'Label followed by a value', 'No separator is needed between a label and a formula (as in [1] p. 21).', '10 LET S = 3
20 PRINT "ROOTS =" S
30 END', 'ROOTS = 3', 0, NULL, NULL);
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id, page) VALUES (200007, NULL, 3, 'Print an integer', 'From the DTSS-Win simulator files (BASPRT). Output checked on DTSS-Win (compiler of February 1965).', '10 PRINT 3
20 END', ' 3', 1, 200008, 'BASPRT');
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id, page) VALUES (200007, NULL, 4, 'Quadratic equation', 'From the DTSS-Win simulator files (LIB/QUAD). Output checked on DTSS-Win (compiler of February 1965). SQR(D) with D = -8 prints the message and goes on with the root of the absolute value: the imaginary part is 1.41421.', '5 PRINT "QUADRATIC EQUATION"
6 PRINT
10 READ A, B, C
20 LET D = B * B -4 * A * C
30 LET S = - B / (2 * A )
40 LET T = SQR(D) / (2 * A)
50 IF D = 0 THEN 100
60 IF D < 0 THEN 200
70 PRINT A, B, C, "TWO REAL ROOTS"
80 PRINT "ROOTS = " S + T, S - T
90 GOTO 300
100 PRINT A, B, C, "ONE ROOT"
110 PRINT "ROOT =" S
120 GOTO 300
200 PRINT A, B, C, "COMPLEX ROOTS"
210 PRINT "REAL PART=" S, "IMAGINARY PART=" T
300 PRINT
310 GOTO 10
400 DATA 1, -2, -3, 1, -4, 4, 1, 0, 2
999 END', 'QUADRATIC EQUATION

 1             -2             -3             TWO REAL ROOTS
ROOTS =  3     -1

 1             -4              4             ONE ROOT
ROOT = 2


SQUARE ROOT OF NEGATIVE NUMBER IN  40
 1              0              2             COMPLEX ROOTS
REAL PART= 0                  IMAGINARY PART= 1.41421


OUT OF DATA IN  10', 1, 200008, 'LIB/QUAD');

-- END (STATEMENT)
INSERT INTO entry (id, layer_id, name, category_id, operation, redefines_id, description, difference_notes, notes) VALUES (200008, 200001, 'END', 1, 'ADD', NULL, 'Last statement of every program: it must have the highest number.', NULL, NULL);
INSERT INTO entry_source (entry_id, source_id, page) VALUES (200008, 200001, '4');
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, return_min_inclusive, return_max_inclusive, precedence, associativity, operator_class_id, evidence) VALUES (200008, 200008, 1, NULL, NULL, 'END', 200001, '4', NULL, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000040, 200008, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000041, 200008, 2000040, 1, 'KEYWORD', 0, NULL, 200008);
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 200008, id, 'FULL', NULL FROM action WHERE code = 'FLOW_END';
INSERT INTO entry_error (entry_id, form_id, parameter_id, error_code, operation, cause, verified, position) VALUES (200008, NULL, NULL, 'END_NOT_LAST', 'ADD', 'A statement has a higher number ([1] p. 19).', 0, 1);
INSERT INTO entry_error (entry_id, form_id, parameter_id, error_code, operation, cause, verified, position) VALUES (200008, NULL, NULL, 'NO_END', 'ADD', 'The program has no END (from [2]).', 0, 2);
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id, page) VALUES (200008, NULL, 1, 'The shortest program', 'The first program of the manual, written without line numbers in the preface.', 'LET X = (7+8)/3
PRINT X
END', '5', 0, 200001, '1');

-- FOR...TO...STEP (STATEMENT)
INSERT INTO entry (id, layer_id, name, category_id, operation, redefines_id, description, difference_notes, notes) VALUES (200009, 200001, 'FOR...TO...STEP', 1, 'ADD', NULL, 'Starts a loop: the variable goes from the first value to the second in steps of 1 or of the STEP value.', NULL, 'The loop is closed by NEXT with the same variable. Steps that are not integers worked because the GE-225 truncated its binary results: .1 was slightly less, so `FOR X = 1 TO 10 STEP .1` reached 10, while `FOR X = 10 TO 1 STEP -.1` did not reach 1 [9].');
INSERT INTO entry_source (entry_id, source_id, page) VALUES (200009, 200001, '9-10');
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, return_min_inclusive, return_max_inclusive, precedence, associativity, operator_class_id, evidence) VALUES (200009, 200009, 1, NULL, NULL, 'FOR V = F1 TO F2', 200001, '9-10', NULL, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200005, 200009, 'v', 'NONE', NULL, NULL, 'A single letter (manual p. 10): N, X; not N5.', 'MANUAL');
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200006, 200009, 'f1', 'NONE', NULL, NULL, 'First value: a number or a formula.', 'MANUAL');
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200007, 200009, 'f2', 'NONE', NULL, NULL, 'Final value: a number or a formula.', 'MANUAL');
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200008, 200009, 'f3', 'NONE', NULL, NULL, 'Step; 1 when STEP is omitted.', 'MANUAL');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000042, 200009, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000043, 200009, 2000042, 1, 'KEYWORD', 0, NULL, 200009);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000044, 200009, 2000042, 2, 'PARAMETER', 0, NULL, 200005, 200006);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000045, 200009, 2000042, 3, 'KEYWORD', 0, NULL, 200039);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000046, 200009, 2000042, 4, 'PARAMETER', 0, NULL, 200006, 200005);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000047, 200009, 2000042, 5, 'KEYWORD', 0, NULL, 200010);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000048, 200009, 2000042, 6, 'PARAMETER', 0, NULL, 200007, 200005);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000049, 200009, 2000042, 7, 'OPTIONAL', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000050, 200009, 2000049, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000051, 200009, 2000050, 1, 'KEYWORD', 0, NULL, 200011);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000052, 200009, 2000050, 2, 'PARAMETER', 0, NULL, 200008, 200005);
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 200009, id, 'FULL', NULL FROM action WHERE code = 'FLOW_FOR';
INSERT INTO entry_error (entry_id, form_id, parameter_id, error_code, operation, cause, verified, position) VALUES (200009, NULL, NULL, 'INCORRECT_FORMAT', 'ADD', 'The FOR is not written in its form ([1] p. 19, [2]).', 0, 1);
INSERT INTO entry_error (entry_id, form_id, parameter_id, error_code, operation, cause, verified, position) VALUES (200009, NULL, NULL, 'TOO_MANY_LOOPS', 'ADD', 'More than 26 FOR statements (from [2]).', 0, 2);
INSERT INTO entry_error (entry_id, form_id, parameter_id, error_code, operation, cause, verified, position) VALUES (200009, NULL, NULL, 'FOR_WITHOUT_NEXT', 'ADD', 'No NEXT closes the loop (from [2]).', 0, 3);
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id, page) VALUES (200009, NULL, 1, 'Sum of 100 fifth powers', NULL, '10 PRINT "SUM OF 100 FIFTH POWERS."
20 LET S = 0
30 FOR N = 1 TO 100
40 LET S = S + N↑5
50 NEXT N
60 PRINT S
99 END', NULL, 0, 200001, '9');
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id, page) VALUES (200009, NULL, 2, 'Even numbers', NULL, '20 LET S = 0
30 FOR N = 2 TO 100 STEP 2
40 LET S = S + N↑5
50 NEXT N
60 PRINT S
99 END', NULL, 0, 200001, '10');
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id, page) VALUES (200009, NULL, 3, 'Simple loop', 'From the DTSS-Win simulator files (BASFOR). Output checked on DTSS-Win (compiler of February 1965).', '10 FOR I = 1 TO 3
20 PRINT I
30 NEXT I
40 END', ' 1
 2
 3', 1, 200008, 'BASFOR');
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id, page) VALUES (200009, NULL, 4, 'Approximate pi', 'From the DTSS-Win simulator files (LIB/PIE). Output checked on DTSS-Win (compiler of February 1965).', '100 REM PIE
110 READ D
120 DATA 10
130 LET S = 1
140 LET N = 6
150 FOR I = 1 TO D
160 LET X = S/2
170 LET Y = 1 - SQR(1 - X*X)
180 LET S = SQR(X*X + Y*Y)
190 LET N = 2*N
200 LET P = N*S/2
210 PRINT I, P
220 NEXT I
230 END', ' 1              3.10583
 2              3.13263
 3              3.13935
 4              3.14103
 5              3.14145
 6              3.14156
 7              3.14158
 8              3.14159
 9              3.14159
 10             3.14159', 1, 200008, 'LIB/PIE');

-- NEXT (STATEMENT)
INSERT INTO entry (id, layer_id, name, category_id, operation, redefines_id, description, difference_notes, notes) VALUES (200010, 200001, 'NEXT', 1, 'ADD', NULL, 'Ends the loop of the FOR with the same variable.', NULL, NULL);
INSERT INTO entry_source (entry_id, source_id, page) VALUES (200010, 200001, '9');
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, return_min_inclusive, return_max_inclusive, precedence, associativity, operator_class_id, evidence) VALUES (200010, 200010, 1, NULL, NULL, 'NEXT V', 200001, '9', NULL, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200009, 200010, 'v', 'NONE', NULL, NULL, 'The variable of the FOR.', 'MANUAL');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000053, 200010, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000054, 200010, 2000053, 1, 'KEYWORD', 0, NULL, 200012);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000055, 200010, 2000053, 2, 'PARAMETER', 0, NULL, 200009, 200006);
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 200010, id, 'FULL', NULL FROM action WHERE code = 'FLOW_NEXT';
INSERT INTO entry_error (entry_id, form_id, parameter_id, error_code, operation, cause, verified, position) VALUES (200010, NULL, NULL, 'NOT_MATCH_WITH_FOR', 'ADD', 'Another variable than the FOR''s, or loops crossed (from [2]).', 0, 1);
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id, page) VALUES (200010, NULL, 1, 'Table of exponentials', NULL, '10 PRINT "X", "EXP(X)"
20 FOR X = 0 TO 20
30 PRINT X, EXP(X)
40 NEXT X
50 END', NULL, 0, 200001, '9');
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id, page) VALUES (200010, NULL, 2, 'Nested loops', 'From the DTSS-Win simulator files (BASLOP). Output checked on DTSS-Win (compiler of February 1965).', '10 FOR X = 1 TO 5 STEP 3
30 FOR Y = 1 TO X
40 PRINT X, Y
50 NEXT Y
60 NEXT X
70 END', ' 1              1
 4              1
 4              2
 4              3
 4              4', 1, 200008, 'BASLOP');

-- GO TO (STATEMENT)
INSERT INTO entry (id, layer_id, name, category_id, operation, redefines_id, description, difference_notes, notes) VALUES (200011, 200001, 'GO TO', 1, 'ADD', NULL, 'Jumps to a line.', NULL, NULL);
INSERT INTO entry_source (entry_id, source_id, page) VALUES (200011, 200001, '11');
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, return_min_inclusive, return_max_inclusive, precedence, associativity, operator_class_id, evidence) VALUES (200011, 200011, 1, NULL, NULL, 'GO TO N', 200001, '11', NULL, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200010, 200011, 'n', 'NONE', 'UNDEFINED_NUMBER', 'ERROR', 'Line number: an integer of up to five digits, written as a number (not a formula).', 'MANUAL');
INSERT INTO parameter_limit (parameter_id, minimum, maximum, notes, min_inclusive, max_inclusive, evidence) VALUES (200010, 1, 99999, NULL, 1, 1, 'MANUAL');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000056, 200011, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000057, 200011, 2000056, 1, 'KEYWORD', 0, NULL, 200013);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000058, 200011, 2000056, 2, 'PARAMETER', 0, NULL, 200010, 200002);
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 200011, id, 'FULL', NULL FROM action WHERE code = 'FLOW_GOTO';
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id, page) VALUES (200011, NULL, 1, 'Back to an earlier line', 'The program stops when the data are used up.', '10 READ X
20 PRINT X, X↑2
30 GO TO 10
40 DATA 1, 2, 3
99 END', '1             1
2             4
3             9', 0, NULL, NULL);

-- IF...THEN (STATEMENT)
INSERT INTO entry (id, layer_id, name, category_id, operation, redefines_id, description, difference_notes, notes) VALUES (200012, 200001, 'IF...THEN', 1, 'ADD', NULL, 'Jumps to a line if a relation between two formulas is true.', NULL, 'If the relation is false the program goes on with the next statement. GO TO and IF...THEN may jump to a REM or DATA line, which does nothing [2] p. 45.');
INSERT INTO entry_source (entry_id, source_id, page) VALUES (200012, 200001, '11-12');
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, return_min_inclusive, return_max_inclusive, precedence, associativity, operator_class_id, evidence) VALUES (200012, 200012, 1, NULL, NULL, 'IF F1 α F2 THEN N', 200001, '11-12', NULL, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200011, 200012, 'relation', 'NONE', NULL, NULL, 'F1 relation F2, with one of = > < >= <= <>.', 'MANUAL');
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200012, 200012, 'n', 'NONE', 'UNDEFINED_NUMBER', 'ERROR', 'Line number: an integer of up to five digits, written as a number (not a formula).', 'MANUAL');
INSERT INTO parameter_limit (parameter_id, minimum, maximum, notes, min_inclusive, max_inclusive, evidence) VALUES (200012, 1, 99999, NULL, 1, 1, 'MANUAL');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000059, 200012, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000060, 200012, 2000059, 1, 'KEYWORD', 0, NULL, 200014);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000061, 200012, 2000059, 2, 'PARAMETER', 0, NULL, 200011, 200011);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000062, 200012, 2000059, 3, 'KEYWORD', 0, NULL, 200015);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000063, 200012, 2000059, 4, 'PARAMETER', 0, NULL, 200012, 200002);
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 200012, id, 'PARTIAL', 'Only a jump, no ELSE' FROM action WHERE code = 'FLOW_IF';
INSERT INTO entry_error (entry_id, form_id, parameter_id, error_code, operation, cause, verified, position) VALUES (200012, NULL, NULL, 'INCORRECT_FORMAT', 'ADD', 'The IF...THEN is not written in its form ([1] p. 19).', 0, 1);
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id, page) VALUES (200012, NULL, 1, 'Largest value of the sine', NULL, '10 LET X0 = 0
20 LET M = SIN(0)
30 FOR N = 1 TO 300
40 LET X = N/100
50 IF SIN(X) <= M THEN 100
60 LET X0 = X
70 LET M = SIN(X)
100 NEXT N
110 PRINT X0, M
999 END', NULL, 0, 200001, '12');
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id, page) VALUES (200012, NULL, 2, 'Jumps in a loop', 'From the DTSS-Win simulator files (BASNFO). Output checked on DTSS-Win (compiler of February 1965).', '10 FOR I = 1 TO 2
20 IF I = 1 THEN 50
30 PRINT "TWO"
40 GOTO 60
50 PRINT "ONE"
60 NEXT I
70 END', 'ONE
TWO', 1, 200008, 'BASNFO');

-- DEF (STATEMENT)
INSERT INTO entry (id, layer_id, name, category_id, operation, redefines_id, description, difference_notes, notes) VALUES (200013, 200001, 'DEF', 1, 'ADD', NULL, 'Defines a function FNA to FNZ with one argument.', NULL, 'DEF may be anywhere in the program. `DEF FNS(Z) = SIN(Z*P/180)` gives a sine in degrees, `DEF FNL(Z) = LOG(Z)/LOG(10)` a common logarithm [1] p. 13.');
INSERT INTO entry_source (entry_id, source_id, page) VALUES (200013, 200001, '13');
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, return_min_inclusive, return_max_inclusive, precedence, associativity, operator_class_id, evidence) VALUES (200013, 200013, 1, NULL, NULL, 'DEF FNC(Z) = Z↑3 + 2.7*Z', 200001, '13', NULL, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200013, 200013, 'letter', 'NONE', NULL, NULL, 'A to Z: up to 26 functions.', 'MANUAL');
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200014, 200013, 'argument', 'NONE', NULL, NULL, 'Used only for the definition; the manual says not to use it elsewhere in the program.', 'MANUAL');
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200015, 200013, 'formula', 'NONE', NULL, NULL, 'Any formula containing the argument; on one line.', 'MANUAL');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000064, 200013, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000065, 200013, 2000064, 1, 'KEYWORD', 0, NULL, 200016);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000066, 200013, 2000064, 2, 'KEYWORD', 0, NULL, 200017);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000067, 200013, 2000064, 3, 'PARAMETER', 1, NULL, 200013, 200004);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, text) VALUES (2000068, 200013, 2000064, 4, 'LITERAL', 1, NULL, '(');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000069, 200013, 2000064, 5, 'PARAMETER', 1, NULL, 200014, 200006);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, text) VALUES (2000070, 200013, 2000064, 6, 'LITERAL', 1, NULL, ')');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000071, 200013, 2000064, 7, 'KEYWORD', 0, NULL, 200039);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000072, 200013, 2000064, 8, 'PARAMETER', 0, NULL, 200015, 200005);
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 200013, id, 'FULL', NULL FROM action WHERE code = 'FN_DEFINE';
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id, page) VALUES (200013, NULL, 1, 'Sine in degrees and common logarithm', 'Lines 10-30 are in the manual.', '10 LET P = 3.14159265
20 DEF FNS(Z) = SIN(Z*P/180)
30 DEF FNL(Z) = LOG(Z)/LOG(10)
40 PRINT FNS(30), FNL(100)
50 END', '.5            2', 0, 200001, '13');

-- READ (STATEMENT)
INSERT INTO entry (id, layer_id, name, category_id, operation, redefines_id, description, difference_notes, notes) VALUES (200014, 200001, 'READ', 1, 'ADD', NULL, 'Gives the variables the next numbers of the DATA statements.', NULL, 'When there is no data left, the program stops, with no message [1] p. 15. The compiler of February 1965 (DTSS-Win) already prints `OUT OF DATA IN n` and stops.');
INSERT INTO entry_source (entry_id, source_id, page) VALUES (200014, 200001, '14-15');
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, return_min_inclusive, return_max_inclusive, precedence, associativity, operator_class_id, evidence) VALUES (200014, 200014, 1, NULL, NULL, 'READ A, B, C', 200001, '14-15', NULL, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200016, 200014, 'variable', 'NONE', NULL, NULL, 'Variables or elements, separated by commas.', 'MANUAL');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000073, 200014, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000074, 200014, 2000073, 1, 'KEYWORD', 0, NULL, 200018);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, separator, min_occ, max_occ) VALUES (2000075, 200014, 2000073, 2, 'REPEAT', 0, NULL, ',', 1, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000076, 200014, 2000075, 1, 'PARAMETER', 0, NULL, 200016, 200009);
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 200014, id, 'FULL', NULL FROM action WHERE code = 'DATA_READ';
INSERT INTO entry_error (entry_id, form_id, parameter_id, error_code, operation, cause, verified, position) VALUES (200014, NULL, NULL, 'NO_DATA', 'ADD', 'The program has no DATA statement ([1] p. 19).', 0, 1);
INSERT INTO entry_error (entry_id, form_id, parameter_id, error_code, operation, cause, verified, position) VALUES (200014, NULL, NULL, 'ILLEGAL_VARIABLE', 'ADD', 'An item of the list is not a variable.', 0, 2);
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id, page) VALUES (200014, NULL, 1, 'Data for several runs', 'Stops after the fifth value, with no message.', '10 READ X
20 LET Y = X↑3 + X↑2 - X
30 PRINT X, Y
40 GO TO 10
50 DATA 1.23, -.2345, 12.3, 1E-17, 123456815
99 END', NULL, 0, 200001, '15');

-- DATA (STATEMENT)
INSERT INTO entry (id, layer_id, name, category_id, operation, redefines_id, description, difference_notes, notes) VALUES (200015, 200001, 'DATA', 1, 'ADD', NULL, 'Numbers for READ, taken in the order of the DATA statements.', NULL, 'Never executed: it can be anywhere, usually just before END. Up to 200 numbers in all [1] p. 14.');
INSERT INTO entry_source (entry_id, source_id, page) VALUES (200015, 200001, '14');
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, return_min_inclusive, return_max_inclusive, precedence, associativity, operator_class_id, evidence) VALUES (200015, 200015, 1, NULL, NULL, 'DATA 1, 2, 3', 200001, '14', NULL, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200017, 200015, 'number', 'NONE', NULL, NULL, 'Numbers separated by commas, as many as fit on the line.', 'MANUAL');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000077, 200015, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000078, 200015, 2000077, 1, 'KEYWORD', 0, NULL, 200019);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, separator, min_occ, max_occ) VALUES (2000079, 200015, 2000077, 2, 'REPEAT', 0, NULL, ',', 1, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000080, 200015, 2000079, 1, 'PARAMETER', 0, NULL, 200017, 200001);
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 200015, id, 'FULL', NULL FROM action WHERE code = 'DATA_DEFINE';
INSERT INTO entry_error (entry_id, form_id, parameter_id, error_code, operation, cause, verified, position) VALUES (200015, NULL, NULL, 'TOO_MUCH_DATA', 'ADD', 'More numbers than the limit (200 in [1] p. 14).', 0, 1);
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id, page) VALUES (200015, NULL, 1, 'Order of the data', 'A = 1, B = 2, C = 3, D1 = 4, ..., D4 = 7.', '10 READ A, B, C
20 READ D1, D2, D3, D4
30 PRINT A, D4
80 DATA 1, 2, 3, 4, 5, 6
90 DATA 7, 8, 9, 10
99 END', '1             7', 0, 200001, '14');
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id, page) VALUES (200015, NULL, 2, 'Life of a mortgage', 'From the DTSS-Win simulator files (LIB/MORT). DATA lines interleaved with REM lines; the typing slip COMOPUTER is in the original. Output checked on DTSS-Win (compiler of February 1965). The run prints 291 lines (to 1988): only the first and last lines are shown, the dots stand for the rest.', '1 REM MORTGAGE COMOPUTER
2 REM YEARLY INTEREST RATE
10 DATA 0.05
15 REM INITIAL PRINCIPAL
20 DATA 28500
25 REM MONTHLY PAYMENT
30 DATA 170
35 REM STARTING MONTH AND YEAR
40 DATA 1, 1964
50 READ I, P, P1, M, Y
60 LET R = 1 + I/12
70 PRINT "YEAR", "PRINCIPAL"
80 PRINT Y, P
90 LET P = P*R - P1
100 IF P >= 0 THEN 120
110 LET P = 0
120 LET M = M + 1
130 IF M > 12 THEN 160
140 PRINT "       ",
150 GO TO 190
160 LET M = 1
170 LET Y = Y + 1
180 PRINT Y,
190 PRINT INT(P)
200 IF P > 0 THEN 90
210 END', 'YEAR           PRINCIPAL
 1964           28500
                28448
                28397
                28345
                28293
                28241
                28189
                28136
                28083
                28030
                27977
                27924
 1965           27870
...
                736
                569
                401
                233
 1988           64
                0', 1, 200008, 'LIB/MORT');

-- GOSUB (STATEMENT)
INSERT INTO entry (id, layer_id, name, category_id, operation, redefines_id, description, difference_notes, notes) VALUES (200016, 200001, 'GOSUB', 1, 'ADD', NULL, 'Calls a subroutine: RETURN goes back to the statement after the GOSUB.', NULL, 'Part II of the May manual is missing: taken from the 2nd edition manual [2] pp. 42-43, which says that a GOSUB inside a subroutine "just won''t work": no nesting. The compiler of February 1965 (DTSS-Win) already runs nested GOSUBs correctly. Kurtz [9] writes that GOSUB "used a stack for the return address", which does not agree with [2].');
INSERT INTO entry_source (entry_id, source_id, page) VALUES (200016, 200002, '42-43');
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, return_min_inclusive, return_max_inclusive, precedence, associativity, operator_class_id, evidence) VALUES (200016, 200016, 1, NULL, NULL, 'GOSUB N', 200002, '42-43', NULL, NULL, NULL, 1, 1, NULL, NULL, NULL, 'INFERRED');
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200018, 200016, 'n', 'NONE', 'UNDEFINED_NUMBER', 'ERROR', 'Line number: an integer of up to five digits, written as a number (not a formula).', 'INFERRED');
INSERT INTO parameter_limit (parameter_id, minimum, maximum, notes, min_inclusive, max_inclusive, evidence) VALUES (200018, 1, 99999, NULL, 1, 1, 'INFERRED');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000081, 200016, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000082, 200016, 2000081, 1, 'KEYWORD', 0, NULL, 200020);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000083, 200016, 2000081, 2, 'PARAMETER', 0, NULL, 200018, 200002);
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 200016, id, 'FULL', NULL FROM action WHERE code = 'FLOW_GOSUB';
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id, page) VALUES (200016, NULL, 1, 'Call a subroutine', 'STOP comes with the 2nd edition: in the 1st write `40 GO TO 120`.', '10 LET X = 3
20 GOSUB 100
30 PRINT Y
40 STOP
100 LET Y = X*X
110 RETURN
120 END', '9', 0, NULL, NULL);
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id, page) VALUES (200016, NULL, 2, 'Greatest common divisor', 'From the DTSS-Win simulator files (LIB/GCD). GCD 30 for 60 and 90, 8 for 38456 and 64872; it stops when the data run out. Output checked on DTSS-Win (compiler of February 1965).', '10 PRINT "A", "B", "GCD"
20 READ A, B
30 LET X = A
40 LET Y = B
50 GOSUB 200
90 PRINT A, B, G
100 GOTO 20
110 DATA 60, 90
120 DATA 38456, 64872
200 LET Q = INT(X/Y)
210 LET R = X - Q*Y
220 IF R = 0 THEN 300
230 LET X = Y
240 LET Y = R
250 GOTO 200
300 LET G = Y
310 RETURN
999 END', 'A              B              GCD
 60             90             30
 38456          64872          8

OUT OF DATA IN  20', 1, 200008, 'LIB/GCD');

-- RETURN (STATEMENT)
INSERT INTO entry (id, layer_id, name, category_id, operation, redefines_id, description, difference_notes, notes) VALUES (200017, 200001, 'RETURN', 1, 'ADD', NULL, 'Goes back to the statement after the last GOSUB.', NULL, 'Taken from the 2nd edition manual [2] (Part II of [1] is missing).');
INSERT INTO entry_source (entry_id, source_id, page) VALUES (200017, 200002, '42-43');
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, return_min_inclusive, return_max_inclusive, precedence, associativity, operator_class_id, evidence) VALUES (200017, 200017, 1, NULL, NULL, 'RETURN', 200002, '42-43', NULL, NULL, NULL, 1, 1, NULL, NULL, NULL, 'INFERRED');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000084, 200017, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000085, 200017, 2000084, 1, 'KEYWORD', 0, NULL, 200021);
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 200017, id, 'FULL', NULL FROM action WHERE code = 'FLOW_RETURN';
INSERT INTO entry_error (entry_id, form_id, parameter_id, error_code, operation, cause, verified, position) VALUES (200017, NULL, NULL, 'ILLEGAL_RETURN', 'ADD', 'RETURN before any GOSUB (from [2]).', 0, 1);
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id, page) VALUES (200017, NULL, 1, 'Two calls', NULL, '10 GOSUB 100
20 GOSUB 100
30 GO TO 999
100 PRINT "HELLO"
110 RETURN
999 END', 'HELLO
HELLO', 0, NULL, NULL);
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id, page) VALUES (200017, NULL, 2, 'GCD of three numbers', 'From the DTSS-Win simulator files (LIB/GCD3NO). The same subroutine called twice: GCD 30, then 1. Output checked on DTSS-Win (compiler of February 1965).', '10 PRINT "A", "B", "C", "GCD"
20 READ A, B, C
30 LET X = A
40 LET Y = B
50 GOSUB 200
60 LET X = G
70 LET Y = C
80 GOSUB 200
90 PRINT A, B, C, G
100 GOTO 20
110 DATA 60, 90, 120
120 DATA 38456, 64872, 98765
200 LET Q = INT(X/Y)
210 LET R = X - Q*Y
220 IF R = 0 THEN 300
230 LET X = Y
240 LET Y = R
250 GOTO 200
300 LET G = Y
310 RETURN
999 END', 'A              B              C              GCD
 60             90             120            30
 38456          64872          98765          1

OUT OF DATA IN  20', 1, 200008, 'LIB/GCD3NO');

-- DIM (STATEMENT)
INSERT INTO entry (id, layer_id, name, category_id, operation, redefines_id, description, difference_notes, notes) VALUES (200018, 200001, 'DIM', 1, 'ADD', NULL, 'Gives lists and tables more elements than the default.', NULL, 'Taken from the 2nd edition manual [2] p. 38 (Part II of [1] is missing). According to source [5] the 1st edition needed DIM only for more than 10 elements, numbered from 1.');
INSERT INTO entry_source (entry_id, source_id, page) VALUES (200018, 200002, '38');
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, return_min_inclusive, return_max_inclusive, precedence, associativity, operator_class_id, evidence) VALUES (200018, 200018, 1, NULL, NULL, 'DIM A(17), B(15,20)', 200002, '38', NULL, NULL, NULL, 1, 1, NULL, NULL, NULL, 'INFERRED');
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200019, 200018, 'array', 'NONE', NULL, NULL, 'One letter.', 'INFERRED');
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200020, 200018, 'n', 'NONE', NULL, NULL, 'Largest subscript (of the rows, for a table).', 'INFERRED');
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200021, 200018, 'm', 'NONE', NULL, NULL, 'Largest column subscript of a table.', 'INFERRED');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000086, 200018, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000087, 200018, 2000086, 1, 'KEYWORD', 0, NULL, 200022);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, separator, min_occ, max_occ) VALUES (2000088, 200018, 2000086, 2, 'REPEAT', 0, NULL, ',', 1, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000089, 200018, 2000088, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000090, 200018, 2000089, 1, 'PARAMETER', 0, NULL, 200019, 200010);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, text) VALUES (2000091, 200018, 2000089, 2, 'LITERAL', 1, NULL, '(');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000092, 200018, 2000089, 3, 'PARAMETER', 1, NULL, 200020, 200001);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000093, 200018, 2000089, 4, 'OPTIONAL', 1, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000094, 200018, 2000093, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, text) VALUES (2000095, 200018, 2000094, 1, 'LITERAL', 1, NULL, ',');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000096, 200018, 2000094, 2, 'PARAMETER', 1, NULL, 200021, 200001);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, text) VALUES (2000097, 200018, 2000089, 5, 'LITERAL', 1, NULL, ')');
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 200018, id, 'PARTIAL', 'Numeric arrays of one or two dimensions' FROM action WHERE code = 'VAR_DIM';
INSERT INTO entry_error (entry_id, form_id, parameter_id, error_code, operation, cause, verified, position) VALUES (200018, NULL, NULL, 'DIMENSION_TOO_LARGE', 'ADD', 'From [2].', 0, 1);
INSERT INTO entry_error (entry_id, form_id, parameter_id, error_code, operation, cause, verified, position) VALUES (200018, NULL, NULL, 'CUT_PROGRAM_OR_DIMS', 'ADD', 'The arrays take too much room (from [2]).', 0, 2);
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id, page) VALUES (200018, NULL, 1, 'A longer list', NULL, '10 DIM A(20)
20 FOR I = 1 TO 20
30 LET A(I) = I*I
40 NEXT I
50 PRINT A(20)
60 END', '400', 0, NULL, NULL);

-- REM (STATEMENT)
INSERT INTO entry (id, layer_id, name, category_id, operation, redefines_id, description, difference_notes, notes) VALUES (200019, 200001, 'REM', 1, 'ADD', NULL, 'Remark: does nothing.', NULL, 'Taken from the 2nd edition manual [2] p. 45 (Part II of [1] is missing).');
INSERT INTO entry_source (entry_id, source_id, page) VALUES (200019, 200002, '45');
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, return_min_inclusive, return_max_inclusive, precedence, associativity, operator_class_id, evidence) VALUES (200019, 200019, 1, NULL, NULL, 'REM', 200002, '45', NULL, NULL, NULL, 1, 1, NULL, NULL, NULL, 'INFERRED');
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200022, 200019, 'text', 'NONE', NULL, NULL, 'Any text.', 'MANUAL');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000098, 200019, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000099, 200019, 2000098, 1, 'KEYWORD', 0, NULL, 200023);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000100, 200019, 2000098, 2, 'OPTIONAL', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000101, 200019, 2000100, 1, 'PARAMETER', 0, NULL, 200022, 200012);
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 200019, id, 'FULL', NULL FROM action WHERE code = 'PROG_REM';
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id, page) VALUES (200019, NULL, 1, 'A remark', NULL, '10 REM SQUARES
20 PRINT 3↑2
30 END', '9', 0, NULL, NULL);

-- SIN (FUNCTION)
INSERT INTO entry (id, layer_id, name, category_id, operation, redefines_id, description, difference_notes, notes) VALUES (200020, 200001, 'SIN', 3, 'ADD', NULL, 'Sine; the argument is in radians.', NULL, NULL);
INSERT INTO entry_source (entry_id, source_id, page) VALUES (200020, 200001, '5');
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, return_min_inclusive, return_max_inclusive, precedence, associativity, operator_class_id, evidence) VALUES (200020, 200020, 1, NULL, NULL, 'SIN(X)', 200001, '5', 200001, -1, 1, 1, 1, NULL, NULL, NULL, 'MANUAL');
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200023, 200020, 'x', 'NONE', NULL, NULL, 'Any formula.', 'MANUAL');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000102, 200020, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000103, 200020, 2000102, 1, 'KEYWORD', 0, NULL, 200024);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, text) VALUES (2000104, 200020, 2000102, 2, 'LITERAL', 1, NULL, '(');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000105, 200020, 2000102, 3, 'PARAMETER', 1, NULL, 200023, 200005);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, text) VALUES (2000106, 200020, 2000102, 4, 'LITERAL', 1, NULL, ')');
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 200020, id, 'FULL', NULL FROM action WHERE code = 'MATH_SIN';
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id, page) VALUES (200020, NULL, 1, 'Sine of 30 degrees', NULL, '10 PRINT SIN(3.14159265/6)
20 END', '.5', 0, NULL, NULL);
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id, page) VALUES (200020, NULL, 2, 'Table of sines', 'From the DTSS-Win simulator files (BASSIN). Output checked on DTSS-Win (compiler of February 1965).', '10 LET P = 3.14159265
20 FOR D = 0 TO 180 STEP 10
30 PRINT D, SIN(D*P/180)
40 NEXT D
50 END', ' 0              0
 10             .173648
 20             .34202
 30             .5
 40             .642788
 50             .766044
 60             .866025
 70             .939693
 80             .984808
 90             1.
 100            .984808
 110            .939693
 120            .866025
 130            .766044
 140            .642788
 150            .5
 160            .34202
 170            .173648
 180            8.73115 E-9', 1, 200008, 'BASSIN');

-- COS (FUNCTION)
INSERT INTO entry (id, layer_id, name, category_id, operation, redefines_id, description, difference_notes, notes) VALUES (200021, 200001, 'COS', 3, 'ADD', NULL, 'Cosine; the argument is in radians.', NULL, NULL);
INSERT INTO entry_source (entry_id, source_id, page) VALUES (200021, 200001, '5');
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, return_min_inclusive, return_max_inclusive, precedence, associativity, operator_class_id, evidence) VALUES (200021, 200021, 1, NULL, NULL, 'COS(X)', 200001, '5', 200001, -1, 1, 1, 1, NULL, NULL, NULL, 'MANUAL');
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200024, 200021, 'x', 'NONE', NULL, NULL, 'Any formula.', 'MANUAL');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000107, 200021, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000108, 200021, 2000107, 1, 'KEYWORD', 0, NULL, 200025);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, text) VALUES (2000109, 200021, 2000107, 2, 'LITERAL', 1, NULL, '(');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000110, 200021, 2000107, 3, 'PARAMETER', 1, NULL, 200024, 200005);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, text) VALUES (2000111, 200021, 2000107, 4, 'LITERAL', 1, NULL, ')');
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 200021, id, 'FULL', NULL FROM action WHERE code = 'MATH_COS';
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id, page) VALUES (200021, NULL, 1, 'Cosine of 0', NULL, '10 PRINT COS(0)
20 END', '1', 0, NULL, NULL);
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id, page) VALUES (200021, NULL, 2, 'Table of cosines', 'From the DTSS-Win simulator files (BASCOS). Output checked on DTSS-Win (compiler of February 1965).', '10 LET P = 3.14159265
20 FOR D = 0 TO 180 STEP 10
30 PRINT D, COS(D*P/180)
40 NEXT D
50 END', ' 0              1
 10             .984808
 20             .939693
 30             .866025
 40             .766044
 50             .642788
 60             .5
 70             .34202
 80             .173648
 90             5.82077 E-9
 100           -.173648
 110           -.34202
 120           -.5
 130           -.642788
 140           -.766044
 150           -.866025
 160           -.939693
 170           -.984808
 180           -1.', 1, 200008, 'BASCOS');

-- TAN (FUNCTION)
INSERT INTO entry (id, layer_id, name, category_id, operation, redefines_id, description, difference_notes, notes) VALUES (200022, 200001, 'TAN', 3, 'ADD', NULL, 'Tangent; the argument is in radians.', NULL, NULL);
INSERT INTO entry_source (entry_id, source_id, page) VALUES (200022, 200001, '5');
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, return_min_inclusive, return_max_inclusive, precedence, associativity, operator_class_id, evidence) VALUES (200022, 200022, 1, NULL, NULL, 'TAN(X)', 200001, '5', 200001, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200025, 200022, 'x', 'NONE', NULL, NULL, 'Any formula.', 'MANUAL');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000112, 200022, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000113, 200022, 2000112, 1, 'KEYWORD', 0, NULL, 200026);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, text) VALUES (2000114, 200022, 2000112, 2, 'LITERAL', 1, NULL, '(');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000115, 200022, 2000112, 3, 'PARAMETER', 1, NULL, 200025, 200005);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, text) VALUES (2000116, 200022, 2000112, 4, 'LITERAL', 1, NULL, ')');
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 200022, id, 'FULL', NULL FROM action WHERE code = 'MATH_TAN';
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id, page) VALUES (200022, NULL, 1, 'Tangent', NULL, '10 PRINT TAN(.785398)
20 END', '1', 0, NULL, NULL);
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id, page) VALUES (200022, NULL, 2, 'Table of tangents', 'From the DTSS-Win simulator files (BASTAN). Output checked on DTSS-Win (compiler of February 1965).', '10 LET P = 3.14159265
20 FOR D = 0 TO 180 STEP 10
30 PRINT D, TAN(D*P/180)
40 NEXT D
50 END', ' 0              0
 10             .176327
 20             .36397
 30             .57735
 40             .8391
 50             1.19175
 60             1.73205
 70             2.74748
 80             5.67128
 90             1.71799 E 8
 100           -5.67128
 110           -2.74748
 120           -1.73205
 130           -1.19175
 140           -.8391
 150           -.57735
 160           -.36397
 170           -.176327
 180           -8.73115 E-9', 1, 200008, 'BASTAN');

-- ATN (FUNCTION)
INSERT INTO entry (id, layer_id, name, category_id, operation, redefines_id, description, difference_notes, notes) VALUES (200023, 200001, 'ATN', 3, 'ADD', NULL, 'Arc tangent, in radians.', NULL, NULL);
INSERT INTO entry_source (entry_id, source_id, page) VALUES (200023, 200001, '5');
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, return_min_inclusive, return_max_inclusive, precedence, associativity, operator_class_id, evidence) VALUES (200023, 200023, 1, NULL, NULL, 'ATN(X)', 200001, '5', 200001, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200026, 200023, 'x', 'NONE', NULL, NULL, 'Any formula.', 'MANUAL');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000117, 200023, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000118, 200023, 2000117, 1, 'KEYWORD', 0, NULL, 200027);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, text) VALUES (2000119, 200023, 2000117, 2, 'LITERAL', 1, NULL, '(');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000120, 200023, 2000117, 3, 'PARAMETER', 1, NULL, 200026, 200005);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, text) VALUES (2000121, 200023, 2000117, 4, 'LITERAL', 1, NULL, ')');
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 200023, id, 'FULL', NULL FROM action WHERE code = 'MATH_ATN';
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id, page) VALUES (200023, NULL, 1, 'Arc tangent', NULL, '10 PRINT 4*ATN(1)
20 END', '3.14159', 0, NULL, NULL);
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id, page) VALUES (200023, NULL, 2, 'Arc tangent in degrees', 'From the DTSS-Win simulator files (BASATN). Output checked on DTSS-Win (compiler of February 1965).', '10 LET P1 = 3.14159265
20 FOR T = -5 TO 5
30 PRINT ATN(T)*180/P1
40 NEXT T
50 END', '-78.6901
-75.9638
-71.5651
-63.435
-45.
 0
 45
 63.4349
 71.5651
 75.9638
 78.6901', 1, 200008, 'BASATN');

-- EXP (FUNCTION)
INSERT INTO entry (id, layer_id, name, category_id, operation, redefines_id, description, difference_notes, notes) VALUES (200024, 200001, 'EXP', 3, 'ADD', NULL, 'e raised to the argument.', NULL, NULL);
INSERT INTO entry_source (entry_id, source_id, page) VALUES (200024, 200001, '5');
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, return_min_inclusive, return_max_inclusive, precedence, associativity, operator_class_id, evidence) VALUES (200024, 200024, 1, NULL, NULL, 'EXP(A)', 200001, '5', 200001, 0, NULL, 1, 1, NULL, NULL, NULL, 'MANUAL');
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200027, 200024, 'x', 'NONE', NULL, NULL, 'Any formula.', 'MANUAL');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000122, 200024, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000123, 200024, 2000122, 1, 'KEYWORD', 0, NULL, 200028);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, text) VALUES (2000124, 200024, 2000122, 2, 'LITERAL', 1, NULL, '(');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000125, 200024, 2000122, 3, 'PARAMETER', 1, NULL, 200027, 200005);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, text) VALUES (2000126, 200024, 2000122, 4, 'LITERAL', 1, NULL, ')');
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 200024, id, 'FULL', NULL FROM action WHERE code = 'MATH_EXP';
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id, page) VALUES (200024, NULL, 1, 'The number e', NULL, '10 PRINT EXP(1)
20 END', '2.71828', 0, NULL, NULL);
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id, page) VALUES (200024, NULL, 2, 'Table of exponentials', 'From the DTSS-Win simulator files (BASEXP). Output checked on DTSS-Win (compiler of February 1965).', '10 FOR X = -1 TO 1 STEP .5
20 PRINT X, EXP(X)
30 NEXT X
40 END', '-1              .367879
-.5             .606531
 0              1
 .5             1.64872
 1              2.71828', 1, 200008, 'BASEXP');

-- LOG (FUNCTION)
INSERT INTO entry (id, layer_id, name, category_id, operation, redefines_id, description, difference_notes, notes) VALUES (200025, 200001, 'LOG', 3, 'ADD', NULL, 'Natural logarithm.', NULL, 'The 2nd edition manual [2] says that the logarithm is taken of the absolute value of the argument, with no message.');
INSERT INTO entry_source (entry_id, source_id, page) VALUES (200025, 200001, '5');
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, return_min_inclusive, return_max_inclusive, precedence, associativity, operator_class_id, evidence) VALUES (200025, 200025, 1, NULL, NULL, 'LOG(A)', 200001, '5', 200001, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200028, 200025, 'x', 'NONE', NULL, NULL, 'Any formula.', 'MANUAL');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000127, 200025, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000128, 200025, 2000127, 1, 'KEYWORD', 0, NULL, 200029);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, text) VALUES (2000129, 200025, 2000127, 2, 'LITERAL', 1, NULL, '(');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000130, 200025, 2000127, 3, 'PARAMETER', 1, NULL, 200028, 200005);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, text) VALUES (2000131, 200025, 2000127, 4, 'LITERAL', 1, NULL, ')');
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 200025, id, 'FULL', NULL FROM action WHERE code = 'MATH_LN';
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id, page) VALUES (200025, NULL, 1, 'Average of 100 logarithms', 'Output checked on DTSS-Win (compiler of February 1965, program AVELOG): the same result, printed as ` 1.5797`.', '10 PRINT "AVERAGE OF 100 LOGS"
20 LET S = 0
30 FOR N = 1 TO 100
40 LET S = S + FNL(N)
50 NEXT N
60 LET S = S/100
70 PRINT S
80 DEF FNL(Z) = LOG(Z)/LOG(10)
99 END', 'AVERAGE OF 100 LOGS
1.5797', 1, 200001, '21');
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id, page) VALUES (200025, NULL, 2, 'Natural and common logarithms', 'From the DTSS-Win simulator files (BASLOG). Output checked on DTSS-Win (compiler of February 1965).', '10 FOR X = 1 TO 10
20 PRINT X, LOG(X), LOG(X)/LOG(10)
30 NEXT X
40 END', ' 1              0              0
 2              .693147        .30103
 3              1.09861        .477121
 4              1.38629        .60206
 5              1.60944        .69897
 6              1.79176        .778151
 7              1.94591        .845098
 8              2.07944        .90309
 9              2.19722        .954243
 10             2.30259        1', 1, 200008, 'BASLOG');

-- SQR (FUNCTION)
INSERT INTO entry (id, layer_id, name, category_id, operation, redefines_id, description, difference_notes, notes) VALUES (200026, 200001, 'SQR', 3, 'ADD', NULL, 'Square root of the absolute value of the argument.', NULL, 'The square root is always taken of the absolute value: `SQR(-4)` = 2, with no message [1] p. 5. The compiler of February 1965 (DTSS-Win) prints `SQUARE ROOT OF NEGATIVE NUMBER IN n`, then goes on with the root of the absolute value.');
INSERT INTO entry_source (entry_id, source_id, page) VALUES (200026, 200001, '5');
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, return_min_inclusive, return_max_inclusive, precedence, associativity, operator_class_id, evidence) VALUES (200026, 200026, 1, NULL, NULL, 'SQR(A)', 200001, '5', 200001, 0, NULL, 1, 1, NULL, NULL, NULL, 'MANUAL');
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200029, 200026, 'x', 'NONE', NULL, NULL, 'Any formula.', 'MANUAL');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000132, 200026, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000133, 200026, 2000132, 1, 'KEYWORD', 0, NULL, 200030);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, text) VALUES (2000134, 200026, 2000132, 2, 'LITERAL', 1, NULL, '(');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000135, 200026, 2000132, 3, 'PARAMETER', 1, NULL, 200029, 200005);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, text) VALUES (2000136, 200026, 2000132, 4, 'LITERAL', 1, NULL, ')');
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 200026, id, 'FULL', NULL FROM action WHERE code = 'MATH_SQR';
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id, page) VALUES (200026, NULL, 1, 'Root of a negative number', 'The absolute value is used, with no message according to [1]. DTSS-Win (compiler of February 1965) prints `SQUARE ROOT OF NEGATIVE NUMBER IN 10` and then 2.', '10 PRINT SQR(-4)
20 END', '2', 0, NULL, NULL);
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id, page) VALUES (200026, NULL, 2, 'Table of square roots', 'From the DTSS-Win simulator files (BASSQR). Output checked on DTSS-Win (compiler of February 1965).', '10 FOR X = 0 TO 10
20 PRINT X, SQR(X)
30 NEXT X
40 END', ' 0              0
 1              1
 2              1.41421
 3              1.73205
 4              2
 5              2.23607
 6              2.44949
 7              2.64575
 8              2.82843
 9              3
 10             3.16228', 1, 200008, 'BASSQR');

-- ABS (FUNCTION)
INSERT INTO entry (id, layer_id, name, category_id, operation, redefines_id, description, difference_notes, notes) VALUES (200027, 200001, 'ABS', 3, 'ADD', NULL, 'Absolute value.', NULL, NULL);
INSERT INTO entry_source (entry_id, source_id, page) VALUES (200027, 200001, '6');
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, return_min_inclusive, return_max_inclusive, precedence, associativity, operator_class_id, evidence) VALUES (200027, 200027, 1, NULL, NULL, 'ABS(X)', 200001, '6', 200001, 0, NULL, 1, 1, NULL, NULL, NULL, 'MANUAL');
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200030, 200027, 'x', 'NONE', NULL, NULL, 'Any formula.', 'MANUAL');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000137, 200027, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000138, 200027, 2000137, 1, 'KEYWORD', 0, NULL, 200031);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, text) VALUES (2000139, 200027, 2000137, 2, 'LITERAL', 1, NULL, '(');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000140, 200027, 2000137, 3, 'PARAMETER', 1, NULL, 200030, 200005);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, text) VALUES (2000141, 200027, 2000137, 4, 'LITERAL', 1, NULL, ')');
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 200027, id, 'FULL', NULL FROM action WHERE code = 'MATH_ABS';
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id, page) VALUES (200027, NULL, 1, 'Absolute value', NULL, '10 PRINT ABS(-3.5)
20 END', '3.5', 0, NULL, NULL);
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id, page) VALUES (200027, NULL, 2, 'Absolute values', 'From the DTSS-Win simulator files (BASABS). Output checked on DTSS-Win (compiler of February 1965).', '10 FOR N = -10 TO 10 STEP 2
15 LET X = N/3
20 PRINT X, ABS(X)
30 NEXT N
40 END', '-3.33333        3.33333
-2.66667        2.66667
-2              2
-1.33333        1.33333
-.666667        .666667
 0              0
 .666667        .666667
 1.33333        1.33333
 2              2
 2.66667        2.66667
 3.33333        3.33333', 1, 200008, 'BASABS');

-- RND (FUNCTION)
INSERT INTO entry (id, layer_id, name, category_id, operation, redefines_id, description, difference_notes, notes) VALUES (200028, 200001, 'RND', 3, 'ADD', NULL, 'Random number between 0 and 1.', NULL, 'The May manual only names it ("see Part II"): taken from the 2nd edition manual [2] pp. 39-40. Every run gives the same sequence. DTSS-Win (compiler of February 1965) confirms it: in LIB/GUESS, `INT(100*RND(0)+1)` gives 75 at the start of every RUN, then 20. Kurtz [9] confirms the dummy argument in the 1st edition ("no doubt we were merely being lazy").');
INSERT INTO entry_source (entry_id, source_id, page) VALUES (200028, 200002, '39-40');
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, return_min_inclusive, return_max_inclusive, precedence, associativity, operator_class_id, evidence) VALUES (200028, 200028, 1, NULL, NULL, 'RND(X)', 200002, '39-40', 200001, 0, 1, 1, 1, NULL, NULL, NULL, 'MANUAL');
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200031, 200028, 'x', 'NONE', NULL, NULL, 'Has no significance, but must be written.', 'MANUAL');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000142, 200028, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000143, 200028, 2000142, 1, 'KEYWORD', 0, NULL, 200032);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, text) VALUES (2000144, 200028, 2000142, 2, 'LITERAL', 1, NULL, '(');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000145, 200028, 2000142, 3, 'PARAMETER', 1, NULL, 200031, 200005);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, text) VALUES (2000146, 200028, 2000142, 4, 'LITERAL', 1, NULL, ')');
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 200028, id, 'PARTIAL', 'Only between 0 and 1' FROM action WHERE code = 'RND_VALUE';
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id, page) VALUES (200028, NULL, 1, 'Three random numbers', 'The same three numbers at every run.', '10 FOR I = 1 TO 3
20 PRINT RND(0),
30 NEXT I
40 END', NULL, 0, NULL, NULL);
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id, page) VALUES (200028, NULL, 2, 'Three random numbers', 'From the DTSS-Win simulator files (BASRND). Output checked on DTSS-Win (compiler of February 1965).', '10 LET T = 3
15 FOR N = 1 TO T
20 PRINT RND(0)
30 NEXT N
40 END', ' .746478
 .196324
 4.12519 E-2', 1, 200008, 'BASRND');

-- INT (FUNCTION)
INSERT INTO entry (id, layer_id, name, category_id, operation, redefines_id, description, difference_notes, notes) VALUES (200029, 200001, 'INT', 3, 'ADD', NULL, 'Integer part, truncated towards zero.', NULL, 'The May manual only names it: taken from the 2nd edition manual [2] p. 39, where `INT(-7.8)` = -7. Rounding: `INT(X+.5)` for positive X, `INT(X-.5)` for negative X. Kurtz [9] quotes the complete 1st edition manual (June 1964, p. 31): `INT(3.45)` = 3, `INT(-34.567)` = -34.');
INSERT INTO entry_source (entry_id, source_id, page) VALUES (200029, 200002, '39');
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, return_min_inclusive, return_max_inclusive, precedence, associativity, operator_class_id, evidence) VALUES (200029, 200029, 1, NULL, NULL, 'INT(X)', 200002, '39', 200001, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200032, 200029, 'x', 'NONE', NULL, NULL, 'Any formula.', 'MANUAL');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000147, 200029, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000148, 200029, 2000147, 1, 'KEYWORD', 0, NULL, 200033);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, text) VALUES (2000149, 200029, 2000147, 2, 'LITERAL', 1, NULL, '(');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000150, 200029, 2000147, 3, 'PARAMETER', 1, NULL, 200032, 200005);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, text) VALUES (2000151, 200029, 2000147, 4, 'LITERAL', 1, NULL, ')');
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 200029, id, 'PARTIAL', 'Truncation towards zero, not the floor' FROM action WHERE code = 'MATH_INT';
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id, page) VALUES (200029, NULL, 1, 'Truncation', 'INT(-7.8) = -7 checked on DTSS-Win (compiler of February 1965).', '10 PRINT INT(7.8), INT(-7.8)
20 END', '7            -7', 1, 200002, '39');
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id, page) VALUES (200029, NULL, 2, 'Integer part of thirds', 'From the DTSS-Win simulator files (BASINT). Output checked on DTSS-Win (compiler of February 1965).', '10 FOR N = -10 TO 10 STEP 2
15 LET X = N/3
20 PRINT X, INT(X)
30 NEXT N
40 END', '-3.33333       -3
-2.66667       -2
-2             -2
-1.33333       -1
-.666667        0
 0              0
 .666667        0
 1.33333        1
 2              2
 2.66667        2
 3.33333        3', 1, 200008, 'BASINT');

-- FN (FUNCTION)
INSERT INTO entry (id, layer_id, name, category_id, operation, redefines_id, description, difference_notes, notes) VALUES (200030, 200001, 'FN', 3, 'ADD', NULL, 'Calls a function defined with DEF.', NULL, NULL);
INSERT INTO entry_source (entry_id, source_id, page) VALUES (200030, 200001, '13');
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, return_min_inclusive, return_max_inclusive, precedence, associativity, operator_class_id, evidence) VALUES (200030, 200030, 1, NULL, NULL, 'FNC(X)', 200001, '13', 200001, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200033, 200030, 'letter', 'NONE', NULL, NULL, 'Letter of a function defined with DEF.', 'MANUAL');
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200034, 200030, 'x', 'NONE', NULL, NULL, 'Any formula.', 'MANUAL');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000152, 200030, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000153, 200030, 2000152, 1, 'KEYWORD', 0, NULL, 200017);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000154, 200030, 2000152, 2, 'PARAMETER', 1, NULL, 200033, 200004);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, text) VALUES (2000155, 200030, 2000152, 3, 'LITERAL', 1, NULL, '(');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000156, 200030, 2000152, 4, 'PARAMETER', 1, NULL, 200034, 200005);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, text) VALUES (2000157, 200030, 2000152, 5, 'LITERAL', 1, NULL, ')');
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 200030, id, 'FULL', NULL FROM action WHERE code = 'FN_CALL';
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id, page) VALUES (200030, NULL, 1, 'Root of a function', NULL, '10 PRINT "ROOT OF FUNCTION."
30 DEF FNF(Z) = Z↑5 + Z↑3 - 1
40 LET X = 0
50 LET D = .5
60 LET Y = FNF(X)
70 IF Y = 0 THEN 200
80 IF Y > 0 THEN 150
90 LET X = X + D
100 GO TO 160
150 LET X = X - D
160 IF D < .0001 THEN 200
170 LET D = D/2
180 GO TO 60
200 PRINT "ROOT =" X
999 END', 'ROOT OF FUNCTION.
ROOT = .837585', 0, 200001, '22');

-- ↑ (OPERATOR)
INSERT INTO entry (id, layer_id, name, category_id, operation, redefines_id, description, difference_notes, notes) VALUES (200031, 200001, '↑', 4, 'ADD', NULL, 'Raise to a power, of the absolute value of the base.', NULL, '`A↑B` is computed as |A|↑B: for a negative X write `X*X*X`, not `X↑3` [1] p. 5 (also [2] p. 9). `A↑B↑C` is `(A↑B)↑C` [2] p. 10. The DTSS-Win simulator, which runs a compiler of February 1965, gives `(-2)↑3` = -8: the sign was already kept by then.');
INSERT INTO entry_source (entry_id, source_id, page) VALUES (200031, 200001, '5');
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, return_min_inclusive, return_max_inclusive, precedence, associativity, operator_class_id, evidence) VALUES (200031, 200031, 1, NULL, NULL, 'X↑2', 200001, '5', 200001, 0, NULL, 1, 1, 4, 'LEFT', 1, 'MANUAL');
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200035, 200031, 'a', 'NONE', NULL, NULL, 'Base: its absolute value is used, so X↑3 of a negative X is positive.', 'MANUAL');
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200036, 200031, 'b', 'NONE', NULL, NULL, NULL, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000158, 200031, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000159, 200031, 2000158, 1, 'PARAMETER', 0, NULL, 200035, 200005);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000160, 200031, 2000158, 2, 'KEYWORD', 0, NULL, 200038);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000161, 200031, 2000158, 3, 'PARAMETER', 0, NULL, 200036, 200005);
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 200031, id, 'PARTIAL', 'Of the absolute value of the base' FROM action WHERE code = 'OP_POWER';
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id, page) VALUES (200031, NULL, 1, 'Power of a negative number', 'The absolute value of the base is used according to [1] p. 5 and [2] p. 9; DTSS-Win (compiler of February 1965) prints -8.', '10 PRINT (-2)↑3
20 END', '8', 0, NULL, NULL);

-- - (OPERATOR)
INSERT INTO entry (id, layer_id, name, category_id, operation, redefines_id, description, difference_notes, notes) VALUES (200032, 200001, '-', 4, 'ADD', NULL, 'Change of sign and subtraction.', NULL, 'A leading minus sign comes **before** the power: `-X↑2` is `(-X)↑2` (source [6]); corrected in the 3rd edition.');
INSERT INTO entry_source (entry_id, source_id, page) VALUES (200032, 200001, '5');
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, return_min_inclusive, return_max_inclusive, precedence, associativity, operator_class_id, evidence) VALUES (200032, 200032, 1, 'Change of sign', NULL, NULL, 200001, '5', 200001, NULL, NULL, 1, 1, 5, NULL, 1, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200037, 200032, 'a', 'NONE', NULL, NULL, NULL, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000162, 200032, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000163, 200032, 2000162, 1, 'KEYWORD', 0, NULL, 200035);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000164, 200032, 2000162, 2, 'PARAMETER', 1, NULL, 200037, 200005);
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 200032, id, 'FULL', NULL FROM action WHERE code = 'OP_NEG';
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, return_min_inclusive, return_max_inclusive, precedence, associativity, operator_class_id, evidence) VALUES (200033, 200032, 2, 'Subtraction', NULL, NULL, 200001, '5', 200001, NULL, NULL, 1, 1, 2, 'LEFT', 1, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200038, 200033, 'a', 'NONE', NULL, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200039, 200033, 'b', 'NONE', NULL, NULL, NULL, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000165, 200033, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000166, 200033, 2000165, 1, 'PARAMETER', 0, NULL, 200038, 200005);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000167, 200033, 2000165, 2, 'KEYWORD', 0, NULL, 200035);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000168, 200033, 2000165, 3, 'PARAMETER', 0, NULL, 200039, 200005);
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 200033, id, 'FULL', NULL FROM action WHERE code = 'OP_SUB';
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id, page) VALUES (200032, 200032, 1, 'Minus before the power', '`(-X)↑2` (source [6]); checked on DTSS-Win (compiler of February 1965).', '10 LET X = 3
20 PRINT -X↑2
30 END', '9', 1, NULL, NULL);
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id, page) VALUES (200032, NULL, 2, 'Subtraction', 'From the DTSS-Win simulator files (BASSUB). Output checked on DTSS-Win (compiler of February 1965).', '10 LET S = 2 - 5
20 PRINT S
30 END', '-3', 1, 200008, 'BASSUB');

-- * (OPERATOR)
INSERT INTO entry (id, layer_id, name, category_id, operation, redefines_id, description, difference_notes, notes) VALUES (200033, 200001, '*', 4, 'ADD', NULL, 'Multiplication; it must always be written.', NULL, NULL);
INSERT INTO entry_source (entry_id, source_id, page) VALUES (200033, 200001, '5');
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, return_min_inclusive, return_max_inclusive, precedence, associativity, operator_class_id, evidence) VALUES (200034, 200033, 1, NULL, NULL, NULL, 200001, '5', 200001, NULL, NULL, 1, 1, 3, 'LEFT', 1, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200040, 200034, 'a', 'NONE', NULL, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200041, 200034, 'b', 'NONE', NULL, NULL, NULL, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000169, 200034, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000170, 200034, 2000169, 1, 'PARAMETER', 0, NULL, 200040, 200005);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000171, 200034, 2000169, 2, 'KEYWORD', 0, NULL, 200036);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000172, 200034, 2000169, 3, 'PARAMETER', 0, NULL, 200041, 200005);
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 200034, id, 'FULL', NULL FROM action WHERE code = 'OP_MUL';
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id, page) VALUES (200033, NULL, 1, 'Product', NULL, '10 PRINT 6*7
20 END', '42', 0, NULL, NULL);

-- / (OPERATOR)
INSERT INTO entry (id, layer_id, name, category_id, operation, redefines_id, description, difference_notes, notes) VALUES (200034, 200001, '/', 4, 'ADD', NULL, 'Division.', NULL, '`A/B/C` is `(A/B)/C` [2] p. 10. Division by zero is not described in [1] or [2]; the compiler of February 1965 (DTSS-Win) prints 1 for `1/0`, with no message.');
INSERT INTO entry_source (entry_id, source_id, page) VALUES (200034, 200001, '5');
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, return_min_inclusive, return_max_inclusive, precedence, associativity, operator_class_id, evidence) VALUES (200035, 200034, 1, NULL, NULL, NULL, 200001, '5', 200001, NULL, NULL, 1, 1, 3, 'LEFT', 1, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200042, 200035, 'a', 'NONE', NULL, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200043, 200035, 'b', 'NONE', NULL, NULL, NULL, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000173, 200035, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000174, 200035, 2000173, 1, 'PARAMETER', 0, NULL, 200042, 200005);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000175, 200035, 2000173, 2, 'KEYWORD', 0, NULL, 200037);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000176, 200035, 2000173, 3, 'PARAMETER', 0, NULL, 200043, 200005);
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 200035, id, 'FULL', NULL FROM action WHERE code = 'OP_DIV';
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id, page) VALUES (200034, NULL, 1, 'Division from the left', NULL, '10 PRINT 24/4/2
20 END', '3', 0, NULL, NULL);

-- + (OPERATOR)
INSERT INTO entry (id, layer_id, name, category_id, operation, redefines_id, description, difference_notes, notes) VALUES (200035, 200001, '+', 4, 'ADD', NULL, 'Addition.', NULL, NULL);
INSERT INTO entry_source (entry_id, source_id, page) VALUES (200035, 200001, '5');
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, return_min_inclusive, return_max_inclusive, precedence, associativity, operator_class_id, evidence) VALUES (200036, 200035, 1, NULL, NULL, NULL, 200001, '5', 200001, NULL, NULL, 1, 1, 2, 'LEFT', 1, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200044, 200036, 'a', 'NONE', NULL, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200045, 200036, 'b', 'NONE', NULL, NULL, NULL, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000177, 200036, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000178, 200036, 2000177, 1, 'PARAMETER', 0, NULL, 200044, 200005);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000179, 200036, 2000177, 2, 'KEYWORD', 0, NULL, 200034);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000180, 200036, 2000177, 3, 'PARAMETER', 0, NULL, 200045, 200005);
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 200036, id, 'FULL', NULL FROM action WHERE code = 'OP_ADD';
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id, page) VALUES (200035, NULL, 1, 'Sum', NULL, '10 PRINT 741+852
20 END', '1593', 0, NULL, NULL);

-- ( ) (OPERATOR)
INSERT INTO entry (id, layer_id, name, category_id, operation, redefines_id, description, difference_notes, notes) VALUES (200036, 200001, '( )', 4, 'ADD', NULL, 'Parentheses: the formula inside is computed first.', NULL, NULL);
INSERT INTO entry_source (entry_id, source_id, page) VALUES (200036, 200001, '6');
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, return_min_inclusive, return_max_inclusive, precedence, associativity, operator_class_id, evidence) VALUES (200037, 200036, 1, NULL, NULL, NULL, 200001, '6', NULL, NULL, NULL, 1, 1, NULL, NULL, 8, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200046, 200037, 'f', 'NONE', NULL, NULL, 'Any formula.', 'MANUAL');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000181, 200037, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, text) VALUES (2000182, 200037, 2000181, 1, 'LITERAL', 0, NULL, '(');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000183, 200037, 2000181, 2, 'PARAMETER', 1, NULL, 200046, 200005);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, text) VALUES (2000184, 200037, 2000181, 3, 'LITERAL', 1, NULL, ')');
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id, page) VALUES (200036, NULL, 1, 'Parentheses', NULL, '10 LET X = (7+8)/3
20 PRINT X
30 END', '5', 0, 200001, '1');

-- = (OPERATOR)
INSERT INTO entry (id, layer_id, name, category_id, operation, redefines_id, description, difference_notes, notes) VALUES (200037, 200001, '=', 4, 'ADD', NULL, 'Equal: only in the relation of IF...THEN.', NULL, NULL);
INSERT INTO entry_source (entry_id, source_id, page) VALUES (200037, 200001, '12');
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, return_min_inclusive, return_max_inclusive, precedence, associativity, operator_class_id, evidence) VALUES (200038, 200037, 1, NULL, NULL, NULL, 200001, '12', NULL, NULL, NULL, 1, 1, 1, NULL, 6, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200047, 200038, 'a', 'NONE', NULL, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200048, 200038, 'b', 'NONE', NULL, NULL, NULL, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000185, 200038, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000186, 200038, 2000185, 1, 'PARAMETER', 0, NULL, 200047, 200005);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000187, 200038, 2000185, 2, 'KEYWORD', 0, NULL, 200039);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000188, 200038, 2000185, 3, 'PARAMETER', 0, NULL, 200048, 200005);
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 200038, id, 'FULL', NULL FROM action WHERE code = 'OP_EQ';
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id, page) VALUES (200037, NULL, 1, 'Equal', NULL, '10 LET A = 2
20 IF A = 2 THEN 50
30 PRINT "NO"
40 GO TO 99
50 PRINT "YES"
99 END', 'YES', 0, NULL, NULL);

-- <> (OPERATOR)
INSERT INTO entry (id, layer_id, name, category_id, operation, redefines_id, description, difference_notes, notes) VALUES (200038, 200001, '<>', 4, 'ADD', NULL, 'Not equal: only in the relation of IF...THEN.', NULL, NULL);
INSERT INTO entry_source (entry_id, source_id, page) VALUES (200038, 200001, '12');
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, return_min_inclusive, return_max_inclusive, precedence, associativity, operator_class_id, evidence) VALUES (200039, 200038, 1, NULL, NULL, NULL, 200001, '12', NULL, NULL, NULL, 1, 1, 1, NULL, 6, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200049, 200039, 'a', 'NONE', NULL, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200050, 200039, 'b', 'NONE', NULL, NULL, NULL, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000189, 200039, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000190, 200039, 2000189, 1, 'PARAMETER', 0, NULL, 200049, 200005);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000191, 200039, 2000189, 2, 'KEYWORD', 0, NULL, 200044);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000192, 200039, 2000189, 3, 'PARAMETER', 0, NULL, 200050, 200005);
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 200039, id, 'FULL', NULL FROM action WHERE code = 'OP_NE';

-- > (OPERATOR)
INSERT INTO entry (id, layer_id, name, category_id, operation, redefines_id, description, difference_notes, notes) VALUES (200039, 200001, '>', 4, 'ADD', NULL, 'Greater than: only in the relation of IF...THEN.', NULL, NULL);
INSERT INTO entry_source (entry_id, source_id, page) VALUES (200039, 200001, '12');
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, return_min_inclusive, return_max_inclusive, precedence, associativity, operator_class_id, evidence) VALUES (200040, 200039, 1, NULL, NULL, NULL, 200001, '12', NULL, NULL, NULL, 1, 1, 1, NULL, 6, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200051, 200040, 'a', 'NONE', NULL, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200052, 200040, 'b', 'NONE', NULL, NULL, NULL, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000193, 200040, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000194, 200040, 2000193, 1, 'PARAMETER', 0, NULL, 200051, 200005);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000195, 200040, 2000193, 2, 'KEYWORD', 0, NULL, 200042);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000196, 200040, 2000193, 3, 'PARAMETER', 0, NULL, 200052, 200005);
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 200040, id, 'FULL', NULL FROM action WHERE code = 'OP_GT';

-- >= (OPERATOR)
INSERT INTO entry (id, layer_id, name, category_id, operation, redefines_id, description, difference_notes, notes) VALUES (200040, 200001, '>=', 4, 'ADD', NULL, 'Greater than or equal: only in the relation of IF...THEN.', NULL, NULL);
INSERT INTO entry_source (entry_id, source_id, page) VALUES (200040, 200001, '12');
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, return_min_inclusive, return_max_inclusive, precedence, associativity, operator_class_id, evidence) VALUES (200041, 200040, 1, NULL, NULL, NULL, 200001, '12', NULL, NULL, NULL, 1, 1, 1, NULL, 6, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200053, 200041, 'a', 'NONE', NULL, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200054, 200041, 'b', 'NONE', NULL, NULL, NULL, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000197, 200041, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000198, 200041, 2000197, 1, 'PARAMETER', 0, NULL, 200053, 200005);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000199, 200041, 2000197, 2, 'KEYWORD', 0, NULL, 200043);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000200, 200041, 2000197, 3, 'PARAMETER', 0, NULL, 200054, 200005);
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 200041, id, 'FULL', NULL FROM action WHERE code = 'OP_GE';

-- < (OPERATOR)
INSERT INTO entry (id, layer_id, name, category_id, operation, redefines_id, description, difference_notes, notes) VALUES (200041, 200001, '<', 4, 'ADD', NULL, 'Less than: only in the relation of IF...THEN.', NULL, NULL);
INSERT INTO entry_source (entry_id, source_id, page) VALUES (200041, 200001, '12');
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, return_min_inclusive, return_max_inclusive, precedence, associativity, operator_class_id, evidence) VALUES (200042, 200041, 1, NULL, NULL, NULL, 200001, '12', NULL, NULL, NULL, 1, 1, 1, NULL, 6, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200055, 200042, 'a', 'NONE', NULL, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200056, 200042, 'b', 'NONE', NULL, NULL, NULL, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000201, 200042, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000202, 200042, 2000201, 1, 'PARAMETER', 0, NULL, 200055, 200005);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000203, 200042, 2000201, 2, 'KEYWORD', 0, NULL, 200040);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000204, 200042, 2000201, 3, 'PARAMETER', 0, NULL, 200056, 200005);
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 200042, id, 'FULL', NULL FROM action WHERE code = 'OP_LT';
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id, page) VALUES (200041, NULL, 1, 'Less than', NULL, '10 IF 1 < 2 THEN 40
20 PRINT "NO"
30 GO TO 99
40 PRINT "YES"
99 END', 'YES', 0, NULL, NULL);

-- <= (OPERATOR)
INSERT INTO entry (id, layer_id, name, category_id, operation, redefines_id, description, difference_notes, notes) VALUES (200042, 200001, '<=', 4, 'ADD', NULL, 'Less than or equal: only in the relation of IF...THEN.', NULL, NULL);
INSERT INTO entry_source (entry_id, source_id, page) VALUES (200042, 200001, '12');
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, return_min_inclusive, return_max_inclusive, precedence, associativity, operator_class_id, evidence) VALUES (200043, 200042, 1, NULL, NULL, NULL, 200001, '12', NULL, NULL, NULL, 1, 1, 1, NULL, 6, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200057, 200043, 'a', 'NONE', NULL, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200058, 200043, 'b', 'NONE', NULL, NULL, NULL, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000205, 200043, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000206, 200043, 2000205, 1, 'PARAMETER', 0, NULL, 200057, 200005);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000207, 200043, 2000205, 2, 'KEYWORD', 0, NULL, 200041);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000208, 200043, 2000205, 3, 'PARAMETER', 0, NULL, 200058, 200005);
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 200043, id, 'FULL', NULL FROM action WHERE code = 'OP_LE';

INSERT INTO reference (entry_id, related_entry_id, kind) VALUES (200009, 200010, 'OPENS_BLOCK');
INSERT INTO reference (entry_id, related_entry_id, kind) VALUES (200016, 200017, 'OPENS_BLOCK');
INSERT INTO reference (entry_id, related_entry_id, kind) VALUES (200014, 200015, 'SEE_ALSO');
INSERT INTO reference (entry_id, related_entry_id, kind) VALUES (200013, 200030, 'SEE_ALSO');
INSERT INTO reference (entry_id, related_entry_id, kind) VALUES (200011, 200012, 'SEE_ALSO');
INSERT INTO reference (entry_id, related_entry_id, kind) VALUES (200004, 200001, 'SEE_ALSO');
INSERT INTO open_question (layer_id, position, question) VALUES (200001, 1, 'Part II of the May 1964 manual is missing: GOSUB, RETURN, DIM, REM, RND, INT and the arrays are taken from the October 1964 manual. Kurtz [9] answers part of it (the four statements are DIM, GOSUB, RETURN, REM; lists from 1 to 10 without DIM; INT truncates), quoting the complete manual of June 1964, which is still to be found.');
INSERT INTO open_question (layer_id, position, question) VALUES (200001, 2, 'GOSUB in the 1st edition: the October 1964 manual says a GOSUB inside a subroutine does not work, Kurtz [9] that GOSUB used a stack for the return address. Which one is right for 1964?');
INSERT INTO open_question (layer_id, position, question) VALUES (200001, 3, 'Errors: the May manual shows only five messages; the others come from the October 1964 manual. The simulator DTSS-Win runs a compiler of February 1965 that already has 3rd edition behaviours (nested GOSUB, OUT OF DATA, LOG OF NEGATIVE NUMBER, SQUARE ROOT OF NEGATIVE NUMBER, the sign of (-2)↑3), so it cannot confirm the 1964 behaviour. Why does it print 1 for 1/0?');
INSERT INTO open_question (layer_id, position, question) VALUES (200001, 4, 'FOR: the May manual wants a single letter, the October manual any unsubscripted variable (FOR X1): was the 1st edition really stricter? Does a loop whose start is past the end run zero times, as in the October manual?');
INSERT INTO open_question (layer_id, position, question) VALUES (200001, 5, 'Variables and program in memory, internal character code of the GE-235: to be taken from the compiler listings BA-1..BA-3 [7].');
INSERT INTO open_question (layer_id, position, question) VALUES (200001, 6, 'DTSS-Win prints the round brackets of a label as square ones (`PRINT "()"` gives `[]`): does the GE-235 code of a label have no round brackets, or is it the simulator?');

-- ================= layer DARTMOUTH_2ED_layer
INSERT INTO table_status (table_kind_id, layer_id, status, notes) SELECT id, 200002, 'COMPLETE', 'As in the 1st edition.' FROM table_kind WHERE code = 'CHARACTER_CODES';
INSERT INTO table_status (table_kind_id, layer_id, status, notes) SELECT id, 200002, 'NOT_APPLICABLE', 'No statement reads the keyboard.' FROM table_kind WHERE code = 'KEYBOARD_CODES';
INSERT INTO table_status (table_kind_id, layer_id, status, notes) SELECT id, 200002, 'COMPLETE', 'Appendix A of [2] pp. 53-54 (22 messages, found while compiling: the program does not run, checked on DTSS-Win with `ILLEGAL FORMULA IN 20`); printed with the line number: `INCORRECT FORMAT IN 5` [2] p. 24. The compiler of February 1965 (DTSS-Win) also has run-time messages that do **not** stop the program: `SQUARE ROOT OF NEGATIVE NUMBER IN 20` is printed and the run goes on. Limits behind them, appendix B p. 55: about two feet of Teletype paper of program, 175 constants and printed labels, 300 data numbers, printed labels slightly under 600 characters in all, 26 FOR, 80 GO TO and IF-THEN, 1500 list and table elements.' FROM table_kind WHERE code = 'ERRORS';
INSERT INTO table_status (table_kind_id, layer_id, status, notes) SELECT id, 200002, 'COMPLETE', 'As in the 1st edition [2] p. 10.' FROM table_kind WHERE code = 'OPERATOR_PRECEDENCE';
INSERT INTO table_status (table_kind_id, layer_id, status, notes) SELECT id, 200002, 'TO_DO', 'To be taken from the listings [7].' FROM table_kind WHERE code = 'VARIABLE_LAYOUT';
INSERT INTO table_status (table_kind_id, layer_id, status, notes) SELECT id, 200002, 'TO_DO', 'To be taken from the listings [7].' FROM table_kind WHERE code = 'PROGRAM_LAYOUT';
INSERT INTO table_status (table_kind_id, layer_id, status, notes) SELECT id, 200002, 'NOT_APPLICABLE', 'No sound.' FROM table_kind WHERE code = 'MUSICAL_NOTES';
INSERT INTO variable_kind (id, layer_id, code, name, data_type_id, dimensions, name_rule, name_pattern, max_name_length, significant_chars, examples, notes, operation, redefines_id) VALUES (200004, 200002, 'LIST', 'List', 200001, 1, 'one letter followed by a subscript in parentheses', '^[A-Z]$', 1, 0, 'A(5), B(I+1)', 'Subscripts from **0** to 10 without DIM; DIM sets other upper limits. A letter can be a simple variable and a list at the same time, not a list and a table [2] pp. 36-38. Up to 1500 elements in all lists and tables.', 'REPLACE', 200002);
INSERT INTO variable_kind (id, layer_id, code, name, data_type_id, dimensions, name_rule, name_pattern, max_name_length, significant_chars, examples, notes, operation, redefines_id) VALUES (200005, 200002, 'TABLE', 'Table', 200001, 2, 'one letter followed by two subscripts in parentheses', '^[A-Z]$', 1, 0, 'B(0,0), M(I,J)', 'Subscripts from 0 to 10 in each dimension without DIM [2] p. 37.', 'REPLACE', 200003);
INSERT INTO feature (layer_id, feature_kind_id, value, verified, notes, operation, redefines_id) SELECT 200002, id, 'No', 1, 'A loop whose start is already past the final value runs zero times; the variable is then left at the first value minus one step: after `FOR Z = 2 TO -2` Z is 1 [2] p. 30. Checked on DTSS-Win (compiler of February 1965).', 'REPLACE', (SELECT f.id FROM feature f JOIN feature_kind k ON k.id = f.feature_kind_id WHERE f.layer_id = 200001 AND k.code = 'FOR_RUNS_ONCE') FROM feature_kind WHERE code = 'FOR_RUNS_ONCE';
INSERT INTO feature (layer_id, feature_kind_id, value, verified, notes, operation, redefines_id) SELECT 200002, id, '15 columns', 0, 'Five zones of 15 characters on a 75-character line [2] p. 31.', 'REPLACE', (SELECT f.id FROM feature f JOIN feature_kind k ON k.id = f.feature_kind_id WHERE f.layer_id = 200001 AND k.code = 'TAB_ZONE_WIDTH') FROM feature_kind WHERE code = 'TAB_ZONE_WIDTH';
INSERT INTO keyword (id, layer_id, text, notes) VALUES (200045, 200002, 'NEW', NULL);
INSERT INTO keyword (id, layer_id, text, notes) VALUES (200046, 200002, 'OLD', NULL);
INSERT INTO keyword (id, layer_id, text, notes) VALUES (200047, 200002, 'SCRATCH', NULL);
INSERT INTO keyword (id, layer_id, text, notes) VALUES (200048, 200002, 'RENAME', NULL);
INSERT INTO keyword (id, layer_id, text, notes) VALUES (200049, 200002, 'CATALOG', NULL);
INSERT INTO keyword (id, layer_id, text, notes) VALUES (200050, 200002, 'UNSAVE', NULL);
INSERT INTO keyword (id, layer_id, text, notes) VALUES (200051, 200002, ';', 'Packed output in PRINT.');

-- FOR...TO...STEP (STATEMENT)
INSERT INTO entry (id, layer_id, name, category_id, operation, redefines_id, description, difference_notes, notes) VALUES (200043, 200002, 'FOR...TO...STEP', 1, 'REPLACE', 200009, 'Starts a loop: the variable goes from the first value to the second in steps of 1 or of the STEP value.', 'The loop variable can be any unsubscripted variable (FOR X1).', 'If the first value is already past the final one the body is skipped: after `50 FOR Z = 2 TO -2` Z is 1, the first value minus the step [2] p. 30. At most 26 FOR in a program [2] p. 55.');
INSERT INTO entry_source (entry_id, source_id, page) VALUES (200043, 200002, '29-30, 56');
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, return_min_inclusive, return_max_inclusive, precedence, associativity, operator_class_id, evidence) VALUES (200044, 200043, 1, NULL, NULL, 'FOR <unsubscripted variable> = <expression> TO <expression> STEP <expression>', 200002, '29-30, 56', NULL, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200059, 200044, 'v', 'NONE', NULL, NULL, 'An unsubscripted variable: X, X1.', 'MANUAL');
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200060, 200044, 'f1', 'NONE', NULL, NULL, 'First value.', 'MANUAL');
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200061, 200044, 'f2', 'NONE', NULL, NULL, 'Final value.', 'MANUAL');
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200062, 200044, 'f3', 'NONE', NULL, NULL, 'Step; 1 when STEP is omitted; it can be negative or a fraction.', 'MANUAL');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000209, 200044, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000210, 200044, 2000209, 1, 'KEYWORD', 0, NULL, 200009);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000211, 200044, 2000209, 2, 'PARAMETER', 0, NULL, 200059, 200006);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000212, 200044, 2000209, 3, 'KEYWORD', 0, NULL, 200039);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000213, 200044, 2000209, 4, 'PARAMETER', 0, NULL, 200060, 200005);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000214, 200044, 2000209, 5, 'KEYWORD', 0, NULL, 200010);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000215, 200044, 2000209, 6, 'PARAMETER', 0, NULL, 200061, 200005);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000216, 200044, 2000209, 7, 'OPTIONAL', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000217, 200044, 2000216, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000218, 200044, 2000217, 1, 'KEYWORD', 0, NULL, 200011);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000219, 200044, 2000217, 2, 'PARAMETER', 0, NULL, 200062, 200005);
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 200044, id, 'FULL', NULL FROM action WHERE code = 'FLOW_FOR';
INSERT INTO entry_error (entry_id, form_id, parameter_id, error_code, operation, cause, verified, position) VALUES (200043, NULL, NULL, 'INCORRECT_FORMAT', 'ADD', 'The FOR is not written in its form ([1] p. 19, [2]).', 0, 1);
INSERT INTO entry_error (entry_id, form_id, parameter_id, error_code, operation, cause, verified, position) VALUES (200043, NULL, NULL, 'TOO_MANY_LOOPS', 'ADD', 'More than 26 FOR statements (from [2]).', 0, 2);
INSERT INTO entry_error (entry_id, form_id, parameter_id, error_code, operation, cause, verified, position) VALUES (200043, NULL, NULL, 'FOR_WITHOUT_NEXT', 'ADD', 'No NEXT closes the loop (from [2]).', 0, 3);
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id, page) VALUES (200043, NULL, 1, 'A loop run zero times', 'Z is the first value minus the step [2] p. 30. Checked on DTSS-Win (compiler of February 1965).', '10 FOR Z = 2 TO -2
20 NEXT Z
30 PRINT Z
40 END', '1', 1, NULL, NULL);
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id, page) VALUES (200043, NULL, 2, 'Loop variable with a digit', 'Checked on DTSS-Win (compiler of February 1965).', '10 FOR X1 = 1 TO 2
20 PRINT X1
30 NEXT X1
40 END', '1
2', 1, NULL, NULL);

-- NEXT (STATEMENT)
INSERT INTO entry (id, layer_id, name, category_id, operation, redefines_id, description, difference_notes, notes) VALUES (200044, 200002, 'NEXT', 1, 'REPLACE', 200010, 'Ends the loop of the FOR with the same variable.', 'Any unsubscripted variable.', NULL);
INSERT INTO entry_source (entry_id, source_id, page) VALUES (200044, 200002, '29, 56');
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, return_min_inclusive, return_max_inclusive, precedence, associativity, operator_class_id, evidence) VALUES (200045, 200044, 1, NULL, NULL, 'NEXT <unsubscripted variable>', 200002, '29, 56', NULL, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200063, 200045, 'v', 'NONE', NULL, NULL, 'The variable of the FOR: X, X1.', 'MANUAL');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000220, 200045, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000221, 200045, 2000220, 1, 'KEYWORD', 0, NULL, 200012);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000222, 200045, 2000220, 2, 'PARAMETER', 0, NULL, 200063, 200006);
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 200045, id, 'FULL', NULL FROM action WHERE code = 'FLOW_NEXT';
INSERT INTO entry_error (entry_id, form_id, parameter_id, error_code, operation, cause, verified, position) VALUES (200044, NULL, NULL, 'NOT_MATCH_WITH_FOR', 'ADD', 'Another variable than the FOR''s, or loops crossed (from [2]).', 0, 1);
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id, page) VALUES (200044, NULL, 1, 'Table of exponentials', NULL, '10 PRINT "X", "EXP(X)"
20 FOR X = 0 TO 20
30 PRINT X, EXP(X)
40 NEXT X
50 END', NULL, 0, 200001, '9');
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id, page) VALUES (200044, NULL, 2, 'Nested loops', 'From the DTSS-Win simulator files (BASLOP). Output checked on DTSS-Win (compiler of February 1965).', '10 FOR X = 1 TO 5 STEP 3
30 FOR Y = 1 TO X
40 PRINT X, Y
50 NEXT Y
60 NEXT X
70 END', ' 1              1
 4              1
 4              2
 4              3
 4              4', 1, 200008, 'BASLOP');

-- DATA (STATEMENT)
INSERT INTO entry (id, layer_id, name, category_id, operation, redefines_id, description, difference_notes, notes) VALUES (200045, 200002, 'DATA', 1, 'REPLACE', 200015, 'Numbers for READ, taken in the order of the DATA statements.', 'Up to 300 numbers.', 'Never executed: it can be anywhere. Up to 300 numbers in all [2] p. 55.');
INSERT INTO entry_source (entry_id, source_id, page) VALUES (200045, 200002, '27, 56');
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, return_min_inclusive, return_max_inclusive, precedence, associativity, operator_class_id, evidence) VALUES (200046, 200045, 1, NULL, NULL, 'DATA 1, 2, 3', 200002, '27, 56', NULL, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200064, 200046, 'number', 'NONE', NULL, NULL, 'Numbers separated by commas, as many as fit on the line.', 'MANUAL');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000223, 200046, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000224, 200046, 2000223, 1, 'KEYWORD', 0, NULL, 200019);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, separator, min_occ, max_occ) VALUES (2000225, 200046, 2000223, 2, 'REPEAT', 0, NULL, ',', 1, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000226, 200046, 2000225, 1, 'PARAMETER', 0, NULL, 200064, 200001);
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 200046, id, 'FULL', NULL FROM action WHERE code = 'DATA_DEFINE';
INSERT INTO entry_error (entry_id, form_id, parameter_id, error_code, operation, cause, verified, position) VALUES (200045, NULL, NULL, 'TOO_MUCH_DATA', 'ADD', 'More numbers than the limit (200 in [1] p. 14).', 0, 1);
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id, page) VALUES (200045, NULL, 1, 'Order of the data', 'A = 1, B = 2, C = 3, D1 = 4, ..., D4 = 7.', '10 READ A, B, C
20 READ D1, D2, D3, D4
30 PRINT A, D4
80 DATA 1, 2, 3, 4, 5, 6
90 DATA 7, 8, 9, 10
99 END', '1             7', 0, 200001, '14');
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id, page) VALUES (200045, NULL, 2, 'Life of a mortgage', 'From the DTSS-Win simulator files (LIB/MORT). DATA lines interleaved with REM lines; the typing slip COMOPUTER is in the original. Output checked on DTSS-Win (compiler of February 1965). The run prints 291 lines (to 1988): only the first and last lines are shown, the dots stand for the rest.', '1 REM MORTGAGE COMOPUTER
2 REM YEARLY INTEREST RATE
10 DATA 0.05
15 REM INITIAL PRINCIPAL
20 DATA 28500
25 REM MONTHLY PAYMENT
30 DATA 170
35 REM STARTING MONTH AND YEAR
40 DATA 1, 1964
50 READ I, P, P1, M, Y
60 LET R = 1 + I/12
70 PRINT "YEAR", "PRINCIPAL"
80 PRINT Y, P
90 LET P = P*R - P1
100 IF P >= 0 THEN 120
110 LET P = 0
120 LET M = M + 1
130 IF M > 12 THEN 160
140 PRINT "       ",
150 GO TO 190
160 LET M = 1
170 LET Y = Y + 1
180 PRINT Y,
190 PRINT INT(P)
200 IF P > 0 THEN 90
210 END', 'YEAR           PRINCIPAL
 1964           28500
                28448
                28397
                28345
                28293
                28241
                28189
                28136
                28083
                28030
                27977
                27924
 1965           27870
...
                736
                569
                401
                233
 1988           64
                0', 1, 200008, 'LIB/MORT');

-- NEW (COMMAND)
INSERT INTO entry (id, layer_id, name, category_id, operation, redefines_id, description, difference_notes, notes) VALUES (200046, 200002, 'NEW', 2, 'ADD', NULL, 'Erases the current program and asks for a new problem name.', NULL, NULL);
INSERT INTO entry_source (entry_id, source_id, page) VALUES (200046, 200002, '20');
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, return_min_inclusive, return_max_inclusive, precedence, associativity, operator_class_id, evidence) VALUES (200047, 200046, 1, NULL, NULL, 'NEW', 200002, '20', NULL, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000227, 200047, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000228, 200047, 2000227, 1, 'KEYWORD', 0, NULL, 200045);
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 200047, id, 'FULL', NULL FROM action WHERE code = 'PROG_NEW';

-- OLD (COMMAND)
INSERT INTO entry (id, layer_id, name, category_id, operation, redefines_id, description, difference_notes, notes) VALUES (200047, 200002, 'OLD', 2, 'ADD', NULL, 'Brings back a saved program.', NULL, 'In the May 1964 manual OLD is only the answer to the question TYPE OR OLD of HELLO; in October HELLO asks NEW OR OLD [2] p. 19.');
INSERT INTO entry_source (entry_id, source_id, page) VALUES (200047, 200002, '20');
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, return_min_inclusive, return_max_inclusive, precedence, associativity, operator_class_id, evidence) VALUES (200048, 200047, 1, NULL, NULL, 'OLD', 200002, '20', NULL, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000229, 200048, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000230, 200048, 2000229, 1, 'KEYWORD', 0, NULL, 200046);
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 200048, id, 'FULL', 'From the disk of the time-sharing system' FROM action WHERE code = 'TAPE_LOAD';

-- SCRATCH (COMMAND)
INSERT INTO entry (id, layer_id, name, category_id, operation, redefines_id, description, difference_notes, notes) VALUES (200048, 200002, 'SCRATCH', 2, 'ADD', NULL, 'Erases the current program but keeps its problem name.', NULL, NULL);
INSERT INTO entry_source (entry_id, source_id, page) VALUES (200048, 200002, '20');
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, return_min_inclusive, return_max_inclusive, precedence, associativity, operator_class_id, evidence) VALUES (200049, 200048, 1, NULL, NULL, 'SCRATCH', 200002, '20', NULL, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000231, 200049, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000232, 200049, 2000231, 1, 'KEYWORD', 0, NULL, 200047);
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 200049, id, 'PARTIAL', 'Keeps the name' FROM action WHERE code = 'PROG_NEW';

-- RENAME (COMMAND)
INSERT INTO entry (id, layer_id, name, category_id, operation, redefines_id, description, difference_notes, notes) VALUES (200049, 200002, 'RENAME', 2, 'ADD', NULL, 'Gives the current program a new problem name without erasing it.', NULL, NULL);
INSERT INTO entry_source (entry_id, source_id, page) VALUES (200049, 200002, '20');
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, return_min_inclusive, return_max_inclusive, precedence, associativity, operator_class_id, evidence) VALUES (200050, 200049, 1, NULL, NULL, 'RENAME', 200002, '20', NULL, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000233, 200050, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000234, 200050, 2000233, 1, 'KEYWORD', 0, NULL, 200048);
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 200050, id, 'FULL', NULL FROM action WHERE code = 'PROG_RENAME';

-- CATALOG (COMMAND)
INSERT INTO entry (id, layer_id, name, category_id, operation, redefines_id, description, difference_notes, notes) VALUES (200050, 200002, 'CATALOG', 2, 'ADD', NULL, 'Lists the saved programs of the user.', NULL, NULL);
INSERT INTO entry_source (entry_id, source_id, page) VALUES (200050, 200002, '20');
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, return_min_inclusive, return_max_inclusive, precedence, associativity, operator_class_id, evidence) VALUES (200051, 200050, 1, NULL, NULL, 'CATALOG', 200002, '20', NULL, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000235, 200051, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000236, 200051, 2000235, 1, 'KEYWORD', 0, NULL, 200049);
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 200051, id, 'FULL', NULL FROM action WHERE code = 'DISK_DIRECTORY';
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id, page) VALUES (200050, NULL, 1, 'Saved programs', NULL, 'CATALOG', NULL, 0, NULL, NULL);

-- UNSAVE (COMMAND)
INSERT INTO entry (id, layer_id, name, category_id, operation, redefines_id, description, difference_notes, notes) VALUES (200051, 200002, 'UNSAVE', 2, 'ADD', NULL, 'Deletes the saved program from the disk.', NULL, 'Users are asked to unsave the programs they no longer need.');
INSERT INTO entry_source (entry_id, source_id, page) VALUES (200051, 200002, '20');
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, return_min_inclusive, return_max_inclusive, precedence, associativity, operator_class_id, evidence) VALUES (200052, 200051, 1, NULL, NULL, 'UNSAVE', 200002, '20', NULL, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000237, 200052, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000238, 200052, 2000237, 1, 'KEYWORD', 0, NULL, 200050);
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 200052, id, 'FULL', NULL FROM action WHERE code = 'DISK_DELETE';

-- LIST (COMMAND)
INSERT INTO entry (id, layer_id, name, category_id, operation, redefines_id, description, difference_notes, notes) VALUES (200052, 200002, 'LIST', 2, 'REPLACE', 200003, 'Types the current version of the program.', 'Can start from a given line (LIST-n).', 'Typing S stops the listing.');
INSERT INTO entry_source (entry_id, source_id, page) VALUES (200052, 200002, '20');
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, return_min_inclusive, return_max_inclusive, precedence, associativity, operator_class_id, evidence) VALUES (200053, 200052, 1, NULL, NULL, 'LIST - XXXXX', 200002, '20', NULL, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200065, 200053, 'n', 'NONE', NULL, NULL, 'First line to list.', 'MANUAL');
INSERT INTO parameter_limit (parameter_id, minimum, maximum, notes, min_inclusive, max_inclusive, evidence) VALUES (200065, 1, 99999, NULL, 1, 1, 'MANUAL');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000239, 200053, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000240, 200053, 2000239, 1, 'KEYWORD', 0, NULL, 200003);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000241, 200053, 2000239, 2, 'OPTIONAL', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000242, 200053, 2000241, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, text) VALUES (2000243, 200053, 2000242, 1, 'LITERAL', 0, NULL, '-');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000244, 200053, 2000242, 2, 'PARAMETER', 1, NULL, 200065, 200002);
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 200053, id, 'FULL', NULL FROM action WHERE code = 'PROG_LIST';
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id, page) VALUES (200052, NULL, 1, 'List from a line', 'The program from line 100 on.', 'LIST-100', NULL, 0, 200002, '18');

-- STOP (STATEMENT)
INSERT INTO entry (id, layer_id, name, category_id, operation, redefines_id, description, difference_notes, notes) VALUES (200053, 200002, 'STOP', 1, 'ADD', NULL, 'Stops the program.', NULL, 'It can replace a GO TO the END line where a program has several ends [2] p. 45.');
INSERT INTO entry_source (entry_id, source_id, page) VALUES (200053, 200002, '45');
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, return_min_inclusive, return_max_inclusive, precedence, associativity, operator_class_id, evidence) VALUES (200054, 200053, 1, NULL, NULL, 'STOP', 200002, '45', NULL, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000245, 200054, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000246, 200054, 2000245, 1, 'KEYWORD', 0, NULL, 200005);
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 200054, id, 'FULL', NULL FROM action WHERE code = 'FLOW_STOP';
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id, page) VALUES (200053, NULL, 1, 'Two ends', NULL, '10 READ X
20 IF X < 0 THEN 50
30 PRINT SQR(X)
40 STOP
50 PRINT "NEGATIVE"
60 DATA 16
99 END', '4', 0, NULL, NULL);
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id, page) VALUES (200053, NULL, 2, 'Compiling long expressions', 'From the DTSS-Win simulator files (BASTIM). A test of the compiler: STOP ends the run before the long LETs, which are only compiled. Output checked on DTSS-Win (compiler of February 1965): it prints nothing.', '005 STOP
010 LET X = X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X
020 LET X = X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X
030 LET X = X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X
040 LET X = X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X
999 END', NULL, 1, 200008, 'BASTIM');

-- PRINT (STATEMENT)
INSERT INTO entry (id, layer_id, name, category_id, operation, redefines_id, description, difference_notes, notes) VALUES (200054, 200002, 'PRINT', 1, 'REPLACE', 200007, 'Types the values of formulas and labels on a line.', 'The semicolon packs the output: the next item starts at the next multiple of three characters.', 'Numbers: up to six significant digits, integers in full up to nine digits, no trailing zeros, numbers below 0.1 as `X.XXXXXE-Y` unless they fit in six decimal places; integers without a decimal point [2] pp. 31-35. On DTSS-Win (compiler of February 1965) the exponent is printed after a space (`5.82077 E-9`, `1.71799 E 8`), and a value that rounds to an integer without being one keeps the point (`1.`, `-45.`).');
INSERT INTO entry_source (entry_id, source_id, page) VALUES (200054, 200002, '31-35');
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, return_min_inclusive, return_max_inclusive, precedence, associativity, operator_class_id, evidence) VALUES (200055, 200054, 1, NULL, ''','' moves to the next zone of 15 characters (after the fifth, to the next line); '';'' moves to the next multiple of three characters, at least six per number. A PRINT ending with a comma or semicolon does not end the line; PRINT alone skips a line.', 'PRINT', 200002, '31-35', NULL, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200066, 200055, 'label', 'NONE', NULL, NULL, 'Text in quotes, typed as it is; it fills whole zones.', 'MANUAL');
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200067, 200055, 'formula', 'NONE', NULL, NULL, 'Any formula: its value is typed.', 'MANUAL');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000247, 200055, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000248, 200055, 2000247, 1, 'KEYWORD', 0, NULL, 200007);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000249, 200055, 2000247, 2, 'OPTIONAL', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000250, 200055, 2000249, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000251, 200055, 2000250, 1, 'CHOICE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000252, 200055, 2000251, 1, 'PARAMETER', 0, NULL, 200066, 200003);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000253, 200055, 2000251, 2, 'PARAMETER', 0, NULL, 200067, 200005);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000254, 200055, 2000251, 3, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000255, 200055, 2000254, 1, 'PARAMETER', 0, NULL, 200066, 200003);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000256, 200055, 2000254, 2, 'PARAMETER', 0, NULL, 200067, 200005);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, separator, min_occ, max_occ) VALUES (2000257, 200055, 2000250, 2, 'REPEAT', 0, NULL, NULL, 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000258, 200055, 2000257, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000259, 200055, 2000258, 1, 'CHOICE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, text) VALUES (2000260, 200055, 2000259, 1, 'LITERAL', 0, NULL, ',');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, text) VALUES (2000261, 200055, 2000259, 2, 'LITERAL', 0, NULL, ';');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000262, 200055, 2000258, 2, 'CHOICE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000263, 200055, 2000262, 1, 'PARAMETER', 0, NULL, 200066, 200003);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000264, 200055, 2000262, 2, 'PARAMETER', 0, NULL, 200067, 200005);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000265, 200055, 2000262, 3, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000266, 200055, 2000265, 1, 'PARAMETER', 0, NULL, 200066, 200003);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000267, 200055, 2000265, 2, 'PARAMETER', 0, NULL, 200067, 200005);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000268, 200055, 2000250, 3, 'OPTIONAL', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000269, 200055, 2000268, 1, 'CHOICE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, text) VALUES (2000270, 200055, 2000269, 1, 'LITERAL', 0, NULL, ',');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, text) VALUES (2000271, 200055, 2000269, 2, 'LITERAL', 0, NULL, ';');
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 200055, id, 'FULL', NULL FROM action WHERE code = 'IO_PRINT';
INSERT INTO entry_error (entry_id, form_id, parameter_id, error_code, operation, cause, verified, position) VALUES (200054, NULL, NULL, 'TOO_MANY_LABELS', 'ADD', 'The labels of the program are too long altogether (from [2]).', 0, 1);
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id, page) VALUES (200054, NULL, 1, 'Zones and packed output', 'Comma: zones of 15; semicolon: multiples of 3.', '10 PRINT 1, 2, 3
20 PRINT 1; 2; 3
30 END', ' 1             2             3
 1    2    3', 0, NULL, NULL);
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id, page) VALUES (200054, NULL, 2, 'Element 0 of a list', 'Subscripts start at 0 from the 2nd edition. Checked on DTSS-Win (compiler of February 1965).', '10 DIM A(5)
20 LET A(0) = 1
30 PRINT A(0)
40 END', '1', 1, NULL, NULL);
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id, page) VALUES (200054, NULL, 3, 'Semicolon', 'From the DTSS-Win simulator files (BASSEM). Output checked on DTSS-Win (compiler of February 1965).', '10 PRINT 2; 3
20 END', ' 2     3', 1, 200008, 'BASSEM');
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id, page) VALUES (200054, NULL, 4, 'A list from element 0', 'From the DTSS-Win simulator files (BASLIS). Element 0 and the default size of 10, without DIM. Output checked on DTSS-Win (compiler of February 1965).', '10 FOR I = 0 TO 10
20 LET X(I) = I
30 NEXT I
40 FOR I = 0 TO 10
50 PRINT X(I);
60 NEXT I
70 END', ' 0     1     2     3     4     5     6     7     8     9     10', 1, 200008, 'BASLIS');
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id, page) VALUES (200054, NULL, 5, 'Plot of the normal curve', 'From the DTSS-Win simulator files (LIB/NORMAL). The file writes the power as ^, the ASCII character with the code of ↑ (94). Lines 110 and 130 are empty. Output checked on DTSS-Win (compiler of February 1965). Only 40 lines for the 41 values from -2 to 2: the sum of the steps of .1 passes 2 by a little, so the last value is lost.', '100 REM PLOT A NORMAL DISTRIBUTION CURVE
110
120 DEF FNN(X) = EXP(-(X↑2/2))/SQR(2*3.14159265)
130
140 FOR X = -2 TO 2 STEP .1
150 LET Y = FNN(X)
160 LET Y = INT(100*Y)
170 FOR Z = 1 TO Y
180 PRINT " ";
190 NEXT Z
200 PRINT "*"
210 NEXT X
220 END', '     *
      *
       *
         *
           *
            *
              *
                 *
                   *
                     *
                        *
                          *
                            *
                               *
                                 *
                                   *
                                    *
                                      *
                                       *
                                       *
                                       *
                                       *
                                       *
                                      *
                                    *
                                   *
                                 *
                               *
                            *
                          *
                        *
                     *
                   *
                 *
              *
            *
           *
         *
       *
      *', 1, 200008, 'LIB/NORMAL');

INSERT INTO reference (entry_id, related_entry_id, kind) VALUES (200053, 200008, 'SEE_ALSO');
INSERT INTO reference (entry_id, related_entry_id, kind) VALUES (200004, 200051, 'SEE_ALSO');
INSERT INTO reference (entry_id, related_entry_id, kind) VALUES (200046, 200048, 'SEE_ALSO');
INSERT INTO reference (entry_id, related_entry_id, kind) VALUES (200047, 200004, 'SEE_ALSO');
INSERT INTO open_question (layer_id, position, question) VALUES (200002, 1, 'Card BASIC (chapter IV of the October 1964 manual: PAGE, MAT, relations EQU LSS ...) is not entered: is it worth a dialect of its own?');

-- ================= layer DARTMOUTH_3ED_layer
INSERT INTO table_status (table_kind_id, layer_id, status, notes) SELECT id, 200003, 'COMPLETE', 'As in the 1st edition.' FROM table_kind WHERE code = 'CHARACTER_CODES';
INSERT INTO table_status (table_kind_id, layer_id, status, notes) SELECT id, 200003, 'NOT_APPLICABLE', 'INPUT reads whole lines.' FROM table_kind WHERE code = 'KEYBOARD_CODES';
INSERT INTO table_status (table_kind_id, layer_id, status, notes) SELECT id, 200003, 'COMPLETE', 'From the GE manual [3] appendix A: compile-time messages and run-time messages; some run-time errors only print a message and the program goes on.' FROM table_kind WHERE code = 'ERRORS';
INSERT INTO table_status (table_kind_id, layer_id, status, notes) SELECT id, 200003, 'COMPLETE', 'The change of sign now comes after the power (source [5]).' FROM table_kind WHERE code = 'OPERATOR_PRECEDENCE';
INSERT INTO table_status (table_kind_id, layer_id, status, notes) SELECT id, 200003, 'TO_DO', 'Not documented.' FROM table_kind WHERE code = 'VARIABLE_LAYOUT';
INSERT INTO table_status (table_kind_id, layer_id, status, notes) SELECT id, 200003, 'TO_DO', 'Not documented.' FROM table_kind WHERE code = 'PROGRAM_LAYOUT';
INSERT INTO table_status (table_kind_id, layer_id, status, notes) SELECT id, 200003, 'NOT_APPLICABLE', 'No sound.' FROM table_kind WHERE code = 'MUSICAL_NOTES';
INSERT INTO parameter_kind (id, layer_id, code, name, nature, type_class_id, variable_kind_id, notes, operation, redefines_id) VALUES (200013, 200003, 'MATRIX_NAME', 'Matrix name', 'ARRAY_NAME', NULL, NULL, 'A list (vector) or table (matrix): one letter.', 'ADD', NULL);
INSERT INTO feature (layer_id, feature_kind_id, value, verified, notes, operation, redefines_id) SELECT 200003, id, 'Not stated', 0, 'INT now gives the largest integer not greater than the argument (floor) [3] p. 25.', 'REPLACE', (SELECT f.id FROM feature f JOIN feature_kind k ON k.id = f.feature_kind_id WHERE f.layer_id = 200001 AND k.code = 'INTEGER_CONVERSION') FROM feature_kind WHERE code = 'INTEGER_CONVERSION';
INSERT INTO error (id, layer_id, code, message, operation, redefines_id, description) VALUES (200023, 200003, 'OUT_OF_DATA', 'OUT OF DATA', 'ADD', NULL, 'READ finds no data left: the program stops [3] p. 36.');
INSERT INTO error (id, layer_id, code, message, operation, redefines_id, description) VALUES (200024, 200003, 'RETURN_BEFORE_GOSUB', 'RETURN BEFORE GOSUB', 'ADD', NULL, 'RETURN with no GOSUB to go back to [3] p. 36.');
INSERT INTO error (id, layer_id, code, message, operation, redefines_id) VALUES (200025, 200003, 'ILLEGAL_RETURN', 'ILLEGAL RETURN', 'REMOVE', 200022);
INSERT INTO error (id, layer_id, code, message, operation, redefines_id) VALUES (200026, 200003, 'TOO_MANY_LABELS', 'TOO MANY LABELS', 'REMOVE', 200016);
INSERT INTO error (id, layer_id, code, message, operation, redefines_id, description) VALUES (200027, 200003, 'GOSUB_TOO_DEEP', 'GOSUB NESTED TOO DEEPLY', 'ADD', NULL, 'Too many GOSUB without RETURN [3] p. 36.');
INSERT INTO error (id, layer_id, code, message, operation, redefines_id, description) VALUES (200028, 200003, 'DIVISION_BY_ZERO', 'DIVISION BY ZERO', 'ADD', NULL, 'The program goes on with the largest number as the result [3] p. 36.');
INSERT INTO error (id, layer_id, code, message, operation, redefines_id, description) VALUES (200029, 200003, 'DIMENSION_ERROR', 'DIMENSION ERROR', 'ADD', NULL, 'Dimensions of the matrices of a MAT statement that do not agree [3] p. 36.');
INSERT INTO error (id, layer_id, code, message, operation, redefines_id, description) VALUES (200030, 200003, 'NEARLY_SINGULAR', 'NEARLY SINGULAR MATRIX', 'ADD', NULL, 'MAT INV of a matrix that has (almost) no inverse [3] p. 37.');
INSERT INTO error (id, layer_id, code, message, operation, redefines_id, description) VALUES (200031, 200003, 'ZERO_NEGATIVE_POWER', 'ZERO TO A NEGATIVE POWER', 'ADD', NULL, '[3] p. 37.');
INSERT INTO error (id, layer_id, code, message, operation, redefines_id, description) VALUES (200032, 200003, 'ABS_RAISED_TO_POWER', 'ABSOLUTE VALUE RAISED TO POWER', 'ADD', NULL, 'A negative base with a non-integer exponent: the absolute value is used and the program goes on [3] p. 37.');
INSERT INTO error (id, layer_id, code, message, operation, redefines_id, description) VALUES (200033, 200003, 'OVERFLOW', 'OVERFLOW', 'ADD', NULL, 'A result of about 5.78960E76 or more [3] p. 37.');
INSERT INTO error (id, layer_id, code, message, operation, redefines_id, description) VALUES (200034, 200003, 'UNDERFLOW', 'UNDERFLOW', 'ADD', NULL, 'A result smaller than about 4.31809E-78: it becomes 0 [3] p. 37.');
INSERT INTO error (id, layer_id, code, message, operation, redefines_id, description) VALUES (200035, 200003, 'EXP_TOO_LARGE', 'EXP TOO LARGE', 'ADD', NULL, '[3] p. 37.');
INSERT INTO error (id, layer_id, code, message, operation, redefines_id, description) VALUES (200036, 200003, 'LOG_NEGATIVE', 'LOG OF NEGATIVE NUMBER', 'ADD', NULL, 'The logarithm of the absolute value is used [3] p. 37.');
INSERT INTO error (id, layer_id, code, message, operation, redefines_id, description) VALUES (200037, 200003, 'LOG_ZERO', 'LOG OF ZERO', 'ADD', NULL, '[3] p. 37.');
INSERT INTO error (id, layer_id, code, message, operation, redefines_id, description) VALUES (200038, 200003, 'SQR_NEGATIVE', 'SQUARE ROOT OF A NEGATIVE NUMBER', 'ADD', NULL, 'The root of the absolute value is used [3] p. 37.');
INSERT INTO error_rule (layer_id, selector, selector_value, error_code, cause, verified) VALUES (200003, 'OPERATOR_CLASS', 'ARITHMETIC', 'OVERFLOW', 'The result is too large.', 0);
INSERT INTO error_rule (layer_id, selector, selector_value, error_code, cause, verified) VALUES (200003, 'OPERATOR_CLASS', 'ARITHMETIC', 'UNDERFLOW', 'The result is too small: it becomes 0.', 0);
INSERT INTO keyword (id, layer_id, text, notes) VALUES (200052, 200003, 'INPUT', NULL);
INSERT INTO keyword (id, layer_id, text, notes) VALUES (200053, 200003, 'RESTORE', NULL);
INSERT INTO keyword (id, layer_id, text, notes) VALUES (200054, 200003, 'SGN', NULL);
INSERT INTO keyword (id, layer_id, text, notes) VALUES (200055, 200003, 'MAT', 'Starts every matrix statement.');
INSERT INTO keyword (id, layer_id, text, notes) VALUES (200056, 200003, 'ZER', NULL);
INSERT INTO keyword (id, layer_id, text, notes) VALUES (200057, 200003, 'CON', NULL);
INSERT INTO keyword (id, layer_id, text, notes) VALUES (200058, 200003, 'IDN', NULL);
INSERT INTO keyword (id, layer_id, text, notes) VALUES (200059, 200003, 'TRN', NULL);
INSERT INTO keyword (id, layer_id, text, notes) VALUES (200060, 200003, 'INV', NULL);
INSERT INTO keyword (id, layer_id, text, notes) VALUES (200061, 200003, 'LENGTH', NULL);
INSERT INTO keyword (id, layer_id, text, notes) VALUES (200062, 200003, 'SYSTEM', NULL);

-- LENGTH (COMMAND)
INSERT INTO entry (id, layer_id, name, category_id, operation, redefines_id, description, difference_notes, notes) VALUES (200055, 200003, 'LENGTH', 2, 'ADD', NULL, 'Tells the length of the program, in characters.', NULL, 'From the GE manual [3] appendix C (programs up to 6400 characters).');
INSERT INTO entry_source (entry_id, source_id, page) VALUES (200055, 200003, '41');
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, return_min_inclusive, return_max_inclusive, precedence, associativity, operator_class_id, evidence) VALUES (200056, 200055, 1, NULL, NULL, 'LENGTH', 200003, '41', NULL, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000272, 200056, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000273, 200056, 2000272, 1, 'KEYWORD', 0, NULL, 200061);
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 200056, id, 'FULL', NULL FROM action WHERE code = 'PROG_LENGTH';

-- SYSTEM (COMMAND)
INSERT INTO entry (id, layer_id, name, category_id, operation, redefines_id, description, difference_notes, notes) VALUES (200056, 200003, 'SYSTEM', 2, 'ADD', NULL, 'Chooses the language system (BASIC or ALGOL).', NULL, 'From the GE manual [3] appendix C.');
INSERT INTO entry_source (entry_id, source_id, page) VALUES (200056, 200003, '41');
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, return_min_inclusive, return_max_inclusive, precedence, associativity, operator_class_id, evidence) VALUES (200057, 200056, 1, NULL, NULL, 'SYSTEM', 200003, '41', NULL, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000274, 200057, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000275, 200057, 2000274, 1, 'KEYWORD', 0, NULL, 200062);
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 200057, id, 'FULL', NULL FROM action WHERE code = 'SYSTEM_SELECT';

-- INPUT (STATEMENT)
INSERT INTO entry (id, layer_id, name, category_id, operation, redefines_id, description, difference_notes, notes) VALUES (200057, 200003, 'INPUT', 1, 'ADD', NULL, 'Types a question mark and waits for values typed at the Teletype.', NULL, 'New in the 3rd edition [5]: for the first time a program can ask for data while it runs. The listings of February 1965 [7] already have it. DTSS-Win (compiler of February 1965) answers a value it cannot read with `INPUT DATA NOT IN CORRECT FORMAT. RETYPE IT.` and a new question mark (seen in LIB/GUESS).');
INSERT INTO entry_source (entry_id, source_id, page) VALUES (200057, 200003, '29-30');
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, return_min_inclusive, return_max_inclusive, precedence, associativity, operator_class_id, evidence) VALUES (200058, 200057, 1, NULL, NULL, 'INPUT X, Y', 200003, '29-30', NULL, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200068, 200058, 'variable', 'NONE', NULL, NULL, 'Variables or elements, separated by commas; the values are typed the same way.', 'MANUAL');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000276, 200058, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000277, 200058, 2000276, 1, 'KEYWORD', 0, NULL, 200052);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, separator, min_occ, max_occ) VALUES (2000278, 200058, 2000276, 2, 'REPEAT', 0, NULL, ',', 1, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000279, 200058, 2000278, 1, 'PARAMETER', 0, NULL, 200068, 200009);
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 200058, id, 'FULL', NULL FROM action WHERE code = 'IO_INPUT';
INSERT INTO entry_error (entry_id, form_id, parameter_id, error_code, operation, cause, verified, position) VALUES (200057, NULL, NULL, 'ILLEGAL_VARIABLE', 'ADD', 'An item of the list is not a variable.', 0, 1);
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id, page) VALUES (200057, NULL, 1, 'Ask for two numbers', 'Type 2, 3 and RETURN: 5 is printed.', '10 INPUT A, B
20 PRINT A+B
30 END', '?', 0, NULL, NULL);
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id, page) VALUES (200057, NULL, 2, 'Ask for a move', 'From the DTSS-Win simulator files (BASINP). Output checked on DTSS-Win (compiler of February 1965).', '10 PRINT "YOUR MOVE";
20 INPUT N
30 PRINT N
40 END', 'YOUR MOVE? 42

 42', 1, 200008, 'BASINP');
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id, page) VALUES (200057, NULL, 3, 'Guess a number', 'From the DTSS-Win simulator files (LIB/GUESS). Output checked on DTSS-Win (compiler of February 1965). One game, with the guesses 50 and 75 typed by the editor; the run was left at the last INPUT. The prompt of line 310 is printed with square brackets, `[YES = 1, NO = 0]`, although the program has round ones (DTSS-Win prints every round bracket of a label as a square one). The number to guess is 75 at the start of every RUN, and the second game of the same run asks for 20: RND gives the same sequence on every run.', '100 REM GUESSING GAME
110
120 PRINT "GUESS THE NUMBER BETWEEN 1 AND 100."
130
140 LET X = INT(100*RND(0)+1)
150 LET N = 0
160 PRINT "YOUR GUESS";
170 INPUT G
180 LET N = N+1
190 IF G = X THEN 300
200 IF G < X THEN 250
210 PRINT "TOO LARGE, GUESS AGAIN"
220 GOTO 160
230
250 PRINT "TOO SMALL, GUESS AGAIN"
260 GOTO 160
270
300 PRINT "YOU GUESSED IT, IN"; N; "TRIES"
310 PRINT "ANOTHER GAME (YES = 1, NO = 0)";
320 INPUT A
330 IF A = 1 THEN 140
340 PRINT "THANKS FOR PLAYING"
350 END', 'GUESS THE NUMBER BETWEEN 1 AND 100.
YOUR GUESS? 50

TOO SMALL, GUESS AGAIN
YOUR GUESS? 75

YOU GUESSED IT, IN 2    TRIES
ANOTHER GAME [YES = 1, NO = 0]?', 1, 200008, 'LIB/GUESS');

-- RESTORE (STATEMENT)
INSERT INTO entry (id, layer_id, name, category_id, operation, redefines_id, description, difference_notes, notes) VALUES (200058, 200003, 'RESTORE', 1, 'ADD', NULL, 'Starts the data list again: the next READ takes the first number.', NULL, NULL);
INSERT INTO entry_source (entry_id, source_id, page) VALUES (200058, 200003, '30');
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, return_min_inclusive, return_max_inclusive, precedence, associativity, operator_class_id, evidence) VALUES (200059, 200058, 1, NULL, NULL, 'RESTORE', 200003, '30', NULL, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000280, 200059, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000281, 200059, 2000280, 1, 'KEYWORD', 0, NULL, 200053);
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 200059, id, 'FULL', NULL FROM action WHERE code = 'DATA_RESTORE';
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id, page) VALUES (200058, NULL, 1, 'Read the data twice', NULL, '10 READ A, B
20 RESTORE
30 READ C
40 PRINT A, B, C
50 DATA 1, 2
60 END', '1             2             1', 0, NULL, NULL);

-- SGN (FUNCTION)
INSERT INTO entry (id, layer_id, name, category_id, operation, redefines_id, description, difference_notes, notes) VALUES (200059, 200003, 'SGN', 3, 'ADD', NULL, 'Sign of the argument: 1, 0 or -1.', NULL, 'Added in the 3rd edition according to source [5]; the GE manual [3] does not list it.');
INSERT INTO entry_source (entry_id, source_id, page) VALUES (200059, 200005, NULL);
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, return_min_inclusive, return_max_inclusive, precedence, associativity, operator_class_id, evidence) VALUES (200060, 200059, 1, NULL, NULL, 'SGN(X)', 200005, NULL, 200001, -1, 1, 1, 1, NULL, NULL, NULL, 'MANUAL');
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200069, 200060, 'x', 'NONE', NULL, NULL, 'Any formula.', 'MANUAL');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000282, 200060, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000283, 200060, 2000282, 1, 'KEYWORD', 0, NULL, 200054);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, text) VALUES (2000284, 200060, 2000282, 2, 'LITERAL', 1, NULL, '(');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000285, 200060, 2000282, 3, 'PARAMETER', 1, NULL, 200069, 200005);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, text) VALUES (2000286, 200060, 2000282, 4, 'LITERAL', 1, NULL, ')');
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 200060, id, 'FULL', NULL FROM action WHERE code = 'MATH_SGN';
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id, page) VALUES (200059, NULL, 1, 'Signs', NULL, '10 PRINT SGN(-5), SGN(0), SGN(3)
20 END', '-1            0             1', 0, NULL, NULL);

-- MAT READ (STATEMENT)
INSERT INTO entry (id, layer_id, name, category_id, operation, redefines_id, description, difference_notes, notes) VALUES (200060, 200003, 'MAT READ', 1, 'ADD', NULL, 'Reads matrices from the data list, row by row.', NULL, 'The matrices must have a DIM. Their subscript 0 can be used [5]. Eleven MAT statements in [3] pp. 31-34 (from Card BASIC of the 2nd edition). According to Kurtz [9], in the 3rd edition MAT counts from row and column 0, so `CON(3,4)` is 4 × 5; `MAT A = B` is not allowed (write `MAT A = (1)*B`); in MAT PRINT the semicolon packs and the comma uses the zones.');
INSERT INTO entry_source (entry_id, source_id, page) VALUES (200060, 200003, '31');
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, return_min_inclusive, return_max_inclusive, precedence, associativity, operator_class_id, evidence) VALUES (200061, 200060, 1, NULL, NULL, 'MAT READ A, B', 200003, '31', NULL, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200070, 200061, 'matrix', 'NONE', NULL, NULL, 'Matrices with a DIM.', 'MANUAL');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000287, 200061, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000288, 200061, 2000287, 1, 'KEYWORD', 0, NULL, 200055);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000289, 200061, 2000287, 2, 'KEYWORD', 0, NULL, 200018);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, separator, min_occ, max_occ) VALUES (2000290, 200061, 2000287, 3, 'REPEAT', 0, NULL, ',', 1, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000291, 200061, 2000290, 1, 'PARAMETER', 0, NULL, 200070, 200013);
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 200061, id, 'FULL', NULL FROM action WHERE code = 'MAT_READ';
INSERT INTO entry_error (entry_id, form_id, parameter_id, error_code, operation, cause, verified, position) VALUES (200060, NULL, NULL, 'OUT_OF_DATA', 'ADD', 'No data left.', 0, 1);
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id, page) VALUES (200060, NULL, 1, 'Read and print a matrix', NULL, '10 DIM A(2,3)
20 MAT READ A
30 MAT PRINT A
40 DATA 1,2,3,4,5,6
50 END', ' 1             2             3

 4             5             6', 0, NULL, NULL);

-- MAT PRINT (STATEMENT)
INSERT INTO entry (id, layer_id, name, category_id, operation, redefines_id, description, difference_notes, notes) VALUES (200061, 200003, 'MAT PRINT', 1, 'ADD', NULL, 'Prints matrices, one row per line; a list is printed as a column.', NULL, 'The matrices must have a DIM. Their subscript 0 can be used [5]. Eleven MAT statements in [3] pp. 31-34 (from Card BASIC of the 2nd edition). According to Kurtz [9], in the 3rd edition MAT counts from row and column 0, so `CON(3,4)` is 4 × 5; `MAT A = B` is not allowed (write `MAT A = (1)*B`); in MAT PRINT the semicolon packs and the comma uses the zones.');
INSERT INTO entry_source (entry_id, source_id, page) VALUES (200061, 200003, '31');
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, return_min_inclusive, return_max_inclusive, precedence, associativity, operator_class_id, evidence) VALUES (200062, 200061, 1, NULL, NULL, 'MAT PRINT A', 200003, '31', NULL, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200071, 200062, 'matrix', 'NONE', NULL, NULL, 'Matrices; after '';'' a matrix is printed packed.', 'MANUAL');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000292, 200062, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000293, 200062, 2000292, 1, 'KEYWORD', 0, NULL, 200055);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000294, 200062, 2000292, 2, 'KEYWORD', 0, NULL, 200007);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000295, 200062, 2000292, 3, 'PARAMETER', 0, NULL, 200071, 200013);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, separator, min_occ, max_occ) VALUES (2000296, 200062, 2000292, 4, 'REPEAT', 0, NULL, NULL, 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000297, 200062, 2000296, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000298, 200062, 2000297, 1, 'CHOICE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, text) VALUES (2000299, 200062, 2000298, 1, 'LITERAL', 0, NULL, ',');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, text) VALUES (2000300, 200062, 2000298, 2, 'LITERAL', 0, NULL, ';');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000301, 200062, 2000297, 2, 'PARAMETER', 0, NULL, 200071, 200013);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000302, 200062, 2000292, 5, 'OPTIONAL', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000303, 200062, 2000302, 1, 'CHOICE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, text) VALUES (2000304, 200062, 2000303, 1, 'LITERAL', 0, NULL, ',');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, text) VALUES (2000305, 200062, 2000303, 2, 'LITERAL', 0, NULL, ';');
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 200062, id, 'FULL', NULL FROM action WHERE code = 'MAT_PRINT';
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id, page) VALUES (200061, NULL, 1, 'Packed', NULL, '10 DIM A(2,2)
20 MAT A = IDN
30 MAT PRINT A;
40 END', NULL, 0, NULL, NULL);

-- MAT (STATEMENT)
INSERT INTO entry (id, layer_id, name, category_id, operation, redefines_id, description, difference_notes, notes) VALUES (200062, 200003, 'MAT', 1, 'ADD', NULL, 'Matrix arithmetic: sum, difference, product, multiple, zero, ones, identity, transpose, inverse.', NULL, 'The matrices must have a DIM. Their subscript 0 can be used [5]. Eleven MAT statements in [3] pp. 31-34 (from Card BASIC of the 2nd edition). According to Kurtz [9], in the 3rd edition MAT counts from row and column 0, so `CON(3,4)` is 4 × 5; `MAT A = B` is not allowed (write `MAT A = (1)*B`); in MAT PRINT the semicolon packs and the comma uses the zones. One operation per statement. Dimensions can be given in parentheses after ZER, CON and IDN.');
INSERT INTO entry_source (entry_id, source_id, page) VALUES (200062, 200003, '32-34');
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, return_min_inclusive, return_max_inclusive, precedence, associativity, operator_class_id, evidence) VALUES (200063, 200062, 1, 'Sum', NULL, 'MAT C = A + B', 200003, '32-34', NULL, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200072, 200063, 'c', 'NONE', NULL, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200073, 200063, 'a', 'NONE', NULL, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200074, 200063, 'b', 'NONE', NULL, NULL, NULL, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000306, 200063, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000307, 200063, 2000306, 1, 'KEYWORD', 0, NULL, 200055);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000308, 200063, 2000306, 2, 'PARAMETER', 0, NULL, 200072, 200013);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000309, 200063, 2000306, 3, 'KEYWORD', 0, NULL, 200039);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000310, 200063, 2000306, 4, 'PARAMETER', 0, NULL, 200073, 200013);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000311, 200063, 2000306, 5, 'KEYWORD', 0, NULL, 200034);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000312, 200063, 2000306, 6, 'PARAMETER', 0, NULL, 200074, 200013);
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 200063, id, 'FULL', NULL FROM action WHERE code = 'MAT_ADD';
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, return_min_inclusive, return_max_inclusive, precedence, associativity, operator_class_id, evidence) VALUES (200064, 200062, 2, 'Difference', NULL, 'MAT C = A - B', 200003, '32-34', NULL, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200075, 200064, 'c', 'NONE', NULL, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200076, 200064, 'a', 'NONE', NULL, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200077, 200064, 'b', 'NONE', NULL, NULL, NULL, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000313, 200064, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000314, 200064, 2000313, 1, 'KEYWORD', 0, NULL, 200055);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000315, 200064, 2000313, 2, 'PARAMETER', 0, NULL, 200075, 200013);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000316, 200064, 2000313, 3, 'KEYWORD', 0, NULL, 200039);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000317, 200064, 2000313, 4, 'PARAMETER', 0, NULL, 200076, 200013);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000318, 200064, 2000313, 5, 'KEYWORD', 0, NULL, 200035);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000319, 200064, 2000313, 6, 'PARAMETER', 0, NULL, 200077, 200013);
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 200064, id, 'FULL', NULL FROM action WHERE code = 'MAT_SUB';
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, return_min_inclusive, return_max_inclusive, precedence, associativity, operator_class_id, evidence) VALUES (200065, 200062, 3, 'Product', NULL, 'MAT C = A * B', 200003, '32-34', NULL, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200078, 200065, 'c', 'NONE', NULL, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200079, 200065, 'a', 'NONE', NULL, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200080, 200065, 'b', 'NONE', NULL, NULL, NULL, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000320, 200065, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000321, 200065, 2000320, 1, 'KEYWORD', 0, NULL, 200055);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000322, 200065, 2000320, 2, 'PARAMETER', 0, NULL, 200078, 200013);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000323, 200065, 2000320, 3, 'KEYWORD', 0, NULL, 200039);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000324, 200065, 2000320, 4, 'PARAMETER', 0, NULL, 200079, 200013);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000325, 200065, 2000320, 5, 'KEYWORD', 0, NULL, 200036);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000326, 200065, 2000320, 6, 'PARAMETER', 0, NULL, 200080, 200013);
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 200065, id, 'FULL', NULL FROM action WHERE code = 'MAT_MUL';
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, return_min_inclusive, return_max_inclusive, precedence, associativity, operator_class_id, evidence) VALUES (200066, 200062, 4, 'Multiple', NULL, 'MAT C = (K) * A', 200003, '32-34', NULL, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200081, 200066, 'c', 'NONE', NULL, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200082, 200066, 'k', 'NONE', NULL, NULL, 'Any formula, in parentheses.', 'MANUAL');
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200083, 200066, 'a', 'NONE', NULL, NULL, NULL, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000327, 200066, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000328, 200066, 2000327, 1, 'KEYWORD', 0, NULL, 200055);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000329, 200066, 2000327, 2, 'PARAMETER', 0, NULL, 200081, 200013);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000330, 200066, 2000327, 3, 'KEYWORD', 0, NULL, 200039);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, text) VALUES (2000331, 200066, 2000327, 4, 'LITERAL', 0, NULL, '(');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000332, 200066, 2000327, 5, 'PARAMETER', 1, NULL, 200082, 200005);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, text) VALUES (2000333, 200066, 2000327, 6, 'LITERAL', 1, NULL, ')');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000334, 200066, 2000327, 7, 'KEYWORD', 0, NULL, 200036);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000335, 200066, 2000327, 8, 'PARAMETER', 0, NULL, 200083, 200013);
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 200066, id, 'FULL', NULL FROM action WHERE code = 'MAT_SCALAR';
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, return_min_inclusive, return_max_inclusive, precedence, associativity, operator_class_id, evidence) VALUES (200067, 200062, 5, 'Zero matrix', NULL, 'MAT C = ZER(M,N)', 200003, '32-34', NULL, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200084, 200067, 'c', 'NONE', NULL, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200085, 200067, 'm', 'NONE', NULL, NULL, 'Rows (a formula).', 'MANUAL');
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200086, 200067, 'n', 'NONE', NULL, NULL, 'Columns (a formula).', 'MANUAL');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000336, 200067, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000337, 200067, 2000336, 1, 'KEYWORD', 0, NULL, 200055);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000338, 200067, 2000336, 2, 'PARAMETER', 0, NULL, 200084, 200013);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000339, 200067, 2000336, 3, 'KEYWORD', 0, NULL, 200039);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000340, 200067, 2000336, 4, 'KEYWORD', 0, NULL, 200056);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000341, 200067, 2000336, 5, 'OPTIONAL', 1, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000342, 200067, 2000341, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, text) VALUES (2000343, 200067, 2000342, 1, 'LITERAL', 1, NULL, '(');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000344, 200067, 2000342, 2, 'PARAMETER', 1, NULL, 200085, 200005);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000345, 200067, 2000342, 3, 'OPTIONAL', 1, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000346, 200067, 2000345, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, text) VALUES (2000347, 200067, 2000346, 1, 'LITERAL', 1, NULL, ',');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000348, 200067, 2000346, 2, 'PARAMETER', 1, NULL, 200086, 200005);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, text) VALUES (2000349, 200067, 2000342, 4, 'LITERAL', 1, NULL, ')');
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 200067, id, 'FULL', NULL FROM action WHERE code = 'MAT_ZERO';
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, return_min_inclusive, return_max_inclusive, precedence, associativity, operator_class_id, evidence) VALUES (200068, 200062, 6, 'Ones', NULL, 'MAT C = CON(M,N)', 200003, '32-34', NULL, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200087, 200068, 'c', 'NONE', NULL, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200088, 200068, 'm', 'NONE', NULL, NULL, 'Rows (a formula).', 'MANUAL');
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200089, 200068, 'n', 'NONE', NULL, NULL, 'Columns (a formula).', 'MANUAL');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000350, 200068, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000351, 200068, 2000350, 1, 'KEYWORD', 0, NULL, 200055);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000352, 200068, 2000350, 2, 'PARAMETER', 0, NULL, 200087, 200013);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000353, 200068, 2000350, 3, 'KEYWORD', 0, NULL, 200039);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000354, 200068, 2000350, 4, 'KEYWORD', 0, NULL, 200057);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000355, 200068, 2000350, 5, 'OPTIONAL', 1, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000356, 200068, 2000355, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, text) VALUES (2000357, 200068, 2000356, 1, 'LITERAL', 1, NULL, '(');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000358, 200068, 2000356, 2, 'PARAMETER', 1, NULL, 200088, 200005);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000359, 200068, 2000356, 3, 'OPTIONAL', 1, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000360, 200068, 2000359, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, text) VALUES (2000361, 200068, 2000360, 1, 'LITERAL', 1, NULL, ',');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000362, 200068, 2000360, 2, 'PARAMETER', 1, NULL, 200089, 200005);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, text) VALUES (2000363, 200068, 2000356, 4, 'LITERAL', 1, NULL, ')');
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 200068, id, 'FULL', NULL FROM action WHERE code = 'MAT_ONES';
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, return_min_inclusive, return_max_inclusive, precedence, associativity, operator_class_id, evidence) VALUES (200069, 200062, 7, 'Identity', NULL, 'MAT C = IDN(N)', 200003, '32-34', NULL, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200090, 200069, 'c', 'NONE', NULL, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200091, 200069, 'n', 'NONE', NULL, NULL, 'Order of the square matrix.', 'MANUAL');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000364, 200069, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000365, 200069, 2000364, 1, 'KEYWORD', 0, NULL, 200055);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000366, 200069, 2000364, 2, 'PARAMETER', 0, NULL, 200090, 200013);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000367, 200069, 2000364, 3, 'KEYWORD', 0, NULL, 200039);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000368, 200069, 2000364, 4, 'KEYWORD', 0, NULL, 200058);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000369, 200069, 2000364, 5, 'OPTIONAL', 1, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000370, 200069, 2000369, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, text) VALUES (2000371, 200069, 2000370, 1, 'LITERAL', 1, NULL, '(');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000372, 200069, 2000370, 2, 'PARAMETER', 1, NULL, 200091, 200005);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, text) VALUES (2000373, 200069, 2000370, 3, 'LITERAL', 1, NULL, ')');
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 200069, id, 'FULL', NULL FROM action WHERE code = 'MAT_IDENTITY';
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, return_min_inclusive, return_max_inclusive, precedence, associativity, operator_class_id, evidence) VALUES (200070, 200062, 8, 'Transpose', NULL, 'MAT C = TRN(A)', 200003, '32-34', NULL, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200092, 200070, 'c', 'NONE', NULL, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200093, 200070, 'a', 'NONE', NULL, NULL, NULL, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000374, 200070, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000375, 200070, 2000374, 1, 'KEYWORD', 0, NULL, 200055);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000376, 200070, 2000374, 2, 'PARAMETER', 0, NULL, 200092, 200013);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000377, 200070, 2000374, 3, 'KEYWORD', 0, NULL, 200039);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000378, 200070, 2000374, 4, 'KEYWORD', 0, NULL, 200059);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, text) VALUES (2000379, 200070, 2000374, 5, 'LITERAL', 1, NULL, '(');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000380, 200070, 2000374, 6, 'PARAMETER', 1, NULL, 200093, 200013);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, text) VALUES (2000381, 200070, 2000374, 7, 'LITERAL', 1, NULL, ')');
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 200070, id, 'FULL', NULL FROM action WHERE code = 'MAT_TRANSPOSE';
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, return_min_inclusive, return_max_inclusive, precedence, associativity, operator_class_id, evidence) VALUES (200071, 200062, 9, 'Inverse', NULL, 'MAT C = INV(A)', 200003, '32-34', NULL, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200094, 200071, 'c', 'NONE', NULL, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200095, 200071, 'a', 'NONE', NULL, NULL, NULL, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000382, 200071, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000383, 200071, 2000382, 1, 'KEYWORD', 0, NULL, 200055);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000384, 200071, 2000382, 2, 'PARAMETER', 0, NULL, 200094, 200013);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000385, 200071, 2000382, 3, 'KEYWORD', 0, NULL, 200039);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000386, 200071, 2000382, 4, 'KEYWORD', 0, NULL, 200060);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, text) VALUES (2000387, 200071, 2000382, 5, 'LITERAL', 1, NULL, '(');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000388, 200071, 2000382, 6, 'PARAMETER', 1, NULL, 200095, 200013);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, text) VALUES (2000389, 200071, 2000382, 7, 'LITERAL', 1, NULL, ')');
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 200071, id, 'FULL', NULL FROM action WHERE code = 'MAT_INVERSE';
INSERT INTO entry_error (entry_id, form_id, parameter_id, error_code, operation, cause, verified, position) VALUES (200062, NULL, NULL, 'DIMENSION_ERROR', 'ADD', 'The dimensions of the matrices do not agree.', 0, 1);
INSERT INTO entry_error (entry_id, form_id, parameter_id, error_code, operation, cause, verified, position) VALUES (200062, 200071, NULL, 'NEARLY_SINGULAR', 'ADD', 'The matrix has no inverse.', 0, 2);
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id, page) VALUES (200062, 200065, 1, 'Product', NULL, '10 DIM A(2,2), B(2,2), C(2,2)
20 MAT READ A, B
30 MAT C = A * B
40 MAT PRINT C
50 DATA 1,2,3,4, 1,0,0,1
60 END', ' 1             2

 3             4', 0, NULL, NULL);
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id, page) VALUES (200062, 200071, 2, 'Inverse', NULL, '10 DIM A(2,2), B(2,2)
20 MAT READ A
30 MAT B = INV(A)
40 MAT PRINT B
50 DATA 2,0,0,4
60 END', ' .5            0

 0             .25', 0, NULL, NULL);

-- INT (FUNCTION)
INSERT INTO entry (id, layer_id, name, category_id, operation, redefines_id, description, difference_notes, notes) VALUES (200063, 200003, 'INT', 3, 'REPLACE', 200029, 'Largest integer not greater than the argument.', 'Floor instead of truncation: INT(-2.35) = -3.', '`INT(-2.35)` = -3 [3] p. 25; rounding can now be written `INT(X+.5)` for every X.');
INSERT INTO entry_source (entry_id, source_id, page) VALUES (200063, 200003, '25');
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, return_min_inclusive, return_max_inclusive, precedence, associativity, operator_class_id, evidence) VALUES (200072, 200063, 1, NULL, NULL, 'INT(X)', 200003, '25', 200001, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200096, 200072, 'x', 'NONE', NULL, NULL, 'Any formula.', 'MANUAL');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000390, 200072, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000391, 200072, 2000390, 1, 'KEYWORD', 0, NULL, 200033);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, text) VALUES (2000392, 200072, 2000390, 2, 'LITERAL', 1, NULL, '(');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000393, 200072, 2000390, 3, 'PARAMETER', 1, NULL, 200096, 200005);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, text) VALUES (2000394, 200072, 2000390, 4, 'LITERAL', 1, NULL, ')');
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 200072, id, 'FULL', NULL FROM action WHERE code = 'MATH_INT';
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id, page) VALUES (200063, NULL, 1, 'Floor', NULL, '10 PRINT INT(7.8), INT(-2.35)
20 END', '7            -3', 0, 200003, '25');

-- - (OPERATOR)
INSERT INTO entry (id, layer_id, name, category_id, operation, redefines_id, description, difference_notes, notes) VALUES (200064, 200003, '-', 4, 'REPLACE', 200032, 'Change of sign and subtraction.', 'The change of sign comes after the power: -X↑2 = -(X↑2).', 'A leading minus is now applied after the power: `-X↑2` is `-(X↑2)` (source [5]).');
INSERT INTO entry_source (entry_id, source_id, page) VALUES (200064, 200005, NULL);
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, return_min_inclusive, return_max_inclusive, precedence, associativity, operator_class_id, evidence) VALUES (200073, 200064, 1, 'Change of sign', NULL, NULL, 200005, NULL, 200001, NULL, NULL, 1, 1, 2, NULL, 1, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200097, 200073, 'a', 'NONE', NULL, NULL, NULL, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000395, 200073, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000396, 200073, 2000395, 1, 'KEYWORD', 0, NULL, 200035);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000397, 200073, 2000395, 2, 'PARAMETER', 1, NULL, 200097, 200005);
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 200073, id, 'FULL', NULL FROM action WHERE code = 'OP_NEG';
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, return_min_inclusive, return_max_inclusive, precedence, associativity, operator_class_id, evidence) VALUES (200074, 200064, 2, 'Subtraction', NULL, NULL, 200005, NULL, 200001, NULL, NULL, 1, 1, 2, 'LEFT', 1, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200098, 200074, 'a', 'NONE', NULL, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200099, 200074, 'b', 'NONE', NULL, NULL, NULL, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000398, 200074, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000399, 200074, 2000398, 1, 'PARAMETER', 0, NULL, 200098, 200005);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000400, 200074, 2000398, 2, 'KEYWORD', 0, NULL, 200035);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000401, 200074, 2000398, 3, 'PARAMETER', 0, NULL, 200099, 200005);
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 200074, id, 'FULL', NULL FROM action WHERE code = 'OP_SUB';
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id, page) VALUES (200064, 200073, 1, 'Minus after the power', NULL, '10 LET X = 3
20 PRINT -X↑2
30 END', '-9', 0, NULL, NULL);

-- ↑ (OPERATOR)
INSERT INTO entry (id, layer_id, name, category_id, operation, redefines_id, description, difference_notes, notes) VALUES (200065, 200003, '↑', 4, 'REPLACE', 200031, 'Raise to a power.', 'A negative base with an integer exponent gives the right result.', '`(-3)↑3` = -27 [3] p. 37. `A↑B↑C` is `(A↑B)↑C`.');
INSERT INTO entry_source (entry_id, source_id, page) VALUES (200065, 200003, '37');
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, return_min_inclusive, return_max_inclusive, precedence, associativity, operator_class_id, evidence) VALUES (200075, 200065, 1, NULL, NULL, 'X↑2', 200003, '37', 200001, NULL, NULL, 1, 1, 4, 'LEFT', 1, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200100, 200075, 'a', 'NONE', NULL, NULL, 'Base: negative only with an integer exponent; otherwise its absolute value is used, with a message.', 'MANUAL');
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200101, 200075, 'b', 'NONE', NULL, NULL, NULL, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000402, 200075, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000403, 200075, 2000402, 1, 'PARAMETER', 0, NULL, 200100, 200005);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000404, 200075, 2000402, 2, 'KEYWORD', 0, NULL, 200038);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000405, 200075, 2000402, 3, 'PARAMETER', 0, NULL, 200101, 200005);
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 200075, id, 'FULL', NULL FROM action WHERE code = 'OP_POWER';
INSERT INTO entry_error (entry_id, form_id, parameter_id, error_code, operation, cause, verified, position) VALUES (200065, NULL, NULL, 'ZERO_NEGATIVE_POWER', 'ADD', '0 raised to a negative power.', 0, 1);
INSERT INTO entry_error (entry_id, form_id, parameter_id, error_code, operation, cause, verified, position) VALUES (200065, NULL, NULL, 'ABS_RAISED_TO_POWER', 'ADD', 'A negative base with a non-integer exponent.', 0, 2);
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id, page) VALUES (200065, NULL, 1, 'Negative base, integer exponent', NULL, '10 PRINT (-3)↑3
20 END', '-27', 0, 200003, '37');

-- / (OPERATOR)
INSERT INTO entry (id, layer_id, name, category_id, operation, redefines_id, description, difference_notes, notes) VALUES (200066, 200003, '/', 4, 'REPLACE', 200034, 'Division.', 'Division by zero gives a message and the largest number.', '`A/B/C` is `(A/B)/C`. Division by zero prints DIVISION BY ZERO and goes on with the largest number [3] p. 36.');
INSERT INTO entry_source (entry_id, source_id, page) VALUES (200066, 200003, '36');
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, return_min_inclusive, return_max_inclusive, precedence, associativity, operator_class_id, evidence) VALUES (200076, 200066, 1, NULL, NULL, NULL, 200003, '36', 200001, NULL, NULL, 1, 1, 3, 'LEFT', 1, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200102, 200076, 'a', 'NONE', NULL, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200103, 200076, 'b', 'NONE', NULL, NULL, NULL, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000406, 200076, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000407, 200076, 2000406, 1, 'PARAMETER', 0, NULL, 200102, 200005);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000408, 200076, 2000406, 2, 'KEYWORD', 0, NULL, 200037);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000409, 200076, 2000406, 3, 'PARAMETER', 0, NULL, 200103, 200005);
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 200076, id, 'FULL', NULL FROM action WHERE code = 'OP_DIV';
INSERT INTO entry_error (entry_id, form_id, parameter_id, error_code, operation, cause, verified, position) VALUES (200066, NULL, NULL, 'DIVISION_BY_ZERO', 'ADD', 'The divisor is 0: the program goes on with the largest number.', 0, 1);
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id, page) VALUES (200066, NULL, 1, 'Division by zero', 'Then the largest number is printed.', '10 PRINT 1/0
20 END', 'DIVISION BY ZERO IN 10', 0, NULL, NULL);

-- SQR (FUNCTION)
INSERT INTO entry (id, layer_id, name, category_id, operation, redefines_id, description, difference_notes, notes) VALUES (200067, 200003, 'SQR', 3, 'REPLACE', 200026, 'Square root of the absolute value of the argument.', 'A negative argument gives a message.', 'The root of the absolute value is used, with the message SQUARE ROOT OF A NEGATIVE NUMBER [3] p. 37.');
INSERT INTO entry_source (entry_id, source_id, page) VALUES (200067, 200003, '25');
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, return_min_inclusive, return_max_inclusive, precedence, associativity, operator_class_id, evidence) VALUES (200077, 200067, 1, NULL, NULL, 'SQR(A)', 200003, '25', 200001, 0, NULL, 1, 1, NULL, NULL, NULL, 'MANUAL');
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200104, 200077, 'x', 'NONE', NULL, NULL, 'Any formula.', 'MANUAL');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000410, 200077, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000411, 200077, 2000410, 1, 'KEYWORD', 0, NULL, 200030);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, text) VALUES (2000412, 200077, 2000410, 2, 'LITERAL', 1, NULL, '(');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000413, 200077, 2000410, 3, 'PARAMETER', 1, NULL, 200104, 200005);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, text) VALUES (2000414, 200077, 2000410, 4, 'LITERAL', 1, NULL, ')');
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 200077, id, 'FULL', NULL FROM action WHERE code = 'MATH_SQR';
INSERT INTO entry_error (entry_id, form_id, parameter_id, error_code, operation, cause, verified, position) VALUES (200067, NULL, NULL, 'SQR_NEGATIVE', 'ADD', 'The argument is negative: the root of its absolute value is used.', 0, 1);
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id, page) VALUES (200067, NULL, 1, 'Root of a negative number', 'The absolute value is used, with no message according to [1]. DTSS-Win (compiler of February 1965) prints `SQUARE ROOT OF NEGATIVE NUMBER IN 10` and then 2.', '10 PRINT SQR(-4)
20 END', '2', 0, NULL, NULL);
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id, page) VALUES (200067, NULL, 2, 'Table of square roots', 'From the DTSS-Win simulator files (BASSQR). Output checked on DTSS-Win (compiler of February 1965).', '10 FOR X = 0 TO 10
20 PRINT X, SQR(X)
30 NEXT X
40 END', ' 0              0
 1              1
 2              1.41421
 3              1.73205
 4              2
 5              2.23607
 6              2.44949
 7              2.64575
 8              2.82843
 9              3
 10             3.16228', 1, 200008, 'BASSQR');

-- LOG (FUNCTION)
INSERT INTO entry (id, layer_id, name, category_id, operation, redefines_id, description, difference_notes, notes) VALUES (200068, 200003, 'LOG', 3, 'REPLACE', 200025, 'Natural logarithm.', 'A negative or zero argument gives a message.', 'The logarithm of the absolute value is used, with the message LOG OF NEGATIVE NUMBER; LOG(0) gives LOG OF ZERO [3] p. 37.');
INSERT INTO entry_source (entry_id, source_id, page) VALUES (200068, 200003, '25');
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, return_min_inclusive, return_max_inclusive, precedence, associativity, operator_class_id, evidence) VALUES (200078, 200068, 1, NULL, NULL, 'LOG(A)', 200003, '25', 200001, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200105, 200078, 'x', 'NONE', NULL, NULL, 'Any formula.', 'MANUAL');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000415, 200078, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000416, 200078, 2000415, 1, 'KEYWORD', 0, NULL, 200029);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, text) VALUES (2000417, 200078, 2000415, 2, 'LITERAL', 1, NULL, '(');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000418, 200078, 2000415, 3, 'PARAMETER', 1, NULL, 200105, 200005);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, text) VALUES (2000419, 200078, 2000415, 4, 'LITERAL', 1, NULL, ')');
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 200078, id, 'FULL', NULL FROM action WHERE code = 'MATH_LN';
INSERT INTO entry_error (entry_id, form_id, parameter_id, error_code, operation, cause, verified, position) VALUES (200068, NULL, NULL, 'LOG_NEGATIVE', 'ADD', 'The argument is negative: the logarithm of its absolute value is used.', 0, 1);
INSERT INTO entry_error (entry_id, form_id, parameter_id, error_code, operation, cause, verified, position) VALUES (200068, NULL, NULL, 'LOG_ZERO', 'ADD', 'The argument is 0.', 0, 2);
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id, page) VALUES (200068, NULL, 1, 'Average of 100 logarithms', 'Output checked on DTSS-Win (compiler of February 1965, program AVELOG): the same result, printed as ` 1.5797`.', '10 PRINT "AVERAGE OF 100 LOGS"
20 LET S = 0
30 FOR N = 1 TO 100
40 LET S = S + FNL(N)
50 NEXT N
60 LET S = S/100
70 PRINT S
80 DEF FNL(Z) = LOG(Z)/LOG(10)
99 END', 'AVERAGE OF 100 LOGS
1.5797', 1, 200003, '21');
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id, page) VALUES (200068, NULL, 2, 'Logarithm of a negative number', 'The logarithm of the absolute value is printed and the program goes on. Checked on DTSS-Win (compiler of February 1965).', '10 PRINT LOG(-1)
20 END', 'LOG OF NEGATIVE NUMBER IN 10
 0', 1, NULL, NULL);

-- EXP (FUNCTION)
INSERT INTO entry (id, layer_id, name, category_id, operation, redefines_id, description, difference_notes, notes) VALUES (200069, 200003, 'EXP', 3, 'REPLACE', 200024, 'e raised to the argument.', 'A result too large gives a message.', 'EXP TOO LARGE when the result is out of range [3] p. 37.');
INSERT INTO entry_source (entry_id, source_id, page) VALUES (200069, 200003, '25');
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, return_min_inclusive, return_max_inclusive, precedence, associativity, operator_class_id, evidence) VALUES (200079, 200069, 1, NULL, NULL, 'EXP(A)', 200003, '25', 200001, 0, NULL, 1, 1, NULL, NULL, NULL, 'MANUAL');
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200106, 200079, 'x', 'NONE', NULL, NULL, 'Any formula.', 'MANUAL');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000420, 200079, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000421, 200079, 2000420, 1, 'KEYWORD', 0, NULL, 200028);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, text) VALUES (2000422, 200079, 2000420, 2, 'LITERAL', 1, NULL, '(');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000423, 200079, 2000420, 3, 'PARAMETER', 1, NULL, 200106, 200005);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, text) VALUES (2000424, 200079, 2000420, 4, 'LITERAL', 1, NULL, ')');
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 200079, id, 'FULL', NULL FROM action WHERE code = 'MATH_EXP';
INSERT INTO entry_error (entry_id, form_id, parameter_id, error_code, operation, cause, verified, position) VALUES (200069, NULL, NULL, 'EXP_TOO_LARGE', 'ADD', 'The result is out of range.', 0, 1);
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id, page) VALUES (200069, NULL, 1, 'The number e', NULL, '10 PRINT EXP(1)
20 END', '2.71828', 0, NULL, NULL);
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id, page) VALUES (200069, NULL, 2, 'Table of exponentials', 'From the DTSS-Win simulator files (BASEXP). Output checked on DTSS-Win (compiler of February 1965).', '10 FOR X = -1 TO 1 STEP .5
20 PRINT X, EXP(X)
30 NEXT X
40 END', '-1              .367879
-.5             .606531
 0              1
 .5             1.64872
 1              2.71828', 1, 200008, 'BASEXP');

-- READ (STATEMENT)
INSERT INTO entry (id, layer_id, name, category_id, operation, redefines_id, description, difference_notes, notes) VALUES (200070, 200003, 'READ', 1, 'REPLACE', 200014, 'Gives the variables the next numbers of the DATA statements.', 'Running out of data prints OUT OF DATA.', 'When there is no data left the program stops with the message OUT OF DATA [3] p. 36 (which can be a normal end).');
INSERT INTO entry_source (entry_id, source_id, page) VALUES (200070, 200003, '19');
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, return_min_inclusive, return_max_inclusive, precedence, associativity, operator_class_id, evidence) VALUES (200080, 200070, 1, NULL, NULL, 'READ A, B, C', 200003, '19', NULL, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200107, 200080, 'variable', 'NONE', NULL, NULL, 'Variables or elements, separated by commas.', 'MANUAL');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000425, 200080, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000426, 200080, 2000425, 1, 'KEYWORD', 0, NULL, 200018);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, separator, min_occ, max_occ) VALUES (2000427, 200080, 2000425, 2, 'REPEAT', 0, NULL, ',', 1, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000428, 200080, 2000427, 1, 'PARAMETER', 0, NULL, 200107, 200009);
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 200080, id, 'FULL', NULL FROM action WHERE code = 'DATA_READ';
INSERT INTO entry_error (entry_id, form_id, parameter_id, error_code, operation, cause, verified, position) VALUES (200070, NULL, NULL, 'OUT_OF_DATA', 'ADD', 'No data left: the program stops.', 0, 1);
INSERT INTO entry_error (entry_id, form_id, parameter_id, error_code, operation, cause, verified, position) VALUES (200070, NULL, NULL, 'NO_DATA', 'ADD', 'The program has no DATA statement.', 0, 2);
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id, page) VALUES (200070, NULL, 1, 'Out of data', 'The program stops: AFTER is not printed. Checked on DTSS-Win (compiler of February 1965), with the same lines numbered 50-90.', '10 READ A
20 PRINT A
30 READ B
40 PRINT "AFTER"
50 DATA 5
99 END', '5

OUT OF DATA IN 30', 1, NULL, NULL);

-- GOSUB (STATEMENT)
INSERT INTO entry (id, layer_id, name, category_id, operation, redefines_id, description, difference_notes, notes) VALUES (200071, 200003, 'GOSUB', 1, 'REPLACE', 200016, 'Calls a subroutine: RETURN goes back to the statement after the GOSUB.', 'Subroutines can call other subroutines.', 'GOSUB can be nested; the depth limit is not given (GOSUB NESTED TOO DEEPLY). A subroutine should be left only with RETURN [3] p. 28.');
INSERT INTO entry_source (entry_id, source_id, page) VALUES (200071, 200003, '28');
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, return_min_inclusive, return_max_inclusive, precedence, associativity, operator_class_id, evidence) VALUES (200081, 200071, 1, NULL, NULL, 'GOSUB N', 200003, '28', NULL, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200108, 200081, 'n', 'NONE', 'UNDEFINED_NUMBER', 'ERROR', 'Line number: an integer of up to five digits, written as a number (not a formula).', 'MANUAL');
INSERT INTO parameter_limit (parameter_id, minimum, maximum, notes, min_inclusive, max_inclusive, evidence) VALUES (200108, 1, 99999, NULL, 1, 1, 'MANUAL');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000429, 200081, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000430, 200081, 2000429, 1, 'KEYWORD', 0, NULL, 200020);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000431, 200081, 2000429, 2, 'PARAMETER', 0, NULL, 200108, 200002);
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 200081, id, 'FULL', NULL FROM action WHERE code = 'FLOW_GOSUB';
INSERT INTO entry_error (entry_id, form_id, parameter_id, error_code, operation, cause, verified, position) VALUES (200071, NULL, NULL, 'GOSUB_TOO_DEEP', 'ADD', 'Too many nested GOSUB.', 0, 1);
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id, page) VALUES (200071, NULL, 1, 'Nested subroutines', NULL, '10 GOSUB 100
20 STOP
100 GOSUB 200
110 RETURN
200 PRINT "DEEP"
210 RETURN
999 END', 'DEEP', 0, NULL, NULL);
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id, page) VALUES (200071, NULL, 2, 'Nested subroutines, checked', 'Checked on DTSS-Win (compiler of February 1965).', '10 GOSUB 100
20 PRINT "BACK IN MAIN"
30 STOP
100 PRINT "OUTER"
110 GOSUB 200
120 PRINT "BACK IN OUTER"
130 RETURN
200 PRINT "INNER"
210 RETURN
220 END', 'OUTER
INNER
BACK IN OUTER
BACK IN MAIN', 1, NULL, NULL);

-- RETURN (STATEMENT)
INSERT INTO entry (id, layer_id, name, category_id, operation, redefines_id, description, difference_notes, notes) VALUES (200072, 200003, 'RETURN', 1, 'REPLACE', 200017, 'Goes back to the statement after the last GOSUB.', 'The error is now RETURN BEFORE GOSUB, at run time.', NULL);
INSERT INTO entry_source (entry_id, source_id, page) VALUES (200072, 200003, '28');
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, return_min_inclusive, return_max_inclusive, precedence, associativity, operator_class_id, evidence) VALUES (200082, 200072, 1, NULL, NULL, 'RETURN', 200003, '28', NULL, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000432, 200082, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000433, 200082, 2000432, 1, 'KEYWORD', 0, NULL, 200021);
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 200082, id, 'FULL', NULL FROM action WHERE code = 'FLOW_RETURN';
INSERT INTO entry_error (entry_id, form_id, parameter_id, error_code, operation, cause, verified, position) VALUES (200072, NULL, NULL, 'RETURN_BEFORE_GOSUB', 'ADD', 'RETURN with no GOSUB to go back to.', 0, 1);
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id, page) VALUES (200072, NULL, 1, 'Two calls', NULL, '10 GOSUB 100
20 GOSUB 100
30 GO TO 999
100 PRINT "HELLO"
110 RETURN
999 END', 'HELLO
HELLO', 0, NULL, NULL);
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id, page) VALUES (200072, NULL, 2, 'GCD of three numbers', 'From the DTSS-Win simulator files (LIB/GCD3NO). The same subroutine called twice: GCD 30, then 1. Output checked on DTSS-Win (compiler of February 1965).', '10 PRINT "A", "B", "C", "GCD"
20 READ A, B, C
30 LET X = A
40 LET Y = B
50 GOSUB 200
60 LET X = G
70 LET Y = C
80 GOSUB 200
90 PRINT A, B, C, G
100 GOTO 20
110 DATA 60, 90, 120
120 DATA 38456, 64872, 98765
200 LET Q = INT(X/Y)
210 LET R = X - Q*Y
220 IF R = 0 THEN 300
230 LET X = Y
240 LET Y = R
250 GOTO 200
300 LET G = Y
310 RETURN
999 END', 'A              B              C              GCD
 60             90             120            30
 38456          64872          98765          1

OUT OF DATA IN  20', 1, 200008, 'LIB/GCD3NO');

-- PRINT (STATEMENT)
INSERT INTO entry (id, layer_id, name, category_id, operation, redefines_id, description, difference_notes, notes) VALUES (200073, 200003, 'PRINT', 1, 'REPLACE', 200054, 'Types the values of formulas and labels on a line.', 'Packed zones of 6, 9 or 12 characters.', ''';'' gives packed zones of 6, 9 or 12 characters; a final comma or semicolon keeps the line open [3] pp. 23-24.');
INSERT INTO entry_source (entry_id, source_id, page) VALUES (200073, 200003, '23-24');
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, return_min_inclusive, return_max_inclusive, precedence, associativity, operator_class_id, evidence) VALUES (200083, 200073, 1, NULL, ''','' moves to the next zone of 15 characters (after the fifth, to the next line); '';'' moves to the next multiple of three characters, at least six per number. A PRINT ending with a comma or semicolon does not end the line; PRINT alone skips a line.', 'PRINT', 200003, '23-24', NULL, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200109, 200083, 'label', 'NONE', NULL, NULL, 'Text in quotes, typed as it is; it fills whole zones.', 'MANUAL');
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200110, 200083, 'formula', 'NONE', NULL, NULL, 'Any formula: its value is typed.', 'MANUAL');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000434, 200083, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000435, 200083, 2000434, 1, 'KEYWORD', 0, NULL, 200007);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000436, 200083, 2000434, 2, 'OPTIONAL', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000437, 200083, 2000436, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000438, 200083, 2000437, 1, 'CHOICE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000439, 200083, 2000438, 1, 'PARAMETER', 0, NULL, 200109, 200003);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000440, 200083, 2000438, 2, 'PARAMETER', 0, NULL, 200110, 200005);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000441, 200083, 2000438, 3, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000442, 200083, 2000441, 1, 'PARAMETER', 0, NULL, 200109, 200003);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000443, 200083, 2000441, 2, 'PARAMETER', 0, NULL, 200110, 200005);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, separator, min_occ, max_occ) VALUES (2000444, 200083, 2000437, 2, 'REPEAT', 0, NULL, NULL, 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000445, 200083, 2000444, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000446, 200083, 2000445, 1, 'CHOICE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, text) VALUES (2000447, 200083, 2000446, 1, 'LITERAL', 0, NULL, ',');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, text) VALUES (2000448, 200083, 2000446, 2, 'LITERAL', 0, NULL, ';');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000449, 200083, 2000445, 2, 'CHOICE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000450, 200083, 2000449, 1, 'PARAMETER', 0, NULL, 200109, 200003);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000451, 200083, 2000449, 2, 'PARAMETER', 0, NULL, 200110, 200005);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000452, 200083, 2000449, 3, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000453, 200083, 2000452, 1, 'PARAMETER', 0, NULL, 200109, 200003);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000454, 200083, 2000452, 2, 'PARAMETER', 0, NULL, 200110, 200005);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000455, 200083, 2000437, 3, 'OPTIONAL', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000456, 200083, 2000455, 1, 'CHOICE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, text) VALUES (2000457, 200083, 2000456, 1, 'LITERAL', 0, NULL, ',');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, text) VALUES (2000458, 200083, 2000456, 2, 'LITERAL', 0, NULL, ';');
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 200083, id, 'FULL', NULL FROM action WHERE code = 'IO_PRINT';
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id, page) VALUES (200073, NULL, 1, 'Zones and packed output', 'Comma: zones of 15; semicolon: multiples of 3.', '10 PRINT 1, 2, 3
20 PRINT 1; 2; 3
30 END', ' 1             2             3
 1    2    3', 0, NULL, NULL);
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id, page) VALUES (200073, NULL, 2, 'Element 0 of a list', 'Subscripts start at 0 from the 2nd edition. Checked on DTSS-Win (compiler of February 1965).', '10 DIM A(5)
20 LET A(0) = 1
30 PRINT A(0)
40 END', '1', 1, NULL, NULL);
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id, page) VALUES (200073, NULL, 3, 'Semicolon', 'From the DTSS-Win simulator files (BASSEM). Output checked on DTSS-Win (compiler of February 1965).', '10 PRINT 2; 3
20 END', ' 2     3', 1, 200008, 'BASSEM');
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id, page) VALUES (200073, NULL, 4, 'A list from element 0', 'From the DTSS-Win simulator files (BASLIS). Element 0 and the default size of 10, without DIM. Output checked on DTSS-Win (compiler of February 1965).', '10 FOR I = 0 TO 10
20 LET X(I) = I
30 NEXT I
40 FOR I = 0 TO 10
50 PRINT X(I);
60 NEXT I
70 END', ' 0     1     2     3     4     5     6     7     8     9     10', 1, 200008, 'BASLIS');
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id, page) VALUES (200073, NULL, 5, 'Plot of the normal curve', 'From the DTSS-Win simulator files (LIB/NORMAL). The file writes the power as ^, the ASCII character with the code of ↑ (94). Lines 110 and 130 are empty. Output checked on DTSS-Win (compiler of February 1965). Only 40 lines for the 41 values from -2 to 2: the sum of the steps of .1 passes 2 by a little, so the last value is lost.', '100 REM PLOT A NORMAL DISTRIBUTION CURVE
110
120 DEF FNN(X) = EXP(-(X↑2/2))/SQR(2*3.14159265)
130
140 FOR X = -2 TO 2 STEP .1
150 LET Y = FNN(X)
160 LET Y = INT(100*Y)
170 FOR Z = 1 TO Y
180 PRINT " ";
190 NEXT Z
200 PRINT "*"
210 NEXT X
220 END', '     *
      *
       *
         *
           *
            *
              *
                 *
                   *
                     *
                        *
                          *
                            *
                               *
                                 *
                                   *
                                    *
                                      *
                                       *
                                       *
                                       *
                                       *
                                       *
                                      *
                                    *
                                   *
                                 *
                               *
                            *
                          *
                        *
                     *
                   *
                 *
              *
            *
           *
         *
       *
      *', 1, 200008, 'LIB/NORMAL');

-- DATA (STATEMENT)
INSERT INTO entry (id, layer_id, name, category_id, operation, redefines_id, description, difference_notes, notes) VALUES (200074, 200003, 'DATA', 1, 'REPLACE', 200045, 'Numbers for READ, taken in the order of the DATA statements.', 'Up to 1280 numbers.', 'Never executed: it can be anywhere. Up to 1280 numbers in all [3] p. 38.');
INSERT INTO entry_source (entry_id, source_id, page) VALUES (200074, 200003, '20');
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, return_min_inclusive, return_max_inclusive, precedence, associativity, operator_class_id, evidence) VALUES (200084, 200074, 1, NULL, NULL, 'DATA 1, 2, 3', 200003, '20', NULL, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200111, 200084, 'number', 'NONE', NULL, NULL, 'Numbers separated by commas, as many as fit on the line.', 'MANUAL');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000459, 200084, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000460, 200084, 2000459, 1, 'KEYWORD', 0, NULL, 200019);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, separator, min_occ, max_occ) VALUES (2000461, 200084, 2000459, 2, 'REPEAT', 0, NULL, ',', 1, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000462, 200084, 2000461, 1, 'PARAMETER', 0, NULL, 200111, 200001);
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 200084, id, 'FULL', NULL FROM action WHERE code = 'DATA_DEFINE';
INSERT INTO entry_error (entry_id, form_id, parameter_id, error_code, operation, cause, verified, position) VALUES (200074, NULL, NULL, 'TOO_MUCH_DATA', 'ADD', 'More numbers than the limit (200 in [1] p. 14).', 0, 1);
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id, page) VALUES (200074, NULL, 1, 'Order of the data', 'A = 1, B = 2, C = 3, D1 = 4, ..., D4 = 7.', '10 READ A, B, C
20 READ D1, D2, D3, D4
30 PRINT A, D4
80 DATA 1, 2, 3, 4, 5, 6
90 DATA 7, 8, 9, 10
99 END', '1             7', 0, 200001, '14');
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id, page) VALUES (200074, NULL, 2, 'Life of a mortgage', 'From the DTSS-Win simulator files (LIB/MORT). DATA lines interleaved with REM lines; the typing slip COMOPUTER is in the original. Output checked on DTSS-Win (compiler of February 1965). The run prints 291 lines (to 1988): only the first and last lines are shown, the dots stand for the rest.', '1 REM MORTGAGE COMOPUTER
2 REM YEARLY INTEREST RATE
10 DATA 0.05
15 REM INITIAL PRINCIPAL
20 DATA 28500
25 REM MONTHLY PAYMENT
30 DATA 170
35 REM STARTING MONTH AND YEAR
40 DATA 1, 1964
50 READ I, P, P1, M, Y
60 LET R = 1 + I/12
70 PRINT "YEAR", "PRINCIPAL"
80 PRINT Y, P
90 LET P = P*R - P1
100 IF P >= 0 THEN 120
110 LET P = 0
120 LET M = M + 1
130 IF M > 12 THEN 160
140 PRINT "       ",
150 GO TO 190
160 LET M = 1
170 LET Y = Y + 1
180 PRINT Y,
190 PRINT INT(P)
200 IF P > 0 THEN 90
210 END', 'YEAR           PRINCIPAL
 1964           28500
                28448
                28397
                28345
                28293
                28241
                28189
                28136
                28083
                28030
                27977
                27924
 1965           27870
...
                736
                569
                401
                233
 1988           64
                0', 1, 200008, 'LIB/MORT');

INSERT INTO reference (entry_id, related_entry_id, kind) VALUES (200070, 200058, 'SEE_ALSO');
INSERT INTO reference (entry_id, related_entry_id, kind) VALUES (200057, 200070, 'SEE_ALSO');
INSERT INTO reference (entry_id, related_entry_id, kind) VALUES (200060, 200062, 'SEE_ALSO');
INSERT INTO reference (entry_id, related_entry_id, kind) VALUES (200061, 200062, 'SEE_ALSO');
INSERT INTO reference (entry_id, related_entry_id, kind) VALUES (200059, 200027, 'SEE_ALSO');
INSERT INTO open_question (layer_id, position, question) VALUES (200003, 1, 'The 3rd edition is built from the GE manual of January 1967 and from Wikipedia: check it against the Dartmouth 3rd edition manual (1 January 1966) if it can be found. SGN, the unary minus after the power and INT as floor are now confirmed by Kurtz [9].');

-- ================= layer DARTMOUTH_4ED_layer
INSERT INTO character_code (id, layer_id, code, evidence, operation, redefines_id, kind, name, action) VALUES (201004, 200004, 4, 'MANUAL', 'REPLACE', 200004, 'CONTROL', 'EOT', 'End of transmission');
INSERT INTO character_code (id, layer_id, code, evidence, operation, redefines_id, kind, name, action) VALUES (201007, 200004, 7, 'MANUAL', 'REPLACE', 200007, 'CONTROL', 'BELL', 'Rings the bell of the Teletype');
INSERT INTO character_code (id, layer_id, code, evidence, operation, redefines_id, kind, name, action) VALUES (201010, 200004, 10, 'MANUAL', 'REPLACE', 200010, 'CONTROL', 'LF', 'Line feed');
INSERT INTO character_code (id, layer_id, code, evidence, operation, redefines_id, kind, name, action) VALUES (201013, 200004, 13, 'MANUAL', 'REPLACE', 200013, 'CONTROL', 'CR', 'Carriage return');
INSERT INTO character_code (id, layer_id, code, evidence, operation, redefines_id, kind, screen_code) VALUES (201032, 200004, 32, 'MANUAL', 'REPLACE', 200032, 'PRINTABLE', 32);
INSERT INTO character_code (id, layer_id, code, evidence, operation, redefines_id, kind, screen_code) VALUES (201033, 200004, 33, 'MANUAL', 'REPLACE', 200033, 'PRINTABLE', 33);
INSERT INTO character_code (id, layer_id, code, evidence, operation, redefines_id, kind, screen_code) VALUES (201034, 200004, 34, 'MANUAL', 'REPLACE', 200034, 'PRINTABLE', 34);
INSERT INTO character_code (id, layer_id, code, evidence, operation, redefines_id, kind, screen_code) VALUES (201035, 200004, 35, 'MANUAL', 'REPLACE', 200035, 'PRINTABLE', 35);
INSERT INTO character_code (id, layer_id, code, evidence, operation, redefines_id, kind, screen_code) VALUES (201036, 200004, 36, 'MANUAL', 'REPLACE', 200036, 'PRINTABLE', 36);
INSERT INTO character_code (id, layer_id, code, evidence, operation, redefines_id, kind, screen_code) VALUES (201037, 200004, 37, 'MANUAL', 'REPLACE', 200037, 'PRINTABLE', 37);
INSERT INTO character_code (id, layer_id, code, evidence, operation, redefines_id, kind, screen_code) VALUES (201038, 200004, 38, 'MANUAL', 'REPLACE', 200038, 'PRINTABLE', 38);
INSERT INTO character_code (id, layer_id, code, evidence, operation, redefines_id, kind, screen_code) VALUES (201039, 200004, 39, 'MANUAL', 'REPLACE', 200039, 'PRINTABLE', 39);
INSERT INTO character_code (id, layer_id, code, evidence, operation, redefines_id, kind, screen_code) VALUES (201040, 200004, 40, 'MANUAL', 'REPLACE', 200040, 'PRINTABLE', 40);
INSERT INTO character_code (id, layer_id, code, evidence, operation, redefines_id, kind, screen_code) VALUES (201041, 200004, 41, 'MANUAL', 'REPLACE', 200041, 'PRINTABLE', 41);
INSERT INTO character_code (id, layer_id, code, evidence, operation, redefines_id, kind, screen_code) VALUES (201042, 200004, 42, 'MANUAL', 'REPLACE', 200042, 'PRINTABLE', 42);
INSERT INTO character_code (id, layer_id, code, evidence, operation, redefines_id, kind, screen_code) VALUES (201043, 200004, 43, 'MANUAL', 'REPLACE', 200043, 'PRINTABLE', 43);
INSERT INTO character_code (id, layer_id, code, evidence, operation, redefines_id, kind, screen_code) VALUES (201044, 200004, 44, 'MANUAL', 'REPLACE', 200044, 'PRINTABLE', 44);
INSERT INTO character_code (id, layer_id, code, evidence, operation, redefines_id, kind, screen_code) VALUES (201045, 200004, 45, 'MANUAL', 'REPLACE', 200045, 'PRINTABLE', 45);
INSERT INTO character_code (id, layer_id, code, evidence, operation, redefines_id, kind, screen_code) VALUES (201046, 200004, 46, 'MANUAL', 'REPLACE', 200046, 'PRINTABLE', 46);
INSERT INTO character_code (id, layer_id, code, evidence, operation, redefines_id, kind, screen_code) VALUES (201047, 200004, 47, 'MANUAL', 'REPLACE', 200047, 'PRINTABLE', 47);
INSERT INTO character_code (id, layer_id, code, evidence, operation, redefines_id, kind, screen_code) VALUES (201048, 200004, 48, 'MANUAL', 'REPLACE', 200048, 'PRINTABLE', 48);
INSERT INTO character_code (id, layer_id, code, evidence, operation, redefines_id, kind, screen_code) VALUES (201049, 200004, 49, 'MANUAL', 'REPLACE', 200049, 'PRINTABLE', 49);
INSERT INTO character_code (id, layer_id, code, evidence, operation, redefines_id, kind, screen_code) VALUES (201050, 200004, 50, 'MANUAL', 'REPLACE', 200050, 'PRINTABLE', 50);
INSERT INTO character_code (id, layer_id, code, evidence, operation, redefines_id, kind, screen_code) VALUES (201051, 200004, 51, 'MANUAL', 'REPLACE', 200051, 'PRINTABLE', 51);
INSERT INTO character_code (id, layer_id, code, evidence, operation, redefines_id, kind, screen_code) VALUES (201052, 200004, 52, 'MANUAL', 'REPLACE', 200052, 'PRINTABLE', 52);
INSERT INTO character_code (id, layer_id, code, evidence, operation, redefines_id, kind, screen_code) VALUES (201053, 200004, 53, 'MANUAL', 'REPLACE', 200053, 'PRINTABLE', 53);
INSERT INTO character_code (id, layer_id, code, evidence, operation, redefines_id, kind, screen_code) VALUES (201054, 200004, 54, 'MANUAL', 'REPLACE', 200054, 'PRINTABLE', 54);
INSERT INTO character_code (id, layer_id, code, evidence, operation, redefines_id, kind, screen_code) VALUES (201055, 200004, 55, 'MANUAL', 'REPLACE', 200055, 'PRINTABLE', 55);
INSERT INTO character_code (id, layer_id, code, evidence, operation, redefines_id, kind, screen_code) VALUES (201056, 200004, 56, 'MANUAL', 'REPLACE', 200056, 'PRINTABLE', 56);
INSERT INTO character_code (id, layer_id, code, evidence, operation, redefines_id, kind, screen_code) VALUES (201057, 200004, 57, 'MANUAL', 'REPLACE', 200057, 'PRINTABLE', 57);
INSERT INTO character_code (id, layer_id, code, evidence, operation, redefines_id, kind, screen_code) VALUES (201058, 200004, 58, 'MANUAL', 'REPLACE', 200058, 'PRINTABLE', 58);
INSERT INTO character_code (id, layer_id, code, evidence, operation, redefines_id, kind, screen_code) VALUES (201059, 200004, 59, 'MANUAL', 'REPLACE', 200059, 'PRINTABLE', 59);
INSERT INTO character_code (id, layer_id, code, evidence, operation, redefines_id, kind, screen_code) VALUES (201060, 200004, 60, 'MANUAL', 'REPLACE', 200060, 'PRINTABLE', 60);
INSERT INTO character_code (id, layer_id, code, evidence, operation, redefines_id, kind, screen_code) VALUES (201061, 200004, 61, 'MANUAL', 'REPLACE', 200061, 'PRINTABLE', 61);
INSERT INTO character_code (id, layer_id, code, evidence, operation, redefines_id, kind, screen_code) VALUES (201062, 200004, 62, 'MANUAL', 'REPLACE', 200062, 'PRINTABLE', 62);
INSERT INTO character_code (id, layer_id, code, evidence, operation, redefines_id, kind, screen_code) VALUES (201063, 200004, 63, 'MANUAL', 'REPLACE', 200063, 'PRINTABLE', 63);
INSERT INTO character_code (id, layer_id, code, evidence, operation, redefines_id, kind, screen_code) VALUES (201064, 200004, 64, 'MANUAL', 'REPLACE', 200064, 'PRINTABLE', 64);
INSERT INTO character_code (id, layer_id, code, evidence, operation, redefines_id, kind, screen_code) VALUES (201065, 200004, 65, 'MANUAL', 'REPLACE', 200065, 'PRINTABLE', 65);
INSERT INTO character_code (id, layer_id, code, evidence, operation, redefines_id, kind, screen_code) VALUES (201066, 200004, 66, 'MANUAL', 'REPLACE', 200066, 'PRINTABLE', 66);
INSERT INTO character_code (id, layer_id, code, evidence, operation, redefines_id, kind, screen_code) VALUES (201067, 200004, 67, 'MANUAL', 'REPLACE', 200067, 'PRINTABLE', 67);
INSERT INTO character_code (id, layer_id, code, evidence, operation, redefines_id, kind, screen_code) VALUES (201068, 200004, 68, 'MANUAL', 'REPLACE', 200068, 'PRINTABLE', 68);
INSERT INTO character_code (id, layer_id, code, evidence, operation, redefines_id, kind, screen_code) VALUES (201069, 200004, 69, 'MANUAL', 'REPLACE', 200069, 'PRINTABLE', 69);
INSERT INTO character_code (id, layer_id, code, evidence, operation, redefines_id, kind, screen_code) VALUES (201070, 200004, 70, 'MANUAL', 'REPLACE', 200070, 'PRINTABLE', 70);
INSERT INTO character_code (id, layer_id, code, evidence, operation, redefines_id, kind, screen_code) VALUES (201071, 200004, 71, 'MANUAL', 'REPLACE', 200071, 'PRINTABLE', 71);
INSERT INTO character_code (id, layer_id, code, evidence, operation, redefines_id, kind, screen_code) VALUES (201072, 200004, 72, 'MANUAL', 'REPLACE', 200072, 'PRINTABLE', 72);
INSERT INTO character_code (id, layer_id, code, evidence, operation, redefines_id, kind, screen_code) VALUES (201073, 200004, 73, 'MANUAL', 'REPLACE', 200073, 'PRINTABLE', 73);
INSERT INTO character_code (id, layer_id, code, evidence, operation, redefines_id, kind, screen_code) VALUES (201074, 200004, 74, 'MANUAL', 'REPLACE', 200074, 'PRINTABLE', 74);
INSERT INTO character_code (id, layer_id, code, evidence, operation, redefines_id, kind, screen_code) VALUES (201075, 200004, 75, 'MANUAL', 'REPLACE', 200075, 'PRINTABLE', 75);
INSERT INTO character_code (id, layer_id, code, evidence, operation, redefines_id, kind, screen_code) VALUES (201076, 200004, 76, 'MANUAL', 'REPLACE', 200076, 'PRINTABLE', 76);
INSERT INTO character_code (id, layer_id, code, evidence, operation, redefines_id, kind, screen_code) VALUES (201077, 200004, 77, 'MANUAL', 'REPLACE', 200077, 'PRINTABLE', 77);
INSERT INTO character_code (id, layer_id, code, evidence, operation, redefines_id, kind, screen_code) VALUES (201078, 200004, 78, 'MANUAL', 'REPLACE', 200078, 'PRINTABLE', 78);
INSERT INTO character_code (id, layer_id, code, evidence, operation, redefines_id, kind, screen_code) VALUES (201079, 200004, 79, 'MANUAL', 'REPLACE', 200079, 'PRINTABLE', 79);
INSERT INTO character_code (id, layer_id, code, evidence, operation, redefines_id, kind, screen_code) VALUES (201080, 200004, 80, 'MANUAL', 'REPLACE', 200080, 'PRINTABLE', 80);
INSERT INTO character_code (id, layer_id, code, evidence, operation, redefines_id, kind, screen_code) VALUES (201081, 200004, 81, 'MANUAL', 'REPLACE', 200081, 'PRINTABLE', 81);
INSERT INTO character_code (id, layer_id, code, evidence, operation, redefines_id, kind, screen_code) VALUES (201082, 200004, 82, 'MANUAL', 'REPLACE', 200082, 'PRINTABLE', 82);
INSERT INTO character_code (id, layer_id, code, evidence, operation, redefines_id, kind, screen_code) VALUES (201083, 200004, 83, 'MANUAL', 'REPLACE', 200083, 'PRINTABLE', 83);
INSERT INTO character_code (id, layer_id, code, evidence, operation, redefines_id, kind, screen_code) VALUES (201084, 200004, 84, 'MANUAL', 'REPLACE', 200084, 'PRINTABLE', 84);
INSERT INTO character_code (id, layer_id, code, evidence, operation, redefines_id, kind, screen_code) VALUES (201085, 200004, 85, 'MANUAL', 'REPLACE', 200085, 'PRINTABLE', 85);
INSERT INTO character_code (id, layer_id, code, evidence, operation, redefines_id, kind, screen_code) VALUES (201086, 200004, 86, 'MANUAL', 'REPLACE', 200086, 'PRINTABLE', 86);
INSERT INTO character_code (id, layer_id, code, evidence, operation, redefines_id, kind, screen_code) VALUES (201087, 200004, 87, 'MANUAL', 'REPLACE', 200087, 'PRINTABLE', 87);
INSERT INTO character_code (id, layer_id, code, evidence, operation, redefines_id, kind, screen_code) VALUES (201088, 200004, 88, 'MANUAL', 'REPLACE', 200088, 'PRINTABLE', 88);
INSERT INTO character_code (id, layer_id, code, evidence, operation, redefines_id, kind, screen_code) VALUES (201089, 200004, 89, 'MANUAL', 'REPLACE', 200089, 'PRINTABLE', 89);
INSERT INTO character_code (id, layer_id, code, evidence, operation, redefines_id, kind, screen_code) VALUES (201090, 200004, 90, 'MANUAL', 'REPLACE', 200090, 'PRINTABLE', 90);
INSERT INTO character_code (id, layer_id, code, evidence, operation, redefines_id, kind, screen_code) VALUES (201091, 200004, 91, 'MANUAL', 'REPLACE', 200091, 'PRINTABLE', 91);
INSERT INTO character_code (id, layer_id, code, evidence, operation, redefines_id, kind, screen_code) VALUES (201092, 200004, 92, 'MANUAL', 'REPLACE', 200092, 'PRINTABLE', 92);
INSERT INTO character_code (id, layer_id, code, evidence, operation, redefines_id, kind, screen_code) VALUES (201093, 200004, 93, 'MANUAL', 'REPLACE', 200093, 'PRINTABLE', 93);
INSERT INTO character_code (id, layer_id, code, evidence, operation, redefines_id, kind, screen_code, notes) VALUES (201094, 200004, 94, 'MANUAL', 'REPLACE', 200094, 'PRINTABLE', 94, 'The power operator (circumflex in later ASCII).');
INSERT INTO character_code (id, layer_id, code, evidence, operation, redefines_id, kind, screen_code, notes) VALUES (201095, 200004, 95, 'MANUAL', 'REPLACE', 200095, 'PRINTABLE', 95, 'Back arrow: "useful on output" [4] p. 68 (underscore in later ASCII).');
INSERT INTO character_code (id, layer_id, code, evidence, operation, redefines_id, kind, name, action) VALUES (201127, 200004, 127, 'MANUAL', 'REPLACE', 200127, 'CONTROL', 'RUB-OUT', 'Tape use only');
INSERT INTO table_status (table_kind_id, layer_id, status, notes) SELECT id, 200004, 'COMPLETE', 'The table of CHANGE [4] p. 68: printable characters 32-94, the back arrow 95 ("useful on output"), EOT 4, BELL 7, LF 10, CR 13, RUB-OUT 127 (tape only); 128 codes in all, the others duplicates, lower case for other Teletypes, or useless.' FROM table_kind WHERE code = 'CHARACTER_CODES';
INSERT INTO table_status (table_kind_id, layer_id, status, notes) SELECT id, 200004, 'NOT_APPLICABLE', 'INPUT reads whole lines.' FROM table_kind WHERE code = 'KEYBOARD_CODES';
INSERT INTO table_status (table_kind_id, layer_id, status, notes) SELECT id, 200004, 'COMPLETE', 'Section 2.8 of [4] pp. 70-73: compile-time messages, run-time messages that stop the program or let it go on, input messages. Printed with the line: `OUT OF DATA IN 20`.' FROM table_kind WHERE code = 'ERRORS';
INSERT INTO table_status (table_kind_id, layer_id, status, notes) SELECT id, 200004, 'COMPLETE', 'As in the 3rd edition [4] p. 12.' FROM table_kind WHERE code = 'OPERATOR_PRECEDENCE';
INSERT INTO table_status (table_kind_id, layer_id, status, notes) SELECT id, 200004, 'TO_DO', 'Not documented. Size rule of thumb: C/4 + M + S < 8000 (C characters of the program, M array elements, S strings) [4] p. 74.' FROM table_kind WHERE code = 'VARIABLE_LAYOUT';
INSERT INTO table_status (table_kind_id, layer_id, status, notes) SELECT id, 200004, 'TO_DO', 'Not documented.' FROM table_kind WHERE code = 'PROGRAM_LAYOUT';
INSERT INTO table_status (table_kind_id, layer_id, status, notes) SELECT id, 200004, 'NOT_APPLICABLE', 'No sound.' FROM table_kind WHERE code = 'MUSICAL_NOTES';
INSERT INTO data_type (id, layer_id, code, name, suffix, type_class_id, minimum, maximum, max_length, precision, operation, redefines_id, notes) VALUES (200002, 200004, 'REAL', 'Number', NULL, 3, -1.70141e+38, 1.70141e+38, NULL, '9 digits', 'REPLACE', 200001, 'Floating point of the GE-635. Constants of up to nine digits, with E and an exponent: `1E7`, `.123456789E-2` [4] p. 14. The largest value is inferred from EXP TOO LARGE (an argument above 88.029 [4] p. 72): about 1.70141E38.');
INSERT INTO data_type (id, layer_id, code, name, suffix, type_class_id, minimum, maximum, max_length, precision, operation, redefines_id, notes) VALUES (200003, 200004, 'STRING', 'String', '$', 4, NULL, NULL, NULL, NULL, 'ADD', NULL, 'No fixed maximum length: a string longer than 60 characters needs a DIM, e.g. `DIM A$(1000)` [4] p. 75. Only assignment, READ, INPUT, PRINT, comparison and CHANGE: no joining or substrings.');
INSERT INTO variable_kind (id, layer_id, code, name, data_type_id, dimensions, name_rule, name_pattern, max_name_length, significant_chars, examples, notes, operation, redefines_id) VALUES (200006, 200004, 'NUMERIC', 'Variable', 200002, 0, 'one letter, or one letter followed by one digit', '^[A-Z][0-9]?$', 2, 0, 'A, X, N5, X0, K9', 'All variables are 0 when the program starts [4] p. 15.', 'REPLACE', 200001);
INSERT INTO variable_kind (id, layer_id, code, name, data_type_id, dimensions, name_rule, name_pattern, max_name_length, significant_chars, examples, notes, operation, redefines_id) VALUES (200007, 200004, 'STRING', 'String variable', 200003, 0, 'a variable name followed by $', '^[A-Z][0-9]?\$$', 2, 0, 'A$, C7$', 'Empty when the program starts (not stated).', 'ADD', NULL);
INSERT INTO variable_kind (id, layer_id, code, name, data_type_id, dimensions, name_rule, name_pattern, max_name_length, significant_chars, examples, notes, operation, redefines_id) VALUES (200008, 200004, 'STRING_LIST', 'String list', 200003, 1, 'one letter followed by $ and a subscript in parentheses', '^[A-Z]\$$', 1, 0, 'V$(3)', 'One dimension only: there are no string tables [4] p. 63.', 'ADD', NULL);
INSERT INTO parameter_kind (id, layer_id, code, name, nature, type_class_id, variable_kind_id, notes, operation, redefines_id) VALUES (200014, 200004, 'STR_LITERAL', 'String', 'LITERAL', 4, NULL, 'In quotes; in DATA and INPUT also without quotes if it starts with a letter and has no comma [4] p. 64.', 'ADD', NULL);
INSERT INTO parameter_kind (id, layer_id, code, name, nature, type_class_id, variable_kind_id, notes, operation, redefines_id) VALUES (200015, 200004, 'STR_EXPR', 'String value', 'EXPRESSION', 4, NULL, 'A string in quotes, a string variable or a list element.', 'ADD', NULL);
INSERT INTO parameter_kind (id, layer_id, code, name, nature, type_class_id, variable_kind_id, notes, operation, redefines_id) VALUES (200016, 200004, 'STR_VAR', 'String variable', 'VARIABLE', NULL, 200007, NULL, 'ADD', NULL);
INSERT INTO parameter_kind (id, layer_id, code, name, nature, type_class_id, variable_kind_id, notes, operation, redefines_id) VALUES (200017, 200004, 'STR_LIST_ELEMENT', 'String list element', 'ARRAY_ELEMENT', NULL, 200008, 'E.g. V$(3).', 'ADD', NULL);
INSERT INTO parameter_kind (id, layer_id, code, name, nature, type_class_id, variable_kind_id, notes, operation, redefines_id) VALUES (200018, 200004, 'ANY_VAR', 'Variable or element', 'VARIABLE', NULL, NULL, 'A numeric or string variable, or an element of a list or table.', 'REPLACE', 200009);
INSERT INTO parameter_kind (id, layer_id, code, name, nature, type_class_id, variable_kind_id, notes, operation, redefines_id) VALUES (200019, 200004, 'CONDITION', 'Relation', 'CONDITION', 5, NULL, 'Two formulas, or two strings, joined by one relation: = < <= > >= <>. Strings are compared in alphabetical order, trailing blanks ignored [4] p. 65.', 'REPLACE', 200011);
INSERT INTO parameter_kind (id, layer_id, code, name, nature, type_class_id, variable_kind_id, notes, operation, redefines_id) VALUES (200020, 200004, 'LINE_LIST', 'Line numbers', 'LITERAL', 2, NULL, 'Line numbers separated by commas.', 'ADD', NULL);
INSERT INTO feature (layer_id, feature_kind_id, value, verified, notes, operation, redefines_id) SELECT 200004, id, 'Integer part (floor)', 0, 'ON and TAB use the integer part of their formula [4] pp. 36, 40; INT is the floor.', 'REPLACE', (SELECT f.id FROM feature f JOIN feature_kind k ON k.id = f.feature_kind_id WHERE f.layer_id = 200003 AND k.code = 'INTEGER_CONVERSION') FROM feature_kind WHERE code = 'INTEGER_CONVERSION';
INSERT INTO feature (layer_id, feature_kind_id, value, verified, notes, operation, redefines_id) SELECT 200004, id, 'Yes', 0, 'The start, limit and step are computed once; the body may change the variable, and the end test uses its current value [4] p. 37.', 'REPLACE', (SELECT f.id FROM feature f JOIN feature_kind k ON k.id = f.feature_kind_id WHERE f.layer_id = 200001 AND k.code = 'FOR_VARIABLE_CHANGEABLE') FROM feature_kind WHERE code = 'FOR_VARIABLE_CHANGEABLE';
INSERT INTO feature (layer_id, feature_kind_id, value, verified, notes, operation, redefines_id) SELECT 200004, id, 'No', 0, 'TAB(n) in PRINT moves to column n (0-74), but there are no tab stops.', 'REPLACE', (SELECT f.id FROM feature f JOIN feature_kind k ON k.id = f.feature_kind_id WHERE f.layer_id = 200001 AND k.code = 'VARIABLE_TAB_STOPS') FROM feature_kind WHERE code = 'VARIABLE_TAB_STOPS';
INSERT INTO error (id, layer_id, code, message, operation, redefines_id, description) VALUES (200039, 200004, 'INCORRECT_FORMAT', 'ILLEGAL FORMAT', 'REPLACE', 200002, 'The form of the statement is wrong [4] p. 70.');
INSERT INTO error (id, layer_id, code, message, operation, redefines_id) VALUES (200040, 200004, 'NO_DATA', 'NO DATA', 'REMOVE', 200005);
INSERT INTO error (id, layer_id, code, message, operation, redefines_id, description) VALUES (200041, 200004, 'NO_NUMERIC_DATA', 'NO NUMERIC DATA', 'ADD', NULL, 'READ of a number, but no number in DATA [4] p. 70.');
INSERT INTO error (id, layer_id, code, message, operation, redefines_id, description) VALUES (200042, 200004, 'NO_STRING_DATA', 'NO STRING DATA', 'ADD', NULL, 'READ of a string, but no string in DATA [4] p. 70.');
INSERT INTO error (id, layer_id, code, message, operation, redefines_id, description) VALUES (200043, 200004, 'UNDEFINED_FUNCTION', 'UNDEFINED FUNCTION FN', 'REPLACE', 200013, 'A function FN is used but never defined [4] p. 70.');
INSERT INTO error (id, layer_id, code, message, operation, redefines_id, description) VALUES (200044, 200004, 'UNDEFINED_NUMBER', 'UNDEFINED LINE NUMBER', 'REPLACE', 200004, 'A jump to a line that does not exist: `UNDEFINED LINE NUMBER 50 IN 20` [4] p. 31.');
INSERT INTO error (id, layer_id, code, message, operation, redefines_id, description) VALUES (200045, 200004, 'NOT_MATCH_WITH_FOR', 'NEXT WITHOUT FOR', 'REPLACE', 200018, 'NEXT with no FOR, or loops crossed [4] p. 30.');
INSERT INTO error (id, layer_id, code, message, operation, redefines_id) VALUES (200046, 200004, 'PROGRAM_TOO_LONG', 'PROGRAM TOO LONG', 'REMOVE', 200014);
INSERT INTO error (id, layer_id, code, message, operation, redefines_id) VALUES (200047, 200004, 'TOO_MUCH_DATA', 'TOO MUCH DATA', 'REMOVE', 200015);
INSERT INTO error (id, layer_id, code, message, operation, redefines_id) VALUES (200048, 200004, 'TOO_MANY_LOOPS', 'TOO MANY LOOPS', 'REMOVE', 200017);
INSERT INTO error (id, layer_id, code, message, operation, redefines_id) VALUES (200049, 200004, 'NEARLY_SINGULAR', 'NEARLY SINGULAR MATRIX', 'REMOVE', 200030);
INSERT INTO error (id, layer_id, code, message, operation, redefines_id, description) VALUES (200050, 200004, 'SQR_NEGATIVE', 'SQUARE ROOT OF NEGATIVE NUMBER', 'REPLACE', 200038, 'The root of the absolute value is used [4] p. 72.');
INSERT INTO error (id, layer_id, code, message, operation, redefines_id, description) VALUES (200051, 200004, 'ILLEGAL_CHARACTER', 'ILLEGAL CHARACTER', 'ADD', NULL, '[4] p. 70.');
INSERT INTO error (id, layer_id, code, message, operation, redefines_id, description) VALUES (200052, 200004, 'WRONG_ARGUMENTS', 'INCORRECT NUMBER OF ARGUMENTS', 'ADD', NULL, '[4] p. 70.');
INSERT INTO error (id, layer_id, code, message, operation, redefines_id, description) VALUES (200053, 200004, 'WRONG_SUBSCRIPTS', 'INCORRECT NUMBER OF SUBSCRIPTS', 'ADD', NULL, '[4] p. 70.');
INSERT INTO error (id, layer_id, code, message, operation, redefines_id, description) VALUES (200054, 200004, 'FORS_TOO_DEEP', 'FORS NESTED TOO DEEPLY', 'ADD', NULL, '[4] p. 71.');
INSERT INTO error (id, layer_id, code, message, operation, redefines_id, description) VALUES (200055, 200004, 'ILLEGAL_LINE_REFERENCE', 'ILLEGAL LINE REFERENCE', 'ADD', NULL, 'E.g. a jump into a multi-line DEF [4] p. 71.');
INSERT INTO error (id, layer_id, code, message, operation, redefines_id, description) VALUES (200056, 200004, 'UNFINISHED_DEF', 'UNFINISHED DEF', 'ADD', NULL, 'A multi-line DEF without FNEND [4] p. 71.');
INSERT INTO error (id, layer_id, code, message, operation, redefines_id, description) VALUES (200057, 200004, 'NESTED_DEF', 'NESTED DEF', 'ADD', NULL, 'A DEF inside a multi-line DEF [4] p. 71.');
INSERT INTO error (id, layer_id, code, message, operation, redefines_id, description) VALUES (200058, 200004, 'TOO_COMPLICATED', 'EXPRESSION TOO COMPLICATED', 'ADD', NULL, '[4] p. 71.');
INSERT INTO error (id, layer_id, code, message, operation, redefines_id, description) VALUES (200059, 200004, 'TOO_MANY_CONSTANTS', 'TOO MANY CONSTANTS', 'ADD', NULL, 'More than 100 constants (small integers do not count) [4] p. 75.');
INSERT INTO error (id, layer_id, code, message, operation, redefines_id, description) VALUES (200060, 200004, 'ILLEGAL_MAT_TRANSPOSE', 'ILLEGAL MAT TRANSPOSE', 'ADD', NULL, 'E.g. MAT A = TRN(A) [4] p. 71.');
INSERT INTO error (id, layer_id, code, message, operation, redefines_id, description) VALUES (200061, 200004, 'ILLEGAL_MAT_FUNCTION', 'ILLEGAL MAT FUNCTION', 'ADD', NULL, '[4] p. 71.');
INSERT INTO error (id, layer_id, code, message, operation, redefines_id, description) VALUES (200062, 200004, 'ILLEGAL_MAT_MULTIPLE', 'ILLEGAL MAT MULTIPLE', 'ADD', NULL, 'E.g. MAT A = A * B [4] p. 71.');
INSERT INTO error (id, layer_id, code, message, operation, redefines_id, description) VALUES (200063, 200004, 'MISMATCHED_STRING', 'MISMATCHED STRING OPERATION', 'ADD', NULL, 'A string where a number is wanted, or the other way round [4] p. 71.');
INSERT INTO error (id, layer_id, code, message, operation, redefines_id, description) VALUES (200064, 200004, 'SYSTEM_ERROR', 'SYSTEM ERROR', 'ADD', NULL, '[4] p. 71.');
INSERT INTO error (id, layer_id, code, message, operation, redefines_id, description) VALUES (200065, 200004, 'ON_OUT_OF_RANGE', 'ON EVALUATED OUT OF RANGE', 'ADD', NULL, 'The formula of ON is below 1 or beyond the list [4] p. 72.');
INSERT INTO error (id, layer_id, code, message, operation, redefines_id, description) VALUES (200066, 200004, 'USELESS_LOOP', 'USELESS LOOP', 'ADD', NULL, '[4] p. 72.');
INSERT INTO error (id, layer_id, code, message, operation, redefines_id, description) VALUES (200067, 200004, 'OUT_OF_ROOM', 'OUT OF ROOM', 'ADD', NULL, '[4] p. 72.');
INSERT INTO error (id, layer_id, code, message, operation, redefines_id, description) VALUES (200068, 200004, 'TIME_UP', 'TIME UP - LOOPING', 'ADD', NULL, 'Only in TEACH programs [4] p. 72.');
INSERT INTO error (id, layer_id, code, message, operation, redefines_id, description) VALUES (200069, 200004, 'INPUT_FORMAT', 'INPUT DATA NOT IN CORRECT FORMAT--RETYPE IT', 'ADD', NULL, '[4] p. 73.');
INSERT INTO error (id, layer_id, code, message, operation, redefines_id, description) VALUES (200070, 200004, 'NOT_ENOUGH_INPUT', 'NOT ENOUGH INPUT--ADD MORE', 'ADD', NULL, '[4] p. 73.');
INSERT INTO error (id, layer_id, code, message, operation, redefines_id, description) VALUES (200071, 200004, 'TOO_MUCH_INPUT', 'TOO MUCH INPUT--EXCESS IGNORED', 'ADD', NULL, '[4] p. 73.');
INSERT INTO error_rule (layer_id, selector, selector_value, error_code, cause, verified) VALUES (200004, 'PARAMETER_KIND', 'STR_EXPR', 'MISMATCHED_STRING', 'A number where a string is wanted.', 0);
INSERT INTO error_rule (layer_id, selector, selector_value, error_code, cause, verified) VALUES (200004, 'PARAMETER_KIND', 'NUM_EXPR', 'MISMATCHED_STRING', 'A string where a number is wanted.', 0);
INSERT INTO error_rule (layer_id, selector, selector_value, error_code, cause, verified) VALUES (200004, 'PARAMETER_KIND', 'LIST_ELEMENT', 'WRONG_SUBSCRIPTS', 'Two subscripts for a list.', 0);
INSERT INTO error_rule (layer_id, selector, selector_value, error_code, cause, verified) VALUES (200004, 'PARAMETER_KIND', 'TABLE_ELEMENT', 'WRONG_SUBSCRIPTS', 'One subscript for a table.', 0);
INSERT INTO keyword (id, layer_id, text, notes) VALUES (200063, 200004, 'ON', NULL);
INSERT INTO keyword (id, layer_id, text, notes) VALUES (200064, 200004, 'TAB', NULL);
INSERT INTO keyword (id, layer_id, text, notes) VALUES (200065, 200004, 'RANDOMIZE', 'RANDOM also accepted [4] p. 45.');
INSERT INTO keyword (id, layer_id, text, notes) VALUES (200066, 200004, 'CHANGE', NULL);
INSERT INTO keyword (id, layer_id, text, notes) VALUES (200067, 200004, 'FNEND', NULL);
INSERT INTO keyword (id, layer_id, text, notes) VALUES (200068, 200004, 'COT', NULL);
INSERT INTO keyword (id, layer_id, text, notes) VALUES (200069, 200004, 'NUM', NULL);
INSERT INTO keyword (id, layer_id, text, notes) VALUES (200070, 200004, 'DET', NULL);
INSERT INTO keyword (id, layer_id, text, notes) VALUES (200071, 200004, 'RESTORE*', NULL);
INSERT INTO keyword (id, layer_id, text, notes) VALUES (200072, 200004, 'RESTORE$', NULL);
INSERT INTO keyword (id, layer_id, text, notes) VALUES (200073, 200004, '''', 'Remark to the end of the line.');
INSERT INTO keyword (id, layer_id, text, notes) VALUES (200074, 200004, 'BYE', 'GOODBYE is also accepted [4] p. 27.');
INSERT INTO keyword (id, layer_id, text, notes) VALUES (200075, 200004, 'REPLACE', NULL);

-- BYE (COMMAND)
INSERT INTO entry (id, layer_id, name, category_id, operation, redefines_id, description, difference_notes, notes) VALUES (200075, 200004, 'BYE', 2, 'ADD', NULL, 'Ends the session.', NULL, 'Also GOODBYE [4] p. 27.');
INSERT INTO entry_source (entry_id, source_id, page) VALUES (200075, 200004, '27');
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, return_min_inclusive, return_max_inclusive, precedence, associativity, operator_class_id, evidence) VALUES (200085, 200075, 1, NULL, NULL, 'BYE', 200004, '27', NULL, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000463, 200085, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000464, 200085, 2000463, 1, 'KEYWORD', 0, NULL, 200074);
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 200085, id, 'FULL', NULL FROM action WHERE code = 'SESSION_END';
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id, page) VALUES (200075, NULL, 1, 'End of the session', NULL, 'BYE', NULL, 0, NULL, NULL);

-- REPLACE (COMMAND)
INSERT INTO entry (id, layer_id, name, category_id, operation, redefines_id, description, difference_notes, notes) VALUES (200076, 200004, 'REPLACE', 2, 'ADD', NULL, 'Saves the program in place of the saved copy with the same name.', NULL, NULL);
INSERT INTO entry_source (entry_id, source_id, page) VALUES (200076, 200004, '78');
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, return_min_inclusive, return_max_inclusive, precedence, associativity, operator_class_id, evidence) VALUES (200086, 200076, 1, NULL, NULL, 'REPLACE', 200004, '78', NULL, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000465, 200086, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000466, 200086, 2000465, 1, 'KEYWORD', 0, NULL, 200075);
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 200086, id, 'PARTIAL', 'Replaces the saved copy' FROM action WHERE code = 'TAPE_SAVE';

-- LET (STATEMENT)
INSERT INTO entry (id, layer_id, name, category_id, operation, redefines_id, description, difference_notes, notes) VALUES (200077, 200004, 'LET', 1, 'REPLACE', 200006, 'Computes the value of a formula and gives it to a variable.', 'Strings, and several variables in one LET.', '`LET X = Y = A(3,1) = 1` gives all three the value 1 [4] p. 33.');
INSERT INTO entry_source (entry_id, source_id, page) VALUES (200077, 200004, '32-33');
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, return_min_inclusive, return_max_inclusive, precedence, associativity, operator_class_id, evidence) VALUES (200087, 200077, 1, NULL, NULL, 'LET X = Y = A(3,1) = 1', 200004, '32-33', NULL, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200112, 200087, 'variable', 'NONE', NULL, NULL, 'Numeric or string variables or elements; several can get the same value.', 'MANUAL');
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200113, 200087, 'formula', 'NONE', NULL, NULL, 'A formula, or a string for string variables.', 'MANUAL');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000467, 200087, NULL, 1, 'CHOICE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000468, 200087, 2000467, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000469, 200087, 2000468, 1, 'KEYWORD', 0, NULL, 200006);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, separator, min_occ, max_occ) VALUES (2000470, 200087, 2000468, 2, 'REPEAT', 0, NULL, NULL, 1, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000471, 200087, 2000470, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000472, 200087, 2000471, 1, 'CHOICE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000473, 200087, 2000472, 1, 'PARAMETER', 0, NULL, 200112, 200006);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000474, 200087, 2000472, 2, 'PARAMETER', 0, NULL, 200112, 200007);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000475, 200087, 2000472, 3, 'PARAMETER', 0, NULL, 200112, 200008);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000476, 200087, 2000471, 2, 'KEYWORD', 0, NULL, 200039);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000477, 200087, 2000468, 3, 'PARAMETER', 0, NULL, 200113, 200005);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000478, 200087, 2000467, 2, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000479, 200087, 2000478, 1, 'KEYWORD', 0, NULL, 200006);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, separator, min_occ, max_occ) VALUES (2000480, 200087, 2000478, 2, 'REPEAT', 0, NULL, NULL, 1, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000481, 200087, 2000480, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000482, 200087, 2000481, 1, 'CHOICE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000483, 200087, 2000482, 1, 'PARAMETER', 0, NULL, 200112, 200016);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000484, 200087, 2000482, 2, 'PARAMETER', 0, NULL, 200112, 200017);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000485, 200087, 2000481, 2, 'KEYWORD', 0, NULL, 200039);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000486, 200087, 2000478, 3, 'PARAMETER', 0, NULL, 200113, 200015);
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 200087, id, 'FULL', NULL FROM action WHERE code = 'VAR_LET';
INSERT INTO entry_error (entry_id, form_id, parameter_id, error_code, operation, cause, verified, position) VALUES (200077, NULL, NULL, 'ILLEGAL_VARIABLE', 'ADD', 'The name on the left is not a variable.', 0, 1);
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id, page) VALUES (200077, NULL, 1, 'Several at once', NULL, '10 LET X = Y = 1
20 LET A$ = "YES"
30 PRINT X; Y; A$
40 END', ' 1  1 YES', 0, NULL, NULL);

-- PRINT (STATEMENT)
INSERT INTO entry (id, layer_id, name, category_id, operation, redefines_id, description, difference_notes, notes) VALUES (200078, 200004, 'PRINT', 1, 'REPLACE', 200073, 'Types the values of formulas and labels on a line.', 'Strings and TAB(n).', 'Integers of more than eight digits are printed as `1.34218 E+8`; other numbers with up to six significant digits, below 0.1 in E form unless they fit in six decimal places [4] p. 41.');
INSERT INTO entry_source (entry_id, source_id, page) VALUES (200078, 200004, '34, 38-42');
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, return_min_inclusive, return_max_inclusive, precedence, associativity, operator_class_id, evidence) VALUES (200088, 200078, 1, NULL, ''','' moves to the next of five zones of 15 columns; '';'' packs: a number is printed as its sign (minus or space), the digits and one space. A final '','' or '';'' keeps the line open.', 'PRINT', 200004, '34, 38-42', NULL, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200114, 200088, 'label', 'NONE', NULL, NULL, 'Text in quotes.', 'MANUAL');
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200115, 200088, 'formula', 'NONE', NULL, NULL, 'Any formula.', 'MANUAL');
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200116, 200088, 'string', 'NONE', NULL, NULL, 'A string variable or element.', 'MANUAL');
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200117, 200088, 'n', 'TRUNCATE', NULL, NULL, 'Column 0 to 74: integer part, taken modulo 75.', 'MANUAL');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000487, 200088, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000488, 200088, 2000487, 1, 'KEYWORD', 0, NULL, 200007);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000489, 200088, 2000487, 2, 'OPTIONAL', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000490, 200088, 2000489, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000491, 200088, 2000490, 1, 'CHOICE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000492, 200088, 2000491, 1, 'PARAMETER', 0, NULL, 200114, 200003);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000493, 200088, 2000491, 2, 'PARAMETER', 0, NULL, 200115, 200005);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000494, 200088, 2000491, 3, 'PARAMETER', 0, NULL, 200116, 200015);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000495, 200088, 2000491, 4, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000496, 200088, 2000495, 1, 'KEYWORD', 0, NULL, 200064);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, text) VALUES (2000497, 200088, 2000495, 2, 'LITERAL', 1, NULL, '(');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000498, 200088, 2000495, 3, 'PARAMETER', 1, NULL, 200117, 200005);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, text) VALUES (2000499, 200088, 2000495, 4, 'LITERAL', 1, NULL, ')');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, separator, min_occ, max_occ) VALUES (2000500, 200088, 2000490, 2, 'REPEAT', 0, NULL, NULL, 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000501, 200088, 2000500, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000502, 200088, 2000501, 1, 'CHOICE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, text) VALUES (2000503, 200088, 2000502, 1, 'LITERAL', 0, NULL, ',');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, text) VALUES (2000504, 200088, 2000502, 2, 'LITERAL', 0, NULL, ';');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000505, 200088, 2000501, 2, 'CHOICE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000506, 200088, 2000505, 1, 'PARAMETER', 0, NULL, 200114, 200003);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000507, 200088, 2000505, 2, 'PARAMETER', 0, NULL, 200115, 200005);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000508, 200088, 2000505, 3, 'PARAMETER', 0, NULL, 200116, 200015);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000509, 200088, 2000505, 4, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000510, 200088, 2000509, 1, 'KEYWORD', 0, NULL, 200064);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, text) VALUES (2000511, 200088, 2000509, 2, 'LITERAL', 1, NULL, '(');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000512, 200088, 2000509, 3, 'PARAMETER', 1, NULL, 200117, 200005);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, text) VALUES (2000513, 200088, 2000509, 4, 'LITERAL', 1, NULL, ')');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000514, 200088, 2000490, 3, 'OPTIONAL', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000515, 200088, 2000514, 1, 'CHOICE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, text) VALUES (2000516, 200088, 2000515, 1, 'LITERAL', 0, NULL, ',');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, text) VALUES (2000517, 200088, 2000515, 2, 'LITERAL', 0, NULL, ';');
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 200088, id, 'FULL', NULL FROM action WHERE code = 'IO_PRINT';
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 200088, id, 'FULL', 'TAB(n)' FROM action WHERE code = 'IO_POSITION';
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id, page) VALUES (200078, NULL, 1, 'Columns', 'B in column 10.', '10 PRINT "A"; TAB(10); "B"
20 END', 'A         B', 0, NULL, NULL);

-- INPUT (STATEMENT)
INSERT INTO entry (id, layer_id, name, category_id, operation, redefines_id, description, difference_notes, notes) VALUES (200079, 200004, 'INPUT', 1, 'REPLACE', 200057, 'Types a question mark and waits for values typed at the Teletype.', 'Strings, and messages for wrong input.', 'Types `?`; the values are separated by commas. A PRINT ending with '';'' keeps the question mark on its line. Strings can be typed without quotes if they start with a letter [4] pp. 50-51, 64.');
INSERT INTO entry_source (entry_id, source_id, page) VALUES (200079, 200004, '50-51');
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, return_min_inclusive, return_max_inclusive, precedence, associativity, operator_class_id, evidence) VALUES (200089, 200079, 1, NULL, NULL, 'INPUT X, Y', 200004, '50-51', NULL, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200118, 200089, 'variable', 'NONE', NULL, NULL, 'Variables or elements, separated by commas; the values are typed the same way.', 'MANUAL');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000518, 200089, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000519, 200089, 2000518, 1, 'KEYWORD', 0, NULL, 200052);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, separator, min_occ, max_occ) VALUES (2000520, 200089, 2000518, 2, 'REPEAT', 0, NULL, ',', 1, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000521, 200089, 2000520, 1, 'PARAMETER', 0, NULL, 200118, 200018);
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 200089, id, 'FULL', NULL FROM action WHERE code = 'IO_INPUT';
INSERT INTO entry_error (entry_id, form_id, parameter_id, error_code, operation, cause, verified, position) VALUES (200079, NULL, NULL, 'INPUT_FORMAT', 'ADD', 'The values typed are not in the right form.', 0, 1);
INSERT INTO entry_error (entry_id, form_id, parameter_id, error_code, operation, cause, verified, position) VALUES (200079, NULL, NULL, 'NOT_ENOUGH_INPUT', 'ADD', 'Fewer values than variables.', 0, 2);
INSERT INTO entry_error (entry_id, form_id, parameter_id, error_code, operation, cause, verified, position) VALUES (200079, NULL, NULL, 'TOO_MUCH_INPUT', 'ADD', 'More values than variables.', 0, 3);
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id, page) VALUES (200079, NULL, 1, 'A name', NULL, '10 PRINT "NAME";
20 INPUT N$
30 PRINT "HELLO "; N$
40 END', 'NAME?', 0, NULL, NULL);

-- READ (STATEMENT)
INSERT INTO entry (id, layer_id, name, category_id, operation, redefines_id, description, difference_notes, notes) VALUES (200080, 200004, 'READ', 1, 'REPLACE', 200070, 'Gives the variables the next numbers of the DATA statements.', 'Strings; the data are two separate lists.', 'Numbers and strings of the DATA statements form two separate lists: a numeric READ takes the next number, a string READ the next string [4] p. 66. When the data run out: OUT OF DATA [4] p. 33.');
INSERT INTO entry_source (entry_id, source_id, page) VALUES (200080, 200004, '33, 66');
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, return_min_inclusive, return_max_inclusive, precedence, associativity, operator_class_id, evidence) VALUES (200090, 200080, 1, NULL, NULL, 'READ A, B, C', 200004, '33, 66', NULL, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200119, 200090, 'variable', 'NONE', NULL, NULL, 'Variables or elements, separated by commas.', 'MANUAL');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000522, 200090, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000523, 200090, 2000522, 1, 'KEYWORD', 0, NULL, 200018);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, separator, min_occ, max_occ) VALUES (2000524, 200090, 2000522, 2, 'REPEAT', 0, NULL, ',', 1, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000525, 200090, 2000524, 1, 'PARAMETER', 0, NULL, 200119, 200018);
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 200090, id, 'FULL', NULL FROM action WHERE code = 'DATA_READ';
INSERT INTO entry_error (entry_id, form_id, parameter_id, error_code, operation, cause, verified, position) VALUES (200080, NULL, NULL, 'OUT_OF_DATA', 'ADD', 'No data left.', 0, 1);
INSERT INTO entry_error (entry_id, form_id, parameter_id, error_code, operation, cause, verified, position) VALUES (200080, NULL, NULL, 'NO_NUMERIC_DATA', 'ADD', 'A number is read but DATA holds none.', 0, 2);
INSERT INTO entry_error (entry_id, form_id, parameter_id, error_code, operation, cause, verified, position) VALUES (200080, NULL, NULL, 'NO_STRING_DATA', 'ADD', 'A string is read but DATA holds none.', 0, 3);
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id, page) VALUES (200080, NULL, 1, 'Numbers and strings', NULL, '10 READ A$, N
20 PRINT A$; N
30 DATA "TEN", 10
40 END', 'TEN 10', 0, NULL, NULL);

-- DATA (STATEMENT)
INSERT INTO entry (id, layer_id, name, category_id, operation, redefines_id, description, difference_notes, notes) VALUES (200081, 200004, 'DATA', 1, 'REPLACE', 200074, 'Numbers for READ, taken in the order of the DATA statements.', 'Strings too.', 'Never executed; all DATA statements form one list, in the order of their numbers [4] p. 33-34.');
INSERT INTO entry_source (entry_id, source_id, page) VALUES (200081, 200004, '33-34');
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, return_min_inclusive, return_max_inclusive, precedence, associativity, operator_class_id, evidence) VALUES (200091, 200081, 1, NULL, NULL, 'DATA', 200004, '33-34', NULL, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200120, 200091, 'item', 'NONE', NULL, NULL, 'Numbers (not formulas) and strings, separated by commas.', 'MANUAL');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000526, 200091, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000527, 200091, 2000526, 1, 'KEYWORD', 0, NULL, 200019);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, separator, min_occ, max_occ) VALUES (2000528, 200091, 2000526, 2, 'REPEAT', 0, NULL, ',', 1, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000529, 200091, 2000528, 1, 'CHOICE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000530, 200091, 2000529, 1, 'PARAMETER', 0, NULL, 200120, 200001);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000531, 200091, 2000529, 2, 'PARAMETER', 0, NULL, 200120, 200014);
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 200091, id, 'FULL', NULL FROM action WHERE code = 'DATA_DEFINE';
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id, page) VALUES (200081, NULL, 1, 'Unquoted string', NULL, '10 READ A$
20 PRINT A$
30 DATA HELLO
40 END', 'HELLO', 0, NULL, NULL);

-- RESTORE (STATEMENT)
INSERT INTO entry (id, layer_id, name, category_id, operation, redefines_id, description, difference_notes, notes) VALUES (200082, 200004, 'RESTORE', 1, 'REPLACE', 200058, 'Starts the data list again: the next READ takes the first number.', 'RESTORE* and RESTORE$ restart only one of the two data lists.', NULL);
INSERT INTO entry_source (entry_id, source_id, page) VALUES (200082, 200004, '52, 66');
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, return_min_inclusive, return_max_inclusive, precedence, associativity, operator_class_id, evidence) VALUES (200092, 200082, 1, 'Both lists', NULL, 'RESTORE', 200004, '52, 66', NULL, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000532, 200092, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000533, 200092, 2000532, 1, 'KEYWORD', 0, NULL, 200053);
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 200092, id, 'FULL', NULL FROM action WHERE code = 'DATA_RESTORE';
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, return_min_inclusive, return_max_inclusive, precedence, associativity, operator_class_id, evidence) VALUES (200093, 200082, 2, 'Numbers', NULL, 'RESTORE*', 200004, '52, 66', NULL, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000534, 200093, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000535, 200093, 2000534, 1, 'KEYWORD', 0, NULL, 200071);
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 200093, id, 'PARTIAL', 'Only the numbers' FROM action WHERE code = 'DATA_RESTORE';
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, return_min_inclusive, return_max_inclusive, precedence, associativity, operator_class_id, evidence) VALUES (200094, 200082, 3, 'Strings', NULL, 'RESTORE$', 200004, '52, 66', NULL, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000536, 200094, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000537, 200094, 2000536, 1, 'KEYWORD', 0, NULL, 200072);
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 200094, id, 'PARTIAL', 'Only the strings' FROM action WHERE code = 'DATA_RESTORE';
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id, page) VALUES (200082, 200094, 1, 'Only the strings', NULL, '10 READ A$, B$, N
20 RESTORE$
30 READ C$
40 PRINT C$; N
50 DATA "X", "Y", 5
60 END', 'X 5', 0, NULL, NULL);

-- IF...THEN (STATEMENT)
INSERT INTO entry (id, layer_id, name, category_id, operation, redefines_id, description, difference_notes, notes) VALUES (200083, 200004, 'IF...THEN', 1, 'REPLACE', 200012, 'Jumps to a line if a relation between two formulas is true.', 'Strings can be compared; GO TO can replace THEN.', 'If the relation is false the program goes on with the next statement. GO TO and IF...THEN may jump to a REM or DATA line, which does nothing [2] p. 45.');
INSERT INTO entry_source (entry_id, source_id, page) VALUES (200083, 200004, '35-36');
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, return_min_inclusive, return_max_inclusive, precedence, associativity, operator_class_id, evidence) VALUES (200095, 200083, 1, NULL, NULL, 'IF ... THEN line', 200004, '35-36', NULL, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200121, 200095, 'relation', 'NONE', NULL, NULL, 'Two formulas or two strings joined by a relation.', 'MANUAL');
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200122, 200095, 'n', 'NONE', 'UNDEFINED_NUMBER', 'ERROR', 'Line number: an integer of up to five digits, written as a number (not a formula).', 'MANUAL');
INSERT INTO parameter_limit (parameter_id, minimum, maximum, notes, min_inclusive, max_inclusive, evidence) VALUES (200122, 1, 99999, NULL, 1, 1, 'MANUAL');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000538, 200095, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000539, 200095, 2000538, 1, 'KEYWORD', 0, NULL, 200014);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000540, 200095, 2000538, 2, 'PARAMETER', 0, NULL, 200121, 200019);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000541, 200095, 2000538, 3, 'CHOICE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000542, 200095, 2000541, 1, 'KEYWORD', 0, NULL, 200015);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000543, 200095, 2000541, 2, 'KEYWORD', 0, NULL, 200013);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000544, 200095, 2000538, 4, 'PARAMETER', 0, NULL, 200122, 200002);
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 200095, id, 'PARTIAL', 'Only a jump, no ELSE' FROM action WHERE code = 'FLOW_IF';
INSERT INTO entry_error (entry_id, form_id, parameter_id, error_code, operation, cause, verified, position) VALUES (200083, NULL, NULL, 'INCORRECT_FORMAT', 'ADD', 'The IF...THEN is not written in its form ([1] p. 19).', 0, 1);
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id, page) VALUES (200083, NULL, 1, 'Strings', 'Trailing blanks do not count: "YES " = "YES".', '10 INPUT A$
20 IF A$ = "YES" THEN 50
30 PRINT "NO"
40 STOP
50 PRINT "OK"
60 END', NULL, 0, NULL, NULL);

-- ON...GO TO (STATEMENT)
INSERT INTO entry (id, layer_id, name, category_id, operation, redefines_id, description, difference_notes, notes) VALUES (200084, 200004, 'ON...GO TO', 1, 'ADD', NULL, 'Jumps to the first, second, ... line of the list, according to the value of a formula.', NULL, 'THEN can be written instead of GO TO [4] p. 36.');
INSERT INTO entry_source (entry_id, source_id, page) VALUES (200084, 200004, '36');
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, return_min_inclusive, return_max_inclusive, precedence, associativity, operator_class_id, evidence) VALUES (200096, 200084, 1, NULL, NULL, 'ON expr GO TO l1, l2, ...', 200004, '36', NULL, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200123, 200096, 'f', 'TRUNCATE', NULL, NULL, 'Integer part 1 selects the first line, 2 the second, ...', 'MANUAL');
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200124, 200096, 'lines', 'NONE', 'UNDEFINED_NUMBER', 'ERROR', 'Line numbers separated by commas.', 'MANUAL');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000545, 200096, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000546, 200096, 2000545, 1, 'KEYWORD', 0, NULL, 200063);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000547, 200096, 2000545, 2, 'PARAMETER', 0, NULL, 200123, 200005);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000548, 200096, 2000545, 3, 'CHOICE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000549, 200096, 2000548, 1, 'KEYWORD', 0, NULL, 200013);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000550, 200096, 2000548, 2, 'KEYWORD', 0, NULL, 200015);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000551, 200096, 2000545, 4, 'PARAMETER', 0, NULL, 200124, 200020);
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 200096, id, 'FULL', NULL FROM action WHERE code = 'FLOW_ON_GOTO';
INSERT INTO entry_error (entry_id, form_id, parameter_id, error_code, operation, cause, verified, position) VALUES (200084, NULL, NULL, 'ON_OUT_OF_RANGE', 'ADD', 'The integer part is below 1 or beyond the number of lines.', 0, 1);
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id, page) VALUES (200084, NULL, 1, 'Three ways', 'Type 2: TWO is printed.', '10 INPUT K
20 ON K GO TO 100, 200, 300
100 PRINT "ONE"
110 STOP
200 PRINT "TWO"
210 STOP
300 PRINT "THREE"
999 END', NULL, 0, NULL, NULL);

-- RANDOMIZE (STATEMENT)
INSERT INTO entry (id, layer_id, name, category_id, operation, redefines_id, description, difference_notes, notes) VALUES (200085, 200004, 'RANDOMIZE', 1, 'ADD', NULL, 'Starts RND from an unpredictable point.', NULL, 'Without it RND gives the same numbers at every run: leave it out while debugging [4] p. 45.');
INSERT INTO entry_source (entry_id, source_id, page) VALUES (200085, 200004, '45');
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, return_min_inclusive, return_max_inclusive, precedence, associativity, operator_class_id, evidence) VALUES (200097, 200085, 1, NULL, NULL, 'RANDOMIZE', 200004, '45', NULL, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000552, 200097, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000553, 200097, 2000552, 1, 'KEYWORD', 0, NULL, 200065);
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 200097, id, 'PARTIAL', 'No seed value: an unpredictable start' FROM action WHERE code = 'RND_SEED';
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id, page) VALUES (200085, NULL, 1, 'Dice', 'Different numbers at every run.', '10 RANDOMIZE
20 FOR I = 1 TO 5
30 PRINT INT(6*RND+1);
40 NEXT I
50 END', NULL, 0, NULL, NULL);

-- CHANGE (STATEMENT)
INSERT INTO entry (id, layer_id, name, category_id, operation, redefines_id, description, difference_notes, notes) VALUES (200086, 200004, 'CHANGE', 1, 'ADD', NULL, 'Turns a string into a list of character codes, or a list of codes into a string.', NULL, 'The codes are those of the table of [4] pp. 67-68 (ASCII: A = 65).');
INSERT INTO entry_source (entry_id, source_id, page) VALUES (200086, 200004, '67-69');
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, return_min_inclusive, return_max_inclusive, precedence, associativity, operator_class_id, evidence) VALUES (200098, 200086, 1, 'String to codes', NULL, 'CHANGE A$ TO A', 200004, '67-69', NULL, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200125, 200098, 's', 'NONE', NULL, NULL, 'A string variable.', 'MANUAL');
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200126, 200098, 'v', 'NONE', NULL, NULL, 'A numeric list: element 0 gets the length, the others the codes.', 'MANUAL');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000554, 200098, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000555, 200098, 2000554, 1, 'KEYWORD', 0, NULL, 200066);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000556, 200098, 2000554, 2, 'PARAMETER', 0, NULL, 200125, 200016);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000557, 200098, 2000554, 3, 'KEYWORD', 0, NULL, 200010);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000558, 200098, 2000554, 4, 'PARAMETER', 0, NULL, 200126, 200010);
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 200098, id, 'FULL', NULL FROM action WHERE code = 'STR_TO_CODES';
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, return_min_inclusive, return_max_inclusive, precedence, associativity, operator_class_id, evidence) VALUES (200099, 200086, 2, 'Codes to string', NULL, 'CHANGE A TO A$', 200004, '67-69', NULL, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200127, 200099, 'v', 'NONE', NULL, NULL, 'A numeric list: element 0 holds the number of characters.', 'MANUAL');
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200128, 200099, 's', 'NONE', NULL, NULL, 'A string variable.', 'MANUAL');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000559, 200099, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000560, 200099, 2000559, 1, 'KEYWORD', 0, NULL, 200066);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000561, 200099, 2000559, 2, 'PARAMETER', 0, NULL, 200127, 200010);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000562, 200099, 2000559, 3, 'KEYWORD', 0, NULL, 200010);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000563, 200099, 2000559, 4, 'PARAMETER', 0, NULL, 200128, 200016);
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 200099, id, 'FULL', NULL FROM action WHERE code = 'STR_FROM_CODES';
INSERT INTO entry_error (entry_id, form_id, parameter_id, error_code, operation, cause, verified, position) VALUES (200086, NULL, NULL, 'MISMATCHED_STRING', 'ADD', 'The two sides are not a string and a list.', 0, 1);
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id, page) VALUES (200086, 200099, 1, 'Codes to string', NULL, '10 DIM A(5)
20 FOR I = 0 TO 5
30 READ A(I)
40 NEXT I
50 CHANGE A TO A$
60 PRINT A$
70 DATA 5, 65, 66, 67, 68, 69
80 END', 'ABCDE', 0, 200004, '68-69');
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id, page) VALUES (200086, 200098, 2, 'String to codes', NULL, '10 DIM A(10)
20 LET A$ = "A"
30 CHANGE A$ TO A
40 PRINT A(0); A(1)
50 END', ' 1  65', 0, NULL, NULL);

-- DEF (STATEMENT)
INSERT INTO entry (id, layer_id, name, category_id, operation, redefines_id, description, difference_notes, notes) VALUES (200087, 200004, 'DEF', 1, 'REPLACE', 200013, 'Defines a function FNA to FNZ with one argument.', 'Functions without argument, and functions of several lines ended by FNEND.', 'Multi-line DEFs cannot be nested, and no jump may enter or leave them [4] p. 48. Whether a function can have more than one argument is to be checked in the manual.');
INSERT INTO entry_source (entry_id, source_id, page) VALUES (200087, 200004, '46-48');
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, return_min_inclusive, return_max_inclusive, precedence, associativity, operator_class_id, evidence) VALUES (200100, 200087, 1, 'One line', NULL, 'DEF FNA(X) = formula', 200004, '46-48', NULL, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200129, 200100, 'letter', 'NONE', NULL, NULL, 'A to Z.', 'MANUAL');
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200130, 200100, 'argument', 'NONE', NULL, NULL, 'Optional: `DEF FNA = 3.1416*R↑2`.', 'MANUAL');
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200131, 200100, 'formula', 'NONE', NULL, NULL, 'Any formula; other variables take their values at the time of the call.', 'MANUAL');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000564, 200100, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000565, 200100, 2000564, 1, 'KEYWORD', 0, NULL, 200016);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000566, 200100, 2000564, 2, 'KEYWORD', 0, NULL, 200017);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000567, 200100, 2000564, 3, 'PARAMETER', 1, NULL, 200129, 200004);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000568, 200100, 2000564, 4, 'OPTIONAL', 1, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000569, 200100, 2000568, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, text) VALUES (2000570, 200100, 2000569, 1, 'LITERAL', 1, NULL, '(');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000571, 200100, 2000569, 2, 'PARAMETER', 1, NULL, 200130, 200006);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, text) VALUES (2000572, 200100, 2000569, 3, 'LITERAL', 1, NULL, ')');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000573, 200100, 2000564, 5, 'KEYWORD', 0, NULL, 200039);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000574, 200100, 2000564, 6, 'PARAMETER', 0, NULL, 200131, 200005);
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 200100, id, 'FULL', NULL FROM action WHERE code = 'FN_DEFINE';
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, return_min_inclusive, return_max_inclusive, precedence, associativity, operator_class_id, evidence) VALUES (200101, 200087, 2, 'Several lines', 'The lines that follow compute the result and give it to FNx (`LET FNA = ...`); FNEND ends the definition.', 'DEF FNA(X)', 200004, '46-48', NULL, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200132, 200101, 'letter', 'NONE', NULL, NULL, 'A to Z.', 'MANUAL');
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200133, 200101, 'argument', 'NONE', NULL, NULL, 'Optional.', 'MANUAL');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000575, 200101, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000576, 200101, 2000575, 1, 'KEYWORD', 0, NULL, 200016);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000577, 200101, 2000575, 2, 'KEYWORD', 0, NULL, 200017);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000578, 200101, 2000575, 3, 'PARAMETER', 1, NULL, 200132, 200004);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000579, 200101, 2000575, 4, 'OPTIONAL', 1, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000580, 200101, 2000579, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, text) VALUES (2000581, 200101, 2000580, 1, 'LITERAL', 1, NULL, '(');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000582, 200101, 2000580, 2, 'PARAMETER', 1, NULL, 200133, 200006);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, text) VALUES (2000583, 200101, 2000580, 3, 'LITERAL', 1, NULL, ')');
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 200101, id, 'FULL', 'Several lines, ended by FNEND' FROM action WHERE code = 'FN_DEFINE';
INSERT INTO entry_error (entry_id, form_id, parameter_id, error_code, operation, cause, verified, position) VALUES (200087, 200101, NULL, 'NESTED_DEF', 'ADD', 'A DEF inside a function of several lines.', 0, 1);
INSERT INTO entry_error (entry_id, form_id, parameter_id, error_code, operation, cause, verified, position) VALUES (200087, 200101, NULL, 'UNFINISHED_DEF', 'ADD', 'No FNEND.', 0, 2);
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id, page) VALUES (200087, 200101, 1, 'Several lines', NULL, '10 DEF FNM(X)
20 LET FNM = X
30 IF X >= 0 THEN 50
40 LET FNM = -X
50 FNEND
60 PRINT FNM(-4)
70 END', '4', 0, NULL, NULL);
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id, page) VALUES (200087, 200100, 2, 'No argument', NULL, '10 LET R = 2
20 DEF FNA = 3.1416*R↑2
30 PRINT FNA
40 END', '12.5664', 0, NULL, NULL);

-- FNEND (STATEMENT)
INSERT INTO entry (id, layer_id, name, category_id, operation, redefines_id, description, difference_notes, notes) VALUES (200088, 200004, 'FNEND', 1, 'ADD', NULL, 'Ends a function of several lines.', NULL, NULL);
INSERT INTO entry_source (entry_id, source_id, page) VALUES (200088, 200004, '47');
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, return_min_inclusive, return_max_inclusive, precedence, associativity, operator_class_id, evidence) VALUES (200102, 200088, 1, NULL, NULL, 'FNEND', 200004, '47', NULL, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000584, 200102, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000585, 200102, 2000584, 1, 'KEYWORD', 0, NULL, 200067);
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 200102, id, 'FULL', NULL FROM action WHERE code = 'FN_END';
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id, page) VALUES (200088, NULL, 1, 'End of a function', NULL, '10 DEF FNS(X)
20 LET FNS = X*X
30 FNEND
40 PRINT FNS(3)
50 END', '9', 0, NULL, NULL);

-- ' (STATEMENT)
INSERT INTO entry (id, layer_id, name, category_id, operation, redefines_id, description, difference_notes, notes) VALUES (200089, 200004, '''', 1, 'ADD', NULL, 'Remark after an apostrophe, also at the end of a statement.', NULL, 'It does not work on a line ending with a string in quotes [4] p. 52.');
INSERT INTO entry_source (entry_id, source_id, page) VALUES (200089, 200004, '52');
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, return_min_inclusive, return_max_inclusive, precedence, associativity, operator_class_id, evidence) VALUES (200103, 200089, 1, NULL, NULL, '''', 200004, '52', NULL, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200134, 200103, 'text', 'NONE', NULL, NULL, 'Any text.', 'MANUAL');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000586, 200103, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000587, 200103, 2000586, 1, 'KEYWORD', 0, NULL, 200073);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000588, 200103, 2000586, 2, 'OPTIONAL', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000589, 200103, 2000588, 1, 'PARAMETER', 1, NULL, 200134, 200012);
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 200103, id, 'FULL', NULL FROM action WHERE code = 'PROG_REM';
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id, page) VALUES (200089, NULL, 1, 'Remark at the end', NULL, '10 LET P = 3.14159 '' PI
20 PRINT P
30 END', '3.14159', 0, NULL, NULL);

-- RND (FUNCTION)
INSERT INTO entry (id, layer_id, name, category_id, operation, redefines_id, description, difference_notes, notes) VALUES (200090, 200004, 'RND', 3, 'REPLACE', 200028, 'Random number between 0 and 1.', 'No argument.', '`INT(A*RND+B)` gives integers from B to A+B-1 [4] p. 44. The same sequence at every run unless RANDOMIZE is used.');
INSERT INTO entry_source (entry_id, source_id, page) VALUES (200090, 200004, '43-44');
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, return_min_inclusive, return_max_inclusive, precedence, associativity, operator_class_id, evidence) VALUES (200104, 200090, 1, NULL, NULL, 'RND', 200004, '43-44', 200002, 0, 1, 1, 1, NULL, NULL, NULL, 'MANUAL');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000590, 200104, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000591, 200104, 2000590, 1, 'KEYWORD', 0, NULL, 200032);
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 200104, id, 'PARTIAL', 'Only between 0 and 1' FROM action WHERE code = 'RND_VALUE';
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id, page) VALUES (200090, NULL, 1, 'Integers 1 to 6', NULL, '10 PRINT INT(6*RND+1)
20 END', NULL, 0, NULL, NULL);

-- COT (FUNCTION)
INSERT INTO entry (id, layer_id, name, category_id, operation, redefines_id, description, difference_notes, notes) VALUES (200091, 200004, 'COT', 3, 'ADD', NULL, 'Cotangent; the argument is in radians.', NULL, NULL);
INSERT INTO entry_source (entry_id, source_id, page) VALUES (200091, 200004, '13');
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, return_min_inclusive, return_max_inclusive, precedence, associativity, operator_class_id, evidence) VALUES (200105, 200091, 1, NULL, NULL, 'COT(X)', 200004, '13', 200002, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200135, 200105, 'x', 'NONE', NULL, NULL, 'Any formula.', 'MANUAL');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000592, 200105, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000593, 200105, 2000592, 1, 'KEYWORD', 0, NULL, 200068);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, text) VALUES (2000594, 200105, 2000592, 2, 'LITERAL', 1, NULL, '(');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000595, 200105, 2000592, 3, 'PARAMETER', 1, NULL, 200135, 200005);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, text) VALUES (2000596, 200105, 2000592, 4, 'LITERAL', 1, NULL, ')');
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 200105, id, 'FULL', NULL FROM action WHERE code = 'MATH_COT';
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id, page) VALUES (200091, NULL, 1, 'Cotangent', NULL, '10 PRINT COT(.785398)
20 END', '1', 0, NULL, NULL);

-- TAB (FUNCTION)
INSERT INTO entry (id, layer_id, name, category_id, operation, redefines_id, description, difference_notes, notes) VALUES (200092, 200004, 'TAB', 3, 'ADD', NULL, 'In PRINT: moves to a column.', NULL, 'Ignored if the print position has already passed the column [4] pp. 40-41.');
INSERT INTO entry_source (entry_id, source_id, page) VALUES (200092, 200004, '40-41');
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, return_min_inclusive, return_max_inclusive, precedence, associativity, operator_class_id, evidence) VALUES (200106, 200092, 1, NULL, NULL, 'TAB(N)', 200004, '40-41', NULL, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200136, 200106, 'n', 'TRUNCATE', NULL, NULL, 'Column 0 to 74: integer part, modulo 75.', 'MANUAL');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000597, 200106, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000598, 200106, 2000597, 1, 'KEYWORD', 0, NULL, 200064);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, text) VALUES (2000599, 200106, 2000597, 2, 'LITERAL', 1, NULL, '(');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000600, 200106, 2000597, 3, 'PARAMETER', 1, NULL, 200136, 200005);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, text) VALUES (2000601, 200106, 2000597, 4, 'LITERAL', 1, NULL, ')');
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 200106, id, 'FULL', NULL FROM action WHERE code = 'IO_POSITION';
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id, page) VALUES (200092, NULL, 1, 'Column 20', NULL, '10 PRINT TAB(20); "*"
20 END', '                    *', 0, NULL, NULL);

-- NUM (FUNCTION)
INSERT INTO entry (id, layer_id, name, category_id, operation, redefines_id, description, difference_notes, notes) VALUES (200093, 200004, 'NUM', 3, 'ADD', NULL, 'Number of values read by the last MAT INPUT.', NULL, NULL);
INSERT INTO entry_source (entry_id, source_id, page) VALUES (200093, 200004, '57');
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, return_min_inclusive, return_max_inclusive, precedence, associativity, operator_class_id, evidence) VALUES (200107, 200093, 1, NULL, NULL, 'NUM', 200004, '57', 200002, 0, NULL, 1, 1, NULL, NULL, NULL, 'MANUAL');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000602, 200107, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000603, 200107, 2000602, 1, 'KEYWORD', 0, NULL, 200069);
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 200107, id, 'FULL', NULL FROM action WHERE code = 'MAT_INPUT_COUNT';
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id, page) VALUES (200093, NULL, 1, 'Average of the typed values', NULL, '10 MAT INPUT V
20 LET N = NUM
30 IF N = 0 THEN 99
40 LET S = 0
50 FOR I = 1 TO N
60 LET S = S + V(I)
70 NEXT I
80 PRINT S/N
99 END', NULL, 0, 200004, '53');

-- DET (FUNCTION)
INSERT INTO entry (id, layer_id, name, category_id, operation, redefines_id, description, difference_notes, notes) VALUES (200094, 200004, 'DET', 3, 'ADD', NULL, 'Determinant of the matrix inverted by the last MAT INV.', NULL, '0 if the matrix had no inverse: the program goes on [4] pp. 59-60.');
INSERT INTO entry_source (entry_id, source_id, page) VALUES (200094, 200004, '59-61');
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, return_min_inclusive, return_max_inclusive, precedence, associativity, operator_class_id, evidence) VALUES (200108, 200094, 1, NULL, NULL, 'DET', 200004, '59-61', 200002, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000604, 200108, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000605, 200108, 2000604, 1, 'KEYWORD', 0, NULL, 200070);
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 200108, id, 'FULL', NULL FROM action WHERE code = 'MAT_DET';
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id, page) VALUES (200094, NULL, 1, 'Determinant', NULL, '10 DIM A(2,2), B(2,2)
20 MAT READ A
30 MAT B = INV(A)
40 PRINT DET
50 DATA 1,2,3,4
60 END', '-2', 0, NULL, NULL);

-- MAT INPUT (STATEMENT)
INSERT INTO entry (id, layer_id, name, category_id, operation, redefines_id, description, difference_notes, notes) VALUES (200095, 200004, 'MAT INPUT', 1, 'ADD', NULL, 'Reads a list from the Teletype; its length need not be given.', NULL, 'NUM gives the number of values typed; `&` before RETURN continues on the next line [4] p. 57.');
INSERT INTO entry_source (entry_id, source_id, page) VALUES (200095, 200004, '57-58');
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, return_min_inclusive, return_max_inclusive, precedence, associativity, operator_class_id, evidence) VALUES (200109, 200095, 1, NULL, NULL, 'MAT INPUT V', 200004, '57-58', NULL, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200137, 200109, 'v', 'NONE', NULL, NULL, 'A list.', 'MANUAL');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000606, 200109, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000607, 200109, 2000606, 1, 'KEYWORD', 0, NULL, 200055);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000608, 200109, 2000606, 2, 'KEYWORD', 0, NULL, 200052);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000609, 200109, 2000606, 3, 'PARAMETER', 0, NULL, 200137, 200013);
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 200109, id, 'FULL', NULL FROM action WHERE code = 'MAT_INPUT';
INSERT INTO entry_error (entry_id, form_id, parameter_id, error_code, operation, cause, verified, position) VALUES (200095, NULL, NULL, 'INPUT_FORMAT', 'ADD', 'The values typed are not in the right form.', 0, 1);
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id, page) VALUES (200095, NULL, 1, 'A list from the keyboard', 'Type 1,2,3: 3 is printed.', '10 MAT INPUT V
20 PRINT NUM
30 END', '?', 0, NULL, NULL);

-- MAT (STATEMENT)
INSERT INTO entry (id, layer_id, name, category_id, operation, redefines_id, description, difference_notes, notes) VALUES (200096, 200004, 'MAT', 1, 'REPLACE', 200062, 'Matrix arithmetic: sum, difference, product, multiple, zero, ones, identity, transpose, inverse.', 'Copy of a matrix (MAT B = A); INV sets DET.', 'Default dimensions: 10 for a list, 10 × 10 for a table; row and column 0 are ignored by MAT but take room. `MAT A = A * B` and `MAT A = TRN(A)` are not allowed. A matrix with no inverse does not stop the program: DET is 0 [4] pp. 53-61.');
INSERT INTO entry_source (entry_id, source_id, page) VALUES (200096, 200004, '53-61');
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, return_min_inclusive, return_max_inclusive, precedence, associativity, operator_class_id, evidence) VALUES (200110, 200096, 1, 'Sum', NULL, 'MAT C = A + B', 200004, '53-61', NULL, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200138, 200110, 'c', 'NONE', NULL, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200139, 200110, 'a', 'NONE', NULL, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200140, 200110, 'b', 'NONE', NULL, NULL, NULL, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000610, 200110, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000611, 200110, 2000610, 1, 'KEYWORD', 0, NULL, 200055);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000612, 200110, 2000610, 2, 'PARAMETER', 0, NULL, 200138, 200013);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000613, 200110, 2000610, 3, 'KEYWORD', 0, NULL, 200039);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000614, 200110, 2000610, 4, 'PARAMETER', 0, NULL, 200139, 200013);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000615, 200110, 2000610, 5, 'KEYWORD', 0, NULL, 200034);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000616, 200110, 2000610, 6, 'PARAMETER', 0, NULL, 200140, 200013);
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 200110, id, 'FULL', NULL FROM action WHERE code = 'MAT_ADD';
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, return_min_inclusive, return_max_inclusive, precedence, associativity, operator_class_id, evidence) VALUES (200111, 200096, 2, 'Difference', NULL, 'MAT C = A - B', 200004, '53-61', NULL, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200141, 200111, 'c', 'NONE', NULL, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200142, 200111, 'a', 'NONE', NULL, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200143, 200111, 'b', 'NONE', NULL, NULL, NULL, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000617, 200111, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000618, 200111, 2000617, 1, 'KEYWORD', 0, NULL, 200055);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000619, 200111, 2000617, 2, 'PARAMETER', 0, NULL, 200141, 200013);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000620, 200111, 2000617, 3, 'KEYWORD', 0, NULL, 200039);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000621, 200111, 2000617, 4, 'PARAMETER', 0, NULL, 200142, 200013);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000622, 200111, 2000617, 5, 'KEYWORD', 0, NULL, 200035);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000623, 200111, 2000617, 6, 'PARAMETER', 0, NULL, 200143, 200013);
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 200111, id, 'FULL', NULL FROM action WHERE code = 'MAT_SUB';
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, return_min_inclusive, return_max_inclusive, precedence, associativity, operator_class_id, evidence) VALUES (200112, 200096, 3, 'Product', NULL, 'MAT C = A * B', 200004, '53-61', NULL, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200144, 200112, 'c', 'NONE', NULL, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200145, 200112, 'a', 'NONE', NULL, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200146, 200112, 'b', 'NONE', NULL, NULL, NULL, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000624, 200112, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000625, 200112, 2000624, 1, 'KEYWORD', 0, NULL, 200055);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000626, 200112, 2000624, 2, 'PARAMETER', 0, NULL, 200144, 200013);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000627, 200112, 2000624, 3, 'KEYWORD', 0, NULL, 200039);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000628, 200112, 2000624, 4, 'PARAMETER', 0, NULL, 200145, 200013);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000629, 200112, 2000624, 5, 'KEYWORD', 0, NULL, 200036);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000630, 200112, 2000624, 6, 'PARAMETER', 0, NULL, 200146, 200013);
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 200112, id, 'FULL', NULL FROM action WHERE code = 'MAT_MUL';
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, return_min_inclusive, return_max_inclusive, precedence, associativity, operator_class_id, evidence) VALUES (200113, 200096, 4, 'Multiple', NULL, 'MAT C = (K) * A', 200004, '53-61', NULL, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200147, 200113, 'c', 'NONE', NULL, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200148, 200113, 'k', 'NONE', NULL, NULL, 'Any formula, in parentheses.', 'MANUAL');
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200149, 200113, 'a', 'NONE', NULL, NULL, NULL, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000631, 200113, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000632, 200113, 2000631, 1, 'KEYWORD', 0, NULL, 200055);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000633, 200113, 2000631, 2, 'PARAMETER', 0, NULL, 200147, 200013);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000634, 200113, 2000631, 3, 'KEYWORD', 0, NULL, 200039);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, text) VALUES (2000635, 200113, 2000631, 4, 'LITERAL', 0, NULL, '(');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000636, 200113, 2000631, 5, 'PARAMETER', 1, NULL, 200148, 200005);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, text) VALUES (2000637, 200113, 2000631, 6, 'LITERAL', 1, NULL, ')');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000638, 200113, 2000631, 7, 'KEYWORD', 0, NULL, 200036);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000639, 200113, 2000631, 8, 'PARAMETER', 0, NULL, 200149, 200013);
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 200113, id, 'FULL', NULL FROM action WHERE code = 'MAT_SCALAR';
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, return_min_inclusive, return_max_inclusive, precedence, associativity, operator_class_id, evidence) VALUES (200114, 200096, 5, 'Zero matrix', NULL, 'MAT C = ZER(M,N)', 200004, '53-61', NULL, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200150, 200114, 'c', 'NONE', NULL, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200151, 200114, 'm', 'NONE', NULL, NULL, 'Rows (a formula).', 'MANUAL');
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200152, 200114, 'n', 'NONE', NULL, NULL, 'Columns (a formula).', 'MANUAL');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000640, 200114, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000641, 200114, 2000640, 1, 'KEYWORD', 0, NULL, 200055);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000642, 200114, 2000640, 2, 'PARAMETER', 0, NULL, 200150, 200013);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000643, 200114, 2000640, 3, 'KEYWORD', 0, NULL, 200039);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000644, 200114, 2000640, 4, 'KEYWORD', 0, NULL, 200056);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000645, 200114, 2000640, 5, 'OPTIONAL', 1, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000646, 200114, 2000645, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, text) VALUES (2000647, 200114, 2000646, 1, 'LITERAL', 1, NULL, '(');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000648, 200114, 2000646, 2, 'PARAMETER', 1, NULL, 200151, 200005);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000649, 200114, 2000646, 3, 'OPTIONAL', 1, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000650, 200114, 2000649, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, text) VALUES (2000651, 200114, 2000650, 1, 'LITERAL', 1, NULL, ',');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000652, 200114, 2000650, 2, 'PARAMETER', 1, NULL, 200152, 200005);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, text) VALUES (2000653, 200114, 2000646, 4, 'LITERAL', 1, NULL, ')');
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 200114, id, 'FULL', NULL FROM action WHERE code = 'MAT_ZERO';
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, return_min_inclusive, return_max_inclusive, precedence, associativity, operator_class_id, evidence) VALUES (200115, 200096, 6, 'Ones', NULL, 'MAT C = CON(M,N)', 200004, '53-61', NULL, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200153, 200115, 'c', 'NONE', NULL, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200154, 200115, 'm', 'NONE', NULL, NULL, 'Rows (a formula).', 'MANUAL');
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200155, 200115, 'n', 'NONE', NULL, NULL, 'Columns (a formula).', 'MANUAL');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000654, 200115, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000655, 200115, 2000654, 1, 'KEYWORD', 0, NULL, 200055);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000656, 200115, 2000654, 2, 'PARAMETER', 0, NULL, 200153, 200013);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000657, 200115, 2000654, 3, 'KEYWORD', 0, NULL, 200039);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000658, 200115, 2000654, 4, 'KEYWORD', 0, NULL, 200057);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000659, 200115, 2000654, 5, 'OPTIONAL', 1, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000660, 200115, 2000659, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, text) VALUES (2000661, 200115, 2000660, 1, 'LITERAL', 1, NULL, '(');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000662, 200115, 2000660, 2, 'PARAMETER', 1, NULL, 200154, 200005);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000663, 200115, 2000660, 3, 'OPTIONAL', 1, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000664, 200115, 2000663, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, text) VALUES (2000665, 200115, 2000664, 1, 'LITERAL', 1, NULL, ',');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000666, 200115, 2000664, 2, 'PARAMETER', 1, NULL, 200155, 200005);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, text) VALUES (2000667, 200115, 2000660, 4, 'LITERAL', 1, NULL, ')');
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 200115, id, 'FULL', NULL FROM action WHERE code = 'MAT_ONES';
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, return_min_inclusive, return_max_inclusive, precedence, associativity, operator_class_id, evidence) VALUES (200116, 200096, 7, 'Identity', NULL, 'MAT C = IDN(N)', 200004, '53-61', NULL, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200156, 200116, 'c', 'NONE', NULL, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200157, 200116, 'n', 'NONE', NULL, NULL, 'Order of the square matrix.', 'MANUAL');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000668, 200116, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000669, 200116, 2000668, 1, 'KEYWORD', 0, NULL, 200055);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000670, 200116, 2000668, 2, 'PARAMETER', 0, NULL, 200156, 200013);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000671, 200116, 2000668, 3, 'KEYWORD', 0, NULL, 200039);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000672, 200116, 2000668, 4, 'KEYWORD', 0, NULL, 200058);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000673, 200116, 2000668, 5, 'OPTIONAL', 1, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000674, 200116, 2000673, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, text) VALUES (2000675, 200116, 2000674, 1, 'LITERAL', 1, NULL, '(');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000676, 200116, 2000674, 2, 'PARAMETER', 1, NULL, 200157, 200005);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, text) VALUES (2000677, 200116, 2000674, 3, 'LITERAL', 1, NULL, ')');
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 200116, id, 'FULL', NULL FROM action WHERE code = 'MAT_IDENTITY';
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, return_min_inclusive, return_max_inclusive, precedence, associativity, operator_class_id, evidence) VALUES (200117, 200096, 8, 'Transpose', NULL, 'MAT C = TRN(A)', 200004, '53-61', NULL, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200158, 200117, 'c', 'NONE', NULL, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200159, 200117, 'a', 'NONE', NULL, NULL, NULL, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000678, 200117, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000679, 200117, 2000678, 1, 'KEYWORD', 0, NULL, 200055);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000680, 200117, 2000678, 2, 'PARAMETER', 0, NULL, 200158, 200013);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000681, 200117, 2000678, 3, 'KEYWORD', 0, NULL, 200039);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000682, 200117, 2000678, 4, 'KEYWORD', 0, NULL, 200059);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, text) VALUES (2000683, 200117, 2000678, 5, 'LITERAL', 1, NULL, '(');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000684, 200117, 2000678, 6, 'PARAMETER', 1, NULL, 200159, 200013);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, text) VALUES (2000685, 200117, 2000678, 7, 'LITERAL', 1, NULL, ')');
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 200117, id, 'FULL', NULL FROM action WHERE code = 'MAT_TRANSPOSE';
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, return_min_inclusive, return_max_inclusive, precedence, associativity, operator_class_id, evidence) VALUES (200118, 200096, 9, 'Inverse', NULL, 'MAT C = INV(A)', 200004, '53-61', NULL, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200160, 200118, 'c', 'NONE', NULL, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200161, 200118, 'a', 'NONE', NULL, NULL, NULL, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000686, 200118, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000687, 200118, 2000686, 1, 'KEYWORD', 0, NULL, 200055);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000688, 200118, 2000686, 2, 'PARAMETER', 0, NULL, 200160, 200013);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000689, 200118, 2000686, 3, 'KEYWORD', 0, NULL, 200039);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000690, 200118, 2000686, 4, 'KEYWORD', 0, NULL, 200060);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, text) VALUES (2000691, 200118, 2000686, 5, 'LITERAL', 1, NULL, '(');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000692, 200118, 2000686, 6, 'PARAMETER', 1, NULL, 200161, 200013);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, text) VALUES (2000693, 200118, 2000686, 7, 'LITERAL', 1, NULL, ')');
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 200118, id, 'FULL', NULL FROM action WHERE code = 'MAT_INVERSE';
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, return_min_inclusive, return_max_inclusive, precedence, associativity, operator_class_id, evidence) VALUES (200119, 200096, 10, 'Copy', NULL, 'MAT B = A', 200004, '53-61', NULL, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200162, 200119, 'b', 'NONE', NULL, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200163, 200119, 'a', 'NONE', NULL, NULL, NULL, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000694, 200119, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000695, 200119, 2000694, 1, 'KEYWORD', 0, NULL, 200055);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000696, 200119, 2000694, 2, 'PARAMETER', 0, NULL, 200162, 200013);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000697, 200119, 2000694, 3, 'KEYWORD', 0, NULL, 200039);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000698, 200119, 2000694, 4, 'PARAMETER', 0, NULL, 200163, 200013);
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 200119, id, 'FULL', NULL FROM action WHERE code = 'MAT_COPY';
INSERT INTO entry_error (entry_id, form_id, parameter_id, error_code, operation, cause, verified, position) VALUES (200096, NULL, NULL, 'DIMENSION_ERROR', 'ADD', 'The dimensions of the matrices do not agree.', 0, 1);
INSERT INTO entry_error (entry_id, form_id, parameter_id, error_code, operation, cause, verified, position) VALUES (200096, 200112, NULL, 'ILLEGAL_MAT_MULTIPLE', 'ADD', 'The result is also a factor: MAT A = A * B.', 0, 2);
INSERT INTO entry_error (entry_id, form_id, parameter_id, error_code, operation, cause, verified, position) VALUES (200096, 200117, NULL, 'ILLEGAL_MAT_TRANSPOSE', 'ADD', 'MAT A = TRN(A).', 0, 3);
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id, page) VALUES (200096, 200112, 1, 'Product', NULL, '10 DIM A(2,2), B(2,2), C(2,2)
20 MAT READ A, B
30 MAT C = A * B
40 MAT PRINT C
50 DATA 1,2,3,4, 1,0,0,1
60 END', ' 1             2

 3             4', 0, NULL, NULL);
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id, page) VALUES (200096, 200118, 2, 'Inverse', NULL, '10 DIM A(2,2), B(2,2)
20 MAT READ A
30 MAT B = INV(A)
40 MAT PRINT B
50 DATA 2,0,0,4
60 END', ' .5            0

 0             .25', 0, NULL, NULL);

INSERT INTO reference (entry_id, related_entry_id, kind) VALUES (200084, 200011, 'SEE_ALSO');
INSERT INTO reference (entry_id, related_entry_id, kind) VALUES (200085, 200090, 'SEE_ALSO');
INSERT INTO reference (entry_id, related_entry_id, kind) VALUES (200092, 200078, 'SEE_ALSO');
INSERT INTO reference (entry_id, related_entry_id, kind) VALUES (200087, 200088, 'OPENS_BLOCK');
INSERT INTO reference (entry_id, related_entry_id, kind) VALUES (200095, 200093, 'SEE_ALSO');
INSERT INTO reference (entry_id, related_entry_id, kind) VALUES (200096, 200094, 'SEE_ALSO');
INSERT INTO reference (entry_id, related_entry_id, kind) VALUES (200089, 200019, 'SEE_ALSO');
INSERT INTO reference (entry_id, related_entry_id, kind) VALUES (200091, 200022, 'SEE_ALSO');
INSERT INTO open_question (layer_id, position, question) VALUES (200004, 1, 'DEF: can a function have more than one argument in the 4th edition? Maximum string length (strings over 60 characters need a DIM)? GOSUB and FOR nesting limits?');

-- ================= layer DARTMOUTH_CARD_layer
INSERT INTO table_status (table_kind_id, layer_id, status, notes) SELECT id, 200005, 'TO_DO', 'The rows shown are inherited from the Teletype version. On the cards: single quote for the double quote, multiple punch 5-8 for the semicolon [2] p. 50; card and printer codes not entered.' FROM table_kind WHERE code = 'CHARACTER_CODES';
INSERT INTO table_status (table_kind_id, layer_id, status, notes) SELECT id, 200005, 'NOT_APPLICABLE', 'No keyboard: punched cards.' FROM table_kind WHERE code = 'KEYBOARD_CODES';
INSERT INTO table_status (table_kind_id, layer_id, status, notes) SELECT id, 200005, 'COMPLETE', 'The messages of appendix A of [2] pp. 53-54; none is marked as Card BASIC only.' FROM table_kind WHERE code = 'ERRORS';
INSERT INTO table_status (table_kind_id, layer_id, status, notes) SELECT id, 200005, 'COMPLETE', 'As in the 2nd edition; relations as three-letter words.' FROM table_kind WHERE code = 'OPERATOR_PRECEDENCE';
INSERT INTO table_status (table_kind_id, layer_id, status, notes) SELECT id, 200005, 'TO_DO', 'Not documented.' FROM table_kind WHERE code = 'VARIABLE_LAYOUT';
INSERT INTO table_status (table_kind_id, layer_id, status, notes) SELECT id, 200005, 'TO_DO', 'A deck of cards, one statement per card.' FROM table_kind WHERE code = 'PROGRAM_LAYOUT';
INSERT INTO table_status (table_kind_id, layer_id, status, notes) SELECT id, 200005, 'NOT_APPLICABLE', 'No sound.' FROM table_kind WHERE code = 'MUSICAL_NOTES';
INSERT INTO variable_kind (id, layer_id, code, name, data_type_id, dimensions, name_rule, name_pattern, max_name_length, significant_chars, examples, notes, operation, redefines_id) VALUES (200009, 200005, 'LIST', 'List', 200001, 1, 'one letter followed by a subscript in parentheses', '^[A-Z]$', 1, 0, 'A(5), B(I+1)', 'At most 1000 elements in a list; at most 4000 elements in all lists and tables. Matrices start with element 1, not 0 [2] p. 51.', 'REPLACE', 200004);
INSERT INTO variable_kind (id, layer_id, code, name, data_type_id, dimensions, name_rule, name_pattern, max_name_length, significant_chars, examples, notes, operation, redefines_id) VALUES (200010, 200005, 'TABLE', 'Table', 200001, 2, 'one letter followed by two subscripts in parentheses', '^[A-Z]$', 1, 0, 'B(1,1), M(I,J)', 'No dimension above 500; at most 4000 elements in all lists and tables. Matrices start with element 1, not 0 [2] p. 51.', 'REPLACE', 200005);
INSERT INTO parameter_kind (id, layer_id, code, name, nature, type_class_id, variable_kind_id, notes, operation, redefines_id) VALUES (200021, 200005, 'LABEL', 'Label', 'LITERAL', 4, NULL, 'Text between single quotes (''), which replace the double quotes on the cards [2] p. 50.', 'REPLACE', 200003);
INSERT INTO parameter_kind (id, layer_id, code, name, nature, type_class_id, variable_kind_id, notes, operation, redefines_id) VALUES (200022, 200005, 'MATRIX_NAME', 'Matrix name', 'ARRAY_NAME', NULL, NULL, 'A list (vector) or table (matrix) with a DIM.', 'ADD', NULL);
INSERT INTO feature (layer_id, feature_kind_id, value, verified, notes, operation, redefines_id) SELECT 200005, id, '8 zones per line', 0, 'The high-speed printer prints 8 numbers per line, up to 18 in packed format [2] p. 50; the width of a zone is not given.', 'REPLACE', (SELECT f.id FROM feature f JOIN feature_kind k ON k.id = f.feature_kind_id WHERE f.layer_id = 200002 AND k.code = 'TAB_ZONE_WIDTH') FROM feature_kind WHERE code = 'TAB_ZONE_WIDTH';
INSERT INTO keyword (id, layer_id, text, notes) VALUES (200076, 200005, 'EQU', NULL);
INSERT INTO keyword (id, layer_id, text, notes) VALUES (200077, 200005, 'NQU', NULL);
INSERT INTO keyword (id, layer_id, text, notes) VALUES (200078, 200005, 'LSS', NULL);
INSERT INTO keyword (id, layer_id, text, notes) VALUES (200079, 200005, 'LQU', NULL);
INSERT INTO keyword (id, layer_id, text, notes) VALUES (200080, 200005, 'GRT', 'Greater than, on the cards [2] p. 50.');
INSERT INTO keyword (id, layer_id, text, notes) VALUES (200081, 200005, 'GQU', NULL);
INSERT INTO keyword (id, layer_id, text, notes) VALUES (200082, 200005, 'PAGE', NULL);
INSERT INTO keyword (id, layer_id, text, notes) VALUES (200083, 200005, 'MAT', 'Starts every matrix statement.');
INSERT INTO keyword (id, layer_id, text, notes) VALUES (200084, 200005, 'ZER', NULL);
INSERT INTO keyword (id, layer_id, text, notes) VALUES (200085, 200005, 'CON', NULL);
INSERT INTO keyword (id, layer_id, text, notes) VALUES (200086, 200005, 'IDN', NULL);
INSERT INTO keyword (id, layer_id, text, notes) VALUES (200087, 200005, 'TRN', NULL);
INSERT INTO keyword (id, layer_id, text, notes) VALUES (200088, 200005, 'INV', NULL);

INSERT INTO entry (id, layer_id, name, category_id, operation, redefines_id, difference_notes) VALUES (200097, 200005, 'HELLO', 2, 'REMOVE', 200001, 'Inferred: Card BASIC is run from a deck of cards, and the manual does not describe Teletype commands for it.');
INSERT INTO entry (id, layer_id, name, category_id, operation, redefines_id, difference_notes) VALUES (200098, 200005, 'RUN', 2, 'REMOVE', 200002, 'Inferred: Card BASIC is run from a deck of cards, and the manual does not describe Teletype commands for it.');
INSERT INTO entry (id, layer_id, name, category_id, operation, redefines_id, difference_notes) VALUES (200099, 200005, 'LIST', 2, 'REMOVE', 200052, 'Inferred: Card BASIC is run from a deck of cards, and the manual does not describe Teletype commands for it.');
INSERT INTO entry (id, layer_id, name, category_id, operation, redefines_id, difference_notes) VALUES (200100, 200005, 'SAVE', 2, 'REMOVE', 200004, 'Inferred: Card BASIC is run from a deck of cards, and the manual does not describe Teletype commands for it.');
INSERT INTO entry (id, layer_id, name, category_id, operation, redefines_id, difference_notes) VALUES (200101, 200005, 'STOP', 2, 'REMOVE', 200005, 'Inferred: Card BASIC is run from a deck of cards, and the manual does not describe Teletype commands for it.');
INSERT INTO entry (id, layer_id, name, category_id, operation, redefines_id, difference_notes) VALUES (200102, 200005, 'NEW', 2, 'REMOVE', 200046, 'Inferred: Card BASIC is run from a deck of cards, and the manual does not describe Teletype commands for it.');
INSERT INTO entry (id, layer_id, name, category_id, operation, redefines_id, difference_notes) VALUES (200103, 200005, 'OLD', 2, 'REMOVE', 200047, 'Inferred: Card BASIC is run from a deck of cards, and the manual does not describe Teletype commands for it.');
INSERT INTO entry (id, layer_id, name, category_id, operation, redefines_id, difference_notes) VALUES (200104, 200005, 'SCRATCH', 2, 'REMOVE', 200048, 'Inferred: Card BASIC is run from a deck of cards, and the manual does not describe Teletype commands for it.');
INSERT INTO entry (id, layer_id, name, category_id, operation, redefines_id, difference_notes) VALUES (200105, 200005, 'RENAME', 2, 'REMOVE', 200049, 'Inferred: Card BASIC is run from a deck of cards, and the manual does not describe Teletype commands for it.');
INSERT INTO entry (id, layer_id, name, category_id, operation, redefines_id, difference_notes) VALUES (200106, 200005, 'CATALOG', 2, 'REMOVE', 200050, 'Inferred: Card BASIC is run from a deck of cards, and the manual does not describe Teletype commands for it.');
INSERT INTO entry (id, layer_id, name, category_id, operation, redefines_id, difference_notes) VALUES (200107, 200005, 'UNSAVE', 2, 'REMOVE', 200051, 'Inferred: Card BASIC is run from a deck of cards, and the manual does not describe Teletype commands for it.');
INSERT INTO entry (id, layer_id, name, category_id, operation, redefines_id, difference_notes) VALUES (200108, 200005, '=', 4, 'REMOVE', 200037, 'Relations are written as three-letter words on the cards [2] p. 50.');
INSERT INTO entry (id, layer_id, name, category_id, operation, redefines_id, difference_notes) VALUES (200109, 200005, '<>', 4, 'REMOVE', 200038, 'Relations are written as three-letter words on the cards [2] p. 50.');
INSERT INTO entry (id, layer_id, name, category_id, operation, redefines_id, difference_notes) VALUES (200110, 200005, '<', 4, 'REMOVE', 200041, 'Relations are written as three-letter words on the cards [2] p. 50.');
INSERT INTO entry (id, layer_id, name, category_id, operation, redefines_id, difference_notes) VALUES (200111, 200005, '<=', 4, 'REMOVE', 200042, 'Relations are written as three-letter words on the cards [2] p. 50.');
INSERT INTO entry (id, layer_id, name, category_id, operation, redefines_id, difference_notes) VALUES (200112, 200005, '>', 4, 'REMOVE', 200039, 'Relations are written as three-letter words on the cards [2] p. 50.');
INSERT INTO entry (id, layer_id, name, category_id, operation, redefines_id, difference_notes) VALUES (200113, 200005, '>=', 4, 'REMOVE', 200040, 'Relations are written as three-letter words on the cards [2] p. 50.');
-- EQU (OPERATOR)
INSERT INTO entry (id, layer_id, name, category_id, operation, redefines_id, description, difference_notes, notes) VALUES (200114, 200005, 'EQU', 4, 'ADD', NULL, 'Equal: only in the relation of IF...THEN; written = on the Teletype.', NULL, 'Card equivalent of =: the key-punch has fewer symbols [2] p. 50.');
INSERT INTO entry_source (entry_id, source_id, page) VALUES (200114, 200002, '50');
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, return_min_inclusive, return_max_inclusive, precedence, associativity, operator_class_id, evidence) VALUES (200120, 200114, 1, NULL, NULL, 'A EQU B', 200002, '50', NULL, NULL, NULL, 1, 1, 1, NULL, 6, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200164, 200120, 'a', 'NONE', NULL, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200165, 200120, 'b', 'NONE', NULL, NULL, NULL, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000699, 200120, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000700, 200120, 2000699, 1, 'PARAMETER', 0, NULL, 200164, 200005);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000701, 200120, 2000699, 2, 'KEYWORD', 0, NULL, 200076);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000702, 200120, 2000699, 3, 'PARAMETER', 0, NULL, 200165, 200005);
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 200120, id, 'FULL', NULL FROM action WHERE code = 'OP_EQ';
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id, page) VALUES (200114, NULL, 1, 'Equal', 'The last card is the data deck.', '10 READ A
20 IF A EQU 2 THEN 50
30 PRINT ''NO''
40 STOP
50 PRINT ''YES''
60 END
2', 'YES', 0, NULL, NULL);

-- NQU (OPERATOR)
INSERT INTO entry (id, layer_id, name, category_id, operation, redefines_id, description, difference_notes, notes) VALUES (200115, 200005, 'NQU', 4, 'ADD', NULL, 'Not equal: only in the relation of IF...THEN; written <> on the Teletype.', NULL, 'Card equivalent of <>: the key-punch has fewer symbols [2] p. 50.');
INSERT INTO entry_source (entry_id, source_id, page) VALUES (200115, 200002, '50');
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, return_min_inclusive, return_max_inclusive, precedence, associativity, operator_class_id, evidence) VALUES (200121, 200115, 1, NULL, NULL, 'A NQU B', 200002, '50', NULL, NULL, NULL, 1, 1, 1, NULL, 6, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200166, 200121, 'a', 'NONE', NULL, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200167, 200121, 'b', 'NONE', NULL, NULL, NULL, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000703, 200121, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000704, 200121, 2000703, 1, 'PARAMETER', 0, NULL, 200166, 200005);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000705, 200121, 2000703, 2, 'KEYWORD', 0, NULL, 200077);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000706, 200121, 2000703, 3, 'PARAMETER', 0, NULL, 200167, 200005);
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 200121, id, 'FULL', NULL FROM action WHERE code = 'OP_NE';

-- LSS (OPERATOR)
INSERT INTO entry (id, layer_id, name, category_id, operation, redefines_id, description, difference_notes, notes) VALUES (200116, 200005, 'LSS', 4, 'ADD', NULL, 'Less than: only in the relation of IF...THEN; written < on the Teletype.', NULL, 'Card equivalent of <: the key-punch has fewer symbols [2] p. 50.');
INSERT INTO entry_source (entry_id, source_id, page) VALUES (200116, 200002, '50');
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, return_min_inclusive, return_max_inclusive, precedence, associativity, operator_class_id, evidence) VALUES (200122, 200116, 1, NULL, NULL, 'A LSS B', 200002, '50', NULL, NULL, NULL, 1, 1, 1, NULL, 6, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200168, 200122, 'a', 'NONE', NULL, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200169, 200122, 'b', 'NONE', NULL, NULL, NULL, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000707, 200122, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000708, 200122, 2000707, 1, 'PARAMETER', 0, NULL, 200168, 200005);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000709, 200122, 2000707, 2, 'KEYWORD', 0, NULL, 200078);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000710, 200122, 2000707, 3, 'PARAMETER', 0, NULL, 200169, 200005);
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 200122, id, 'FULL', NULL FROM action WHERE code = 'OP_LT';
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id, page) VALUES (200116, NULL, 1, 'Less than', NULL, '10 IF 1 LSS 2 THEN 40
20 PRINT ''NO''
30 STOP
40 PRINT ''YES''
50 END', 'YES', 0, NULL, NULL);

-- LQU (OPERATOR)
INSERT INTO entry (id, layer_id, name, category_id, operation, redefines_id, description, difference_notes, notes) VALUES (200117, 200005, 'LQU', 4, 'ADD', NULL, 'Less than or equal: only in the relation of IF...THEN; written <= on the Teletype.', NULL, 'Card equivalent of <=: the key-punch has fewer symbols [2] p. 50.');
INSERT INTO entry_source (entry_id, source_id, page) VALUES (200117, 200002, '50');
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, return_min_inclusive, return_max_inclusive, precedence, associativity, operator_class_id, evidence) VALUES (200123, 200117, 1, NULL, NULL, 'A LQU B', 200002, '50', NULL, NULL, NULL, 1, 1, 1, NULL, 6, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200170, 200123, 'a', 'NONE', NULL, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200171, 200123, 'b', 'NONE', NULL, NULL, NULL, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000711, 200123, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000712, 200123, 2000711, 1, 'PARAMETER', 0, NULL, 200170, 200005);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000713, 200123, 2000711, 2, 'KEYWORD', 0, NULL, 200079);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000714, 200123, 2000711, 3, 'PARAMETER', 0, NULL, 200171, 200005);
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 200123, id, 'FULL', NULL FROM action WHERE code = 'OP_LE';

-- GRT (OPERATOR)
INSERT INTO entry (id, layer_id, name, category_id, operation, redefines_id, description, difference_notes, notes) VALUES (200118, 200005, 'GRT', 4, 'ADD', NULL, 'Greater than: only in the relation of IF...THEN; written > on the Teletype.', NULL, 'Card equivalent of >: the key-punch has fewer symbols [2] p. 50.');
INSERT INTO entry_source (entry_id, source_id, page) VALUES (200118, 200002, '50');
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, return_min_inclusive, return_max_inclusive, precedence, associativity, operator_class_id, evidence) VALUES (200124, 200118, 1, NULL, NULL, 'A GRT B', 200002, '50', NULL, NULL, NULL, 1, 1, 1, NULL, 6, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200172, 200124, 'a', 'NONE', NULL, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200173, 200124, 'b', 'NONE', NULL, NULL, NULL, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000715, 200124, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000716, 200124, 2000715, 1, 'PARAMETER', 0, NULL, 200172, 200005);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000717, 200124, 2000715, 2, 'KEYWORD', 0, NULL, 200080);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000718, 200124, 2000715, 3, 'PARAMETER', 0, NULL, 200173, 200005);
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 200124, id, 'FULL', NULL FROM action WHERE code = 'OP_GT';

-- GQU (OPERATOR)
INSERT INTO entry (id, layer_id, name, category_id, operation, redefines_id, description, difference_notes, notes) VALUES (200119, 200005, 'GQU', 4, 'ADD', NULL, 'Greater than or equal: only in the relation of IF...THEN; written >= on the Teletype.', NULL, 'Card equivalent of >=: the key-punch has fewer symbols [2] p. 50.');
INSERT INTO entry_source (entry_id, source_id, page) VALUES (200119, 200002, '50');
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, return_min_inclusive, return_max_inclusive, precedence, associativity, operator_class_id, evidence) VALUES (200125, 200119, 1, NULL, NULL, 'A GQU B', 200002, '50', NULL, NULL, NULL, 1, 1, 1, NULL, 6, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200174, 200125, 'a', 'NONE', NULL, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200175, 200125, 'b', 'NONE', NULL, NULL, NULL, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000719, 200125, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000720, 200125, 2000719, 1, 'PARAMETER', 0, NULL, 200174, 200005);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000721, 200125, 2000719, 2, 'KEYWORD', 0, NULL, 200081);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000722, 200125, 2000719, 3, 'PARAMETER', 0, NULL, 200175, 200005);
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 200125, id, 'FULL', NULL FROM action WHERE code = 'OP_GE';

-- PRINT (STATEMENT)
INSERT INTO entry (id, layer_id, name, category_id, operation, redefines_id, description, difference_notes, notes) VALUES (200120, 200005, 'PRINT', 1, 'REPLACE', 200054, 'Types the values of formulas and labels on a line.', 'Labels between single quotes; the semicolon is punched as a multiple punch 5-8; 8 numbers per line on the printer.', 'Single quotes replace the double quotes; the semicolon is a 5-8 multiple punch [2] p. 50. The high-speed printer prints 8 numbers per line, up to 18 in packed format.');
INSERT INTO entry_source (entry_id, source_id, page) VALUES (200120, 200002, '50');
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, return_min_inclusive, return_max_inclusive, precedence, associativity, operator_class_id, evidence) VALUES (200126, 200120, 1, NULL, ''','' moves to the next zone of 15 characters (after the fifth, to the next line); '';'' moves to the next multiple of three characters, at least six per number. A PRINT ending with a comma or semicolon does not end the line; PRINT alone skips a line.', 'PRINT', 200002, '50', NULL, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200176, 200126, 'label', 'NONE', NULL, NULL, 'Text in quotes, typed as it is; it fills whole zones.', 'MANUAL');
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200177, 200126, 'formula', 'NONE', NULL, NULL, 'Any formula: its value is typed.', 'MANUAL');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000723, 200126, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000724, 200126, 2000723, 1, 'KEYWORD', 0, NULL, 200007);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000725, 200126, 2000723, 2, 'OPTIONAL', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000726, 200126, 2000725, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000727, 200126, 2000726, 1, 'CHOICE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000728, 200126, 2000727, 1, 'PARAMETER', 0, NULL, 200176, 200021);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000729, 200126, 2000727, 2, 'PARAMETER', 0, NULL, 200177, 200005);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000730, 200126, 2000727, 3, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000731, 200126, 2000730, 1, 'PARAMETER', 0, NULL, 200176, 200021);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000732, 200126, 2000730, 2, 'PARAMETER', 0, NULL, 200177, 200005);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, separator, min_occ, max_occ) VALUES (2000733, 200126, 2000726, 2, 'REPEAT', 0, NULL, NULL, 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000734, 200126, 2000733, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000735, 200126, 2000734, 1, 'CHOICE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, text) VALUES (2000736, 200126, 2000735, 1, 'LITERAL', 0, NULL, ',');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, text) VALUES (2000737, 200126, 2000735, 2, 'LITERAL', 0, NULL, ';');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000738, 200126, 2000734, 2, 'CHOICE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000739, 200126, 2000738, 1, 'PARAMETER', 0, NULL, 200176, 200021);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000740, 200126, 2000738, 2, 'PARAMETER', 0, NULL, 200177, 200005);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000741, 200126, 2000738, 3, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000742, 200126, 2000741, 1, 'PARAMETER', 0, NULL, 200176, 200021);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000743, 200126, 2000741, 2, 'PARAMETER', 0, NULL, 200177, 200005);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000744, 200126, 2000726, 3, 'OPTIONAL', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000745, 200126, 2000744, 1, 'CHOICE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, text) VALUES (2000746, 200126, 2000745, 1, 'LITERAL', 0, NULL, ',');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, text) VALUES (2000747, 200126, 2000745, 2, 'LITERAL', 0, NULL, ';');
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 200126, id, 'FULL', NULL FROM action WHERE code = 'IO_PRINT';
INSERT INTO entry_error (entry_id, form_id, parameter_id, error_code, operation, cause, verified, position) VALUES (200120, NULL, NULL, 'TOO_MANY_LABELS', 'ADD', 'The labels of the program are too long altogether (from [2]).', 0, 1);
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id, page) VALUES (200120, NULL, 1, 'Label in single quotes', NULL, '10 PRINT ''SQUARE ROOT OF 2 ='' SQR(2)
20 END', 'SQUARE ROOT OF 2 = 1.41421', 0, NULL, NULL);

INSERT INTO entry (id, layer_id, name, category_id, operation, redefines_id, difference_notes) VALUES (200121, 200005, 'DATA', 1, 'REMOVE', 200045, 'No DATA statement: the numbers are punched on a data deck after the END card [2] p. 50.');
-- READ (STATEMENT)
INSERT INTO entry (id, layer_id, name, category_id, operation, redefines_id, description, difference_notes, notes) VALUES (200122, 200005, 'READ', 1, 'REPLACE', 200014, 'Gives the variables the next numbers of the DATA statements.', 'The numbers come from the data deck after the END card, with no limit.', 'The data deck follows the END card: numbers separated by commas, as many per card as wanted, without line numbers or the word DATA; there is no limit on the data [2] pp. 50-51.');
INSERT INTO entry_source (entry_id, source_id, page) VALUES (200122, 200002, '50-51');
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, return_min_inclusive, return_max_inclusive, precedence, associativity, operator_class_id, evidence) VALUES (200127, 200122, 1, NULL, NULL, 'READ A, B, C', 200002, '50-51', NULL, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200178, 200127, 'variable', 'NONE', NULL, NULL, 'Variables or elements, separated by commas.', 'MANUAL');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000748, 200127, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000749, 200127, 2000748, 1, 'KEYWORD', 0, NULL, 200018);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, separator, min_occ, max_occ) VALUES (2000750, 200127, 2000748, 2, 'REPEAT', 0, NULL, ',', 1, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000751, 200127, 2000750, 1, 'PARAMETER', 0, NULL, 200178, 200009);
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 200127, id, 'FULL', NULL FROM action WHERE code = 'DATA_READ';
INSERT INTO entry_error (entry_id, form_id, parameter_id, error_code, operation, cause, verified, position) VALUES (200122, NULL, NULL, 'NO_DATA', 'ADD', 'No data deck after the END card.', 0, 1);
INSERT INTO entry_error (entry_id, form_id, parameter_id, error_code, operation, cause, verified, position) VALUES (200122, NULL, NULL, 'ILLEGAL_VARIABLE', 'ADD', 'An item is not a variable.', 0, 2);
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id, page) VALUES (200122, NULL, 1, 'Data deck', 'The data card follows END.', '10 READ A, B
20 PRINT A + B
30 END
3, 4', '7', 0, NULL, NULL);

-- PAGE (STATEMENT)
INSERT INTO entry (id, layer_id, name, category_id, operation, redefines_id, description, difference_notes, notes) VALUES (200123, 200005, 'PAGE', 1, 'ADD', NULL, 'Starts a new page of the printed output.', NULL, 'The manual gives no other detail [2] p. 50.');
INSERT INTO entry_source (entry_id, source_id, page) VALUES (200123, 200002, '50');
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, return_min_inclusive, return_max_inclusive, precedence, associativity, operator_class_id, evidence) VALUES (200128, 200123, 1, NULL, NULL, 'PAGE', 200002, '50', NULL, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000752, 200128, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000753, 200128, 2000752, 1, 'KEYWORD', 0, NULL, 200082);
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 200128, id, 'FULL', NULL FROM action WHERE code = 'IO_NEW_PAGE';
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id, page) VALUES (200123, NULL, 1, 'Two pages', NULL, '10 PRINT ''FIRST''
20 PAGE
30 PRINT ''SECOND''
40 END', NULL, 0, NULL, NULL);

-- MAT READ (STATEMENT)
INSERT INTO entry (id, layer_id, name, category_id, operation, redefines_id, description, difference_notes, notes) VALUES (200124, 200005, 'MAT READ', 1, 'ADD', NULL, 'Reads one matrix of the dimensions shown from the data.', NULL, 'The dimensions can be formulas: `DIM A(20,20)`, `READ M`, `MAT READ A(M,M)` reads a square matrix of any size up to 20 × 20 [2] p. 52. A matrix must be first used in a MAT statement.');
INSERT INTO entry_source (entry_id, source_id, page) VALUES (200124, 200002, '51-52');
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, return_min_inclusive, return_max_inclusive, precedence, associativity, operator_class_id, evidence) VALUES (200129, 200124, 1, NULL, NULL, 'MAT READ A(M,N)', 200002, '51-52', NULL, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200179, 200129, 'matrix', 'NONE', NULL, NULL, 'A matrix with a DIM.', 'MANUAL');
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200180, 200129, 'm', 'NONE', NULL, NULL, 'Rows: a formula, at most the DIM.', 'MANUAL');
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200181, 200129, 'n', 'NONE', NULL, NULL, 'Columns; without it a column vector.', 'MANUAL');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000754, 200129, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000755, 200129, 2000754, 1, 'KEYWORD', 0, NULL, 200083);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000756, 200129, 2000754, 2, 'KEYWORD', 0, NULL, 200018);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000757, 200129, 2000754, 3, 'PARAMETER', 0, NULL, 200179, 200022);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, text) VALUES (2000758, 200129, 2000754, 4, 'LITERAL', 1, NULL, '(');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000759, 200129, 2000754, 5, 'PARAMETER', 1, NULL, 200180, 200005);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000760, 200129, 2000754, 6, 'OPTIONAL', 1, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000761, 200129, 2000760, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, text) VALUES (2000762, 200129, 2000761, 1, 'LITERAL', 1, NULL, ',');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000763, 200129, 2000761, 2, 'PARAMETER', 1, NULL, 200181, 200005);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, text) VALUES (2000764, 200129, 2000754, 7, 'LITERAL', 1, NULL, ')');
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 200129, id, 'FULL', NULL FROM action WHERE code = 'MAT_READ';
INSERT INTO entry_error (entry_id, form_id, parameter_id, error_code, operation, cause, verified, position) VALUES (200124, NULL, NULL, 'DIMENSION_TOO_LARGE', 'ADD', 'More than the limits of [2] p. 51.', 0, 1);
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id, page) VALUES (200124, NULL, 1, 'Square matrix of any size', NULL, '10 DIM A(20,20)
20 READ M
30 MAT READ A(M,M)
40 MAT PRINT A
50 END
2, 1, 2, 3, 4', NULL, 0, 200002, '52');

-- MAT PRINT (STATEMENT)
INSERT INTO entry (id, layer_id, name, category_id, operation, redefines_id, description, difference_notes, notes) VALUES (200125, 200005, 'MAT PRINT', 1, 'ADD', NULL, 'Prints one matrix; vectors are printed as rows.', NULL, NULL);
INSERT INTO entry_source (entry_id, source_id, page) VALUES (200125, 200002, '51-52');
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, return_min_inclusive, return_max_inclusive, precedence, associativity, operator_class_id, evidence) VALUES (200130, 200125, 1, NULL, 'Followed by the 5-8 punch (;) the matrix is printed packed.', 'MAT PRINT A', 200002, '51-52', NULL, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200182, 200130, 'matrix', 'NONE', NULL, NULL, 'A matrix or vector.', 'MANUAL');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000765, 200130, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000766, 200130, 2000765, 1, 'KEYWORD', 0, NULL, 200083);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000767, 200130, 2000765, 2, 'KEYWORD', 0, NULL, 200007);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000768, 200130, 2000765, 3, 'PARAMETER', 0, NULL, 200182, 200022);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000769, 200130, 2000765, 4, 'OPTIONAL', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, text) VALUES (2000770, 200130, 2000769, 1, 'LITERAL', 0, NULL, ';');
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 200130, id, 'FULL', NULL FROM action WHERE code = 'MAT_PRINT';
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id, page) VALUES (200125, NULL, 1, 'Packed', NULL, '10 DIM A(3,3)
20 MAT A = IDN(3)
30 MAT PRINT A;
40 END', NULL, 0, NULL, NULL);

-- MAT (STATEMENT)
INSERT INTO entry (id, layer_id, name, category_id, operation, redefines_id, description, difference_notes, notes) VALUES (200126, 200005, 'MAT', 1, 'ADD', NULL, 'Matrix arithmetic: sum, difference, product, multiple, zero, ones, identity, transpose, inverse.', NULL, 'The matrices must have a DIM and start with element 1; a vector can stand for a matrix [2] pp. 51-52.');
INSERT INTO entry_source (entry_id, source_id, page) VALUES (200126, 200002, '51-52');
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, return_min_inclusive, return_max_inclusive, precedence, associativity, operator_class_id, evidence) VALUES (200131, 200126, 1, 'Sum', NULL, 'MAT C = A + B', 200002, '51-52', NULL, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200183, 200131, 'c', 'NONE', NULL, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200184, 200131, 'a', 'NONE', NULL, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200185, 200131, 'b', 'NONE', NULL, NULL, NULL, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000771, 200131, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000772, 200131, 2000771, 1, 'KEYWORD', 0, NULL, 200083);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000773, 200131, 2000771, 2, 'PARAMETER', 0, NULL, 200183, 200022);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000774, 200131, 2000771, 3, 'KEYWORD', 0, NULL, 200039);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000775, 200131, 2000771, 4, 'PARAMETER', 0, NULL, 200184, 200022);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000776, 200131, 2000771, 5, 'KEYWORD', 0, NULL, 200034);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000777, 200131, 2000771, 6, 'PARAMETER', 0, NULL, 200185, 200022);
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 200131, id, 'FULL', NULL FROM action WHERE code = 'MAT_ADD';
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, return_min_inclusive, return_max_inclusive, precedence, associativity, operator_class_id, evidence) VALUES (200132, 200126, 2, 'Difference', NULL, 'MAT C = A - B', 200002, '51-52', NULL, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200186, 200132, 'c', 'NONE', NULL, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200187, 200132, 'a', 'NONE', NULL, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200188, 200132, 'b', 'NONE', NULL, NULL, NULL, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000778, 200132, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000779, 200132, 2000778, 1, 'KEYWORD', 0, NULL, 200083);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000780, 200132, 2000778, 2, 'PARAMETER', 0, NULL, 200186, 200022);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000781, 200132, 2000778, 3, 'KEYWORD', 0, NULL, 200039);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000782, 200132, 2000778, 4, 'PARAMETER', 0, NULL, 200187, 200022);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000783, 200132, 2000778, 5, 'KEYWORD', 0, NULL, 200035);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000784, 200132, 2000778, 6, 'PARAMETER', 0, NULL, 200188, 200022);
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 200132, id, 'FULL', NULL FROM action WHERE code = 'MAT_SUB';
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, return_min_inclusive, return_max_inclusive, precedence, associativity, operator_class_id, evidence) VALUES (200133, 200126, 3, 'Product', NULL, 'MAT C = A * B', 200002, '51-52', NULL, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200189, 200133, 'c', 'NONE', NULL, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200190, 200133, 'a', 'NONE', NULL, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200191, 200133, 'b', 'NONE', NULL, NULL, NULL, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000785, 200133, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000786, 200133, 2000785, 1, 'KEYWORD', 0, NULL, 200083);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000787, 200133, 2000785, 2, 'PARAMETER', 0, NULL, 200189, 200022);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000788, 200133, 2000785, 3, 'KEYWORD', 0, NULL, 200039);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000789, 200133, 2000785, 4, 'PARAMETER', 0, NULL, 200190, 200022);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000790, 200133, 2000785, 5, 'KEYWORD', 0, NULL, 200036);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000791, 200133, 2000785, 6, 'PARAMETER', 0, NULL, 200191, 200022);
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 200133, id, 'FULL', NULL FROM action WHERE code = 'MAT_MUL';
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, return_min_inclusive, return_max_inclusive, precedence, associativity, operator_class_id, evidence) VALUES (200134, 200126, 4, 'Multiple', NULL, 'MAT C = (K) * A', 200002, '51-52', NULL, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200192, 200134, 'c', 'NONE', NULL, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200193, 200134, 'k', 'NONE', NULL, NULL, 'Any formula, in parentheses.', 'MANUAL');
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200194, 200134, 'a', 'NONE', NULL, NULL, NULL, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000792, 200134, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000793, 200134, 2000792, 1, 'KEYWORD', 0, NULL, 200083);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000794, 200134, 2000792, 2, 'PARAMETER', 0, NULL, 200192, 200022);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000795, 200134, 2000792, 3, 'KEYWORD', 0, NULL, 200039);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, text) VALUES (2000796, 200134, 2000792, 4, 'LITERAL', 0, NULL, '(');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000797, 200134, 2000792, 5, 'PARAMETER', 1, NULL, 200193, 200005);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, text) VALUES (2000798, 200134, 2000792, 6, 'LITERAL', 1, NULL, ')');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000799, 200134, 2000792, 7, 'KEYWORD', 0, NULL, 200036);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000800, 200134, 2000792, 8, 'PARAMETER', 0, NULL, 200194, 200022);
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 200134, id, 'FULL', NULL FROM action WHERE code = 'MAT_SCALAR';
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, return_min_inclusive, return_max_inclusive, precedence, associativity, operator_class_id, evidence) VALUES (200135, 200126, 5, 'Zero matrix', NULL, 'MAT C = ZER(M,N)', 200002, '51-52', NULL, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200195, 200135, 'c', 'NONE', NULL, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200196, 200135, 'm', 'NONE', NULL, NULL, 'Rows (a formula).', 'MANUAL');
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200197, 200135, 'n', 'NONE', NULL, NULL, 'Columns (a formula).', 'MANUAL');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000801, 200135, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000802, 200135, 2000801, 1, 'KEYWORD', 0, NULL, 200083);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000803, 200135, 2000801, 2, 'PARAMETER', 0, NULL, 200195, 200022);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000804, 200135, 2000801, 3, 'KEYWORD', 0, NULL, 200039);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000805, 200135, 2000801, 4, 'KEYWORD', 0, NULL, 200084);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000806, 200135, 2000801, 5, 'OPTIONAL', 1, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000807, 200135, 2000806, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, text) VALUES (2000808, 200135, 2000807, 1, 'LITERAL', 1, NULL, '(');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000809, 200135, 2000807, 2, 'PARAMETER', 1, NULL, 200196, 200005);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000810, 200135, 2000807, 3, 'OPTIONAL', 1, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000811, 200135, 2000810, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, text) VALUES (2000812, 200135, 2000811, 1, 'LITERAL', 1, NULL, ',');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000813, 200135, 2000811, 2, 'PARAMETER', 1, NULL, 200197, 200005);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, text) VALUES (2000814, 200135, 2000807, 4, 'LITERAL', 1, NULL, ')');
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 200135, id, 'FULL', NULL FROM action WHERE code = 'MAT_ZERO';
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, return_min_inclusive, return_max_inclusive, precedence, associativity, operator_class_id, evidence) VALUES (200136, 200126, 6, 'Ones', NULL, 'MAT C = CON(M,N)', 200002, '51-52', NULL, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200198, 200136, 'c', 'NONE', NULL, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200199, 200136, 'm', 'NONE', NULL, NULL, 'Rows (a formula).', 'MANUAL');
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200200, 200136, 'n', 'NONE', NULL, NULL, 'Columns (a formula).', 'MANUAL');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000815, 200136, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000816, 200136, 2000815, 1, 'KEYWORD', 0, NULL, 200083);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000817, 200136, 2000815, 2, 'PARAMETER', 0, NULL, 200198, 200022);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000818, 200136, 2000815, 3, 'KEYWORD', 0, NULL, 200039);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000819, 200136, 2000815, 4, 'KEYWORD', 0, NULL, 200085);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000820, 200136, 2000815, 5, 'OPTIONAL', 1, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000821, 200136, 2000820, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, text) VALUES (2000822, 200136, 2000821, 1, 'LITERAL', 1, NULL, '(');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000823, 200136, 2000821, 2, 'PARAMETER', 1, NULL, 200199, 200005);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000824, 200136, 2000821, 3, 'OPTIONAL', 1, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000825, 200136, 2000824, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, text) VALUES (2000826, 200136, 2000825, 1, 'LITERAL', 1, NULL, ',');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000827, 200136, 2000825, 2, 'PARAMETER', 1, NULL, 200200, 200005);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, text) VALUES (2000828, 200136, 2000821, 4, 'LITERAL', 1, NULL, ')');
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 200136, id, 'FULL', NULL FROM action WHERE code = 'MAT_ONES';
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, return_min_inclusive, return_max_inclusive, precedence, associativity, operator_class_id, evidence) VALUES (200137, 200126, 7, 'Identity', NULL, 'MAT C = IDN(N)', 200002, '51-52', NULL, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200201, 200137, 'c', 'NONE', NULL, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200202, 200137, 'n', 'NONE', NULL, NULL, 'Order of the square matrix.', 'MANUAL');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000829, 200137, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000830, 200137, 2000829, 1, 'KEYWORD', 0, NULL, 200083);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000831, 200137, 2000829, 2, 'PARAMETER', 0, NULL, 200201, 200022);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000832, 200137, 2000829, 3, 'KEYWORD', 0, NULL, 200039);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000833, 200137, 2000829, 4, 'KEYWORD', 0, NULL, 200086);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000834, 200137, 2000829, 5, 'OPTIONAL', 1, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000835, 200137, 2000834, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, text) VALUES (2000836, 200137, 2000835, 1, 'LITERAL', 1, NULL, '(');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000837, 200137, 2000835, 2, 'PARAMETER', 1, NULL, 200202, 200005);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, text) VALUES (2000838, 200137, 2000835, 3, 'LITERAL', 1, NULL, ')');
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 200137, id, 'FULL', NULL FROM action WHERE code = 'MAT_IDENTITY';
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, return_min_inclusive, return_max_inclusive, precedence, associativity, operator_class_id, evidence) VALUES (200138, 200126, 8, 'Transpose', NULL, 'MAT C = TRN(A)', 200002, '51-52', NULL, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200203, 200138, 'c', 'NONE', NULL, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200204, 200138, 'a', 'NONE', NULL, NULL, NULL, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000839, 200138, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000840, 200138, 2000839, 1, 'KEYWORD', 0, NULL, 200083);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000841, 200138, 2000839, 2, 'PARAMETER', 0, NULL, 200203, 200022);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000842, 200138, 2000839, 3, 'KEYWORD', 0, NULL, 200039);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000843, 200138, 2000839, 4, 'KEYWORD', 0, NULL, 200087);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, text) VALUES (2000844, 200138, 2000839, 5, 'LITERAL', 1, NULL, '(');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000845, 200138, 2000839, 6, 'PARAMETER', 1, NULL, 200204, 200022);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, text) VALUES (2000846, 200138, 2000839, 7, 'LITERAL', 1, NULL, ')');
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 200138, id, 'FULL', NULL FROM action WHERE code = 'MAT_TRANSPOSE';
INSERT INTO syntax_form (id, entry_id, position, title, description, original_syntax, source_id, page, return_type_id, return_min, return_max, return_min_inclusive, return_max_inclusive, precedence, associativity, operator_class_id, evidence) VALUES (200139, 200126, 9, 'Inverse', NULL, 'MAT C = INV(A)', 200002, '51-52', NULL, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200205, 200139, 'c', 'NONE', NULL, NULL, NULL, NULL);
INSERT INTO parameter (id, form_id, name, conversion, error_code, missing_line, description, evidence) VALUES (200206, 200139, 'a', 'NONE', NULL, NULL, NULL, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning) VALUES (2000847, 200139, NULL, 1, 'SEQUENCE', 0, NULL);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000848, 200139, 2000847, 1, 'KEYWORD', 0, NULL, 200083);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000849, 200139, 2000847, 2, 'PARAMETER', 0, NULL, 200205, 200022);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000850, 200139, 2000847, 3, 'KEYWORD', 0, NULL, 200039);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, keyword_id) VALUES (2000851, 200139, 2000847, 4, 'KEYWORD', 0, NULL, 200088);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, text) VALUES (2000852, 200139, 2000847, 5, 'LITERAL', 1, NULL, '(');
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, parameter_id, parameter_kind_id) VALUES (2000853, 200139, 2000847, 6, 'PARAMETER', 1, NULL, 200206, 200022);
INSERT INTO syntax_node (id, form_id, parent_id, position, kind, attached, meaning, text) VALUES (2000854, 200139, 2000847, 7, 'LITERAL', 1, NULL, ')');
INSERT INTO form_action (form_id, action_id, coverage, notes) SELECT 200139, id, 'FULL', NULL FROM action WHERE code = 'MAT_INVERSE';
INSERT INTO example (entry_id, form_id, position, title, description, code, expected_result, verified, source_id, page) VALUES (200126, 200139, 1, 'Inverse', NULL, '10 DIM A(2,2), B(2,2)
20 MAT READ A(2,2)
30 MAT B = INV(A)
40 MAT PRINT B
50 END
2, 0, 0, 4', NULL, 0, NULL, NULL);

INSERT INTO reference (entry_id, related_entry_id, kind) VALUES (200124, 200126, 'SEE_ALSO');
INSERT INTO reference (entry_id, related_entry_id, kind) VALUES (200125, 200126, 'SEE_ALSO');
INSERT INTO reference (entry_id, related_entry_id, kind) VALUES (200123, 200120, 'SEE_ALSO');
INSERT INTO open_question (layer_id, position, question) VALUES (200005, 1, 'The examples of the entries inherited from the 1st and 2nd edition are written for the Teletype (double quotes, relations as symbols): in Card BASIC they need single quotes and EQU, LSS, ...');
INSERT INTO open_question (layer_id, position, question) VALUES (200005, 2, 'Card BASIC: are the Teletype commands really absent (removed here by inference)? How is the power written on the cards (↑ or something else)? Are the other limits (constants, GO TO) those of the Teletype version?');

COMMIT;
