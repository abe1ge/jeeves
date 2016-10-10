class nexus::install {

	$nexuszip = 'nexus-3.0.2-02-unix.tar.gz'

	Exec {
		path => ['/bin','/usr/bin','/sbin','/usr/sbin']
	}

	file { '/tmp/shared/${nexuszip}':
		ensure => present,
		source => "/opt/${nexuszip}",
	}

	file {'/opt/nexus/NOTICE.txt':
		ensure => present,
	}

	exec { 'unzip nexus':
		cwd => '/opt/',
		command => "sudo tar -zxvf ${nexuszip}",
	}

	exec { 'link nexus':
		unless => 'grep -rnw "/opt/nexus/" -e "NOTICE"',
		cwd => '/opt/',
		command => "sudo ln -s nexus-3.0.2-02 nexus",
	}
}
