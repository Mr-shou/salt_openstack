#repo_sync:
#  file.managed:
#    - name: /etc/yum.repos.d/openstack.repo
#    - source: salt://ntp/files/openstack.repo
#    - user: root
#    - group: root
#    - mode: 644
#  cmd.rum:
#    - name: yum clean all && yum repolist

ntp_installed:
  pkg.installed:
    - pkgs:
      - chrony

ntp_running:
  file.managed:
    - name: /etc/chrony.conf
    - source: salt://ntp/files/chrony.conf
  service.running:
    - name: chronyd
    - enable: True
    - watch:
      - file: /etc/chrony.conf

sync_time:
  cmd.run:
    - name: chronyc sources
