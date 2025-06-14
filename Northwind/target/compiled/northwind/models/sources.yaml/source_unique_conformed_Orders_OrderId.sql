
    
    

select
    OrderId as unique_field,
    count(*) as n_records

from raw.conformed.Orders
where OrderId is not null
group by OrderId
having count(*) > 1


