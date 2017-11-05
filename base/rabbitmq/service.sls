include:
  - rabbitmq.install

rabbitmq_service:
  service.running:
    - name: rabbitmq-server
    - enable: true

  cmd.run:
    - name: /etc/init.d/script rabbitmq
