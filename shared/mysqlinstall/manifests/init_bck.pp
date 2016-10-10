class mysqlinstall {

require javainstall
require maven

Exec {
	path => ["/usr/bin", "/bin", "/usr/sbin","/sbin"],
}
#
#file { '/opt/mysql-server_5.7.15-1ubuntu14.04_amd64.deb-bundle.tar': 
#ensure => 'present',
#source => '/tmp/shared/mysql-server_5.7.15-1ubuntu14.04_amd64.deb-bundle.tar',
#}
#
#exec { 'Extract sql':
#cwd => '/opt',
#command => 'sudo tar -xvf /opt/mysql-server_5.7.15-1ubuntu14.04_amd64.deb-bundle.tar',
#logoutput => 'true',
#require => File['/opt/mysql-server_5.7.15-1ubuntu14.04_amd64.deb-bundle.tar'],
#}

exec { 'sqlprecon':
command => 'sudo bash /tmp/shared/mysqlinstall/files/sqlbash.sh',
cwd => '/opt',
#logoutput => 'true',
provider => shell,
}

#exec { 'sqlclients':
#command => 'sudo dpkg -i mysql-{common,community-client,client}_5.7.15-1ubuntu14.04_amd64.deb || :',
#cwd => '/opt',
#logoutput => 'true',
#require => Exec['sqlprecon'],
#}
#
#exec { 'sqlupdate':
#command => 'sudo apt-get -fy install ||:',
#cwd => '/opt',
#logoutput => 'true',
#require => Exec['sqlclients'],
#}
#
#exec {'sqlclients2':
#command => 'sudo dpkg -i mysql-{common,community-client,client}_5.7.15-1ubuntu14.04_amd64.deb || :',
#cwd => '/opt',
#logoutput => 'true',
#require => Exec['sqlupdate'],
#}

#exec { 'sqlservers':
#command => 'sudo dpkg -i mysql-{community-server,server}_5.7.15-1ubuntu14.04_amd64.deb || :',
#cwd => '/opt',
#logoutput => 'true',
#require => Exec['sqlclients2'],
#}
#exec { 'sqlupdate2':
#command => 'sudo apt-get -fy install ||:',
#cwd => '/opt',
#logoutput => 'true',
#require => Exec['sqlservers'],
#}

#exec { 'sqlservers2':
#command => 'sudo dpkg -i mysql-{community-server,server}_5.7.15-1ubuntu14.04_amd64.deb ||:',
#cwd => '/opt',
#logoutput => 'true',
#require => Exec['sqlupdate2'],
#}

#exec { 'sqlupdate3':
#command => 'sudo apt-get -fy install ||:',
#cwd => '/opt',
#logoutput => 'true',
#require => Exec['sqlservers2'],
#}

#exec { 'sqlservers3':
#command => 'sudo dpkg -i mysql-{community-server,server}_5.7.15-1ubuntu14.04_amd64.deb ||:',
#cwd => '/opt',
#logoutput => 'true',
#require => Exec['sqlupdate3'],
#}
}
