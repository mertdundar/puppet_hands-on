#!/bin/bash

#Login with Root user always
sudo echo "sudo su -" >> .bashrc

#Switch to root user
sudo -i

#Add Puppet ip to hosts file
echo "10.45.0.100 puppet" >> /etc/hosts

#Puppet Rackage installation
rpm -Uvh https://yum.puppet.com/puppet7-release-el-8.noarch.rpm
yum update -y
yum install puppet-agent -y

#Disable Firewall
systemctl stop firewalld
systemctl disable firewalld

systemctl start puppet
systemctl enable puppet

#Link puppet to bin
ln -s /opt/puppetlabs/bin/puppet /bin/puppet
#puppet resource service puppet ensure=running enable=true #could be used instead of systemctl start puppet && systemctl enable puppet

#Add Puppet Server
puppet config set server puppet --section main

#Send CSR to Puppet Server and wait for Signed Certificate
puppet ssl bootstrap &

#Test Puppet Agent - Server Communication
puppet agent -t &
