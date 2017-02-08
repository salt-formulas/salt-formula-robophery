{%- from "robophery/map.jinja" import server with context %}
{%- if server.enabled %}

robophery_packages:
  pkg.installed:
  - names: {{ robophery.pkgs }}

/etc/robophery.conf:
  file.managed:
  - source: salt://robophery/files/robophery.conf
  - template: jinja
  - user: root
  - group: root
  - mode: 644
  - require:
    - pkg: robophery_packages

{%- endif %}
