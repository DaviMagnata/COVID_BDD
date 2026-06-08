{{ config(materialized='table') }}

WITH base AS (
    SELECT * FROM {{ ref('covid_preparado') }}
),

notificacoes_unicas AS (
    SELECT DISTINCT
        origem,
        _p_usuario,
        "estadoNotificacao",
        "municipioNotificacao"
    FROM base
)

SELECT
    row_number() over (
    order by origem,_p_usuario,"estadoNotificacao","municipioNotificacao"
    ) as id_notificacao_sk,
    *
FROM notificacoes_unicas