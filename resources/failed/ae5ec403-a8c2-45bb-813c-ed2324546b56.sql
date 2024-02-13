SELECT c_custkey, ARRAY_AGG(o_orderkey ORDER BY o_orderdate DESC) WITHIN GROUP (ORDER BY o_totalprice DESC) AS order_keys
FROM customer
JOIN orders ON c_custkey = o_custkey
GROUP BY c_custkey;