{{ config(materialized='view') }}

with base as (
  select
    city_name,
    hourly,
    latitude,
    longitude,
    timezone,
    extracted_at
  from {{ ref('int_clima_py__forecast_union') }}
),

idx as (
  select
    b.*,
    i as pos
  from base b,
  range(
    0::bigint,
    coalesce(
      cast(json_array_length(json_extract(b.hourly, '$.time')) as bigint),
      0::bigint
    )
  ) as t(i)
)

select
  city_name,
  latitude,
  longitude,
  timezone,

  cast(json_extract_string(hourly, '$.time[' || pos || ']') as timestamp) as time_ts,

  cast(json_extract_string(hourly, '$.temperature_2m[' || pos || ']') as double) as temperature_2m,
  cast(json_extract_string(hourly, '$.relative_humidity_2m[' || pos || ']') as double) as relative_humidity_2m,
  cast(json_extract_string(hourly, '$.precipitation[' || pos || ']') as double) as precipitation,
  cast(json_extract_string(hourly, '$.wind_speed_10m[' || pos || ']') as double) as wind_speed_10m,

  extracted_at
from idx