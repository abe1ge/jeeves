class bamboo {
	require javainstall
	require maven
	Exec {
		path => ["/usr/bin", "/bin", "/usr/sbin"],
	}

	file { '/opt/atlassian-bamboo-5.13.2.tar.gz':
		ensure => 'present',
		source => '/tmp/shared/atlassian-bamboo-5.13.2.tar.gz',
	}

	exec { 'extract bamboo files':
		cwd => '/opt/',
		command => 'sudo tar -zxvf atlassian-bamboo-5.13.2.tar.gz',
		require => File['/opt/atlassian-bamboo-5.13.2.tar.gz'],
	}

	exec { 'make bamboo home directory':
		command => 'mkdir -p /home/vagrant/bamboo/bamboo-home',
	}

	exec { 'change permissions for bamboo-init':
		cwd => '/opt/atlassian-bamboo-5.13.2/atlassian-bamboo/WEB-INF/classes',
		command => 'sudo chmod 777 bamboo-init.properties',
		require => Exec['extract bamboo files', 'make bamboo home directory'],
	}

	exec { 'edit bamboo-init.properties':
		command => 'sudo echo "bamboo.home=/home/vagrant/bamboo/bamboo-home" >> bamboo-init.properties',
		require => Exec['change permissions for bamboo-init'],
	}

	exec { 'start bamboo':
		cwd => '/opt/atlassian-bamboo-5.13.2',
		command => 'sudo bin/start-bamboo.sh',
		require => Exec['edit bamboo-init.properties'],
	}

}
