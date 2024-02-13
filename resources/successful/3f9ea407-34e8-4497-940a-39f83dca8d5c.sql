SELECT
  l_orderkey,
  ARRAY_AGG(l_comment) WITHIN GROUP (ORDER BY l_shipdate DESC) AS comments
FROM
  lineitem
GROUP BY
  l_orderkey;