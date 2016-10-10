class maven {
	
	require javainstall
	
	Exec {
		path => ["/usr/bin", "/bin", "/usr/sbin"],
	}
	
	file { '/opt/maven.tar.gz':
		ensure => 'present',
		source => '/tmp/shared/maven.tar.gz',
		notify => Exec ['extract maven'],
	}

	exec { 'extract maven':
		cwd => '/opt',
		command => 'sudo tar -zxvf maven.tar.gz',
		require => File['/opt/maven.tar.gz'],
		refreshonly => true,
		notify => Exec ['install maven'],
	}

	exec { 'install maven':
		require => Exec['extract maven'],
		cwd => '/opt',
		refreshonly => true,
		command => 'sudo update-alternatives --install /usr/bin/mvn mvn /opt/apache-maven-3.3.9/bin/mvn 100',
	}
}
