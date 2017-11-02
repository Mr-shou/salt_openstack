api_endpoints:
  file.managed:
    - name: /tmp/api.sh
    - source: salt://api_endpoints/files/api.sh
    - mode: 755

  cmd.run:
    - name: cd /tmp && ./api.sh
