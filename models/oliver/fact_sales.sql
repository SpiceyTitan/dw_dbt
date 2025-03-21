{{ config(
    materialized = 'table',
    schema = 'dw_oliver'
) }}

SELECT
    cu.cust_key,
    d.date_key,
    s.store_key,
    p.product_key,
    e.employee_key,
    ol.quantity,
    ol.unit_price,
    (ol.quantity * ol.unit_price) as dollars_sold

FROM {{ source('oliver_landing', 'orderline') }} ol
INNER JOIN {{ source('oliver_landing', 'orders') }} o 
    ON ol.order_ID = o.order_ID
inner join {{ ref("oliver_dim_customer") }} cu on o.customer_id = cu.cust_key
inner join {{ ref("oliver_dim_date") }} d on o.order_Date = d.date_key
inner join {{ ref("oliver_dim_store") }} s on o.store_id = s.store_key
inner join {{ ref("oliver_dim_product") }} p on ol.product_id = p.product_key
inner join {{ ref("oliver_dim_employee") }} e on o.employee_id = e.employee_key
