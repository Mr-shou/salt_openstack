node_comput_install:
  file.managed:
    - name: /etc/yum.repos.d/openstack.repo
    - source: salt://openstack/files/openstack.repo
    - template: jinja
    - defaults:
      baseurl: {{ pillar['yum']['info']['baseurl'] }}
      gpgcheck: {{ pillar['yum']['info']['gpgcheck'] }}

  cmd.run:
    - name: yum clean all && yum repolist && yum update -y

  pkg.installed:
    - pkgs:
      - openstack-nova-compute
      - openstack-neutron-linuxbridge
      - ebtables
      - ipset
