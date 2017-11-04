api_endpoints:
  file.managed:
    - name: /tmp/api.sh
    - source: salt://api_endpoints/files/api.sh
    - mode: 755

  cmd.run:
    - name: cd /tmp && ./api.sh

admin-openrc:
  file.managed:
    - name: /root/admin-openrc
    - source: salt://api_endpoints/files/admin-openrc

demo-openrc:
  file.managed:
    - name: /root/demo-openrc
    - source: salt://api_endpoints/files/demo-openrc

