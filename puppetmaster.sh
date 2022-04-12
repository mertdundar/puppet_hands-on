#!/bin/bash

#Login with Root user always
sudo echo "sudo su -" >> .bashrc

#Switch to root user
sudo -i

#Add Puppet Agent ip to hosts file
echo "10.45.0.101 puppetagent" >> /etc/hosts

#Puppet Rackage installation
rpm -Uvh https://yum.puppet.com/puppet7-release-el-8.noarch.rpm
yum update -y
yum install puppetserver -y

#Link puppetserver to bin
ln -s /opt/puppetlabs/bin/puppetserver /bin/puppetserver
ln -s /opt/puppetlabs/bin/puppet /bin/puppet

#RAM Not Enough
sed -i 's/Xms2g/Xms512m/g' /etc/sysconfig/puppetserver
sed -i 's/Xmx2g/Xmx512m/g' /etc/sysconfig/puppetserver

#Disable Firewall
systemctl stop firewalld
systemctl disable firewalld

systemctl start puppetserver
systemctl enable puppetserver

sleep 30

puppetserver ca sign --all
