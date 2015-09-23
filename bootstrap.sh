#!/bin/bash
SALT_MASTER_IP="127.0.0.1"

while getopts ":m:" opt do
  case $opt in
    m)
      SALT_MASTER_IP="$opt"
      echo "setting salt master in /etc/hosts to $SALT_MASTER_IP"
      ;;
    *)
      ;;
  esac
done
#
sudo yum -y install epel-release

sudo yum -y update

#if salt is not yet configured
if [ ! -f "/etc/salt/minion" ]; then
  sudo yum -y install salt-minion
else
  sudo mv /etc/salt/minion /etc/salt/minion.old
fi
sudo ln -s /srv/minion /etc/salt/minion


# alter /etc/hosts
cat /etc/hosts | grep salt
if [ $? -eq 1 ]; then
  echo "$SALT_MASTER_IP salt" >> /etc/hosts
fi


# start the service
sudo /bin/systemctl start  salt-minion.service


# for synched folders to work, VB extensions must be installed for centos7


#sudo salt-call --versions-report
