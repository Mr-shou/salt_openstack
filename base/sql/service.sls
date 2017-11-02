include:
  - sql.install

sql_service:
  service.running:
    - name: mariadb
    - enable: true
    - require:
      - file: /etc/my.cnf.d/openstack.cnf
