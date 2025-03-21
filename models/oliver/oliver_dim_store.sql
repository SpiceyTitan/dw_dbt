{{ config(
    materialized = 'table',
    schema = 'dw_oliver'
    )
}}

SELECT
store_ID as store_key,
store_ID,
store_name,
street,
city,
state
FROM {{ source('oliver_landing', 'store') }}