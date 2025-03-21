{{ config(
    materialized = 'table',
    schema = 'dw_oliver'
    )
}}

SELECT
Customer_ID as cust_key,
Customer_ID,
first_name,
last_name,
email,
phone_number,
state
FROM {{ source('oliver_landing', 'customer') }}