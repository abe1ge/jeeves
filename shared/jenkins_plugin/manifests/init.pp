class jenkins_plugin {
	
	#require javainstall
	require jenkins
	#require git
	#require jira
	#require maven

	Exec {
		path => ["/usr/bin", "/bin", "/usr/sbin", "/sbin"],
	}

	exec { 'git plugin':
		cwd =>  '/var/lib/jenkins/plugins',
		command => 'sudo wget http://updates.jenkins-ci.org/download/plugins/git/3.0.0/git.hpi',
		notify => Exec['jira plugin'],
	}	
	
	exec { 'jira plugin':
		cwd =>  '/var/lib/jenkins/plugins',
		command => 'sudo wget http://updates.jenkins-ci.org/download/plugins/jira/2.2.1/jira.hpi',
		refreshonly => 'true',
		notify => Exec['maven plugin'],
	}

	exec { 'maven plugin':
		cwd => '/var/lib/jenkins/plugins',
		command => 'sudo wget http://updates.jenkins-ci.org/download/plugins/maven-plugin/2.13/maven-plugin.hpi',
		refreshonly => 'true',
		notify => Exec['restart jenkins'],
	}

	exec { 'restart jenkins':
		command => 'sudo service jenkins restart',
		refreshonly => 'true',
		require => Exec['git plugin', 'jira plugin', 'maven plugin'],
	}
}