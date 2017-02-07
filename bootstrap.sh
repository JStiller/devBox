#!/usr/bin/env bash

#########################################################
### ARGUMENTS ###########################################
#########################################################

PROJECT_NAME=$1
PATH_PROJECT=$2
PATH_LOG=$3
PATH_ROOT=$4

#########################################################
### HELPER ##############################################
#########################################################

source /vagrant/helper.sh ${PATH_LOG}

#########################################################
### PROVISIONING ########################################
#########################################################

### DEBUG ###############################################
#( set -o posix ; set ) | less

### UPDATE ##############################################
info "Update"
execute "sudo apt-get -y update" "apt-get -y update"

### INSTALL BASICS ######################################
info "Install Basics"
install "curl build-essential nodejs npm apache2 libfontconfig php php-curl php-gd php-mcrypt php-mysql"

### GIT #################################################
info "GIT"
execute "git config --global user.email ${ENV_EMAIL}" "set email"
git config --global user.name "${ENV_AUTHOR}"

### ENABLE MOD REWRITE ##################################
info "Enable Mod Rewrite"
execute "sudo a2enmod rewrite" "a2enmod rewrite"

### WRITE VHOST #########################################
info "Write VHOST"
sudo sed -i "s|DocumentRoot .*|DocumentRoot ${PATH_ROOT}|" /etc/apache2/sites-available/000-default.conf
execute "sudo touch /etc/apache2/sites-available/${PROJECT_NAME}.conf" "touch ${PROJECT_NAME}.conf"
execute "sudo echo \"<VirtualHost *:80>

	ServerName ${PROJECT_NAME}.dev
	ServerAlias www.${PROJECT_NAME}.dev
	ServerAdmin ${ENV_EMAIL}

	DocumentRoot ${PATH_PROJECT}

	ErrorLog ${PATH_LOG}/error.log
	CustomLog ${PATH_LOG}/access.log combined
	
	RewriteEngine On
	
	<Directory ${PATH_PROJECT}>
		AllowOverride All
		Order Allow,Deny
		Allow from All
	</Directory>
	
</VirtualHost>\" > /etc/apache2/sites-available/${PROJECT_NAME}.conf" "write into ${PROJECT_NAME}.conf"

### ENABLE SITES ########################################
info "Enable Sites"
execute "sudo a2ensite ${PROJECT_NAME}.conf" "a2ensite ${PROJECT_NAME}.conf"

### INSTALL NPM DEPENDENCIES ############################
info "Install NPM dependencies"
execute "sudo ln -s /usr/bin/nodejs /usr/bin/node" "create symlink"
execute "sudo npm cache clean" "clean cache"
execute "sudo npm install -y -g grunt-cli" "install grunt-cli"
execute "sudo npm install -y -g grunt-contrib-jasmine" "install jasmine"
