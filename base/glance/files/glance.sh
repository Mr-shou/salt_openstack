#!/bin/env bash
sourece /root/admin-openrc
(sleep 3;echo "glance";sleep 1;echo "glance") |openstack user create --domain default --password-prompt glance
openstack role add --project service --user glance admin
openstack service create --name glance --description "OpenStack Image" image
openstack endpoint create --region RegionOne   image public http://172.25.27.1:9292
openstack endpoint create --region RegionOne   image internal http://172.25.27.1:9292
openstack endpoint create --region RegionOne   image admin http://172.25.27.1:9292
systemctl enable openstack-glance-api.service  openstack-glance-registry.service
systemctl start openstack-glance-api.service openstack-glance-registry.service
