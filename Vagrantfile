# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.box = "bento/ubuntu-18.04"

  config.vm.network "forwarded_port", guest: 8000, host: 8000
  config.vm.network "forwarded_port", guest: 5432, host: 5432, host_ip: "127.0.0.1"


  config.vm.synced_folder ".", "home/vagrant/my_folder"

  config.vm.provider "virtualbox" do |vb|
    # Display the VirtualBox GUI when booting the machine
    # vb.gui = true
  
    # Customize the amount of memory on the VM:
    vb.memory = "1024"
  end

  config.vm.provision "shell", path: "bootstrap.sh"
end
