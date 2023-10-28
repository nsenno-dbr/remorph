CREATE TABLE hex (v VARCHAR, b BINARY);
INSERT INTO hex (v, b)
   SELECT 'ABab', 
     -- Convert string -> hex-encoded string -> binary.
     TRY_HEX_DECODE_BINARY(HEX_ENCODE('ABab'));