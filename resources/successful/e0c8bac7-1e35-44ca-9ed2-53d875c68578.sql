SELECT
  l_orderkey,
  ARRAY_AGG(l_extendedprice) WITHIN GROUP (ORDER BY l_shipdate) AS extended_prices
FROM
  lineitem
GROUP BY
  l_orderkey