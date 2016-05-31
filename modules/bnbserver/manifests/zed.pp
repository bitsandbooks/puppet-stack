# Zed server's class.
class bnbserver::zed inherits bnbserver {
	# Packages for Zed.
	$zedpkgs = [
		'avahi-daemon',
		'git',
		'hfsutils',
		'netatalk',
		'smartmontools',
	]
	package { $zedpkgs: ensure => 'latest', }

	file { '/etc/ssh/sshd_config':
		ensure => present,
		source => 'puppet:///modules/bnbserver/sshd_config.default',
		notify => Service['ssh'],
	}

	# Set up AppleTalk and Avahi (aka Zeroconf) for Time Machine.
	file { '/etc/netatalk/AppleVolumes.default':
		ensure => 'present',
		source => 'puppet:///modules/bnbserver/AppleVolumes.default',
		require => Package[$zedpkgs],
		notify  => Service['netatalk'],
	}
	service { 'netatalk':
		ensure   => 'running',
		provider => 'upstart',
	}
	file { '/etc/avahi/services/afpd.service':
		ensure  => 'present',
		source  => "puppet:///modules/bnbserver/afpd.service",
		require => Package[$zedpkgs],
		notify  => Service['avahi-daemon'],
	}
	service { 'avahi-daemon':
		ensure   => 'running',
		provider => 'upstart',
	}

	# Cron job: scrub zpool 'storage' once a week.
	cron { 'scrub':
		command => '/sbin/zpool scrub storage',
		user    => 'root',
		weekday => '1',
		hour    => '4',
		minute  => '15',
	}

}
