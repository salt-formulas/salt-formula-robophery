{%- if pillar.robophery is defined %}
include:
{%- if pillar.robophery.server is defined %}
- robophery.server
{%- endif %}
{%- endif %}
