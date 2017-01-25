# -*- mode: ruby -*-
# vi: set ft=ruby :

PROJECT_SETTINGS = {}
PROJECT_SETTINGS["name"] = "progress"
PROJECT_SETTINGS["path"] = {}
PROJECT_SETTINGS["path"]["root"] = "/var/www"
PROJECT_SETTINGS["path"]["project"] = PROJECT_SETTINGS["path"]["root"] + "/" + PROJECT_SETTINGS["name"]
PROJECT_SETTINGS["path"]["log"] = "/vagrant/log"

ENVIRONMENT_SETTINGS = {}
ENVIRONMENT_SETTINGS["database"] = {}
ENVIRONMENT_SETTINGS["database"]["username"] = 'root'
ENVIRONMENT_SETTINGS["database"]["password"] = 'root'
ENVIRONMENT_SETTINGS["email"] = 'info@josestiller.de'

Vagrant.configure(2) do |config|
	config.vm.box = "ubuntu/xenial64"
	config.vm.box_check_update = false

	config.vm.network "private_network",
		ip: "192.168.100.100"

	config.vm.synced_folder "./source/" + PROJECT_SETTINGS["name"], PROJECT_SETTINGS["path"]["project"],
		id: "vagrant-root",
		create: true,
		owner: "ubuntu",
		group: "www-data",
		mount_options: ["dmode=775,fmode=775"]

	config.vm.provider "virtualbox" do |vb|
		vb.gui = false
		vb.name = PROJECT_SETTINGS["name"]
		vb.linked_clone = true
		vb.cpus = 2
		vb.memory = 2048
		vb.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate/v-root", "1"]
	end

	config.vm.provision :shell,
		name: "Bootstrap",
		path: "bootstrap.sh",
		args: [PROJECT_SETTINGS["name"], PROJECT_SETTINGS["path"]["project"], PROJECT_SETTINGS["path"]["log"], PROJECT_SETTINGS["path"]["root"]],
		env: ENVIRONMENT_SETTINGS,
		binary: true,
		privileged: true,
		keep_color: true
		
	config.vm.provision :shell,
		name: "Always",
		path: "always.sh",
		args: [PROJECT_SETTINGS["name"], PROJECT_SETTINGS["path"]["project"], PROJECT_SETTINGS["path"]["log"]],
		env: ENVIRONMENT_SETTINGS,
		binary: true,
		privileged: true,
		keep_color: true,
		run: "always"
end