{{ config(
    materialized = 'table',
    schema = 'dw_sams'
    )
}}




select
{{ dbt_utils.generate_surrogate_key(['employeeid']) }} as employee_key,
employeeid,
employeefname,
employeelname,
employeebday
FROM {{ source('sams_landing', 'employee') }}