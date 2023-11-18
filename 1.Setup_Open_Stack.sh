# Ubuntu Flavor Instructions
apt install apache2 -y
systemctl enable apache2.service
systemctl start apache2
apt install virt-manager qemu-kvm -y
apt install memcached -y 
systemctl enable memcached.service
systemctl start memcached
apt install mysql-server -y 
systemctl enable mysql.service
systemctl start mysql

mysql -uroot -p
ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'StrongAdminSecret';
flush privileges;
quit;
mysql -uroot -p 

su - ubuntu

git clone https://opendev.org/openstack/devstack

cd devstack

vi local.conf

[[local|localrc]]

# Password for KeyStone, Database, RabbitMQ and Service
ADMIN_PASSWORD=StrongAdminSecret
DATABASE_PASSWORD=$ADMIN_PASSWORD
RABBIT_PASSWORD=$ADMIN_PASSWORD
SERVICE_PASSWORD=$ADMIN_PASSWORD

# Host IP - get your Server/VM IP address from ip addr command
HOST_IP=172.31.14.169

./stack.sh

PASSWORD PROPMPTS = StrongAdminSecret

# Installation Text

=========================
DevStack Component Timing
 (times are in seconds)  
=========================
wait_for_service      12
async_wait            76
osc                  138
apt-get              129
test_with_retry        3
dbsync                 4
pip_install          153
apt-get-update         2
run_process           24
git_timed            144
-------------------------
Unaccounted time     162
=========================
Total runtime        847

=================
 Async summary
=================
 Time spent in the background minus waits: 235 sec
 Elapsed time: 847 sec
 Time if we did everything serially: 1082 sec
 Speedup:  1.27745


Post-stack database query stats:
+------------+-----------+-------+
| db         | op        | count |
+------------+-----------+-------+
| keystone   | SELECT    | 46278 |
| keystone   | INSERT    |    93 |
| neutron    | SELECT    |  5099 |
| neutron    | CREATE    |     1 |
| neutron    | SHOW      |     4 |
| neutron    | INSERT    | 10688 |
| neutron    | UPDATE    |   135 |
| placement  | SELECT    |    73 |
| placement  | INSERT    |    68 |
| placement  | SET       |     7 |
| neutron    | DELETE    |    26 |
| nova_api   | SELECT    |   108 |
| nova_cell0 | SELECT    |   232 |
| nova_cell1 | SELECT    |   327 |
| nova_cell0 | INSERT    |    12 |
| nova_cell0 | UPDATE    |    14 |
| nova_cell1 | INSERT    |     7 |
| nova_cell1 | UPDATE    |    60 |
| placement  | UPDATE    |     3 |
| cinder     | SELECT    |   206 |
| cinder     | INSERT    |     5 |
| cinder     | UPDATE    |     1 |
| glance     | SELECT    |    52 |
| glance     | INSERT    |     6 |
| glance     | UPDATE    |     2 |
| nova_api   | INSERT    |    14 |
| nova_api   | SAVEPOINT |     9 |
| nova_api   | RELEASE   |     7 |
| cinder     | DELETE    |     1 |
+------------+-----------+-------+

This is your host IP address: 172.31.14.169
This is your host IPv6 address: ::1
Horizon is now available at http://172.31.14.169/dashboard
Keystone is serving at http://172.31.14.169/identity/
The default users are: admin and demo
The password: StrongAdminSecret

Services are running under systemd unit files.
For more information see: 
https://docs.openstack.org/devstack/latest/systemd.html

DevStack Version: 2024.1
Change: bb0c273697bf54dd569ad38e459cd161b62f96cb Option for SQLAlchemy and alembic git source 2023-11-16 19:49:29 +0530
OS Version: Ubuntu 22.04 jammy

2023-11-18 20:46:26.782 | stack.sh completed in 847 seconds.


Horizon is now available at http://172.31.14.169/dashboard
Keystone is serving at http://172.31.14.169/identity/
The default users are: admin and demo
The password: StrongAdminSecret

Horizon is now available at http://3.29.56.223/dashboard
Keystone is serving at http://3.29.56.223/identity/
The default users are: admin and demo
The password: StrongAdminSecret

