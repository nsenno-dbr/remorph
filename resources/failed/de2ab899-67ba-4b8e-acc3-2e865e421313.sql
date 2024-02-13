SELECT
    l.orderkey,
    ARRAY_AGG(l.linenumber) WITHIN GROUP (ORDER BY l.shipdate DESC) AS linenums
FROM
    lineitem l
GROUP BY
    l.orderkey
LIMIT
    10;