class ufw {

	$ufw = '/usr/sbin/ufw'
	
	package { 'ufw':
		ensure => installed,
		allowcdrom => true,
	}
	
	exec { 'ufw_enable':
		command => "${ufw} enable" ,
	}

	exec { 'allow_ssh':
		command => "${ufw} allow 22"	
	}

	exec { 'allow_puppet':
                command => "${ufw} allow 8140"
        }
	
	service { 'ufw':
		ensure => running,
		enable => true,
		hasstatus => true,
		subscribe => Package['ufw'],
	}
}
