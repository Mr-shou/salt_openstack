#!/bin/env bash

KEY= grep -v ^# /etc/keystone/keystone.conf | grep admin_token | awk -F "=" '{print $2}'
export OS_TOKEN=$KEY
export OS_URL=http://172.25.27.1:35357/v3
export OS_IDENTITY_API_VERSION=3
openstack service create  --name keystone --description "OpenStack Identity" identity
openstack endpoint create --region RegionOne    identity public http://172.25.27.1:5000/v3
openstack endpoint create --region RegionOne   identity internal http://172.25.27.1:5000/v3
openstack endpoint create --region RegionOne   identity admin http://172.25.27.1:35357/v3
openstack domain create --description "Default Domain" default
openstack project create --domain default    --description "Admin Project" admin
echo "admin" | openstack user create --domain default    --password-prompt admin
openstack role create admin
openstack role add --project admin --user admin admin
openstack project create --domain default   --description "Service Project" service
openstack project create --domain default    --description "Demo Project" demo
echo "demo" | openstack user create --domain default    --password-prompt demo
openstack role create user
openstack role add --project demo --user demo user
