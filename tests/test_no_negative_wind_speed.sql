select *
from {{ ref('fact_weather_hourly') }}
where wind_speed_10m < 0
