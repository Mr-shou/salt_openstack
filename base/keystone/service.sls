include:
  - keystone.install

keystone_service:
  file.managed:
    - name: /etc/keystone/keystone.conf
    - source: salt://keystone/files/keystone.conf
    - template: jinja
    - defaults:
      passwd: {{ pillar['databases']['keystone']['password'] }}
      controller_ip: {{ pillar['info']['controller']['ip'] }}

keystone_db_sync:
#  file.managed:
#    - name: /etc/init.d/script
#    - source: salt://bash/script
#    - mode: 755
#    - template: jinja
#    - defaults:
#      db_sync: {{ pillar['databases']['keystone']['db_sync'] }}
#      passwd: {{ pillar['databases']['keystone']['password'] }}
  cmd.run:
    - name: /etc/init.d/script keystone_prerequisites && /etc/init.d/script keystone_ropulate

httpd_services:
    file.managed:
    - name: /etc/httpd/conf/httpd.conf
    - source: salt://keystone/files/httpd.conf
    - template: jinja
    - defaults:
      controller_ip: {{ pillar['info']['controller']['ip'] }}

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
