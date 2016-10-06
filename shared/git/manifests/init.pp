class git {
	
	Exec {
		path => [ "/usr/bin", "/bin", "/usr/sbin"],
	}  	

	exec { 'install':
	cwd => '/tmp',
	command => 'sudo apt-get install git -y'
	}
}
