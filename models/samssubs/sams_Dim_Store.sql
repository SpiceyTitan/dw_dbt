{{ config(
    materialized = 'table',
    schema = 'dw_sams'
    )
}}




select
{{ dbt_utils.generate_surrogate_key(['storeid']) }} as store_key,
storeid,
address,
city,
state,
zip
FROM {{ source('sams_landing', 'store') }}