
    
    

select
    CategoryId as unique_field,
    count(*) as n_records

from raw.conformed.Categories
where CategoryId is not null
group by CategoryId
having count(*) > 1


