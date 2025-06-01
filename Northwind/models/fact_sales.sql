with orders as (
    select
        orderid,
        {{ dbt_utils.generate_surrogate_key(['customerid']) }} as customerkey,
        {{ dbt_utils.generate_surrogate_key(['employeeid']) }} as employeekey,
        TO_NUMBER(TO_CHAR(CAST(orderdate AS DATE), 'YYYYMMDD')) as orderdatekey
    from {{ source('northwind', 'Orders') }}
),

order_details as (
    select
        orderid,
        productid,
        {{ dbt_utils.generate_surrogate_key(['productid']) }} as productkey,
        quantity,
        quantity * unitprice as extendedpriceamount,
        (quantity * unitprice) * discount as discountamount
    from {{ source('northwind', 'Order_Details') }}
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