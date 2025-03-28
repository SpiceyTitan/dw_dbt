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
INNER JOIN {{ ref('sams_dim_date') }} d ON web.event_timestamp = d.event_timestamp
INNER JOIN {{ ref('web_event_dim') }} ev ON web.event_name = ev.event_name
INNER JOIN {{ ref('web_trafficsource_dim') }} tf ON web.traffic_source = tf.traffic_source
INNER JOIN {{ ref('web_webpage_dim') }} wp ON web.page_url = wp.page_url
GROUP BY traffic_key, event_key, page_key, date_key