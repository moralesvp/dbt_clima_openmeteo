{{ config(materialized='view') }}

select * from {{ ref('stg_clima_py__forecast_asuncion') }}
union all
select * from {{ ref('stg_clima_py__forecast_cde') }}
union all
select * from {{ ref('stg_clima_py__forecast_encarnacion') }}