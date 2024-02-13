SELECT
  c_custkey,
  ARRAY_AGG(o_totalprice) WITHIN GROUP (ORDER BY o_orderdate DESC) AS total_prices
FROM
  customer
JOIN
  orders ON c_custkey = o_custkey
GROUP BY
  c_custkey;