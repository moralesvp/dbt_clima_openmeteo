# dbt_clima_openmeteo

Proyecto **dbt** para modelar datos meteorológicos obtenidos desde la API **Open-Meteo** e ingeridos mediante **Airbyte**.

El pipeline transforma datos JSON de pronóstico horario en modelos analíticos listos para análisis utilizando una arquitectura de **3 capas de dbt**.

---

# Arquitectura del proyecto

El pipeline sigue la arquitectura estándar de **Analytics Engineering con dbt**:

```
sources → staging → intermediate → marts
```

## Sources

Datos ingeridos por Airbyte desde Open-Meteo.

```
clima_py.forecast_asuncion
clima_py.forecast_cde
clima_py.forecast_encarnacion
```

## Staging

Normalización ligera de datos provenientes de los sources.

```
stg_clima_py__forecast_asuncion
stg_clima_py__forecast_cde
stg_clima_py__forecast_encarnacion
```

Responsabilidades de la capa staging:

- limpieza básica
- renombrado de columnas
- estandarización de nombres
- preparación inicial para transformación

---

## Intermediate

Transformaciones intermedias y preparación de datos.

```
int_clima_py__forecast_union
int_clima_py__weather_hourly
```

Responsabilidades:

- unión de datos de múltiples ciudades
- transformación de estructuras JSON a formato tabular
- generación de registros por hora

---

## Marts

Modelos analíticos finales.

### Modelo OBT (One Big Table)

```
obt_weather_hourly
```

Tabla analítica desnormalizada lista para análisis.

Incluye:

- ciudad
- timestamp
- temperatura
- humedad relativa
- precipitación
- velocidad del viento
- información de ubicación

### Modelo Dimensional

```
dim_location
dim_time
fact_weather_hourly
```

Implementación estilo **Kimball Star Schema**.

```
dim_location
      │
      ▼
fact_weather_hourly
      ▲
      │
dim_time
```

---

# DAG del pipeline

El DAG generado por `dbt docs` muestra la relación entre modelos:

```
sources
  ↓
stg_clima_py__*
  ↓
int_clima_py__forecast_union
  ↓
int_clima_py__weather_hourly
  ↓
marts
```

---

# Requisitos

- Python 3.10 o superior
- dbt-core
- dbt-duckdb
- cuenta en MotherDuck

Instalar dependencias:

```bash
pip install dbt-duckdb
```

---

# Configuración

El proyecto utiliza **MotherDuck** como data warehouse.

Definir el token de acceso:

```bash
export MOTHERDUCK_TOKEN=your_token_here
```

---

# Ejecutar el pipeline

Desde la raíz del proyecto:

```bash
dbt run --profiles-dir .
```

Esto ejecutará todos los modelos del pipeline.

---

# Generar documentación y DAG

dbt permite generar documentación interactiva del proyecto.

```bash
dbt docs generate --profiles-dir .
dbt docs serve --profiles-dir .
```

Luego abrir en el navegador:

```
http://localhost:8080
```

Allí se puede visualizar:

- DAG del pipeline
- modelos
- sources
- dependencias

---

# Estructura del proyecto

```
dbt_clima_openmeteo
│
├── dbt_project.yml
├── profiles.yml
├── README.md
│
├── models
│   ├── staging
│   │   ├── stg_clima_py__forecast_asuncion.sql
│   │   ├── stg_clima_py__forecast_cde.sql
│   │   └── stg_clima_py__forecast_encarnacion.sql
│   │
│   ├── intermediate
│   │   ├── int_clima_py__forecast_union.sql
│   │   └── int_clima_py__weather_hourly.sql
│   │
│   └── marts
│       ├── dim_location.sql
│       ├── dim_time.sql
│       ├── fact_weather_hourly.sql
│       └── obt_weather_hourly.sql
```

---

# Tecnologías utilizadas

- dbt
- DuckDB
- MotherDuck
- Airbyte
- Open-Meteo API

---

# Autor

Gabriel Morales.
Proyecto académico de **Data Engineering** utilizando dbt para modelado de datos meteorológicos.