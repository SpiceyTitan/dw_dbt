{{ config(
materialized = 'table',
schema = 'dw_sams'
)
}}


SELECT
traffic_key,
event_key,
page_key,
date_key,
COUNT(*) as daily_interactions
FROM {{ source('web_landing', 'web_traffic_events') }} web
INNER JOIN {{ ref('SAMS_DIM_DATE') }} d ON web.event_timestamp = d.event_timestamp
INNER JOIN {{ ref('SAMS_DIM_EVENT') }} ev ON web.event_name = ev.event_name
INNER JOIN {{ ref('SAMS_DIM_TRAFFICSOURCE') }} tf ON web.traffic_source = tf.traffic_source
INNER JOIN {{ ref('SAMS_DIM_WEBPAGE') }} wp ON web.page_url = wp.page_url
GROUP BY traffic_key, event_key, page_key, date_key