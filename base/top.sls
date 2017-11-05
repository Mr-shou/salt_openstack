base:
  'server1':
    - ntp.service
    - openstack.install
    - sql.init
    - rabbitmq.service
    - memcached.service
    - keystone.service
    - service_entity.service
    - glance.service
    - nova.services
    - neutron.services
    - dashboard.service
  'server2':
    - ntp.service
    - comput_node.service

