#!/bin/bash
yum update -y

hostnamectl set-hostname ${hostname}
echo "127.0.1.1 ${hostname}" >> /etc/hosts

useradd -m -s /bin/bash ansible
echo "ansible ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/ansible

yum install -y python3
ln -sf /usr/bin/python3 /usr/bin/python

echo "Bootstrap done at $(date)" >> /var/log/user-data.log
