with base as (
    select * from {{ ref('stg_customers') }}
)

select
    {{ dbt_utils.generate_surrogate_key(['customer_id', 'source_system']) }} as customer_sk,
    customer_id,
    source_system,
    first_name,
    last_name,
    email,
    phone_number,
    address,
    city,
    state,
    zip_code,
    country,
    account_created_date,
    is_active
from base