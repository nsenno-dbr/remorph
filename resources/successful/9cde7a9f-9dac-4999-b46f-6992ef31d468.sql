SELECT c.c_custkey, c.c_name, ARRAY_AGG(o.o_orderkey) WITHIN GROUP (ORDER BY o.o_orderdate DESC) AS order_keys
FROM customer c
JOIN orders o ON c.c_custkey = o.o_custkey
WHERE c.c_nationkey = 3
GROUP BY c.c_custkey, c.c_name
ORDER BY c.c_custkey ASC;