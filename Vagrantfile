Vagrant.configure("2") do |config|

  config.vm.box = "generic/centos8"
  config.vm.synced_folder ".", "/vagrant_data" #to sync data from os to virtual box

  config.vm.define "puppetmaster" do |puppetmaster|
    puppetmaster.vm.hostname = "puppet"
    puppetmaster.vm.network "private_network", ip: "10.45.0.100"
    puppetmaster.vm.provider "virtualbox" do |vb|
      vb.memory = "1024"
    end
    puppetmaster.vm.provision "puppetmaster_installation", type: "shell", path: "./puppetmaster.sh"
  end
  
  config.vm.define "puppetagent" do |puppetagent|
    puppetagent.vm.hostname = "puppetagent"
    puppetagent.vm.network "private_network", ip: "10.45.0.101"
    puppetagent.vm.provider "virtualbox" do |vb|
      vb.memory = "1024"
    end
    puppetagent.vm.provision "puppetmaster_installation", type: "shell", path: "./puppetagent.sh"
  end


end
