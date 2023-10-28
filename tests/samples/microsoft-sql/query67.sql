-- query67
with dw1 as (
      select i_category
            ,i_class
            ,i_brand
            ,i_product_name
            ,d_year
            ,d_qoy
            ,d_moy
            ,s_store_id
            ,sum(coalesce(ss_sales_price*ss_quantity,0)) sumsales
      from store_sales
            ,date_dim
            ,store
            ,item
      where  ss_sold_date_sk=d_date_sk
      and ss_item_sk=i_item_sk
      and ss_store_sk = s_store_sk
      and d_month_seq between 1181 and 1181+11
      group by i_category, i_class, i_brand, i_product_name, d_year, d_qoy, d_moy,s_store_id
), dw2 as (
      select i_category
            ,i_class
            ,i_brand
            ,i_product_name
            ,d_year
            ,d_qoy
            ,d_moy
            ,s_store_id
            ,sumsales
            ,rank() over (partition by i_category, i_class, i_brand, i_product_name order by sumsales desc) rk
      from dw1
), dw3 as (
      select i_category
            ,i_class
            ,i_brand
            ,i_product_name
            ,d_year
            ,d_qoy
            ,d_moy
            ,s_store_id
            ,sumsales
            ,rank() over (partition by i_category order by sumsales desc) rk
      from dw2
      where rk <= 100
)
select top 100 *
from dw2
where rk <= 100
order by i_category
        ,i_class
        ,i_brand
        ,i_product_name
        ,d_year
        ,d_qoy
        ,d_moy
        ,s_store_id
        ,sumsales
        ,rk

