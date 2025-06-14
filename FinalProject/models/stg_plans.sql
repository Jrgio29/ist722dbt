with source as (
    select * from {{ source('fudgeflix', 'ff_plans') }}
)

select
    plan_id::string as plan_id,
    plan_name,
    plan_price,
    plan_current
from source