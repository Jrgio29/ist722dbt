with plans as (
    select * from {{ ref('stg_plans') }}
)

select
    {{ dbt_utils.generate_surrogate_key(['plan_id']) }} as plan_sk,
    plan_id,
    plan_name,
    plan_price,
    plan_current
from plans