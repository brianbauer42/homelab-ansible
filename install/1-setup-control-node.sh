#!/bin/bash
# Run me with superuser privileges

apt update && apt full-upgrade -y
apt install gnupg sudo -y
echo "deb http://ppa.launchpad.net/ansible/ansible/ubuntu trusty main" | tee -a /etc/apt/sources.list
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 93C4A3FD7BB9C367
apt update
apt install -y ansible
useradd ansible
mkdir /home/ansible
chown ansible /home/ansible
su - ansible
ssh-keygen -t ed25519 -f ~/.ssh/ansible_id -C "ansible@bauer.mt" -q -N ""
ansible-galaxy install linux-system-roles.cockpit gantsign.oh-my-zsh