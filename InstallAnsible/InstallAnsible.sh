#! /bin/bash

echo "Updating apt cache"
apt-get update
echo "Installing Git and pip"
apt-get install -y vim git sshpass python-pip
echo "Installing Ansible dependencies"
pip install paramiko PyYAML Jinja2 httplib2
cd /opt
echo "Cloning Ansible"
git clone git://github.com/ansible/ansible.git --recursive ansible
cd ansible
git checkout stable-1.9
echo Updating profile
echo source /opt/ansible/hacking/env-setup >> ~/.profile
echo export ANSIBLE_INVENTORY=~/ansible_hosts >> ~/.profile
echo export ANSIBLE_HOST_KEY_CHECKING=False >> ~/.profile
