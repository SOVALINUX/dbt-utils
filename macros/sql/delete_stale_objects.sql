{% macro delete_stale_objects(schema, dry_run=True, except_names='') %}
  {{ return(adapter.dispatch('delete_stale_objects', 'dbt_utils')(schema, dry_run, except_names)) }}
{% endmacro %}

{% macro default__delete_stale_objects(schema, dry_run=True, except_names='') %}
  {% do exceptions.raise_compiler_error('Delete stale objects have no default implementation yet - most likely your adapter is not supported') %}
{% endmacro %}