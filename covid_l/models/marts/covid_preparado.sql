{{
    config(materialized = 'view')
}}

with stg_covid_mart as (

    select *
    from {{ ref('stg_covid') }}

),

tratamento as (

    select
         _id, "dataNotificacao", 
         cnes, 
        coalesce("ocupacaoCovidCli",("ocupacaoSuspeitoCli" + "ocupacaoConfirmadoCli" )) as ocupacaoCovidCli,
        coalesce("ocupacaoCovidUti",("ocupacaoSuspeitoUti" + "ocupacaoConfirmadoUti" )) as ocupacaoCovidUti,
         
         "ocupacaoHospitalarUti", 
         "ocupacaoHospitalarCli",
          "saidaSuspeitaObitos", 
         "saidaSuspeitaAltas", "saidaConfirmadaObitos",
          "saidaConfirmadaAltas", _p_usuario, 
          "estadoNotificacao", "municipioNotificacao",
            coalesce(estado,'Rio Grande do Sul') as estado,
            coalesce(municipio,'Não-Me-Toque') as municipio,
            excluido,  
           _created_at, _updated_at,
            CASE 
                WHEN origem = 'RPA-PR-CURITIBA' THEN 'RPA-PR'
                WHEN origem = 'RPA-MG-BELO-HORIZONTE' THEN 'RPA-MG'
                ELSE origem
            END as origem
        
    from stg_covid_mart
    WHERE cnes is not NULL AND 
    "saidaConfirmadaObitos" IS NOT NULL AND
    "saidaConfirmadaAltas" IS NOT NULL AND 
    "saidaSuspeitaObitos" IS NOT NULL AND
    "saidaSuspeitaObitos" IS NOT NULL

)
select *
from tratamento