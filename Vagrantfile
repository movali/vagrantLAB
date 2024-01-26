#
# Bitte gegebenenfalls anpassen:
#
NETWORK_LAB_NAME="VT-LAN-11"
NETWORK_PREFIX = "192.168.11"
NETWORK_GATEWAY = "1"
NETWORK_MASK = "24"

Vagrant.configure("2") do |config|

config.vm.define "ansible" do |ansible|
    ansible.vm.box = "generic/debian12"
    ansible.vm.hostname = "ansible"
	ansible.vm.provider "hyperv" do |p|
      p.memory = 1024
      p.cpus = 1
	  #p.mac = "00155D62F44A"
	  p.vmname = "ansible"
	end
    ansible.vm.network :private_network, bridge: 'Default Switch'
	ansible.trigger.before :reload do |trigger|
		trigger.info = "Setting Hyper-V switch to 'labLAN' to allow for static IP..."
		trigger.run = {privileged: "true", powershell_elevated_interactive: "true", path: "./scripts/set-hyperv-switch.ps1", args: ["-VmName ansible", "-SwitchName #{NETWORK_LAB_NAME}"]}
	end
	ansible.vm.provision "shell", path: "./scripts/configure-static-ip.sh", args: "'debian' '#{NETWORK_PREFIX}.50' '#{NETWORK_PREFIX}.#{NETWORK_GATEWAY}' '255.255.255.0'"
end

config.vm.define "debian" do |debian|
    debian.vm.box = "generic/debian12"
    debian.vm.hostname = "debian"
	debian.vm.provider "hyperv" do |p|
      p.memory = 1024
      p.cpus = 1
	  #p.mac = "00155D62F44A"
	  p.vmname = "debian"
	end
    debian.vm.network :private_network, bridge: 'Default Switch'
	debian.trigger.before :reload do |trigger|
		trigger.info = "Setting Hyper-V switch to 'labLAN' to allow for static IP..."
		trigger.run = {privileged: "true", powershell_elevated_interactive: "true", path: "./scripts/set-hyperv-switch.ps1", args: ["-VmName debian", "-SwitchName #{NETWORK_LAB_NAME}"]}
	end
	debian.vm.provision "shell", path: "./scripts/configure-static-ip.sh", args: "'debian' '#{NETWORK_PREFIX}.51' '#{NETWORK_PREFIX}.#{NETWORK_GATEWAY}' '255.255.255.0'"
end

config.vm.define "rocky" do |rocky|
    rocky.vm.box = "generic/rocky8"
    rocky.vm.hostname = "rocky"
	rocky.vm.provider "hyperv" do |p|
      p.memory = 1024
      p.cpus = 1
	  #p.mac = "00155D62F44B"
	  p.vmname = "rocky"
	end
    rocky.vm.network :private_network, bridge: 'Default Switch'
	rocky.trigger.before :reload do |trigger|
		trigger.info = "Setting Hyper-V switch to 'labLAN' to allow for static IP..."
		trigger.run = {privileged: "true", powershell_elevated_interactive: "true", path: "./scripts/set-hyperv-switch.ps1", args: ["-VmName rocky", "-SwitchName #{NETWORK_LAB_NAME}"]}
	end
	rocky.vm.provision "shell", path: "./scripts/configure-static-ip.sh", args: "'rocky' '#{NETWORK_PREFIX}.52' '#{NETWORK_PREFIX}.#{NETWORK_GATEWAY}' '24'"
end

config.vm.define "suse" do |suse|
    suse.vm.box = "generic/opensuse15"
    suse.vm.hostname = "suse"
	suse.vm.provider "hyperv" do |p|
      p.memory = 1024
      p.cpus = 1
	  #p.mac = "00155D62F44B"
	  p.vmname = "suse"
	end
    suse.vm.network :private_network, bridge: 'Default Switch'
	suse.trigger.before :reload do |trigger|
		trigger.info = "Setting Hyper-V switch to 'labLAN' to allow for static IP..."
		trigger.run = {privileged: "true", powershell_elevated_interactive: "true", path: "./scripts/set-hyperv-switch.ps1", args: ["-VmName suse", "-SwitchName #{NETWORK_LAB_NAME}"]}
	end
	suse.vm.provision "shell", path: "./scripts/configure-static-ip.sh", args: "'suse' '#{NETWORK_PREFIX}.53' '#{NETWORK_PREFIX}.#{NETWORK_GATEWAY}' '255.255.255.0'"
end

config.vm.define "ubuntu" do |ubuntu|
    ubuntu.vm.box = "generic/ubuntu2204"
    ubuntu.vm.hostname = "ubuntu"
	ubuntu.vm.provider "hyperv" do |p|
      p.memory = 1024
      p.cpus = 1
	  #p.mac = "00155D62F44B"
	  p.vmname = "ubuntu"
	end
    ubuntu.vm.network :private_network, bridge: 'Default Switch'
	ubuntu.trigger.before :reload do |trigger|
		trigger.info = "Setting Hyper-V switch to 'labLAN' to allow for static IP..."
		trigger.run = {privileged: "true", powershell_elevated_interactive: "true", path: "./scripts/set-hyperv-switch.ps1", args: ["-VmName ubuntu", "-SwitchName #{NETWORK_LAB_NAME}"]}
	end
	ubuntu.vm.provision "shell", path: "./scripts/configure-static-ip.sh", args: "'ubuntu' '#{NETWORK_PREFIX}.54' '#{NETWORK_PREFIX}.#{NETWORK_GATEWAY}' '24'"
end

config.vm.synced_folder ".", "/vagrant_data", disabled: true

config.vm.provider "hyperv"
config.vm.provider "hyperv" do |h|
  h.enable_virtualization_extensions = true
  h.linked_clone = true
end
  
  
config.vm.provision :reload
end
