{{ config(
    materialized = 'table',
    schema = 'dw_oliver'
    )
}}

SELECT
Employee_ID as employee_key,
employee_ID,
first_name,
last_name,
email,
phone_number,
hire_date,
position
FROM {{ source('oliver_landing', 'employee') }}