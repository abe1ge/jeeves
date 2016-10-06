class jira::install {

	file { '/etc/puppet/modules/jira/files/jira.bin':
		ensure => present,
		source => '/tmp/shared/jira.bin',
	}

	exec { 'unzip_jira':
		unless => 'grep -rnw "/opt/atlassian/jira" -e "install"',
		path => ['/bin','/usr/bin'],
		command => 'sudo bash /etc/puppet/modules/jira/files/jira_setup.sh',
		require => Exec['make_executable'],
	}
	
	exec { 'make_executable':
		path => '/bin',
		command => 'chmod a+x /etc/puppet/modules/jira/files/jira.bin',
		require => File['/etc/puppet/modules/jira/files/jira.bin'],
	}
	
}
