#!/bin/bash

agentCount=$1
domain=$2

#Login with Root user always
sudo echo "sudo su -" >> .bashrc

#Switch to root user
sudo -i

echo "DOMAIN=${domain}" >> /etc/sysconfig/network-scripts/ifcfg-eth0
systemctl restart NetworkManager

#Add Puppet Agent ip to hosts file
for i in $(seq 1 1 $agentCount)
  do
    echo "10.45.0.10${i} puppetagent${i}" >> /etc/hosts
  done

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

#add autosign conf
for i in $(seq 1 1 $agentCount)
  do
    echo "*.puppetagent${i}.${domain}" >> /etc/puppetlabs/puppet/autosign.conf
  done

systemctl start puppetserver
systemctl enable puppetserver

puppet module install puppet-chrony

echo "class { 'chrony':" >> /etc/puppetlabs/code/environments/production/manifests/site.pp
echo " servers => ['2.tr.pool.ntp.org']," >> /etc/puppetlabs/code/environments/production/manifests/site.pp
echo "}" >> /etc/puppetlabs/code/environments/production/manifests/site.pp
