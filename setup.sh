#!/bin/bash

# This setup is for centos7

# check to see that virtualbox is installed
sudo yum install -y virtualbox

# Install ruby
sudo yum install -y ruby rubygems

# update the gems
sudo gem update --system

# Install Vagrant
sudo gem install -y vagrant

if [! -d "/local/bin/vagrant" ]; then
  echo "Vagrant is not found.  Install failed."
  exit 1;
fi

# Install the saltstack plugin first
vagrant plugin install vagrant-salt
vagrant plugin install vagrant-hostsupdater

# Install the provided Gem / plugin - this one supports the --local flag
#vagrant plugin install support/vagrant-salt-0.4.0.gem

vagrant plugin list
# Start the environment
# vagrant up

# Remember, salt master needs ports openned up in the firewall:
# firewall-cmd --permanent --zone=<zone> --add-port=4505-4506/tcp
# firewall-cmd --reload
