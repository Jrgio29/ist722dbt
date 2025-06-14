with all_dates as (
    select to_date(order_date) as activity_date
    from {{ source('fudgemart', 'fm_orders') }}
    where order_date is not null

    union

    select to_date(ab_date) as activity_date
    from {{ source('fudgeflix', 'ff_account_billing') }}
    where ab_date is not null

    union

    select to_date(at_queue_date) as activity_date
    from {{ source('fudgeflix', 'ff_account_titles') }}
    where at_queue_date is not null

    union

    select to_date(at_shipped_date) as activity_date
    from {{ source('fudgeflix', 'ff_account_titles') }}
    where at_shipped_date is not null

    union

    select to_date(at_returned_date) as activity_date
    from {{ source('fudgeflix', 'ff_account_titles') }}
    where at_returned_date is not null
)

select distinct activity_date
from all_dates
where activity_date is not null