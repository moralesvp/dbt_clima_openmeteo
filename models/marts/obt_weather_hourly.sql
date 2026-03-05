{{ config(materialized='table') }}

select
  -- identidad del “lugar”
  city_name,

  -- tiempo (grano: 1 ciudad + 1 hora)
  time_ts,
  cast(time_ts as date) as date,
  extract(year  from time_ts) as year,
  extract(month from time_ts) as month,
  extract(day   from time_ts) as day,
  extract(hour  from time_ts) as hour,

  -- métricas
  temperature_2m,
  relative_humidity_2m,
  precipitation,
  wind_speed_10m,

  -- contexto (opcional, pero útil)
  latitude,
  longitude,
  timezone,

  -- metadata
  extracted_at
from {{ ref('int_clima_py__weather_hourly') }}