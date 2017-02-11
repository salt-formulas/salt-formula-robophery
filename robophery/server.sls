{%- from "robophery/map.jinja" import server with context %}
{%- if server.enabled %}

robophery_packages:
  pkg.installed:
  - names: {{ server.pkgs.default }}

robophery_virtualenv:
  virtualenv.manage:
  - name: {{ server.dir.base }}
  - system_site_packages: true
  - require:
    - pkg: robophery_packages

{%- if server.ble_enabled %}

robophery_ble_packages:
  pkg.installed:
  - names: {{ server.pkgs.ble }}
  - require:
    - pkg: robophery_packages

{%- for pip in server.pip.ble %}

{{ pip }}:
  pip.installed:
  - bin_env: {{ server.dir.base }}
  - require:
    - pkg: robophery_ble_packages
    - virtualenv: robophery_virtualenv
  - require_in:
    - file: robophery_config

{%- endfor %}

{%- endif %}

{%- if server.gpio_enabled %}

robophery_gpio_packages:
  pkg.installed:
  - names: {{ server.pkgs.gpio }}
  - require:
    - pkg: robophery_packages

{%- for pip in server.pip.gpio %}

{{ pip }}:
  pip.installed:
  - bin_env: {{ server.dir.base }}
  - require:
    - pkg: robophery_gpio_packages
    - virtualenv: robophery_virtualenv
  - require_in:
    - file: robophery_config

{%- endfor %}

{%- endif %}

/etc/robophery:
  file.directory:
  - makedirs: true

robophery_config:
  file.managed:
  - name: /etc/robophery/robophery.conf
  - source: salt://robophery/files/robophery.conf
  - template: jinja
  - user: root
  - group: root
  - mode: 644
  - require:
    - file: /etc/robophery

{%- endif %}
