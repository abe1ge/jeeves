class jira::install {

	file { '/home/vagrant/jira.bin':
		ensure => present,
		source => '/tmp/shared/jira.bin',
	}

	file { '/home/vagrant/jira_setup.sh':
		ensure => present,
		source => '/tmp/shared/jira_setup.sh',
		before => Exec['unzip_jira'],
	}

	exec { 'unzip_jira':
		unless => 'grep -rnw "/opt/atlassian/jira" -e "install"',
		path => ['/bin','/usr/bin'],
		command => 'sudo bash /home/vagrant/jira_setup.sh',
		require => Exec['make_executable'],
	}
	
	exec { 'make_executable':
		path => '/bin',
		command => 'chmod a+x /home/vagrant/jira.bin',
		require => File['/home/vagrant/jira.bin'],
	}
	
}
