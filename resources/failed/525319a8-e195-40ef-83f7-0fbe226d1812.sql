SELECT
  c_custkey,
  ARRAY_AGG(o_orderkey ORDER BY o_totalprice) WITHIN GROUP (ORDER BY o_orderkey) AS order_keys
FROM
  customer
JOIN
  orders
ON
  c_custkey = o_custkey
GROUP BY
  c_custkey