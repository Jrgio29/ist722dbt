with raw as (
  select
    at.at_id as stream_event_id,
    at.at_account_id as customer_id,
    at.at_title_id as title_id,
    to_date(to_timestamp_ntz(cast(at.at_shipped_date as bigint) / 1000000)) as watch_date,
    at.at_rating as user_rating
  from raw.fudgeflix_v3.ff_account_titles at
),

titles as (
  select
    title_id,
    title_runtime -- in seconds
  from {{ ref('stg_titles') }}
)

select
  r.stream_event_id,
  r.customer_id,
  r.title_id,
  r.watch_date,
  t.title_runtime / 60 as minutes_watched, -- convert seconds to minutes
  r.user_rating
from raw r
left join titles t
  on r.title_id = t.title_id