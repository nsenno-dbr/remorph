SELECT
  o.orderkey,
  ARRAY_AGG(l.quantity ORDER BY l.linenumber) WITHIN GROUP (ORDER BY l.linenumber DESC) AS quantities
FROM
  orders o
JOIN
  lineitem l ON o.orderkey = l.orderkey
GROUP BY
  o.orderkey;