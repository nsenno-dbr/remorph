IF (both_rows_are_valid) THEN
    BEGIN
        BEGIN TRANSACTION;
        INSERT INTO parent ...;
        INSERT INTO child ...;
        COMMIT;
    END;
END IF;