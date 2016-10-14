class zabbix { 
	
	require javainstall
	require maven
	
	group {'zabbix':
	ensure => 'present',
	}
	
	user {'zabbix':
	ensure => 'present',
	home => '/home/zabbix',
	groups => 'zabbix',
	require => Group['zabbix'],
	}
	
	file { '/opt/zabbix_3.2.0':
    ensure => 'directory',
	require => User['zabbix'],
	}
		
	file {'/opt/zabbix_3.2.0/zabbix_agents_3.2.0.linux2_6_23.amd64.tar.gz':
		ensure => 'present',
		source => '/tmp/shared/zabbix_agents_3.2.0.linux2_6_23.amd64.tar.gz',
		require => File['/opt/zabbix_3.2.0'],
	}
	
	exec { 'unzipzabbix':
		command => 'sudo tar zxvf zabbix_agents_3.2.0.linux2_6_23.amd64.tar.gz',
		path => ['/bin/','/usr/bin/','/sbin/','/user/bin/'],
		cwd => '/opt/zabbix_3.2.0',
		refreshonly => 'true',
		subscribe => File['/opt/zabbix_3.2.0/zabbix_agents_3.2.0.linux2_6_23.amd64.tar.gz'],
	}
	
	file {'/sbin/zabbix_agentd':
		ensure => 'present',
		source => '/opt/zabbix_3.2.0/sbin/zabbix_agentd',
		require => Exec['unzipzabbix'],
	}
	
	file {'/bin/zabbix_get':
		ensure => 'present',
		source => '/opt/zabbix_3.2.0/bin/zabbix_get',
		require => Exec['unzipzabbix'],
	}
	
	file {'/bin/zabbix_sender':
		ensure => 'present',
		source => '/opt/zabbix_3.2.0/bin/zabbix_sender',
		require => Exec['unzipzabbix'],
	}
	
	file {'/usr/local/etc/zabbix_agentd.conf':
		ensure => 'present',
		source => '/opt/zabbix_3.2.0/conf/zabbix_agentd.conf',
		require => Exec['unzipzabbix'],
	}
	
	
	exec { 'zabinst':
		command => '/sbin/zabbix_agentd',
		path => '/sbin/',
		refreshonly => 'true',
		subscribe => File['/sbin/zabbix_agentd','/bin/zabbix_sender','/bin/zabbix_get','/usr/local/etc/zabbix_agentd.conf'],
	}
	
}