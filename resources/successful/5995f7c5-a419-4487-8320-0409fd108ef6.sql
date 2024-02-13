SELECT
  l_orderkey,
  ARRAY_AGG(l_partkey) WITHIN GROUP (ORDER BY l_shipdate DESC) AS aggregated_parts
FROM
  lineitem
GROUP BY
  l_orderkey;