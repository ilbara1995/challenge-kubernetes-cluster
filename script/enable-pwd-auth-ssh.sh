#!/bin/bash

# Modifica il file /etc/ssh/sshd_config per abilitare l'autenticazione con password#
sed -i 's/^#\?PasswordAuthentication .*/PasswordAuthentication yes/' /etc/ssh/sshd_config

# Modifica il file /etc/ssh/sshd_config per abilitare l'autenticazione con chiave pubblica
#sed -i 's/^#*PubkeyAuthentication.*$/PubkeyAuthentication yes/' /etc/ssh/sshd_config

# Riavvia il servizio ssh
systemctl restart sshd

#!/bin/bash

echo 'vagrant ALL=(ALL) NOPASSWD:ALL' | sudo tee /etc/sudoers.d/vagrant
sudo chmod 0440 /etc/sudoers.d/vagrant