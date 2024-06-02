Vagrant.configure("2") do |config|

    config.vm.box = "ubuntu/bionic64"
  
    config.vm.boot_timeout = 600

    #config.ssh.insert_key = false
  
    config.vm.provider "virtualbox" do |v|
      v.memory = 2048
      v.cpus = 2
    end
  
    config.vm.define "node1" do |node1|
      node1.vm.network "private_network", ip: "172.17.177.21"
      node1.vm.hostname = "node1"
      node1.vm.provision "shell", path: "script/enable-pwd-auth-ssh.sh"
    end

    config.vm.define "master" do |master|
      master.vm.network "private_network", ip: "172.17.177.23"
      master.vm.hostname = "master"
      master.vm.provision "shell", path: "script/enable-pwd-auth-ssh.sh"
      master.vm.provider "virtualbox" do |v|
        v.memory = 4096  # 2GB di RAM in più
        v.cpus = 3  # 1 CPU in più
      end
    end
  
    config.vm.define 'controller' do |controller|
      controller.vm.hostname = "controller"
      # Disabilita la cartella condivisa di default
      controller.vm.synced_folder ".", "/vagrant", disabled: true
      # Tentativo di sovrascrivere la configurazione di default
      controller.vm.synced_folder ".", "/vagrant", owner: "vagrant", group: "vagrant", mount_options: ["dmode=755,fmode=755"]
      controller.vm.network "private_network", ip: "172.17.177.11"
      controller.vm.provision "shell", path: "script/prepare-script.sh"
      controller.vm.provision "shell", inline: <<-SHELL
        su - vagrant -c 'bash /vagrant/script/enable-pubkey-auth.sh'
      SHELL
      controller.vm.provision :ansible_local do |ansible|
        ansible.playbook       = "ansible/main_playbook.yml"
        ansible.verbose        = true
        ansible.install        = true
        ansible.limit          = "all" # or only "nodes" group, etc.
        ansible.inventory_path = "ansible/inventory"
      end
    end
  
  end
#possibile utilizzo per evitare di avere password in chiaro nel file
  #Vagrant.configure("2") do |config|
    #config.vm.box = "base"
  
    #password = ask("Inserisci la password: ") { |q| q.echo = false }
  
    #config.vm.provision "shell", inline: <<-SHELL
    #echo #{password} | sudo -S su - vagrant -c 'bash /vagrant/enable-pubkey-auth.sh'
  #SHELL
  #end
  


  