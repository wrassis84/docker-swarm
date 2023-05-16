######## ENVIRONMENT ###########################################################

#!/usr/bin/env bash

######## ABOUT #################################################################

# Repository       : https://github.com/wrassis84/<REPO>
# Author           : William Ramos de Assis Rezende
# Maintainer       : William Ramos de Assis Rezende
#
# DeployServers.sh : Executes Ansible Playbooks to Config Servers.
# Requirements     : bash, terraform, ansible
# Usage            : ./Deploy.sh

######## TESTING ENVIRONMENT ###################################################
# Run "bash --version"
# bash version 5.1.16
#
######## TESTS/VALIDATIONS #####################################################
# Is terraform installed?
[ ! -x "$(which terraform)" ] && echo "Terraform isn't installed! Install it!"
# [ ! -x "$(which terraform)" ] && sudo apt install -y lynx
# Is ansible installed?
[ ! -x "$(which ansible)" ]   && echo "Ansible isn't installed! Install it!"
######## VARIABLES #############################################################

######## FUNCTIONS #############################################################
CleanSSH () {
  for i in $(seq 0 2); do
    ssh-keygen -f "$HOME/.ssh/known_hosts"         \
               -R "192.168.0.23$i" > /dev/null 2>&1;
  done           
}
######## MAIN CODE - START #####################################################
echo "Configuring ansible environment..."
cd $PWD/ansible
source ansible.env > /dev/null

echo "Configuring ssh hosts..."
CleanSSH

echo "Playing setup_ubuntu.yml..."
ansible-playbook setup_ubuntu.yml -u sysadmin -b #> /dev/null

echo "Playing setup_docker.yml"
ansible-playbook setup_docker.yml -u sysadmin -b #> /dev/null
cd ../
######## MAIN CODE - END #######################################################
# TODO:
# Test if ansible is installed;
# Checks that servers are running and reachable;