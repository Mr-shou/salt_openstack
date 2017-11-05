include:
  - dashboard.install

/etc/openstack-dashboard/local_settings:
  file.managed:
    - source: salt://dashboard/files/local_settings
    - template: jinja
    - defaults:
      controller_ip: {{ pillar['info']['controller']['ip'] }}
      time_zone: {{ pillar['info']['controller']['time_zone'] }}

dashboard_service:
  cmd.run:
    - name: systemctl restart httpd.service memcached.service
