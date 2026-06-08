{{ config(materialized='table') }}

WITH base AS (
    SELECT * FROM {{ ref('covid_preparado') }}
),

locais_unicos AS (
    SELECT DISTINCT
        cnes,
        estado,
        municipio
    FROM base
)

SELECT
    row_number() over (
    order by cnes, estado, municipio
    ) as id_hospital_sk,
    *
FROM locais_unicos