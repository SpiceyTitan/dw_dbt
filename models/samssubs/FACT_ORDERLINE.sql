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
INNER JOIN {{ ref('SAMS_DIM_DATE') }} d ON d.Date_day = CAST(o.Orderdate AS DATE)
INNER JOIN {{ source('sams_landing', 'store') }} s ON e.StoreID = s.StoreID
INNER JOIN {{ ref('SAMS_DIM_ORDER')}} dor ON o.ordernumber = dor.ordernumber
INNER JOIN {{ ref('SAMS_DIM_PRODUCT') }} pro ON p.ProductID = pro.ProductID
INNER JOIN {{ ref('SAMS_DIM_CUSTOMER') }} cus ON cus.CustomerID = cu.CustomerID
INNER JOIN {{ ref('SAMS_DIM_EMPLOYEE') }} emp ON emp.EmployeeID = e.EmployeeID
INNER JOIN {{ ref('SAMS_DIM_STORE') }} sto ON sto.StoreID = s.StoreID