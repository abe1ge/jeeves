#!/usr/bin/env bash

# Updating VM
sudo apt-get -y update

echo "Box updated"  

#Install open SSH
sudo apt-get -y install openssh-server openssh-client

echo "Open ssh installed"

#Disable Firewall
sudo ufw disable

echo "Firewall disabled"

#Set time-zone
sudo timedatectl set-timezone Europe/London

echo "Time-Zone set to UK standard"

#Install Puppet
sudo cp /tmp/shared/puppet-enterprise-2015.2.0-ubuntu-14.04-amd64.tar.gz /opt
cd /opt
sudo tar -zxvf /opt/puppet-enterprise-2015.2.0-ubuntu-14.04-amd64.tar.gz
sudo cp /tmp/shared/answers.install /opt/puppet-enterprise-2015.2.0-ubuntu-14.04-amd64/answers
sudo wget https://apt.puppetlabs.com/puppetlabs-release-trusty.deb
sudo dpkg -i puppetlabs-release-trusty.deb
sudo apt-get update

sudo /opt/puppet-enterprise-2015.2.0-ubuntu-14.04-amd64/puppet-enterprise-installer -A /opt/puppet-enterprise-2015.2.0-ubuntu-14.04-amd64/answers/answers.install


echo "Puppet installed"

#Forcing an ip to account for network weirdness
sudo ifdown eth1
sudo ifup eth1
sudo ifconfig eth1 192.168.1.124

echo "Forced ip to account for the network being weird"

#Getting master fqdn and ip
mfqdn=`facter fqdn`
mip=`facter ipaddress_eth1`

# Check if mip or mfqdn files exist and deleting them if they do (this is mainly for testing runs)
if [ -e /tmp/shared/mfqdn.file ]
then
	sudo rm /tmp/shared/mfqdn.file
fi

if [ -e /tmp/shared/mip.file ]
then
	sudo rm /tmp/shared/mip.file
fi

#Saving the ip and fqdn of the master
echo 'mfqdn="'"$mfqdn"'"' >> /tmp/shared/mfqdn.file
echo 'mip="'"$mip"'"' >> /tmp/shared/mip.file

echo "The master ip is $mip and its' FQDN is $mfqdn"

#Updating the hosts file
sed -i "1i127.0.0.1	$mfqdn	puppetmaster" /etc/hosts
sed -i "2i$mip	$mfqdn	puppetmaster" /etc/hosts

echo "Hosts file updated"

#Creating Site.pp
sudo touch /etc/puppetlabs/code/environments/production/manifests/site.pp

sudo cp -r /tmp/shared/bamboo /etc/puppetlabs/code/environments/production/modules
sudo cp -r /tmp/shared/git /etc/puppetlabs/code/environments/production/modules
sudo cp -r /tmp/shared/javainstall /etc/puppetlabs/code/environments/production/modules
sudo cp -r /tmp/shared/jenkins /etc/puppetlabs/code/environments/production/modules
sudo cp -r /tmp/shared/jira /etc/puppetlabs/code/environments/production/modules
sudo cp -r /tmp/shared/maven /etc/puppetlabs/code/environments/production/modules
sudo cp -r /tmp/shared/mysqlinstall /etc/puppetlabs/code/environments/production/modules
sudo cp -r /tmp/shared/nexus /etc/puppetlabs/code/environments/production/modules
sudo cp -r /tmp/shared/jenkins_plugin /etc/puppetlabs/code/environments/production/modules
sudo cp -r /tmp/shared/zabbix /etc/puppetlabs/code/environments/production/modules

echo "Modules Copied"

sudo echo "node 'jeevesagent1.qac.local','jeevesagent2.qac.local','jeevesagent3.qac.local','jeevesagent4.qac.local' {" >> /etc/puppetlabs/code/environments/production/manifests/site.pp
sudo echo "include javainstall" >> /etc/puppetlabs/code/environments/production/manifests/site.pp
sudo echo "include maven" >> /etc/puppetlabs/code/environments/production/manifests/site.pp
sudo echo "include nexus" >> /etc/puppetlabs/code/environments/production/manifests/site.pp
sudo echo "include git" >> /etc/puppetlabs/code/environments/production/manifests/site.pp
sudo echo "include bamboo" >> /etc/puppetlabs/code/environments/production/manifests/site.pp
sudo echo "include jira" >> /etc/puppetlabs/code/environments/production/manifests/site.pp
sudo echo "include mysqlinstall" >> /etc/puppetlabs/code/environments/production/manifests/site.pp
sudo echo "include jenkins" >> /etc/puppetlabs/code/environments/production/manifests/site.pp
sudo echo "include zabbix" >> /etc/puppetlabs/code/environments/production/manifests/site.pp
#sudo echo "include jenkins_plugin" >> /etc/puppetlabs/code/environments/production/manifests/site.pp
sudo echo "}" >> /etc/puppetlabs/code/environments/production/manifests/site.pp
sudo echo "" >> /etc/puppetlabs/code/environments/production/manifests/site.pp


echo "Site.pp updated"

#Returning the time taken for the script to run
duration=$SECONDS
echo "$(($duration / 60)) minute(s) and $(($duration % 60)) second(s) elapsed."