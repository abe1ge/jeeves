class git {

	#require javainstall
	#require maven
	require nexus
	
	Exec {
		path => [ "/usr/bin", "/bin", "/usr/sbin"],
	}  	

	package { 'git':
	ensure => 'present',
	notify => Exec['gitinst'],
	}
	
	exec { 'gitinst':
	cwd => '/opt',
	command => 'sudo apt-get install git -y',
	refreshonly => true,
	}
}
