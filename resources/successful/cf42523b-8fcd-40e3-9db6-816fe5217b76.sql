SELECT
  c_custkey,
  ARRAY_AGG(o_orderkey) WITHIN GROUP (ORDER BY o_orderdate DESC) AS order_keys
FROM
  customer
JOIN
  orders ON c_custkey = o_custkey
GROUP BY
  c_custkey