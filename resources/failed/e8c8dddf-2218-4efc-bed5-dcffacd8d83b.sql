SELECT
  c.custkey,
  ARRAY_AGG(o.orderkey ORDER BY o.orderdate) WITHIN GROUP (ORDER BY o.orderkey) AS orderkeys
FROM
  customer c
JOIN
  orders o ON c.custkey = o.custkey
GROUP BY
  c.custkey;