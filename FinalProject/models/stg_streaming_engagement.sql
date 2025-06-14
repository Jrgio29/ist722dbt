with raw as (
    select
        at.at_id as stream_event_id,
        at.at_account_id as customer_id,
        at.at_title_id as title_id,

        to_date(to_timestamp_ntz(at.at_queue_date / 1000000)) as queue_date,
        to_date(to_timestamp_ntz(at.at_shipped_date / 1000000)) as shipped_date,
        to_date(to_timestamp_ntz(at.at_returned_date / 1000000)) as returned_date,

        datediff(
            minute,
            to_timestamp_ntz(at.at_shipped_date / 1000000),
            to_timestamp_ntz(at.at_returned_date / 1000000)
        ) as minutes_watched,

        at.at_rating as user_rating
    from {{ source('fudgeflix', 'ff_account_titles') }} at
)

select * from raw