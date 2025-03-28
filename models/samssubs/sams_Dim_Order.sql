{{ config(
materialized = 'table',
schema = 'dw_sams'
)
}}


SELECT
{{ dbt_utils.generate_surrogate_key(['OrderNumber']) }} as order_key,
OrderNumber,
OrderMethod
FROM {{ source('sams_landing', '"ORDER"') }}