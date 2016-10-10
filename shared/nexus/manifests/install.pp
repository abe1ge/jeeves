class nexus::install {

	#$nexuszip = 'nexus-3.0.2-02-unix.tar.gz'

	Exec {
		path => ['/bin','/usr/bin','/sbin','/usr/sbin']
	}

	file { '/opt/nexus-3.0.2-02-unix.tar.gz':
		ensure => present,
		source => "/tmp/shared/nexus-3.0.2-02-unix.tar.gz",
		notify => Exec['unzip nexus'],
	}

	exec { 'unzip nexus':
		cwd => '/opt/',
		command => "sudo tar -zxvf nexus-3.0.2-02-unix.tar.gz",
		refreshonly => true,
		notify => Exec['link nexus'],
	}

	exec { 'link nexus':
		unless => 'grep -rnw "/opt/nexus/" -e "NOTICE"',
		cwd => '/opt/',
		command => "sudo ln -s nexus-3.0.2-02 nexus",
		refreshonly => true,
	}
}
