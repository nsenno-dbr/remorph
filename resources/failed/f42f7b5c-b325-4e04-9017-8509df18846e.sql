SELECT
  o.orderkey,
  ARRAY_AGG(l.linenumber ORDER BY l.quantity) AS line_numbers
FROM
  orders o
JOIN
  lineitem l ON o.orderkey = l.orderkey
GROUP BY
  o.orderkey;