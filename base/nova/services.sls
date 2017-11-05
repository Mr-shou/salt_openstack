nova_rerequisites:
  cmd.run:
    - name: /etc/init.d/script nova_api && /etc/init.d/script nova

nova_credentials:
  cmd.run:
    - name: /etc/init.d/script nova_credentials

include:
  - nova.install

/etc/nova/nova.conf:
  file.managed:
    - source: salt://nova/files/nova.conf
    - template: jinja
    - defaults:
      nova_db_passwd: {{ pillar['databases']['nova']['password'] }}
      controller_ip: {{ pillar['info']['controller']['ip'] }}
      db_openstack_passwd: {{ pillar['databases']['openstack']['password'] }}
      db_root_passwd: {{ pillar['databases']['root']['password'] }}
      db_neutron_passwd: {{ pillar['databases']['neutron']['password'] }}
#  cmd.run:
#    - name: systemctl enable openstack-nova-api.service openstack-nova-consoleauth.service openstack-nova-scheduler.service openstack-nova-conductor.service openstack-nova-novncproxy.service && systemctl start openstack-nova-api.service openstack-nova-consoleauth.service openstack-nova-scheduler.service openstack-nova-conductor.service openstack-nova-novncproxy.service

nova_populate_db:
  cmd.run:
    - name: /etc/init.d/script nova_populate_db

nova_service:
  cmd.run:
    - name: systemctl enable openstack-nova-api.service openstack-nova-consoleauth.service openstack-nova-scheduler.service openstack-nova-conductor.service openstack-nova-novncproxy.service && systemctl start openstack-nova-api.service openstack-nova-consoleauth.service openstack-nova-scheduler.service openstack-nova-conductor.service openstack-nova-novncproxy.service


#    - require:
#      - file: /etc/nova/nova.conf
#nova_api_service:
#  service.running:
#    - name: openstack-nova-api
#    - enable: true
#
