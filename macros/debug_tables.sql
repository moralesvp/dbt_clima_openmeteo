{% macro debug_tables() %}
  {% set q %}
    select table_schema, table_name
    from information_schema.tables
    where lower(table_name) like '%forecast%'
    order by table_schema, table_name
  {% endset %}

  {% set res = run_query(q) %}
  {% if res is none %}
    {{ log("No result returned (run_query returned none).", info=True) }}
  {% else %}
    {{ log("Found " ~ (res.rows | length) ~ " tables matching '%forecast%'", info=True) }}
    {% for row in res.rows %}
      {{ log(row[0] ~ "." ~ row[1], info=True) }}
    {% endfor %}
  {% endif %}
{% endmacro %}