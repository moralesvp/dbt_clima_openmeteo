{{ config(materialized='table') }}

with t as (
  select distinct time_ts
  from {{ ref('int_clima_py__weather_hourly') }}
)

select
  -- llave surrogate “estable” por hora: YYYYMMDDHH
  (extract(year from time_ts)*1000000
 + extract(month from time_ts)*10000
 + extract(day from time_ts)*100
 + extract(hour from time_ts))::bigint as time_key,

  time_ts,
  cast(time_ts as date) as date,
  extract(year  from time_ts) as year,
  extract(month from time_ts) as month,
  extract(day   from time_ts) as day,
  extract(hour  from time_ts) as hour,
  extract(dow   from time_ts) as day_of_week
from t