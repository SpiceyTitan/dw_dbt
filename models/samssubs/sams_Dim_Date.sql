
{{ config(
materialized = 'table',
schema = 'dw_sams'
)
}}


with cte_date as (
{{ dbt_date.get_date_dimension("1990-01-01", "2050-12-31") }}
)


SELECT
{{ dbt_utils.generate_surrogate_key(['Date_day']) }} as date_key,
c.Date_day,
w.event_timestamp,
c.Day_Of_Week,
c.month_name,
c.year_number
from cte_date c
JOIN {{ source('web_landing', 'web_traffic_events') }} w ON CAST(w.event_timestamp AS DATE) = c.Date_day




