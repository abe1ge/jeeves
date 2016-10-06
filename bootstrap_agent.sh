#!/usr/bin/env bash

# Updating VM
sudo apt-get -y update

sudo apt-get -y install openssh-server openssh-client

sudo ufw disable

sudo apt-get -y install puppet puppetmaster

mfqdn="jeevesmastertest.qac.local"
mip="192.168.1.74"

fqdn=`facter fqdn`
ip=`facter ipaddress`

sed -i "1i$mip	$mfqdn	puppetmaster" /etc/hosts
sed -i "2i127.0.0.1	$fqdn	puppet" /etc/hosts
sed -i "3i$ip	$fqdn	puppet" /etc/hosts

sed -i "2iserver=$mfqdn" /etc/puppet/puppet.conf

#sudo puppet agent --test --server="$mfqdn"

#sudo service puppet stop
#sudo service puppet start

#sleep 3

#sudo puppet agent --enable

#sudo puppet agent --test --server="$mfqdn"
