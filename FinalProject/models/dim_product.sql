with base as (
    select * from {{ ref('stg_products') }}
)

select
    {{ dbt_utils.generate_surrogate_key(['product_id', 'source_system']) }} as product_sk,
    product_id,
    source_system,
    product_name,
    category,
    subcategory,
    vendor_id,
    unit_price,
    release_date,
    is_digital
from base