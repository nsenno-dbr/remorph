```sql
SELECT 
  o.orderkey,
  ARRAY_AGG(l.linenumber) WITHIN GROUP (ORDER BY l.quantity DESC) AS line_numbers
FROM 
  orders o
JOIN 
  lineitem l ON o.orderkey = l.orderkey
GROUP BY 
  o.orderkey
ORDER BY 
  o.orderkey
LIMIT 
  10;
```