#!/usr/bin/env bash

#########################################################
### ARGUMENTS ###########################################
#########################################################

PATH_LOG=$1

#########################################################
### COLORS ##############################################
#########################################################

declare -A COLOR
COLOR[white]='\033[1;37m'
COLOR[blue]='\033[0;34m'
COLOR[green]='\033[0;32m'
COLOR[orange]='\033[0;33m'
COLOR[red]='\033[0;31m'
COLOR[colorless]='\033[0m'

#########################################################
### FUNCTIONS ###########################################
#########################################################

execute() {
	local _COMMAND=$1
	local _INFOTEXT=$2

	${_COMMAND} >> ${PATH_LOG}/provisioning.log 2>&1 && echo -e "${COLOR[white]}${_INFOTEXT} ${COLOR[green]}\u2714${COLOR[colorless]}" || { echo -e "${COLOR[white]}${_INFOTEXT} ${COLOR[red]}\u2718${COLOR[colorless]}"; exit 1; }
}

install() {
	local _PACKAGE_LIST=$1

	for _PACKAGE in ${_PACKAGE_LIST}
		do
			execute "apt-get install --yes ${_PACKAGE}" "${_PACKAGE}"
	done
}

info() {
	local _INFOTEXT=$1
	local _TEXT=""

	for ((N=0;N<58-${#_INFOTEXT};N++))
		do
			_TEXT="${_TEXT}#"
	done
	echo -e "${COLOR[blue]}###${COLOR[white]} ${_INFOTEXT} ${COLOR[blue]}${_TEXT}${COLOR[colorless]}"
}