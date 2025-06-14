





with validation_errors as (

    select
        OrderId, PRoductsId
    from raw.conformed.Order_Details
    group by OrderId, PRoductsId
    having count(*) > 1

)

select *
from validation_errors


