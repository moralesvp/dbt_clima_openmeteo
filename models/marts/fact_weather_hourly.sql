{{ config(materialized='table') }}

select
  l.location_key,
  t.time_key,

  -- medidas
  s.temperature_2m,
  s.relative_humidity_2m,
  s.precipitation,
  s.wind_speed_10m,

  -- metadata
  s.extracted_at
from {{ ref('stg_weather_hourly') }} s
join {{ ref('dim_location') }} l
  on l.city_name = s.city_name
join {{ ref('dim_time') }} t
  on t.time_ts = s.time_ts