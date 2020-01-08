#!/usr/bin/env bash

# Shell script used in user-data to pull the repo, install & run ansible.

REPO_LOCATION="https://github.com/w3s7y/minecraft-server"

source /etc/os-release
mkdir /bootstrap

if [[ ${ID_LIKE} == "debian" ]]
then
    apt-get update
    apt-get install -y python3 python3-pip python-virtualenv git
else
    yum update
    yum install -y python3 python3-pip python-virtualenv git
fi

git clone ${REPO_LOCATION} /bootstrap/minecraft-server
virtualenv --python /usr/bin/python3 /bootstrap/minecraft-server/venv
source /bootstrap/minecraft-server/venv/bin/activate
pip install ansible

mkdir -p /bootstrap/minecraft-server/ansible/roles

ansible-galaxy role install nolte.minecraft -p /bootstrap/minecraft-server/ansible/roles
ansible-playbook -v -c local /bootstrap/minecraft-server/ansible/minecraft-server-playbook.yml
