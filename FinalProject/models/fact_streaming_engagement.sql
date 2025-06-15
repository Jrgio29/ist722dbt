with engagement as (
    select
        se.stream_event_id,
        dc.customer_id,
        dt3.date_key as watch_date_key,
        dt_title.title_id,
        se.minutes_watched,
        se.user_rating
    from {{ ref('stg_streaming_engagement') }} se
    left join {{ ref('dim_customers') }} dc
        on dc.customer_id = cast(se.customer_id as string)
    left join {{ ref('dim_title') }} dt_title
        on dt_title.title_id = se.title_id
    left join {{ ref('dim_date') }} dt3
        on dt3.date = cast(se.watch_date as date)
)

select *
from engagement