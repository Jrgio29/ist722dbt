with orders as (
    select
        orderid,
        md5(cast(coalesce(cast(customerid as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT)) as customerkey,
        md5(cast(coalesce(cast(employeeid as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT)) as employeekey,
        TO_NUMBER(TO_CHAR(CAST(orderdate AS DATE), 'YYYYMMDD')) as orderdatekey
    from raw.northwind.Orders
),

order_details as (
    select
        orderid,
        productid,
        md5(cast(coalesce(cast(productid as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT)) as productkey,
        quantity,
        quantity * unitprice as extendedpriceamount,
        (quantity * unitprice) * discount as discountamount
    from raw.northwind.Order_Details
),

joined as (
    select
        od.orderid,
        o.customerkey,
        o.employeekey,
        o.orderdatekey,
        od.productkey,
        od.quantity,
        od.extendedpriceamount,
        od.discountamount,
        od.extendedpriceamount - od.discountamount as soldamount
    from order_details od
    join orders o on od.orderid = o.orderid
)

select * from joined