SELECT
  o.orderkey,
  o.orderdate,
  ARRAY_AGG(l.linenumber ORDER BY l.quantity DESC) WITHIN GROUP (ORDER BY l.partkey ASC) AS sorted_linenumber
FROM
  orders o
JOIN
  lineitem l
ON
  o.orderkey = l.orderkey
GROUP BY
  o.orderkey,
  o.orderdate;