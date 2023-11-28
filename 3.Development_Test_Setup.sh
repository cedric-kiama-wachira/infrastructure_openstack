# Create 4 Servers with Ubuntu Pro FIPS 16.04 LTS for Hardware requirements
Controller - 2 network cards
Compute - 2 network cards
Block Storage
Object Storage
Change Hos
# Setup the Controller hostname osnodectl1, add and activate a secondary interface with two elastic IPs
ssh -o "IdentitiesOnly yes" -i "openstack-key.pem" ubuntu@ec2-51-112-35-208.me-central-1.compute.amazonaws.com

vi /etc/hostname
osnodectl1

apt update && apt upgrade -y --allow-downgrades && timedatectl set-timezone 'Asia/Dubai' && reboot

ip -c addr
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host 
       valid_lft forever preferred_lft forever
2: ens5: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 9001 qdisc mq state UP group default qlen 1000
    link/ether 0e:f2:d7:93:27:b6 brd ff:ff:ff:ff:ff:ff
    inet 172.31.8.112/20 brd 172.31.15.255 scope global ens5
       valid_lft forever preferred_lft forever
    inet6 fe80::cf2:d7ff:fe93:27b6/64 scope link 
       valid_lft forever preferred_lft forever

ip -c route
default via 172.31.0.1 dev ens5 
172.31.0.0/20 dev ens5  proto kernel  scope link  src 172.31.8.112 

# Add a Secondary Network Interface
Description: openstack-controller-srv-vni2
Subnet: me-central-1c
Private IPv4 address(Custom Option): 172.31.8.122/20
Security group ID: sg-011db2b83bc227f49

# Map the device ID, Public IP and Private IP via AWS Console
eni-03188fa912ecdb137 51.112.35.208	172.31.8.112
eni-01a193adeb9cbff03 51.112.19.240    172.31.8.122

ip -c addr
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host 
       valid_lft forever preferred_lft forever
2: ens5: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 9001 qdisc mq state UP group default qlen 1000
    link/ether 0e:f2:d7:93:27:b6 brd ff:ff:ff:ff:ff:ff
    inet 172.31.8.112/20 brd 172.31.15.255 scope global ens5
       valid_lft forever preferred_lft forever
    inet6 fe80::cf2:d7ff:fe93:27b6/64 scope link 
       valid_lft forever preferred_lft forever
3: ens6: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN group default qlen 1000
    link/ether 0e:b2:08:d6:20:94 brd ff:ff:ff:ff:ff:ff

# Create the secondary Interface file and update 
cp  /etc/network/interfaces.d/50-cloud-init.cfg /etc/network/interfaces.d/51-cloud-init.cfg
cat /etc/network/interfaces.d/51-cloud-init.cfg
# network: {config: disabled}
auto lo
iface lo inet loopback

auto ens6
iface ens6 inet dhcp

reboot

ip -c addr
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host 
       valid_lft forever preferred_lft forever
2: ens5: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 9001 qdisc mq state UP group default qlen 1000
    link/ether 0e:f2:d7:93:27:b6 brd ff:ff:ff:ff:ff:ff
    inet 172.31.8.112/20 brd 172.31.15.255 scope global ens5
       valid_lft forever preferred_lft forever
    inet6 fe80::cf2:d7ff:fe93:27b6/64 scope link 
       valid_lft forever preferred_lft forever
3: ens6: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 9001 qdisc mq state UP group default qlen 1000
    link/ether 0e:14:51:80:a5:c8 brd ff:ff:ff:ff:ff:ff
    inet 172.31.8.122/20 brd 172.31.15.255 scope global ens6
       valid_lft forever preferred_lft forever
    inet6 fe80::c14:51ff:fe80:a5c8/64 scope link 
       valid_lft forever preferred_lft forever

# Now lets setup the Compute Node with a secondary NIC - virtual

ssh -o "IdentitiesOnly yes" -i "openstack-key.pem" ubuntu@ec2-51-112-26-59.me-central-1.compute.amazonaws.com

# Set the hostname
osnodecomp1

ip -c addr
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host 
       valid_lft forever preferred_lft forever
2: ens5: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 9001 qdisc mq state UP group default qlen 1000
    link/ether 0e:d4:8b:37:8f:f0 brd ff:ff:ff:ff:ff:ff
    inet 172.31.1.79/20 brd 172.31.15.255 scope global ens5
       valid_lft forever preferred_lft forever
    inet6 fe80::cd4:8bff:fe37:8ff0/64 scope link 
       valid_lft forever preferred_lft forever

# Add a Secondary Network Interface
Description: openstack-compute-srv-vni2
Subnet: me-central-1c
Private IPv4 address(Custom Option): 172.31.1.89
Security group ID: sg-011db2b83bc227f49

# Once created, we can attach it to the compute instance via AWS console
eni-032586be798cd84c2 51.112.26.59	172.31.1.79
eni-0b549034248a85ef2 3.29.193.166    172.31.1.89

ip -c addr

1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host 
       valid_lft forever preferred_lft forever
2: ens5: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 9001 qdisc mq state UP group default qlen 1000
    link/ether 0e:d4:8b:37:8f:f0 brd ff:ff:ff:ff:ff:ff
    inet 172.31.1.79/20 brd 172.31.15.255 scope global ens5
       valid_lft forever preferred_lft forever
    inet6 fe80::cd4:8bff:fe37:8ff0/64 scope link 
       valid_lft forever preferred_lft forever
3: ens6: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN group default qlen 1000
    link/ether 0e:b2:08:d6:20:94 brd ff:ff:ff:ff:ff:ff
 
# Attache an elastic Public IP to the new interface

    
# Configure the network to auto start and bring up the new interface
cp /etc/network/interfaces.d/50-cloud-init.cfg /etc/network/interfaces.d/51-cloud-init.cfg

vi /etc/network/interfaces.d/51-cloud-init.cfg

# network: {config: disabled}
auto lo
iface lo inet loopback

auto ens6
iface ens6 inet dhcp

# NOTE - on the compute node the new public IP can be used to access the server via ssh
ssh -o "IdentitiesOnly yes" -i "openstack-key.pem" ubuntu@ec2-3-29-193-166.me-central-1.compute.amazonaws.com


#