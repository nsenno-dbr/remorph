WITH customer_orders AS (
    SELECT c.c_custkey, o.o_orderkey, o.o_orderdate, l.l_quantity
    FROM customer c
    JOIN orders o ON c.c_custkey = o.o_custkey
    JOIN lineitem l ON o.o_orderkey = l.l_orderkey
)
SELECT c_custkey, ARRAY_AGG(o_orderkey) WITHIN GROUP (ORDER BY o_orderdate DESC) AS order_keys
FROM customer_orders
GROUP BY c_custkey;