#!/bin/bash

apt-get update

apt-get install -y sshpass

#imposto il file di default per configurazione ansible#
echo 'export ANSIBLE_CONFIG=/vagrant/ansible/ansible.cfg' >> /home/vagrant/.bashrc

#popolo file /etc/hosts

declare -A VM_MAP=( ["172.17.177.21"]="node1" ["172.17.177.23"]="master" )

HOSTS_FILE="/etc/hosts"

for ip in ${!VM_MAP[@]}; do
  echo "$ip ${VM_MAP[$ip]}" >> $HOSTS_FILE
done

#popolo file known hosts con pubkey macchine guest

KNOWN_HOSTS_FILE="/home/vagrant/.ssh/known_hosts"

for ip in ${!VM_MAP[@]}; do
  # Usa ssh-keyscan per ottenere la chiave pubblica del server
  ssh-keyscan $ip >> $KNOWN_HOSTS_FILE
done
