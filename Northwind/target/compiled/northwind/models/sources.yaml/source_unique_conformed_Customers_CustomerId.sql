
    
    

select
    CustomerId as unique_field,
    count(*) as n_records

from raw.conformed.Customers
where CustomerId is not null
group by CustomerId
having count(*) > 1


