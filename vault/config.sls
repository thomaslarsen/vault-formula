{% from "vault/map.jinja" import vault_settings with context %}

configure_vault_server:
  file.managed:
    - name: {{ vault_settings.config_location }}/vault.json
    - makedirs: True
    - contents: |
        {{ vault_settings.config | json() | indent(8) }}
    - watch_in:
      - service: vault_service_running
    - require_in:
      - service: vault_service_running
