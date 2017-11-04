#! /bin/bash
# Description: databases create and grant ,service create...

# See how we were called.
case "$1" in
  keystone_prerequisites)
	mysql -e "CREATE DATABASE keystone"
	mysql -e "GRANT ALL PRIVILEGES ON keystone.* TO 'keystone'@'localhost' IDENTIFIED BY 'keystone'"
	mysql -e "GRANT ALL PRIVILEGES ON keystone.* TO 'keystone'@'%'    IDENTIFIED BY 'keystone'"
        ;;
  keystone_ropulate)
	sed -i.bak 's/admin_token = ADMIN_TOKEN/admin_token ='`openssl rand -hex 10`'/g' /etc/keystone/keystone.conf 
	su -s /bin/sh -c "keystone-manage db_sync" keystone
	keystone-manage fernet_setup --keystone-user keystone --keystone-group keystone
  glance)
	mysql -e "CREATE DATABASE glance"
	mysql -e "GRANT ALL PRIVILEGES ON glance.* TO 'glance'@'localhost' IDENTIFIED BY 'glance'"
	mysql -e "GRANT ALL PRIVILEGES ON glance.* TO 'glance'@'%'    IDENTIFIED BY 'glance'"
        ;;
  nova_api)
	mysql -e "CREATE DATABASE nova_api"
	mysql -e "GRANT ALL PRIVILEGES ON nova_api.* TO 'nova'@'localhost' IDENTIFIED BY 'nova'"
	mysql -e "GRANT ALL PRIVILEGES ON nova_api.* TO 'nova'@'%'    IDENTIFIED BY 'nova'"
        ;;
  nova)
	mysql -e "CREATE DATABASE nova"
	mysql -e "GRANT ALL PRIVILEGES ON nova.* TO 'nova'@'localhost'    IDENTIFIED BY 'nova'"
	mysql -e "GRANT ALL PRIVILEGES ON nova.* TO 'nova'@'%'    IDENTIFIED BY 'nova';"
        ;;
  neutron)
	mysql -e "CREATE DATABASE neutron"
	mysql -e "GRANT ALL PRIVILEGES ON neutron.* TO 'neutron'@'localhost' IDENTIFIED BY 'neutron'"
	mysql -e "GRANT ALL PRIVILEGES ON neutron.* TO 'neutron'@'%'    IDENTIFIED BY 'neutron'"
        ;;
  cinder)
	mysql -e "CREATE DATABASE cinder"
	mysql -e "GRANT ALL PRIVILEGES ON cinder.* TO 'cinder'@'localhost' IDENTIFIED BY 'cinder'"
	mysql -e "GRANT ALL PRIVILEGES ON cinder.* TO 'cinder'@'%'    IDENTIFIED BY 'cinder'"
        ;;
  endpoints_api)
	KEY=`grep -v ^# /etc/keystone/keystone.conf | grep admin_token | awk -F "=" '{print $2}'`
	export OS_TOKEN=$KEY
	export OS_URL=http://172.25.27.1:35357/v3
	export OS_IDENTITY_API_VERSION=3
	openstack service create  --name keystone --description "OpenStack Identity" identity
	openstack endpoint create --region RegionOne    identity public http://172.25.27.1:5000/v3
	openstack endpoint create --region RegionOne   identity internal http://172.25.27.1:5000/v3
	openstack endpoint create --region RegionOne   identity admin http://172.25.27.1:35357/v3
	openstack domain create --description "Default Domain" default
	openstack project create --domain default    --description "Admin Project" admin
	(sleep 3;echo "admin";sleep 1;echo "admin") | openstack user create --domain default    --password-prompt admin
	openstack role create admin
	openstack role add --project admin --user admin admin
	openstack project create --domain default   --description "Service Project" service
	openstack project create --domain default    --description "Demo Project" demo
	(sleep 3;echo "demo";sleep 1;echo "demo") | openstack user create --domain default    --password-prompt demo
	openstack role create user
	openstack role add --project demo --user demo user
        ;;

  restart|reload|force-reload)
        cd "$CWD"
        $0 stop
        $0 start
        rc=$?
        ;;
  *)
        echo $"Usage: $0 {start|stop|status|restart|reload|force-reload}"
        exit 2
esac
exit $rc
