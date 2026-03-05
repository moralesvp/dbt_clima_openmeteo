{{ config(materialized='view') }}

select
  'Asuncion' as city_name,
  hourly,
  latitude,
  longitude,
  timezone,
  timezone_abbreviation,
  utc_offset_seconds,
  elevation,
  generationtime_ms,
  _airbyte_extracted_at as extracted_at
from {{ source('clima_py', 'forecast_asuncion') }}