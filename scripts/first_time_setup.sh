#!/bin/bash

# This script needs to run when you first create a new VM in Proxmox, after transffering the id_rsa.pub file to Tomer's home directory using ssh-copy-id.
# The script will create a user for Ansible, configure it and make it usable by the host Ansible machine.


if [ "$USER" != root ] ; then
  echo "Please run this script as the root user or with sudo priviledge." 
  exit 1
fi


if ! id "ansible"; then 
  useradd -m -s /bin/bash ansible
fi

PASS=$(openssl rand -base64 12)

echo "ansible:$PASS" | chpasswd 
echo 'ansible ALL=(ALL) NOPASSWD: ALL' | sudo EDITOR='tee -a' visudo


mkdir -p /home/ansible/.ssh
chmod 700 /home/ansible/.ssh
chown ansible:ansible /home/ansible/.ssh

cp /home/tomer/.ssh/authorized_keys /home/ansible/.ssh/authorized_keys
chmod 600 /home/ansible/.ssh/authorized_keys
chown ansible:ansible /home/ansible/.ssh/authorized_keys

systemctl enable --now ssh 
