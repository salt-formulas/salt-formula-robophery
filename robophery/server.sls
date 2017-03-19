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

{# temporary until pip install is in place #}

robophery_source_repo:
  git.latest:
  - name: {{ server.source.address }}
  - target: /srv/robophery/source
  - rev: {{ server.source.revision }}
  - require:
    - virtualenv: /srv/robophery

robophery_install:
  cmd.wait:
  - name: source /srv/robophery/bin/activate; python setup.py install
  - cwd: /srv/robophery/source
  - watch:
    - git: robophery_source_repo

/etc/robophery:
  file.directory:
  - makedirs: true

robophery_config:
  file.managed:
  - name: /etc/robophery/robophery_conf.py
  - source: salt://robophery/files/robophery_conf.py
  - template: jinja
  - user: root
  - group: root
  - mode: 644
  - require:
    - file: /etc/robophery

{%- if grains.get('init', None) == 'systemd' %}

robophery_service_file:
  file.managed:
  - name: /etc/systemd/system/{{ server.service }}.service
  - source: salt://robophery/files/robophery-manager.service
  - template: jinja
  - user: root
  - mode: 644
  - require:
    - file: robophery_config

robophery_service:
  service.running:
  - name: {{ server.service }}
  - enable: true
  - require:
    - file: robophery_service_file

{%- endif %}

{%- endif %}
