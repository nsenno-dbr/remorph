SELECT
    c.custkey,
    ARRAY_AGG(o.orderkey) WITHIN GROUP (ORDER BY o.orderdate DESC) AS orderkeys
FROM
    customer c
JOIN
    orders o ON c.custkey = o.custkey
GROUP BY
    c.custkey;