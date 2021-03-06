#!/bin/bash
#
# This setup script assumes Centos7.
#


#while getopts ":" opt do
#  case $opt in
#    *)
#      ;;
#  esac
#done
#
sudo yum -y install epel-release

# dependencies for gitFS
yum install python-pygit2 GitPython

sudo yum -y update

#if salt is not yet configured
if [ ! -f "/etc/salt/master" ]; then
  sudo yum -y install salt-master
fi
sudo mv /etc/salt/master /etc/salt/master.old
sudo ln -s /srv/master /etc/salt/master

# open the ports for saltmaster to be visible
sudo /bin/systemctl enable firewalld
sudo /bin/systemctl start firewalld
sudo firewall-cmd --permanent --zone=public --add-port=22/tcp
sudo firewall-cmd --permanent --zone=public --add-port=443/tcp
sudo firewall-cmd --permanent --zone=public --add-port=4505-4506/tcp

sudo firewall-cmd --reload

# start the service
sudo /bin/systemctl restart salt-master.service
