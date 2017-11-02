include:
  - rabbitmq.install

rabbitmq_service:
  service.running:
    - name: rabbitmq-server
    - enable: true
  cmd.run:
    - name: rabbitmqctl add_user openstack openstack && rabbitmqctl set_permissions openstack ".*" ".*" ".*" && rabbitmq-plugins enable rabbitmq_management
    - creates: /usr/sbin/rabbitmq-server
