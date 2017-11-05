neutron_rerequisites:
  cmd.run:
    - name: /etc/init.d/script neutron

neutron_credentials:
  cmd.run:
    - name: /etc/init.d/script neutron_credentials

include:
  - neutron.install

/etc/neutron/neutron.conf:
  file.managed:
    - source: salt://neutron/files/neutron.conf
    - template: jinja
    - defaults:
      neutron_db_passwd: {{ pillar['databases']['neutron']['password'] }}
      controller_ip: {{ pillar['info']['controller']['ip'] }}
      db_openstack_passwd: {{ pillar['databases']['openstack']['password'] }}
      nova_db_passwd: {{ pillar['databases']['nova']['password'] }}

/etc/neutron/plugins/ml2/ml2_conf.ini:
  file.managed:
    - source: salt://neutron/files/ml2_conf.ini

/etc/neutron/plugins/ml2/linuxbridge_agent.ini:
  file.managed:
    - source: salt://neutron/files/linuxbridge_agent.ini
    - template: jinja
    - defaults:
      underlying_network_if: {{ pillar['info']['controller']['underlying_network_if'] }}

/etc/neutron/dhcp_agent.ini:
  file.managed:
    - source: salt://neutron/files/dhcp_agent.ini

/etc/neutron/metadata_agent.ini:
  file.managed:
    - source: salt://neutron/files/metadata_agent.ini
    - template: jinja
    - defaults:
      db_root_passwd: {{ pillar['databases']['root']['password'] }}
      controller_ip: {{ pillar['info']['controller']['ip'] }}

neutron_finalize:
  cmd.run:
    - name: /etc/init.d/script neutron_finalize
    - creates: /etc/neutron/plugin.ini

neutron_service:
  cmd.run:
    - name: systemctl restart openstack-nova-api.service && systemctl enable neutron-server.service neutron-linuxbridge-agent.service neutron-dhcp-agent.service neutron-metadata-agent.service && systemctl start neutron-server.service neutron-linuxbridge-agent.service neutron-dhcp-agent.service neutron-metadata-agent.service

