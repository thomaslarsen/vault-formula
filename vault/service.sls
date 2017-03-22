{% from "vault/map.jinja" import vault_settings with context %}

install_service_script:
  file.managed:
    - name: {{ vault_settings.install_location }}/vault-service
    - source: salt://vault/files/service.sh
    - mode: 755
    - template: jinja

install_service_init:
  file.managed:
    - name: {{ vault_settings.service.init_file }}
    - source: {{ vault_settings.service.init_source}}
    - template: jinja

vault_service_running:
  service.running:
    - name: vault
    - enable: True
    - reload: True
