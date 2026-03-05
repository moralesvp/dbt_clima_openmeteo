{{ config(materialized='table') }}

select
  row_number() over (order by city_name) as location_key,
  city_name,
  avg(latitude)  as latitude,
  avg(longitude) as longitude,
  any_value(timezone) as timezone
from {{ ref('int_clima_py__weather_hourly') }}
group by city_name