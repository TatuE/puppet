class apache {
	package {'apache2':
		ensure => installed,
		allowcdrom => true,
	}
	file {'/var/www/html/index.html':
		content => "Hello World",
		notify => Service ['apache2'],
		require => Package ['apache2']
	}
	
	file {'/etc/apache2/mods-enabled/userdir.conf':
	        ensure => 'link',
		target => '../mods-available/userdir.conf',
		notify => Service ['apache2'],
                require => Package ['apache2']
	}
	file { '/etc/apache2/mods-enabled/userdir.load':
		ensure => 'link',
		target => '../mods-available/userdir.load',
		notify => Service ['apache2'],
                require => Package ['apache2']
	}

	service {'apache2':
		ensure => running,
		enable => true,
		require => Package ['apache2']
	}

	package {'libapache2-mod-php':
		ensure => installed,
		allowcdrom => true,
		require => Package ['apache2'],
		}

	file {'/etc/apache2/mods-available/php7.0.conf':
		content => template ("apache/php7.0.conf"),
		require => Package ['libapache2-mod-php'],
		notify => Service ['apache2'],
	}
		
}
