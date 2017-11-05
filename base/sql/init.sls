include:
  - sql.service

sql_init:
  file.managed:
    - name: /etc/init.d/script
    - source: salt://bash/script
    - mode: 755
    - template: jinja
    - defaults:
      controller_ip: {{ pillar['info']['controller']['ip'] }}
      db_root_passwd: {{ pillar['databases']['root']['password'] }}
      db_openstack_passwd: {{ pillar['databases']['openstack']['password'] }}
      db_keystone_passwd: {{ pillar['databases']['keystone']['password'] }}
      db_glance_passwd: {{ pillar['databases']['glance']['password'] }}
      db_nova_passwd: {{ pillar['databases']['nova']['password'] }}
      db_neutron_passwd: {{ pillar['databases']['neutron']['password'] }}
      db_cinder_passwd: {{ pillar['databases']['cinder']['password'] }}


  cmd.run:
    - name: /etc/init.d/script mysql_passwd
#    - creates: /tmp/mysql.sh
