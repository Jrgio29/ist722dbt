
  
    

create or replace transient table analytics.dbt_jrgio29_northwind.dim_customers
    
    as (with stg_customers as (
    SELECT * FROM raw.northwind.Customers
)

SELECT md5(cast(coalesce(cast(stg_customers.customerid as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT)) as customerkey, stg_customers.*
FROM stg_customers
    )
;


  