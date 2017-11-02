sql_install:
  pkg.installed:
    - pkgs:
      - mariadb
      - mariadb-server
      - python2-PyMySQL

  file.managed:
    - name: /etc/my.cnf.d/openstack.cnf
    - source: salt://sql/files/openstack.cnf
    - template: jinja
    - defaults:
      BIND_ADDRESS: {{ pillar['BIND_ADDRESS'] }}
