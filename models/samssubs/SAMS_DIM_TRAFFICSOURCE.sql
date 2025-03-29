{{ config(
materialized = 'table',
schema = 'dw_sams'
)
}}




SELECT DISTINCT
{{ dbt_utils.generate_surrogate_key(['traffic_source']) }} as traffic_key,
traffic_source
FROM {{ source('web_landing', 'web_traffic_events') }}