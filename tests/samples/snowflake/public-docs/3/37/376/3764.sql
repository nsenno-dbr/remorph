select
  lah.exchange_name,
  lah.listing_global_name,
  lah.share_name,
  los.value:"objectName"::string as object_name,
  coalesce(los.value:"objectDomain"::string, los.value:"objectDomain"::string) as object_type,
  count(distinct lah.query_token) as n_queries,
  count(distinct lah.consumer_account_locator) as n_distinct_consumer_accounts
from SNOWFLAKE.DATA_SHARING_USAGE.LISTING_ACCESS_HISTORY as lah
join lateral flatten(input=>lah.listing_objects_accessed) as los
where true
  and query_date between '2022-03-01' and '2022-04-30'
group by 1,2,3,4,5
order by 1,2,3,4,5;