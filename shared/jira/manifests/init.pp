class jira {

	#require javainstall
	require maven
	
	
	#include jira::install
	
	file { '/opt/jira.bin':
		ensure => present,
		source => '/tmp/shared/jira.bin',
	}
	
	file { '/opt/response.varfile':
		ensure => present,
		source => '/tmp/shared/jira/files/response.varfile',
		notify => Exec['make_executable'],
		require => File['/opt/jira.bin'],
	}
	
	exec { 'make_executable':
		path => ['/bin','/usr/bin'],
		command => 'sudo chmod a+x /opt/jira.bin',
		refreshonly => 'true',
		require => File['/opt/response.varfile'],
		notify => Exec['unzip_jira'],
	}

	exec { 'unzip_jira':
		unless => 'grep -rnw "/opt/atlassian/jira" -e "install"',
		path => ['/bin','/usr/bin','/opt'],
		cwd => '/opt',
		command => 'sudo /opt/jira.bin -q -varfile /opt/response.varfile',
		refreshonly => 'true',
		require => Exec['make_executable'],
		timeout => '600',
	}	
	
}
