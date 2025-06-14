with fudgemart as (
    select
        product_id::string as product_id,
        'fudgemart' as source_system,
        product_name,
        product_department as category,
        null as subcategory,
        product_vendor_id as vendor_id,
        product_retail_price as unit_price,
        to_timestamp_ntz(product_add_date / 1000000) as release_date,
        false as is_digital
    from {{ source('fudgemart', 'fm_products') }}
),

fudgeflix as (
    select
        title_id as product_id,
        'fudgeflix' as source_system,
        title_name as product_name,
        title_type as category,
        null as subcategory,
        null as vendor_id,
        null as unit_price,
        try_to_date(title_release_year::string, 'YYYY') as release_date,
        true as is_digital
    from {{ source('fudgeflix', 'ff_titles') }}
)

select * from fudgemart
union all
select * from fudgeflix