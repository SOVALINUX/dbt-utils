{% test not_null_proportion(model, column_name, at_least, at_most=1, condition="1=1") %}
  {{ return(adapter.dispatch('test_not_null_proportion', 'dbt_utils')(model, column_name, at_least, at_most, condition)) }}
{% endtest %}

{% macro default__test_not_null_proportion(model, column_name, at_least, at_most=1, condition="1=1") %}
with validation as (
  select
    sum(case when {{ column_name }} is null then 0 else 1 end) / {{ dbt_utils.safe_cast('count(*)', dbt_utils.type_numeric() ) }} as not_null_proportion
  from {{ model }}
  where {{condition}}
),
validation_errors as (
  select
    not_null_proportion
  from validation
  where not_null_proportion < {{ at_least }} or not_null_proportion > {{ at_most }}
)
select
  *
from validation_errors

{% endmacro %}

