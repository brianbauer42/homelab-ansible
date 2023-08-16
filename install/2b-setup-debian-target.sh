#!/bin/bash
# Run me with superuser privileges
set -e

[[ -z "$1" ]] && { echo "Specify temp password for ansible user" ; exit 1; }

ANSPW=$1
apt update && apt full-upgrade -y
apt install gnupg sudo -y
echo "deb http://ppa.launchpad.net/ansible/ansible/ubuntu jammy main" >> /etc/apt/sources.list
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 93C4A3FD7BB9C367
apt update
apt install ansible -y
useradd ansible
echo "ansible:$ANSPW" | chpasswd
mkdir /home/ansible
chown ansible /home/ansible
echo 'ansible	ALL=(ALL:ALL) ALL' >> /etc/sudoers