{{ config(
materialized = 'table',
schema = 'dw_sams'
)
}}


SELECT
{{ dbt_utils.generate_surrogate_key(['customerid']) }} as customer_key,
customerid,
customerFName,
customerLName,
customerBDay,
customerPhone
FROM {{ source('sams_landing', 'customer') }}