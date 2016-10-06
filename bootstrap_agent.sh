#!/usr/bin/env bash

# Updating VM
sudo apt-get -y update

sudo apt-get -y install openssh-server openssh-client

sudo apt-get install sshpass

sudo apt-get install libaio1

sudo ufw disable

sudo apt-get install -y puppet

mfqdn="jeevesmastertest.qac.local"
mip="192.168.1.74"

fqdn=`facter fqdn`
ip=`facter ipaddress`

sed -i "1i$mip	$mfqdn	puppetmaster" /etc/hosts
sed -i "2i127.0.0.1	$fqdn	puppet" /etc/hosts
sed -i "3i$ip	$fqdn	puppet" /etc/hosts

sed -i "2iserver=$mfqdn" /etc/puppet/puppet.conf

sudo puppet agent --test --server="$mfqdn"

sshpass -p "vagrant" ssh -o StrictHostKeyChecking=no vagrant@192.168.1.74 << EOF
sudo puppet cert list
sudo puppet cert sign --all
exit 0
EOF



sudo service puppet stop
sudo service puppet start

sleep 3

sudo puppet agent --enable

sudo puppet agent --test --server="$mfqdn"
