{{ config(
    materialized = 'table',
    schema = 'dw_sams'
    )
}}




Select DISTINCT
{{ dbt_utils.generate_surrogate_key(['event_name']) }} as event_key,
event_name
FROM {{ source('web_landing', 'web_traffic_events') }}