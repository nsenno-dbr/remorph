SELECT c.c_name, ARRAY_AGG(o.o_totalprice) WITHIN GROUP (ORDER BY o.o_orderdate) AS order_prices
FROM customer c
JOIN orders o ON c.c_custkey = o.o_custkey
GROUP BY c.c_name;