{% from "vault/map.jinja" import vault_settings with context %}

install_vault_binary:
  archive.extracted:
    - name: {{ vault_settings.install_location }}
    - source: https://releases.hashicorp.com/vault/{{ vault_settings.version }}/vault_{{ vault_settings.version }}_linux_{{ vault_settings.architecture_dict[grains['osarch']] }}.zip
    - source_hash: https://releases.hashicorp.com/vault/{{ vault_settings.version }}/vault_{{ vault_settings.version }}_SHA256SUMS
    - archive_format: zip
    - if_missing: {{ vault_settings.install_location }}/vault
    - source_hash_update: True
    - enforce_toplevel: False
  file.managed:
    - name: {{ vault_settings.install_location }}/vault
    - mode: '0755'
    - require:
      - archive: install_vault_binary
    - require_in:
      - file: configure_vault_server
