WITH
    sales AS (
        SELECT
            o.orderkey,
            o.orderdate,
            l.linenumber,
            l.quantity,
            l.extendedprice,
            l.discount,
            l.returnflag,
            l.linestatus
        FROM
            tpch_sf100.orders o
        JOIN
            tpch_sf100.lineitem l
        ON
            o.orderkey = l.orderkey
    ),
    aggregated_sales AS (
        SELECT
            orderkey,
            orderdate,
            ARRAY_AGG(
                STRUCT(
                    linenumber,
                    quantity,
                    extendedprice,
                    discount,
                    returnflag,
                    linestatus
                ) 
                ORDER BY
                    extendedprice DESC
            ) AS sales_array
        FROM
            sales
        GROUP BY
            orderkey,
            orderdate
    )
SELECT
    orderkey,
    orderdate,
    sales_array
FROM
    aggregated_sales;