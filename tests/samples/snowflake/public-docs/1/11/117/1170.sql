SELECT v, hex_string, TRY_HEX_DECODE_STRING(hex_string), TRY_HEX_DECODE_STRING(garbage) FROM hex;