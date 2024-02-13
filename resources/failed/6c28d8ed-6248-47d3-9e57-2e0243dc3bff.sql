SELECT
  l.orderkey,
  ARRAY_AGG(l.linenumber ORDER BY l.quantity) WITHIN GROUP (ORDER BY l.partkey) AS sorted_line_numbers
FROM
  lineitem l
GROUP BY
  l.orderkey;