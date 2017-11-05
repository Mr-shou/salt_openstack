include:
  - glance.install

glance_prerequisites:
  cmd.run:
    - name: /etc/init.d/script glance_prerequisites

glance_service:
  file.managed:
    - name: /etc/glance/glance-api.conf
    - source: salt://glance/files/glance-api.conf
    - template: jinja
    - defaults:
      controller_ip: {{ pillar['info']['controller']['ip'] }}
      glance_passwd: {{ pillar['databases']['glance']['password'] }}

/etc/glance/glance-registry.conf:
  file.managed:
    - source: salt://glance/files/glance-registry.conf
    - template: jinja
    - defaults:
      controller_ip: {{ pillar['info']['controller']['ip'] }}
      glance_passwd: {{ pillar['databases']['glance']['password'] }}

#glance_db_sync:
#  file.managed:
#    - name: /tmp/glance_db_sync.sh
#    - source: salt://glance/files/glance_db_sync.sh
#    - mode: 755
glance_populate_image:
  cmd.run:
    - name: /etc/init.d/script glance_populate_image
glance_create_credentials:
  cmd.run:
    - name: /etc/init.d/script glance_create_credentials

glance_api.run:
  service.running:
    - name: openstack-glance-api
    - enable: true
    - watch: 
      - file: /etc/glance/glance-api.conf

glance_registry.run:
  service.running:
    - name: openstack-glance-registry
    - enable: true
    - watch:
      - file: /etc/glance/glance-registry.conf

image_sync:
  file.managed:
    - name: /tmp/cirros-0.3.4-x86_64-disk.img
    - source: salt://glance/files/cirros-0.3.4-x86_64-disk.img

glance_upload_image:
  cmd.run:
    - name: /etc/init.d/script glance_upload_image

#image_create:
#  file.managed:
#    - name: /tmp/image_create.sh
#    - source: salt://glance/files/image_create.sh
#    - mode: 755
#  cmd.run:
#    - name: sh /tmp/image_create.sh


