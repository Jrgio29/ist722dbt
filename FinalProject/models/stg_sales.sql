with

raw_retail_sales as (
    select
        od.order_id::string as order_id,
        o.customer_id::string as customer_id,
        od.product_id::string as product_id,
        null as plan_id,
        'retail' as sale_type,
        od.order_qty as quantity,
        to_timestamp_ntz(o.order_date / 1000000) as sale_date
    from {{ source('fudgemart', 'fm_orders') }} o
    join {{ source('fudgemart', 'fm_order_details') }} od
        on o.order_id = od.order_id
),

enriched_retail_sales as (
    select
        r.order_id,
        r.customer_id,
        r.product_id,
        r.plan_id,
        r.sale_type,
        r.quantity,
        r.sale_date,
        p.unit_price,
        0.00 as discount,
        r.quantity * p.unit_price as total_price
    from raw_retail_sales r
    left join {{ ref('dim_product') }} p
        on r.product_id = p.product_id
        and p.source_system = 'fudgemart'
),

raw_subscription_sales as (
    select
        ab.ab_id::string as order_id,
        ab.ab_account_id::string as customer_id,
        null as product_id,
        ab.ab_plan_id::string as plan_id,
        'subscription' as sale_type,
        1 as quantity,
        to_timestamp_ntz(ab.ab_date / 1000000) as sale_date
    from {{ source('fudgeflix', 'ff_account_billing') }} ab
),

enriched_subscription_sales as (
    select
        s.order_id,
        s.customer_id,
        s.product_id,
        s.plan_id,
        s.sale_type,
        s.quantity,
        s.sale_date,
        p.plan_price as unit_price,
        0.00 as discount,
        s.quantity * p.plan_price as total_price
    from raw_subscription_sales s
    left join {{ ref('dim_plan') }} p
        on s.plan_id = p.plan_id
)

select * from enriched_retail_sales
union all
select * from enriched_subscription_sales