{{ config(
    materialized = 'table',
    schema = 'dw_sams'
    )
}}




select
{{ dbt_utils.generate_surrogate_key(['page_url']) }} as page_key,
page_url
FROM {{ source('web_landing', 'web_traffic_events') }}