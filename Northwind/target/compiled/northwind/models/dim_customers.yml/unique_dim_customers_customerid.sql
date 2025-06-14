
    
    

select
    customerid as unique_field,
    count(*) as n_records

from analytics.dbt_jrgio29_northwind.dim_customers
where customerid is not null
group by customerid
having count(*) > 1


