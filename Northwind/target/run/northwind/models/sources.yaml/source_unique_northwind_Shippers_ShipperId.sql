
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    

select
    ShipperId as unique_field,
    count(*) as n_records

from raw.northwind.Shippers
where ShipperId is not null
group by ShipperId
having count(*) > 1



  
  
      
    ) dbt_internal_test