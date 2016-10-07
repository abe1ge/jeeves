class maven {
	
	Exec {
		path => ["/usr/bin", "/bin", "/usr/sbin"],
	}
	
	file { '/opt/maven.tar.gz':
		ensure => 'present',
		source => 'tmp/shared/maven.tar.gz,
	}

	exec { 'extract maven':
		cwd => '/opt',
		command => 'sudo tar -zxvf maven.tar.gz',
		require => File['/opt/maven.tar.gz'],
	}

	exec { 'install maven':
		require => Exec['extract maven'],
		cwd => '/opt',
		command => 'sudo update-alternatives --install /usr/bin/mvn mvn /opt/apache-maven-3.3.9/bin/mvn 100',
	}
}
