#!/bin/env bash
sed -i.bak 's/admin_token = ADMIN_TOKEN/admin_token ='`openssl rand -hex 10`'/g' /etc/keystone/keystone.conf 
su -s /bin/sh -c "keystone-manage db_sync" keystone
keystone-manage fernet_setup --keystone-user keystone --keystone-group keystone
