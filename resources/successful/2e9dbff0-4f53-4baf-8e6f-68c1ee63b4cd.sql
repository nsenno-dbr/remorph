SELECT o_orderkey, ARRAY_AGG(o_totalprice) WITHIN GROUP (ORDER BY o_orderdate DESC) AS total_prices
FROM orders
GROUP BY o_orderkey;