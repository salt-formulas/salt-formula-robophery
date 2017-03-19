{%- from "robophery/map.jinja" import server with context %}

manager_conf = {
    'log_level': '{{ server.log_level }}',
    'log_handlers': {{ server.log_handlers }},
    'read_interval': {{ server.read_interval }},
    'platform': '{{ server.platform }}',
    'config': {
        'comm': {{ server.communication }},
        'interface': {{ server.interface }},
        'module': {{ server.module }},
    }
}
