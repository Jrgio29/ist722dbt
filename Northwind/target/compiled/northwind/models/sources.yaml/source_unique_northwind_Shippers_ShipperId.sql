
    
    

select
    ShipperId as unique_field,
    count(*) as n_records

from raw.northwind.Shippers
where ShipperId is not null
group by ShipperId
having count(*) > 1


