{{ config(materialized='table') }}

WITH covid_final AS (
    SELECT 
        *
    FROM {{ ref('covid_preparado') }}
),

hospital AS (SELECT * FROM {{ ref('dim_hospital_dbt') }}),
notificacao AS (SELECT * FROM {{ ref('dim_notificacao_dbt') }}),
tempo AS (SELECT * FROM {{ ref('dim_tempo_dbt') }})

SELECT

    h.id_hospital_sk,
    n.id_notificacao_sk,
    t.id_tempo_sk,
    
    base.ocupacaoCovidUti,
    base.ocupacaoCovidCli,
    base."saidaSuspeitaObitos",
    base."saidaSuspeitaAltas",
    base."saidaConfirmadaObitos",
    base."saidaConfirmadaAltas"

FROM covid_final AS base

-- JOIN HOSPITAL
LEFT JOIN hospital h
    ON base.cnes = h.cnes
    AND base.estado = h.estado
    AND base.municipio = h.municipio

-- JOIN NOTIFICACAO
LEFT JOIN notificacao n
    ON base.origem = n.origem
    AND base._p_usuario = n._p_usuario
    AND base."estadoNotificacao" = n."estadoNotificacao"
    AND base."municipioNotificacao" = n."municipioNotificacao"

-- JOIN TEMPO
LEFT JOIN tempo t
    ON base."dataNotificacao"::timestamp = t.data_notificacao
    AND base._created_at::timestamp = t.created_at
    AND base._updated_at::timestamp = t.updated_at