class apache {
	package {'apache2':
		ensure => installed,
	}
	file {'/var/www/html/index.html':
		content => "Hello World",
		notify => Service ['apache2'],
		require => Package ['apache2']
	}
	
	file {'/etc/apache2/mods-enabled/userdir.conf':
		ensure => link,
		target => 'etc/apache2/mods-available/userdir.conf',
		require => Package['apache2'],
		notify => Service['apache2'],	
	}
    
	file {'/etc/apache2/mods-enabled/userdir.load':
		ensure => link,
		target => '/etc/apache2/mods-available/userdir.load',
		require => Package['apache2'],
		notify => Service['apache2'],
	}

	service {'apache2':
		ensure => running,
		enable => true,
		require => Package ['apache2']
	}

	package {'libapache2-mod-php':
		ensure => installed,
		require => Package ['apache2'],
		}

	file {'/etc/apache2/mods-available/php7.0.conf':
		content => template ("apache/php7.0.conf"),
		require => Package ['libapache2-mod-php'],
		notify => Service ['apache2'],
	}
		
}
