class git {
	require javainstall
	require maven
	
	Exec {
		path => [ "/usr/bin", "/bin", "/usr/sbin"],
	}  	

	exec { 'install':
	cwd => '/opt',
	command => 'sudo apt-get install git -y'
	}
}
