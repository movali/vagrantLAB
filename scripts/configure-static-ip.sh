#!/bin/bash

echo 'Setting static IP address for Hyper-V...'



if [ $1 == "debian" ]
  then
    cat << EOF > /etc/network/interfaces
# The loopback network interface
auto lo
iface lo inet loopback

# allow-hotplug eno1
# iface eth0 inet dhcp

# The primary network interface
auto eth0
iface eth0  inet static
 address $2
 netmask $4
 gateway $3
 dns-nameservers 8.8.8.8
 dns-nameservers 8.8.4.4
EOF
elif [ $1 == "rocky" ]
  then
    cat << EOF > /etc/sysconfig/network-scripts/ifcfg-eth0
DEVICE=eth0
BOOTPROTO=none
ONBOOT=yes
PREFIX=$4
IPADDR=$2
GATEWAY=$3
DNS1=8.8.8.8
EOF
systemctl restart NetworkManager
sed -i '/PasswordAuthentication/c\PasswordAuthentication yes' /etc/ssh/sshd_config
sed -i '/ChallengeResponseAuthentication/c\PasswordAuthentication yes' /etc/ssh/sshd_config
elif [ $1 == "suse" ]
  then
 cat << EOF > /etc/sysconfig/network/ifcfg-eth0
BOOTPROTO=static
IPADDR=$2
MTU=1500
NETMASK=$4
STARTMODE=auto
USERCONTROL=no
EOF
 cat << EOF > /etc/sysconfig/network/routes
default $3 --
EOF
 cat << EOF > /etc/resolv.conf
nameserver 8.8.8.8
EOF

elif [ $1 == "centos" ]
  then
 cat << EOF > /etc/sysconfig/network-scripts/ifcfg-eth0
DEVICE=eth0
BOOTPROTO=none
ONBOOT=yes
PREFIX=$4
IPADDR=$2
GATEWAY=$3
DNS1=8.8.8.8
EOF
elif [ $1 == "ubuntu" ]
  then
	# UBUNTU 2204
    cat << EOF > /etc/netplan/01-netcfg.yaml
network:
  version: 2
  ethernets:
    eth0:
      dhcp4: no
      addresses: [$2/$4]
      gateway4: $3
      nameservers:
        addresses: [8.8.8.8,8.8.4.4]
EOF
fi
	
# Be sure NOT to execute "netplan apply" here, so the changes take effect on
# reboot instead of immediately, which would disconnect the provisioner.