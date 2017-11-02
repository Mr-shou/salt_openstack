include:
  - sql.service

sql_init:
  file.managed:
    - name: /tmp/mysql.sh
    - source: salt://sql/files/mysql.sh
    - mode: 755

  cmd.run:
    - name: cd /tmp && sh mysql.sh
    - creates: /tmp/mysql.sh
