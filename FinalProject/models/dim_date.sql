with base as (
    select activity_date
    from {{ ref('stg_dates') }}
)

select
    {{ dbt_utils.generate_surrogate_key(['activity_date']) }} as date_key,
    activity_date as date,
    extract(year from activity_date) as year,
    extract(month from activity_date) as month,
    extract(day from activity_date) as day,
    extract(dow from activity_date) as weekday_number,
    to_char(activity_date, 'Day') as weekday_name,
    to_char(activity_date, 'Month') as month_name,
    case
        when extract(dow from activity_date) in (0, 6) then true
        else false
    end as is_weekend
from base