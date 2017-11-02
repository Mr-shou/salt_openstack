include:
  - keystone.install

keystone_service:
  file.managed:
    - name: /etc/keystone/keystone.conf
    - source: salt://keystone/files/keystone.conf
    - template: jinja
    - defaults:
      BIND_ADDRESS: {{ pillar['BIND_ADDRESS'] }}

  cmd.run:
    - name: sed -i.bak 's/admin_token = ADMIN_TOKEN/admin_token ='`openssl rand -hex 10`'/g' /etc/keystone/keystone.conf && su -s /bin/sh -c "keystone-manage db_sync" keystone && keystone-manage fernet_setup --keystone-user keystone --keystone-group keystone

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
