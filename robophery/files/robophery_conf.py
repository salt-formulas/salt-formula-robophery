{%- from "robophery/map.jinja" import server with context %}

CONF = {
    'name': '{{ server.name|default(grains.nodename) }}',
    'log_level': '{{ server.log_level|default("info") }}',
    'log_handlers': {{ server.log_handlers|default(["console", "syslog"]) }},
    'read_interval': {{ server.get('read_interval', 10000) }},
    'publish_interval': {{ server.get('publish_interval', 60000) }},
    'platform': '{{ server.platform }}',
    'config': {
        'comm': {{ server.communication }},
        'interface': {{ server.interface }},
        'module': {{ server.module }},
    }
}
