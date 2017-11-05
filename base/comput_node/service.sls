include:
  - comput_node.install

/etc/nova/nova.conf:
  file.managed:
    - source: salt://comput_node/files/nova.conf
    - template: jinja
    - defaults:
      nova_db_passwd: {{ pillar['databases']['nova']['password'] }}
      controller_ip: {{ pillar['info']['controller']['ip'] }}
      comput_ip: {{ pillar['info']['comput']['ip'] }}
      db_openstack_passwd: {{ pillar['databases']['openstack']['password'] }}
      db_root_passwd: {{ pillar['databases']['root']['password'] }}
      db_neutron_passwd: {{ pillar['databases']['neutron']['password'] }}

comput_service:
  cmd.run:
    - name: systemctl enable libvirtd.service openstack-nova-compute.service && systemctl start libvirtd.service openstack-nova-compute.service

/etc/neutron/neutron.conf:
  file.managed:
    - source: salt://comput_node/files/neutron.conf
    - template: jinja
    - defaults:
      neutron_db_passwd: {{ pillar['databases']['neutron']['password'] }}
      controller_ip: {{ pillar['info']['controller']['ip'] }}
      db_openstack_passwd: {{ pillar['databases']['openstack']['password'] }}
      nova_db_passwd: {{ pillar['databases']['nova']['password'] }}

/etc/neutron/plugins/ml2/linuxbridge_agent.ini:
  file.managed:
    - source: salt://comput_node/files/linuxbridge_agent.ini
    - template: jinja
    - defaults:
      underlying_network_if: {{ pillar['info']['comput']['underlying_network_if'] }}

comput_neutron_service:
  cmd.run:
    - name: systemctl restart openstack-nova-compute.service && systemctl enable neutron-linuxbridge-agent.service && systemctl start neutron-linuxbridge-agent.service
