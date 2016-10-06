#!/usr/bin/env bash

# Updating VM
sudo apt-get -y update

sudo apt-get -y install openssh-server openssh-client

sudo ufw disable

sudo apt-get -y install puppet puppetmaster

fqdn=`facter fqdn`
ip=`facter ipaddress_eth1`

sed -i "1i127.0.0.1	$fqdn	puppetmaster" /etc/hosts
sed -i "2i$ip	$fqdn	puppetmaster" /etc/hosts

sudo touch /etc/puppet/manifests/site.pp

