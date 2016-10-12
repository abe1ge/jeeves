class jira::install {

	file { '/opt/jira.bin':
		ensure => present,
		source => '/tmp/shared/jira.bin',
		notify => Exec['make_executable'],
	}
	
	file { '/opt/response.varfile':
		ensure => present,
		source => '/tmp/shared/response.varfile',
		notify => Exec['make_executable'],
	}
	
	exec { 'make_executable':
		path => ['/bin','/usr/bin'],
		command => 'sudo chmod a+x /opt/jira.bin',
		refreshonly => 'true',
		require => File['/opt/jira.bin'],
	}

	exec { 'unzip_jira':
		unless => 'grep -rnw "/opt/atlassian/jira" -e "install"',
		path => ['/bin','/usr/bin'],
		cwd => '/opt',
		command => 'sudo jira.bin -q response.varfile',
		refreshonly => 'true',
		require => Exec['make_executable'],
		timeout => '600',
	}	
}
