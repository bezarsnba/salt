# -*- mode: ruby -*-
# vi: set ft=ruby :
## Install: vagrant plugin install vagrant-vbguest
Vagrant.configure(2) do |config|
  ## Master
  config.vm.define "salt_master" do | salt_master |
    salt_master.vm.box = "centos/7" # 18.04 LTS
    salt_master.vm.hostname = "salt-master"
    #salt_master.vm.box_version = "1902.01"
    salt_master.vm.synced_folder ".", "/vagrant", type: "virtualbox"

    salt_master.vm.network "private_network", ip: "192.168.60.3", auto_config: true
    # Increase memory for Virtualbox
    #salt_master.vm.provision "ansible_local" do |ansible|
    #    ansible.verbose = "v"
    #    ansible.playbook = "setup/playbook-install.yaml"
    #end
    salt_master.vm.provider "virtualbox" do |vb|
          vb.memory = "2048"
  end
  end
### node1
config.vm.define "salt_slave" do | salt_slave |
  salt_slave.vm.box = "centos/7" # 18.04 LTS
  salt_slave.vm.hostname = "salt-slave"
  salt_slave.vm.synced_folder ".", "/vagrant", type: "virtualbox"
  salt_slave.vm.network "forwarded_port", guest: 8080, host: 80, auto_correct: true

  salt_slave.vm.network "private_network", ip: "192.168.60.4", auto_config: true

  #salt_slave.vm.provision "ansible_local" do |ansible|
  #    ansible.verbose = "v"
  #    ansible.playbook = "setup/playbook-install.yaml"
  #end
  # Increase memory for Virtualbox
  salt_slave.vm.provider "virtualbox" do |vb|
      vb.memory = "1024"
  end
  end
  
  ### node1
config.vm.define "zbx_proxy" do | zbx_proxy |
  zbx_proxy.vm.box = "centos/7" # 18.04 LTS
  zbx_proxy.vm.hostname = "zbx-proxy"
  zbx_proxy.vm.synced_folder ".", "/vagrant", type: "virtualbox"
  #salt_slave.vm.box_version = "2020.01"
  zbx_proxy.vm.synced_folder ".", "/vagrant" 

  zbx_proxy.vm.network "forwarded_port", guest: 8080, host: 80, auto_correct: true
  #salt_slave.vm.network "public_network",  bridge: "wlp1s0"
  zbx_proxy.vm.network "private_network", ip: "192.168.60.5", auto_config: true

  #salt_slave.vm.provision "ansible_local" do |ansible|
  #    ansible.verbose = "v"
  #    ansible.playbook = "setup/playbook-install.yaml"
  #end
  # Increase memory for Virtualbox
  zbx_proxy.vm.provider "virtualbox" do |vb|
      vb.memory = "1024"
  end
end
end 
