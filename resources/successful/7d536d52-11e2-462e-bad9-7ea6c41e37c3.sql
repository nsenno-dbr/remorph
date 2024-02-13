SELECT c.c_custkey, ARRAY_AGG(o.o_orderdate) WITHIN GROUP (ORDER BY o.o_totalprice DESC) AS order_dates
FROM customer c
JOIN orders o ON c.c_custkey = o.o_custkey
GROUP BY c.c_custkey;