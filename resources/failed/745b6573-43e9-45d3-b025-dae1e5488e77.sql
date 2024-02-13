SELECT
  l_orderkey,
  ARRAY_AGG(l_linenumber ORDER BY l_quantity) AS sorted_linenumbers
FROM
  lineitem
GROUP BY
  l_orderkey;