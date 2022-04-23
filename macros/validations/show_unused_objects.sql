{% macro show_unused_objects(except_names='') %}
  {% set except_names_list = except_names.split(',') %}
  {{log("SN-Graph = " ~ graph.keys(), True)}}
  {%- for node in graph.child_map.keys() %}
    {%- if node.startsWith('model.') and (graph.child_map[node] | length) == 0 -%}
	  {{log('Unused object: "' ~ node ~ '"', True)}}
	{%- endif -%}
  {%- endfor %}
{% endmacro %}