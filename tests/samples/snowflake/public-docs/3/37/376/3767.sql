with
accesses as (
  select
    lah.query_token,
    array_agg(distinct los.value:"objectName"::string) as object_names
  from SNOWFLAKE.DATA_SHARING_USAGE.LISTING_ACCESS_HISTORY as lah
  join lateral flatten(input=>lah.listing_objects_accessed) as los
  where true
    and los.value:"objectDomain"::string in ('Table', 'View')
    and query_date between '2022-03-01' and '2022-04-30'
  group by 1
)
select
  object_names,
  sum(1) as n_queries
from accesses
group by 1