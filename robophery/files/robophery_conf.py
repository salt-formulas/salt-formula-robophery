{%- from "robophery/map.jinja" import server with context %}

CONF = {
    'name': '{{ server.name }}',
    'log_level': '{{ server.log_level }}',
    'log_handlers': {{ server.log_handlers }},
    'read_interval': {{ server.get('read_interval', 10000) }},
    'publish_interval': {{ server.get('publish_interval', 60000) }},
    'platform': '{{ server.platform }}',
    'config': {
        'comm': {{ server.communication }},
        'interface': {{ server.interface }},
        'module': {{ server.module }},
    }
}
