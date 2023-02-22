#!/bin/bash
# Run me with superuser privileges
set -e

[[ -z "$1" ]] && { echo "Specify temp password for ansible user" ; exit 1; }

ANSPW=$1
echo "deb http://download.proxmox.com/debian/pve bullseye pve-no-subscription" >>  /etc/apt/sources.list
rm /etc/apt/sources.list.d/pve-enterprise.list
apt update && apt full-upgrade -y
apt install gnupg sudo -y
echo "deb http://ppa.launchpad.net/ansible/ansible/ubuntu trusty main" >> /etc/apt/sources.list
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 93C4A3FD7BB9C367
apt update
apt install ansible -y
useradd ansible
echo "ansible:$ANSPW" | chpasswd
mkdir -p /home/ansible
chown ansible /home/ansible
echo 'ansible	ALL=(ALL:ALL) ALL' >> /etc/sudoers