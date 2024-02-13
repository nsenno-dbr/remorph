SELECT
  l.orderkey,
  ARRAY_AGG(l.linenumber) WITHIN GROUP (ORDER BY l.quantity) AS line_numbers
FROM
  lineitem l
GROUP BY
  l.orderkey;