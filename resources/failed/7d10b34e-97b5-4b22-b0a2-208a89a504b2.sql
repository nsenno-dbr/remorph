SELECT
    l.orderkey,
    ARRAY_AGG(l.partkey) WITHIN GROUP (ORDER BY l.linenumber DESC) AS partkeys
FROM
    lineitem l
GROUP BY
    l.orderkey;