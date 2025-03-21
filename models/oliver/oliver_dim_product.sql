{{ config(
    materialized = 'table',
    schema = 'dw_oliver'
    )
}}

SELECT
Product_ID as product_key,
product_ID,
Product_name,
description
FROM {{ source('oliver_landing', 'product') }}