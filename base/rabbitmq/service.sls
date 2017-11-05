include:
  - rabbitmq.install

rabbitmq_service:
  service.running:
    - name: rabbitmq-server
    - enable: true
#  file.managed:
#    - name: /etc/init.d/script
#    - source: salt://bash/script
#    - mode: 755
#    - template: jinja
#    - defaults:
#      db_openstack_passwd: {{ pillar['databases']['openstack']['password'] }}
  cmd.run:
    - name: /etc/init.d/script rabbitmq
#    - name: rabbitmqctl add_user openstack openstack && rabbitmqctl set_permissions openstack ".*" ".*" ".*" && rabbitmq-plugins enable rabbitmq_management
#    - creates: /usr/sbin/rabbitmq-server
