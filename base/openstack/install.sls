openstack_installed:
  file.managed:
    - name: /etc/yum.repos.d/openstack.repo
    - source: salt://openstack/files/openstack.repo

  cmd.run:
    - name: yum clean all && yum repolist && yum update -y
#    - name: yum install -y centos-release-openstack-mitaka && yum install -y https://rdoproject.org/repos/rdo-release.rpm && yum clean all && yum repolist && yum update
  pkg.installed:
    - pkgs:
      - python-openstackclient
      - openstack-selinux
