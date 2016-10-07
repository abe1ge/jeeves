class jira::install {

	file { '/opt/jira.bin':
		ensure => present,
		source => '/tmp/shared/jira.bin',
	}

	file { '/opt/jira_setup.sh':
		ensure => present,
		source => '/tmp/shared/jira/files/jira_setup.sh',
		before => Exec['unzip_jira'],
	}

	exec { 'unzip_jira':
		unless => 'grep -rnw "/opt/atlassian/jira" -e "install"',
		path => ['/bin','/usr/bin'],
		command => 'sudo bash /opt/jira_setup.sh',
		require => Exec['make_executable'],
	}
	
	exec { 'make_executable':
		path => ['/bin','/usr/bin'],
		command => 'sudo chmod a+x /opt/jira.bin',
		require => File['/opt/jira.bin'],
	}
	
}
