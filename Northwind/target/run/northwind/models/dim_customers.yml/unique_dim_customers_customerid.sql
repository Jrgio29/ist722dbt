
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    

select
    customerid as unique_field,
    count(*) as n_records

from analytics.dbt_jrgio29_northwind.dim_customers
where customerid is not null
group by customerid
having count(*) > 1



  
  
      
    ) dbt_internal_test