```sql
SELECT
  l_orderkey,
  ARRAY_AGG(l_quantity) WITHIN GROUP (ORDER BY l_partkey DESC) AS quantity_list
FROM
  lineitem
GROUP BY
  l_orderkey
```