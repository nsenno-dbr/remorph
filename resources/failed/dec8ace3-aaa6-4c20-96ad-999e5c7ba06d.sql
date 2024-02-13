SELECT
  l_orderkey,
  ARRAY_AGG(l_linenumber ORDER BY l_quantity DESC) WITHIN GROUP (ORDER BY l_partkey) AS line_numbers
FROM
  lineitem
GROUP BY
  l_orderkey;