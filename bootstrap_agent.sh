#!/usr/bin/env bash

# Updating VM
sudo apt-get -y update

echo "Box updated" 

#Install openssh and sshPass
sudo apt-get -y install openssh-server openssh-client

sudo apt-get install sshpass

echo "Open ssh installed"

#Installing dependencies for the MySQL module
sudo apt-get install -y libaio1
sudo apt-get install -y libmecab2

echo "MySQL Dependencies installed"

sudo ufw disable

echo "Firewall disabled"

#Change time-zone

sudo timedatectl set-timezone Europe/London

echo "Time-Zone set to UK standard"

#Install Puppet
sudo apt-get install -y puppet

echo "Puppet installed"

#mfqdn="jeevesmaster.qac.local"
#mip="192.168.1.80"


#Getting the ip and fqdn from of the master from the file the master 
#bootstrap saved and saving them as $mip and $mfqdn respectively
. /tmp/shared/mfqdn.file
. /tmp/shared/mip.file

echo "The master ip is $mip and its' FQDN is $mfqdn"

#Updating hosts file
fqdn=`facter fqdn`
ip=`facter ipaddress`

sed -i "1i$mip	$mfqdn	puppetmaster" /etc/hosts
sed -i "2i127.0.0.1	$fqdn	puppet" /etc/hosts
sed -i "3i$ip	$fqdn	puppet" /etc/hosts

sed -i "2iserver=$mfqdn" /etc/puppet/puppet.conf

echo "Hosts file updated"

#Retuning time taken to this point
duration1=$SECONDS
echo "$(($duration1 / 60)) minute(s) and $(($duration1 % 60)) second(s) elapsed."

sudo puppet agent --test --server="$mfqdn"

#SSH into master to approve puppet certificate
sshpass -p "vagrant" ssh -o StrictHostKeyChecking=no vagrant@"$mip" << EOF
sudo puppet cert list
sudo puppet cert sign --all
exit 0
EOF

echo " Puppet certificate signed"

#Restarting puppet service
sudo service puppet stop
sudo service puppet start

echo "Puppet service restarted"

#Pause to allow puppet service to restart fully
sleep 3

#Enable puppet agent
sudo puppet agent --enable

echo "Puppet agent enabled"

#Contacting puppet master and provisioning the modules
sudo puppet agent --test --server="$mfqdn"

echo "Puppet agent has linked to master server and applied the puppet modules"

#Returning the total time to provision the box
duration2=$SECONDS
echo "$(($duration2 / 60)) minute(s) and $(($duration2 % 60)) seconds elapsed."