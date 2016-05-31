# rpjd server class.
class bnbserver::rpjd inherits bnbserver {
	file { '/etc/ssh/sshd_config':
		ensure => present,
		source => 'puppet:///modules/bnbserver/sshd_config.default',
		notify => Service['ssh'],
	}

	$rpjdpackages = [
		'nginx',
	]
	package { $rpjdpackages: ensure => latest, }
	service { 'nginx': ensure => 'running', }

	file { '/etc/nginx/sites-available/default':
		ensure  => present,
		content => template('bnbserver/nginx.rpjd.io.erb'),
		notify  => Service[nginx],
		require => Package[$rpjdpackages],
	}
	file { '/etc/nginx/ssl':
		ensure => directory,
		owner   => 'root',
		group   => 'root',
		mode    => '0600',
		recurse => true,
	}
	file { '/var/www/html':
		ensure  => directory,
		owner   => 'www-data',
		group   => 'www-data',
		recurse => true,
	}
}
