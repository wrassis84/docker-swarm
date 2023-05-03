######## ENVIRONMENT ###########################################################

#!/usr/bin/env bash

######## ABOUT #################################################################

# Repository      : https://github.com/wrassis84/<REPO>
# Author          : William Ramos de Assis Rezende
# Maintainer      : William Ramos de Assis Rezende
#
# Deploy.sh       : Executes Ansible Playbooks to Deploy a Swarm Cluster.
# Requirements    : bash, ansible
# Usage           : ./DeploySwarm.sh

######## TESTING ENVIRONMENT ###################################################

######## TESTS/VALIDATIONS #####################################################

######## VARIABLES #############################################################

######## FUNCTIONS #############################################################

######## MAIN CODE - START #####################################################
echo "Configuring ansible environment..."
source ansible.env > /dev/null

echo "Playing docker-swarm role..."
cd $PWD
ansible-playbook main.yml -u sysadmin -b #> /dev/null
######## MAIN CODE - END #######################################################
# TODO:
# Test if ansible is installed;
# Checks that servers are running and reachable;