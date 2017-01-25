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

info "Restart Apache"
execute "systemctl restart apache2.service" "systemctl restart apache2.service"