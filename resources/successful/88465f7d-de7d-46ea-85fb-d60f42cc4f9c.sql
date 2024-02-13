SELECT
  c_name,
  ARRAY_AGG(o_totalprice) WITHIN GROUP (ORDER BY o_orderdate DESC) AS ordered_prices
FROM
  customer,
  orders
WHERE
  c_custkey = o_custkey
GROUP BY
  c_name