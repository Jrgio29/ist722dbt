
  
    

create or replace transient table analytics.dbt_jrgio29_northwind.dim_product
    
    as (with stg_products as (
    select * from raw.northwind.Products
)

select
    md5(cast(coalesce(cast(productid as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT)) as productkey,
    productid,
    productname,
    supplierid,
    categoryid,
    quantityperunit,
    unitprice,
    unitsinstock,
    unitsonorder,
    reorderlevel,
    discontinued
from stg_products
    )
;


  