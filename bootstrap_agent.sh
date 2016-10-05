#!/usr/bin/env bash

# Updating VM
sudo apt-get -y update

sudo apt-get -y install openssh-server openssh-client

sudo ufw disable

sudo apt-get -y install puppet puppetmaster



