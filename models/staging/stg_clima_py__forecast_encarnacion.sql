{{ config(materialized='view') }}

select
  'Encarnacion' as city_name,
  hourly,
  latitude,
  longitude,
  timezone,
  timezone_abbreviation,
  utc_offset_seconds,
  elevation,
  generationtime_ms,
  _airbyte_extracted_at as extracted_at
from {{ source('clima_py', 'forecast_encarnacion') }}