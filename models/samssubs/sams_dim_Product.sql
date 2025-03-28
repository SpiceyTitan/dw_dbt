{{ config(
    materialized = 'table',
    schema = 'dw_sams'
    )
}}




select
{{ dbt_utils.generate_surrogate_key(['p.productid']) }} as product_key,
p.productid,
producttype,
productcalories,
productname,
productcost,
length,
breadtype
FROM {{ source('sams_landing', 'product') }} p
LEFT JOIN {{ source('sams_landing', 'sandwich') }} s ON p.productid = s.productid
