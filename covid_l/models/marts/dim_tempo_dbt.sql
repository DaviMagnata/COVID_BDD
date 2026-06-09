{{ config(materialized='table') }}

WITH base AS (
    SELECT DISTINCT 
        "dataNotificacao"::timestamp AS data_notificacao,
        _created_at::timestamp AS created_at,
        _updated_at::timestamp AS updated_at
    FROM {{ ref('covid_preparado') }}
)

SELECT
    ROW_NUMBER() OVER (
        ORDER BY data_notificacao, created_at, updated_at
    ) AS id_tempo_sk,
    data_notificacao,
    created_at,
    updated_at,


    EXTRACT(YEAR FROM data_notificacao) AS ano_origem,
    EXTRACT(DAY FROM data_notificacao) AS dia_notificacao,
    EXTRACT(MONTH FROM data_notificacao) AS mes_notificacao,
    data_notificacao::time AS hora_notificacao,

    EXTRACT(DAY FROM created_at) AS dia_criado,
    EXTRACT(MONTH FROM created_at) AS mes_criado,
    created_at::time AS hora_criado,

    EXTRACT(DAY FROM updated_at) AS dia_atualizado,
    EXTRACT(MONTH FROM updated_at) AS mes_atualizado,
    updated_at::time AS hora_atualizado

FROM base