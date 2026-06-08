with base as (

    select * from {{ source('raw', 'raw_covid_2020') }}
    union all
    select * from {{ source('raw', 'raw_covid_2021') }}
    union all
    select * from {{ source('raw', 'raw_covid_2022') }}

)

select *
from base