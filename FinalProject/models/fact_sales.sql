with base as (
    select * from {{ ref('stg_sales') }}
),

joined as (
    select
        {{ dbt_utils.generate_surrogate_key(['base.order_id', 'base.product_id', 'base.plan_id', 'base.sale_date']) }} as sales_sk,
        base.order_id,

        -- Customer surrogate key
        base.customer_id,

        -- Product surrogate key (optional for subscriptions)
        base.product_id,

        -- Plan surrogate key (optional for retail)
        base.plan_id,

        -- Date surrogate key
        base.sale_date,

        base.quantity,
        base.unit_price,
        base.discount,
        base.total_price,
        base.sale_type

    from base

    -- Join to dimensions
    left join {{ ref('dim_customers') }} cust
        on base.customer_id = cust.customer_id

    left join {{ ref('dim_product') }} prod
        on base.product_id = prod.product_id
        and base.sale_type = 'retail'

    left join {{ ref('dim_plan') }} plan
        on base.plan_id = plan.plan_id
        and base.sale_type = 'subscription'

    left join {{ ref('dim_date') }} date_dim
        on date_dim.date = base.sale_date::date
)

select * from joined