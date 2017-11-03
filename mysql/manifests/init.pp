class mysql {
	$mysqladmin = '/usr/bin/mysqladmin'

	package {'mysql-server':
		ensure => installed,
	}

	package {'mysql-client':
		ensure => installed,
		require => Package ['mysql-server'],
	}

	package {'php-mysql':
		ensure => installed,
		require => Package ['mysql-client'],
		notify => Service ['mysql'],
	}

	exec {'mysqlpasswd':
		command => "${mysqladmin} -u root password salasana",
		require => Package ['mysql-server'],
		notify => Service ['mysql'],
	}

	service {'mysql':
		ensure => running,
		enable => true,
		require => Package['mysql-server'],
	}
}
