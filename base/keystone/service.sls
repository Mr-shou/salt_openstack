include:
  - keystone.install

keystone_service:
  file.managed:
    - name: /etc/keystone/keystone.conf
    - source: salt://keystone/files/keystone.conf
    - template: jinja
    - defaults:
      BIND_ADDRESS: {{ pillar['BIND_ADDRESS'] }}

keystone_db_sync:
  file.managed:
    - name: /tmp/keystone_db_sync.sh
    - source: salt://keystone/files/keystone_db_sync.sh
    - mode: 755
  cmd.run:
    - name: sh /tmp/keystone_db_sync.sh

httpd_services:
    file.managed:
    - name: /etc/httpd/conf/httpd.conf
    - source: salt://keystone/files/httpd.conf
wsgi_keystone:
    file.managed:
    - name: /etc/httpd/conf.d/wsgi-keystone.conf
    - source: salt://keystone/files/wsgi-keystone.conf
httpd.run:
  service.running:
    - name: httpd
    - enable: true
    - watch: 
      - file: /etc/httpd/conf/httpd.conf
