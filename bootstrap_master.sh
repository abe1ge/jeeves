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
sudo apt-get -y install puppet puppetmaster

echo "Puppet installed"

#Getting master fqdn and ip
mfqdn=`facter fqdn`
mip=`facter ipaddress_eth1`

if [ -z "$mip" ];
then
#Forcing an ip to account for network weirdness
sudo ifdown eth1
sudo ifup eth1
#sudo ifconfig eth1 192.168.1.113

echo "Forced ip to account for the network being weird"

mip=`facter ipaddress_eth1`

fi

# Check if mip or mfqdn files exist and deleting them if they do (this is mainly for testing runs)
if [ -e /tmp/shared/mfqdn.file ];
then
	sudo rm /tmp/shared/mfqdn.file
fi

if [ -e /tmp/shared/mip.file ];
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
sudo touch /etc/puppet/manifests/site.pp

#Copying module directories to a default path
sudo cp -r /tmp/shared/bamboo /usr/share/puppet/modules
sudo cp -r /tmp/shared/git /usr/share/puppet/modules
sudo cp -r /tmp/shared/javainstall /usr/share/puppet/modules
sudo cp -r /tmp/shared/jenkins /usr/share/puppet/modules
sudo cp -r /tmp/shared/jira /usr/share/puppet/modules
sudo cp -r /tmp/shared/maven /usr/share/puppet/modules
sudo cp -r /tmp/shared/mysqlinstall /usr/share/puppet/modules
sudo cp -r /tmp/shared/nexus /usr/share/puppet/modules
sudo cp -r /tmp/shared/zabbix /usr/share/puppet/modules

echo "Modules Copied"

#Updating Site.pp so puppet provisions the correct modules for each agent
sudo echo "node 'default' {" >> /etc/puppet/manifests/site.pp
sudo echo "include javainstall" >> /etc/puppet/manifests/site.pp
sudo echo "include maven" >> /etc/puppet/manifests/site.pp
sudo echo "include nexus" >> /etc/puppet/manifests/site.pp
sudo echo "include git" >> /etc/puppet/manifests/site.pp
sudo echo "include bamboo" >> /etc/puppet/manifests/site.pp
sudo echo "include jira" >> /etc/puppet/manifests/site.pp
sudo echo "include mysqlinstall" >> /etc/puppet/manifests/site.pp
sudo echo "include jenkins" >> /etc/puppet/manifests/site.pp
sudo echo "include zabbix" >> /etc/puppet/manifests/site.pp
sudo echo "}" >> /etc/puppet/manifests/site.pp
# sudo echo "" >> /etc/puppet/manifests/site.pp
# sudo echo "node 'default' {" >> /etc/puppet/manifests/site.pp
# sudo echo "}" >> /etc/puppet/manifests/site.pp

echo "Site.pp updated"

#Returning the time taken for the script to run
duration=$SECONDS
echo "$(($duration / 60)) minute(s) and $(($duration % 60)) second(s) elapsed."