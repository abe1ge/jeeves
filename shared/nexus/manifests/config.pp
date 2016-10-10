class nexus::config {

	$NEXUS_HOME = '/opt/nexus'
	$runnew = 'run_as_user="vagrant"'
	$runold = 'run_as_user=""'

	require nexus::install
	
	Exec {
		path => ['/bin','/usr/bin','/sbin','/usr/sbin'],
	}

	exec { 'runuser':
		cwd => '/opt/nexus/bin/',
		command => "sed -i -e 's/${runold}/$runnew$/g' nexus.rc",
	}

	exec { 'otherlink':
		cwd => "/",
		command => 'sudo ln -s /opt/nexus/bin/nexus /etc/init.d/nexus',
		require => Exec['runuser'],
	}

	exec { 'setdefault':
		cwd => '/etc/init.d',
		command => 'sudo update-rc.d nexus defaults',
		require => Exec['otherlink'],
	}

	exec { 'startnexus':
		cwd => '/etc/init.d',
		command => 'sudo service nexus start',
		require => Exec['setdefault'],
	}
}
