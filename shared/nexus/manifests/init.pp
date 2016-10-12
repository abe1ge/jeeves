class nexus {
	
	require javainstall
	require maven 
	
	#include nexus::install
	#include nexus::config
	
	$NEXUS_HOME = '/opt/nexus'
	$runnew = 'run_as_user="vagrant"'
	$runold = 'run_as_user=""'
	
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
		notify => Exec ['runnexuser'],
	}
	
		exec { 'runnexuser':
		cwd => '/opt/nexus/bin/',
		command => "sed -i -e 's/${runold}/$runnew$/g' nexus.rc",
		refreshonly => true,
		notify => Exec ['otherlinknex'],
	}

	exec { 'otherlinknex':
		cwd => "/",
		command => 'sudo ln -s /opt/nexus/bin/nexus /etc/init.d/nexus',
		notify => Exec ['setdefaultnex'],
		refreshonly => true,
	}

	exec { 'setdefaultnex':
		cwd => '/etc/init.d',
		command => 'sudo update-rc.d nexus defaults', 
		notify => Exec ['startnexus'],
		refreshonly => true,
	}

	exec { 'startnexus':
		cwd => '/etc/init.d',
		command => 'sudo service nexus start',
		require => Exec['setdefaultnex'],
		refreshonly => true,
	}
	
	
}
