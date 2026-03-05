select *
from {{ ref('int_clima_py__weather_hourly') }}
where extract(minute from time_ts) != 0
