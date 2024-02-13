SELECT
    l.orderkey,
    ARRAY_AGG(l.partkey) WITHIN GROUP (ORDER BY l.quantity) AS partkeys
FROM
    lineitem l
GROUP BY
    l.orderkey;