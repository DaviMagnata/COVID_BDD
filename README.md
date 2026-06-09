# COVID_BDD

## Requisitos

- Usar Python 3.11.9
- Postgres

### Dados

Os dados de 2020, 2021 e 2022 devem ser colocados no diretório raiz `COVID_BDD`.

Fonte:
https://dadosabertos.saude.gov.br/dataset/registro-de-ocupacao-hospitalar-covid-19

### Configuração do Banco

- Completar os campos de conexão para o Postgres.

---

## Como Executar

### ETL

Rodar o notebook. Ao final será feito o upload para a DB Postgres.

### ELT

Rodar o notebook e executar:

```bash
dbt run
```

no diretório `covid_l`.