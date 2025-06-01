with f_sales as (
    select * from {{ ref('fact_sales') }}
),

d_customer as (
    select * from {{ ref('dim_customers') }}
),

d_employee as (
    select * from {{ ref('dim_employee') }}
),

d_product as (
    select * from {{ ref('dim_product') }}
),

d_date as (
    select * from {{ ref('dim_date') }}
)

select 
    f.orderid,
    f.quantity,
    f.extendedpriceamount,
    f.discountamount,
    f.soldamount,

    -- Customer fields
    d_customer.customerid,
    d_customer.customerkey,
    d_customer.contactname,
    d_customer.companyname,

    -- Employee fields
    d_employee.employeeid,
    d_employee.employeenamefirstlast,
    d_employee.employeetitle,

    -- Product fields
    d_product.productid,
    d_product.productname,
    d_product.unitprice,

    -- Date fields (order date)
    d_date.datekey as orderdatekey,
    d_date.date as orderdate,
    d_date.monthname,
    d_date.year

from f_sales f
left join d_customer on f.customerkey = d_customer.customerkey
left join d_employee on f.employeekey = d_employee.employeekey
left join d_product on f.productkey = d_product.productkey
left join d_date on f.orderdatekey = d_date.datekey