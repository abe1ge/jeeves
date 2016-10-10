#echo '1'
#sudo cp /tmp/shared/mysql-server_5.7.15-1ubuntu14.04_amd64.deb-bundle.tar /opt/mysql-server_5.7.15-1ubuntu14.04_amd64.deb-bundle.tar
#echo '2'
#sudo tar -xvf mysql-server_5.7.15-1ubuntu14.04_amd64.deb-bundle.tar
#echo '3'
sudo DEBIAN_FRONTEND=noninteractive dpkg-preconfigure mysql-community-server_5.7.15-1ubuntu14.04_amd64.deb
#echo '4'
#sudo dpkg -i mysql-{common,community-client,client}_5.7.15-1ubuntu14.04_amd64.deb
#echo '5'
#sudo apt-get -f -y install
#echo '6'
#sudo dpkg -i mysql-{community-server,server}_5.7.15-1ubuntu14.04_amd64.deb
#echo '7'
#sudo apt-get -f -y install
#echo '8'
#sudo dpkg -i mysql-{community-server,server}_5.7.15-1ubuntu14.04_amd64.deb
