class bamboo {

	#require javainstall
	#require maven
	require git
	
	Exec {
		path => ["/usr/bin", "/bin", "/usr/sbin","/sbin"],
	}

	file { '/opt/atlassian-bamboo-5.13.2.tar.gz':
		ensure => 'present',
		source => '/tmp/shared/atlassian-bamboo-5.13.2.tar.gz',
		notify => Exec['extract bamboo files'],
	}

	exec { 'extract bamboo files':
		cwd => '/opt/',
		command => 'sudo tar -zxvf atlassian-bamboo-5.13.2.tar.gz',
		refreshonly => 'true',
		notify => Exec['make bamboo home directory'],
		require => File['/opt/atlassian-bamboo-5.13.2.tar.gz'],
	}

	exec { 'make bamboo home directory':
		command => 'sudo mkdir -p /opt/bamboo/bamboo-home',
		refreshonly => 'true',
		notify => Exec['change permissions for bamboo-init'],
	}

	exec { 'change permissions for bamboo-init':
		cwd => '/opt/atlassian-bamboo-5.13.2/atlassian-bamboo/WEB-INF/classes',
		command => 'sudo chmod 777 bamboo-init.properties',
		refreshonly => 'true',
		require => Exec['extract bamboo files', 'make bamboo home directory'],
		notify => Exec['edit bamboo-init.properties'],
	}

	exec { 'edit bamboo-init.properties':
		command => 'sudo echo "bamboo.home=/opt/bamboo/bamboo-home" >> bamboo-init.properties',
		cwd => '/opt/atlassian-bamboo-5.13.2/atlassian-bamboo/WEB-INF/classes',
		refreshonly => 'true',
		require => Exec['change permissions for bamboo-init'],
		notify => Exec['start bamboo'],
	}

	exec { 'start bamboo':
		cwd => '/opt/atlassian-bamboo-5.13.2',
		command => 'sudo bin/start-bamboo.sh',
		refreshonly => 'true',
		require => Exec['edit bamboo-init.properties'],
	}

}
