#!/bin/bash

# Sostituisci 'password' con la tua password#
export SSHPASS='vagrant'

DIRECTORY="/home/vagrant/.ssh"

if [ ! -d "$DIRECTORY" ]; then
  vagrant mkdir -p $DIRECTORY
  echo "La directory $DIRECTORY è stata creata."
else
  echo "La directory $DIRECTORY esiste già."
fi

# Genera una nuova chiave SSH se non esiste già
if [ ! -f ~/.ssh/id_rsa ]; then
    ssh-keygen -t rsa -N "" -f /home/vagrant/.ssh/id_rsa
fi

# Copia la chiave pubblica alla macchina 2
sshpass -e ssh-copy-id -o StrictHostKeyChecking=no vagrant@172.17.177.21 >> file.txt

sshpass -e ssh-copy-id -o StrictHostKeyChecking=no vagrant@172.17.177.23 >> file.txt

# Abilita l'autenticazione tramite chiave pubblica sulla macchine e disabilita autenticazione tramite password

sshpass -e ssh -o StrictHostKeyChecking=no -tt vagrant@172.17.177.21 "sudo sed -i 's/^#\?PubkeyAuthentication .*/PubkeyAuthentication yes/' /etc/ssh/sshd_config && sudo service ssh restart"

sshpass -e ssh -o StrictHostKeyChecking=no -tt vagrant@172.17.177.21 "sudo sed -i 's/^#\?PasswordAuthentication .*/PasswordAuthentication no/' /etc/ssh/sshd_config && sudo service ssh restart"

sshpass -e ssh -o StrictHostKeyChecking=no -tt vagrant@172.17.177.23 "sudo sed -i 's/^#\?PubkeyAuthentication .*/PubkeyAuthentication yes/' /etc/ssh/sshd_config && sudo service ssh restart"

sshpass -e ssh -o StrictHostKeyChecking=no -tt vagrant@172.17.177.23 "sudo sed -i 's/^#\?PasswordAuthentication .*/PasswordAuthentication no/' /etc/ssh/sshd_config && sudo service ssh restart"

unset SSHPASS