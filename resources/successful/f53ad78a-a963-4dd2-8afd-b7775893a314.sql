SELECT
  c_custkey,
  ARRAY_AGG(o_orderdate) WITHIN GROUP (ORDER BY o_totalprice DESC) AS order_dates
FROM
  customer
JOIN
  orders
ON
  c_custkey = o_custkey
GROUP BY
  c_custkey