base:
  'controller':
    - ntp.service
    - openstack.install
    - sql.init
    - rabbitmq.service
    - memcached.service
    - keystone.service
    - api_endpoints.service










#  'comput':
#    - keepalived.service
#    - haproxy.service
#  'roles:nginx':
#    - match: grain
#    - nginx.service
