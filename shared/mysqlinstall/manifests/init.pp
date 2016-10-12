class mysqlinstall {

Exec {
	path => ["/usr/bin", "/bin", "/usr/sbin","/sbin"],
}

$frontend="DEBIAN_FRONTEND='noninteractive'"

file { '/opt/mysql-server_5.7.15-1ubuntu14.04_amd64.deb-bundle.tar': 
ensure => 'present',
source => '/tmp/shared/mysql-server_5.7.15-1ubuntu14.04_amd64.deb-bundle.tar',
notify => Exec['Extract sql'],
}

exec { 'Extract sql':
cwd => '/opt',
command => 'sudo tar -xvf /opt/mysql-server_5.7.15-1ubuntu14.04_amd64.deb-bundle.tar',
#logoutput => true,
refreshonly => true,
notify => Exec['sqlprecon'],
}

exec { 'sqlprecon':
command => "sudo ${frontend} dpkg-preconfigure mysql-community-server_5.7.15-1ubuntu14.04_amd64.deb",
#logoutput => true,
cwd => '/opt',
refreshonly => true,
notify => Exec['sqlclients'],
}

exec { 'sqlclients':
command => 'sudo dpkg -i mysql-common_5.7.15-1ubuntu14.04_amd64.deb',
cwd => '/opt',
provider => shell,
#logoutput => true,
refreshonly => true,
notify => Exec['sqlclients2'],
}

exec { 'sqlclients2':
command => 'sudo dpkg -i mysql-community-client_5.7.15-1ubuntu14.04_amd64.deb',
cwd => '/opt',
provider => shell,
#logoutput => true,
refreshonly => true,
notify => Exec['sqlclients3'],
}

exec { 'sqlclients3':
command => 'sudo dpkg -i mysql-client_5.7.15-1ubuntu14.04_amd64.deb',
cwd => '/opt',
provider => shell,
#logoutput => true,
refreshonly => true,
notify => Exec['sqlservers'],
}


exec { 'sqlservers':
command => 'sudo dpkg -i mysql-community-server_5.7.15-1ubuntu14.04_amd64.deb',
cwd => '/opt',
#logoutput => true,
refreshonly => true,
provider => shell,
notify => Exec['sqlservers2'],
}

exec { 'sqlservers2':
command => 'sudo dpkg -i mysql-server_5.7.15-1ubuntu14.04_amd64.deb',
cwd => '/opt',
#logoutput => true,
provider => shell,
refreshonly => true,
}
}
