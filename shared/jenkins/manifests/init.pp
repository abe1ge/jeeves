class jenkins {

	require javainstall
	require maven
	require bamboo
	
	file {'/opt/jenkins_2.1_all.deb':
		ensure => 'present',
		source => '/tmp/shared/jenkins_2.1_all.deb',
		notify => Exec['unzipjenkins'],
	}
	
	exec { 'unzipjenkins':
		command => 'sudo dpkg -i jenkins_2.1_all.deb || :',
		path => ['/bin/','/usr/bin/','/sbin/','/user/bin/'],
		cwd => '/opt/',
		refreshonly => 'true',
		notify => Exec['aptgetin'],
		require => File['/opt/jenkins_2.1_all.deb'],
	}
	
	exec { 'aptgetin':
		command => 'sudo apt-get install -f -y',
		path => ['/bin/','/usr/bin/','/sbin/','/user/bin/'],
		cwd => '/opt/',
		refreshonly => 'true',
		notify => Exec['aptgetjenk'],
		require => Exec['unzipjenkins'],
	}	
	
	exec { 'aptgetjenk':
		command => 'sudo apt-get install -y jenkins',
		path => ['/bin/','/usr/bin/','/sbin/','/user/bin/'],
		cwd => '/opt/',
		refreshonly => 'true',
		notify => Exec['sujenk'],
		require => Exec['aptgetin'],
	}	
	
	exec { 'sujenk':
		command => 'sudo su jenkins -s /bin/bash',
		path => ['/bin/','/usr/bin/','/sbin/','/user/bin/'],
		cwd => '/opt/',
		refreshonly => 'true',
		notify => Exec['jenksshkey'],
		require => Exec['aptgetjenk'],
	}
	
	exec { 'jenksshkey':
		command => 'ssh-keygen || :',
		path => ['/bin/','/usr/bin/','/sbin/','/user/bin/'],
		cwd => '/opt/',
		refreshonly => 'true',
		notify => Exec['jenkservstart'],
		require => Exec['sujenk'],
	}
	
	exec { 'jenkservstart':
		command => 'sudo service jenkins start',
		path => ['/bin/','/usr/bin/','/sbin/','/user/bin/'],
		cwd => '/opt/',
		refreshonly => 'true',
		require => Exec['jenksshkey'],
	}
}