#!/usr/bin/env bash

# Shell script used in user-data to pull the repo, install & run ansible.
REPO_LOCATION="https://github.com/w3s7y/minecraft-server"

source /etc/os-release
mkdir /bootstrap

if [[ ${ID_LIKE} == "debian" ]]
then
    apt-get update
    apt-get install -y python3-pip python3-distutils-extra git
else
    yum update
    yum install -y python3-pip python3-distutils-extra git
fi

git clone ${REPO_LOCATION} /bootstrap/minecraft-server
pip3 install ansible

export mc_accept_eula=true

ansible-galaxy role install nolte.minecraft
ansible-playbook -v -c local /bootstrap/minecraft-server/ansible/minecraft-server-playbook.yml
