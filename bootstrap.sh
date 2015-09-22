#!/bin/bash

#
sudo yum -y install epel-release

sudo yum -y update

#if salt is not yet configured
if [ ! -f "/etc/salt/minion.old" ]; then
  sudo yum -y install salt-minion
  sudo mv /etc/salt/minion /etc/salt/minion.old
  sudo ln -s /srv/minion /etc/salt/minion
fi

# alter /etc/hosts
cat /etc/hosts | grep salt
if [ $? -eq 1 ]; then
  echo "10.95.253.120 salt" >> /etc/hosts
fi


# start the service
sudo /bin/systemctl start  salt-minion.service


# for synched folders to work, VB extensions must be installed for centos7


#sudo salt-call --versions-report
