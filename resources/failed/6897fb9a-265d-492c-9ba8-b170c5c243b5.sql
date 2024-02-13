SELECT
  c.name,
  ARRAY_AGG(o.orderkey ORDER BY o.totalprice) WITHIN GROUP (ORDER BY o.orderdate) AS sorted_orderkeys
FROM
  customer c
JOIN
  orders o ON c.custkey = o.custkey
GROUP BY
  c.name