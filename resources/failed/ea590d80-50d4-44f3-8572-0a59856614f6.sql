SELECT
  c_custkey,
  ARRAY_AGG(o_orderkey ORDER BY o_orderpriority) AS orderkeys
FROM
  customer
JOIN
  orders ON c_custkey = o_custkey
GROUP BY
  c_custkey;