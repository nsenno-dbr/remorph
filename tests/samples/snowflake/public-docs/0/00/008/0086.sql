SELECT column1
FROM VALUES ('a'), ('1'), ('B'), (null), ('2'), ('01'), ('05'), (' this'), ('this'), ('this and that'), ('&'), ('%')
ORDER BY column1;