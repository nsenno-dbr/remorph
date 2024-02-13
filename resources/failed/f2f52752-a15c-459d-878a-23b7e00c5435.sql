SELECT
  o.orderkey,
  ARRAY_AGG(l.linenumber) WITHIN GROUP (ORDER BY l.quantity DESC) AS linenumber_array
FROM
  orders o
JOIN
  lineitem l ON o.orderkey = l.orderkey
GROUP BY
  o.orderkey;