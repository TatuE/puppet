class mysql {
	
	package {'mysql-server':
		ensure => installed,
		allowcdrom => true,	
	}

	package {'mysql-client':
		ensure => installed,
		allowcdrom => true,
		require => Package ['mysql-server'],
	}

	package {'php-mysql':
		ensure => installed,
		allowcdrom => true,
		require => Package ['mysql-client'],
		notify => Service ['mysql'],
	}

	exec {'mysqlpasswd':
		path => ['/bin', '/usr/bin'],
		command => "mysqladmin -uroot password salasana",
		require => Package ['mysql-server'],
		notify => Service ['mysql'],
	}

	service {'mysql':
		ensure => running,
		enable => true,
		require => Package['mysql-server'],
	}
}
