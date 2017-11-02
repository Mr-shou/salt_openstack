include:
  - memcached.install

memcached_service:
  service.running:
    - name: memcached
    - enable: true
    - watch:
      - file: /etc/sysconfig/memcached

  file.managed:
    - name: /etc/sysconfig/memcached
    - source: salt://memcached/files/memcached
    - mode: 755

  cmd.run:
    - name: systemctl restart memcached
