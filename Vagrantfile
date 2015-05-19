# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

  Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
    config.vm.define :docker do |config|
      # All Vagrant configuration is done here. The most common configuration
      # options are documented and commented below. For a complete reference,
      # please see the online documentation at vagrantup.com.

      # Every Vagrant virtual environment requires a box to build off of.
      config.vm.box = "puppetlabs/ubuntu-14.04-64-nocm"
      config.vm.provision :shell, :path => "Startup.sh"
      config.vm.hostname = "docker.grahamgilbert.com"
      config.vm.network "public_network"
      #config.vm.network "private_network", ip: "192.168.33.10"

      # If you are using a private network rather than your normal LAN, use the below instead:
      # config.vm.network "private_network", type: "dhcp"

      config.vm.synced_folder '.', '/vagrant', disabled: true
      config.vm.synced_folder ".", "/usr/local/docker", {:mount_options => ['dmode=777','fmode=777']}
  end

# If you have an OS X Vagrant box and want to use it, uncomment the below
  # config.vm.define :client do |client_config|
  #   config.ssh.insert_key = false
  #   client_config.vm.box = "darwin-10103"
  #   # Uncomment based on your networking requirements
  #   # client_config.vm.network "public_network"
  #   client_config.vm.network "private_network", ip: "192.168.33.11"
  #   client_config.vm.hostname = "murphy"
  #   client_config.vm.provider "vmware_fusion" do |v|
  #     v.gui = true
  #     v.vmx["memsize"] = "4096"
  #     v.vmx["numvcpus"] = "2"
  #     v.vmx["SMBIOS.use12CharSerialNumber"] = "TRUE"
  #   end
  # end


end
