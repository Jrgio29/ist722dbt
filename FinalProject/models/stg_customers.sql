with fudgemart as (
    select
        customer_id::string as customer_id,
        'fudgemart' as source_system,
        customer_firstname as first_name,
        customer_lastname as last_name,
        customer_email as email,
        customer_phone as phone_number,
        customer_address as address,
        customer_city as city,
        customer_state as state,
        customer_zip as zip_code,
        null as country,
        null as account_created_date,
        null as is_active
    from {{ source('fudgemart', 'fm_customers') }}
),

fudgeflix as (
    select
        account_id::string as customer_id,
        'fudgeflix' as source_system,
        account_firstname as first_name,
        account_lastname as last_name,
        account_email as email,
        null as phone_number,
        null as address,
        null as city,
        null as state,
        account_zipcode as zip_code,
        null as country,
        account_opened_on as account_created_date,
        true as is_active
    from {{ source('fudgeflix', 'ff_accounts') }}
)

select * from fudgemart
union all
select * from fudgeflix