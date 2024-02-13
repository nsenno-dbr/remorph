SELECT
  l_orderkey,
  ARRAY_AGG(l_linestatus ORDER BY l_quantity DESC) WITHIN GROUP (ORDER BY l_shipdate) AS status_array
FROM
  lineitem
GROUP BY
  l_orderkey;