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
#
# bash version 5.1.16
#
######## TESTS/VALIDATIONS #####################################################
#
# Is Terraform installed?
[ ! -x "$(which terraform)" ] && echo "Terraform isn't installed! Install it!"
# [ ! -x "$(which terraform)" ] && sudo apt install -y lynx
# Is Ansible installed?
[ ! -x "$(which ansible)" ]   && echo "Ansible isn't installed! Install it!"
#
######## VARIABLES #############################################################
#
TF_WORKDIR=$PWD/terraform
TF_OUTPUT="$(cd $TF_WORKDIR; terraform output)"
ANSIBLE_WORKDIR=$PWD/ansible
# Help message:
HELP_MSG="
  Help Menu for $(basename $0) Program:
  [OPTIONS]:
   -h - Show this help.
   -d - Destroy Infrastructure.
   -D - Deploy Infrastructure.
   -c - Clean SSH hosts.
   -o - Show Terraform output.
   -a - Configure Ansible environment.
   -A - Deploy Servers/Setup Servers/Deploy Swarm Cluster.
   USAGE: ./Deploy.sh -[OPTIONS]
"
# Colors for messages. Put ${GREEN} to use on code.
GREEN="\033[32;1m" 
YELLOW="\033[33;1m"
RED="\033[31;1m"
ESC="\033[m"

DESTROY=0          # Destroy Infrastructure
DEPLOY=0           # Deploy Infrastructure
CLEANSSH=0         # Clean SSH hosts
SHOWTFOUTPUT=0     # Show Terraform output
CONFANSIBLEENV=0 # Configure Ansible environment
DEPLOYALL=0        # Deploy Servers/Setup Servers/Deploy Swarm Cluster
#
######## FUNCTIONS #############################################################
#
CleanSSH () {
  for i in $(seq 0 2); do
    ssh-keygen -f "$HOME/.ssh/known_hosts"         \
               -R "192.168.0.23$i" > /dev/null 2>&1;
  done           
}

ShowTFOutput () {
  cd   "$TF_WORKDIR"
  echo -e "${YELLOW}$TF_OUTPUT${ESC}"
}

ConfigAnsibleEnv () {
  cd     "$ANSIBLE_WORKDIR"
  source ansible.env > /dev/null
  echo -e "${YELLOW}INFO: Ansible environment setup successfuly!${ESC}"
}

SetupUbuntu () {
  ansible-playbook setup_ubuntu.yml -u sysadmin -b #> /dev/null
}

SetupDocker () {
  ansible-playbook setup_docker.yml -u sysadmin -b #> /dev/null
}
#
######## MAIN CODE - START #####################################################
#

while true
do
  case "$1" in
       "") echo "$HELP_MSG" && exit 0 ;;
       -h) echo "$HELP_MSG" && exit 0 ;;       
       -d) DESTROY=1                  ;;
       -D) DEPLOY=1                   ;;
       -c) CLEANSSH=1                 ;;
       -o) SHOWTFOUTPUT=1             ;;
       -a) CONFIGANSIBLEENV=1         ;;
       -A) DEPLOYALL=1                ;;                        
        *) echo -n "Invalid Option!\n "   && echo "${YELLOW}$HELP_MSG${ESC}" \
        && echo -n "[ENTER] to continue:" && read REPLY                      \
        && clear && exit 0            ;;
  esac
  # shift
done

echo -e "${YELLOW}INFO: Checking Terraform output...${ESC}"
ShowTFOutput
# exit 0

echo -e "${YELLOW}INFO: Configuring ansible environment...${ESC}"
# cd     "$ANSIBLE_WORKDIR"
# source ansible.env > /dev/null
# echo   "INFO: Ansible environment setup successfuly!"

echo -e "${YELLOW}INFO: Configuring ssh hosts...${ESC}"
CleanSSH
echo -e "${YELLOW}INFO: SSH hosts setup successfuly!${ESC}"
# exit 0

echo -e "${YELLOW}INFO: Running playbook setup_ubuntu.yml...${ESC}"
# ansible-playbook setup_ubuntu.yml -u sysadmin -b #> /dev/null
SetupUbuntu

echo -e "${YELLOW}INFO: Running playbook setup_docker.yml...${ESC}"
# ansible-playbook setup_docker.yml -u sysadmin -b #> /dev/null
# cd ../
SetupDocker
echo $PWD
#
######## MAIN CODE - END #######################################################
# TODO:
# Test if ansible is installed [OK];
# Improve terraform output formatting;
# Checks that servers are running and reachable;