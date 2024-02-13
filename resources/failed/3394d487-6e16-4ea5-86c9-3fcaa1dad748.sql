SELECT
  o.orderkey,
  ARRAY_AGG(l.linenumber ORDER BY l.quantity) WITHIN GROUP (ORDER BY l.quantity DESC) AS sorted_linenumber
FROM
  orders o
JOIN
  lineitem l ON o.orderkey = l.orderkey
GROUP BY
  o.orderkey;