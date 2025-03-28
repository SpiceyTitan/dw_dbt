{{ config(
materialized = 'table',
schema = 'dw_sams'
)
}}


SELECT
ol.orderlineid,
Customer_key,
Employee_Key,
order_key,
product_key,
store_key,
d.date_key,
ol.orderlineqty,
ol.orderlineprice,
ol.pointsearned,
((ol.orderlineprice - p.productcost)* ol.orderlineqty) as Revenue
FROM {{ source('sams_landing', 'orderdetails') }} ol
INNER JOIN {{ source('sams_landing', '"ORDER"')}} o ON o.ordernumber = ol.ordernumber
INNER JOIN {{ source('sams_landing', 'product') }} p ON ol.ProductID = p.ProductID
INNER JOIN {{ source('sams_landing', 'customer') }} cu ON o.CustomerID = cu.CustomerID
INNER JOIN {{ source('sams_landing', 'employee') }} e ON o.EmployeeID = e.EmployeeID
INNER JOIN {{ ref('sams_dim_date') }} d ON d.Date_day = CAST(o.Orderdate AS DATE)
INNER JOIN {{ source('sams_landing', 'store') }} s ON e.StoreID = s.StoreID
INNER JOIN {{ ref('sams_dim_order')}} dor ON o.ordernumber = dor.ordernumber
INNER JOIN {{ ref('sams_dim_product') }} pro ON p.ProductID = pro.ProductID
INNER JOIN {{ ref('sams_dim_customer') }} cus ON cus.CustomerID = cu.CustomerID
INNER JOIN {{ ref('sams_dim_employee') }} emp ON emp.EmployeeID = e.EmployeeID
INNER JOIN {{ ref('sams_dim_store') }} sto ON sto.StoreID = s.StoreID