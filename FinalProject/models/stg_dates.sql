with all_dates as (

    select to_date(to_timestamp_ntz(cast(order_date / 1000000 as bigint))) as activity_date
    from raw.fudgemart_v3.fm_orders
    where order_date is not null

    union

    select to_date(to_timestamp_ntz(cast(ab_date / 1000000 as bigint))) as activity_date
    from raw.fudgeflix_v3.ff_account_billing
    where ab_date is not null

    union

    select to_date(to_timestamp_ntz(cast(at_queue_date / 1000000 as bigint))) as activity_date
    from raw.fudgeflix_v3.ff_account_titles
    where at_queue_date is not null

    union

    select to_date(to_timestamp_ntz(cast(at_shipped_date / 1000000 as bigint))) as activity_date
    from raw.fudgeflix_v3.ff_account_titles
    where at_shipped_date is not null

    union

    select to_date(to_timestamp_ntz(cast(at_returned_date / 1000000 as bigint))) as activity_date
    from raw.fudgeflix_v3.ff_account_titles
    where at_returned_date is not null

)

select distinct activity_date
from all_dates
where activity_date is not null