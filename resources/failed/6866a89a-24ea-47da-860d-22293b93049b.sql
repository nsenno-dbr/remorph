SELECT
  o.orderkey,
  ARRAY_AGG(l.linenumber ORDER BY l.quantity) WITHIN GROUP (ORDER BY l.partkey) AS sorted_linenumbers
FROM
  orders o
JOIN
  lineitem l ON o.orderkey = l.orderkey
GROUP BY
  o.orderkey;