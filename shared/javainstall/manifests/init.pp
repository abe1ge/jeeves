class javainstall {

#require jenkins

file { '/opt/java.tar.gz': 
ensure => 'present',
source => '/tmp/shared/java.tar.gz',
notify => Exec['javatar'],
}

exec { 'javatar':
command => 'tar zxvf java.tar.gz',
path => '/bin',
cwd => '/opt',
refreshonly => 'true',
notify => Exec['javaup'],
}

exec { 'javaup':
command => 'update-alternatives --install /usr/bin/java java /opt/jdk1.8.0_45/bin/java 100',
path => '/usr/bin',
cwd => '/opt',
refreshonly => 'true',
notify => Exec['javacup'],
}

exec { 'javacup':
command => 'update-alternatives --install /usr/bin/javac javac /opt/jdk1.8.0_45/bin/javac 100',
path => '/usr/bin',
cwd => '/opt',
refreshonly => 'true',
}
}
