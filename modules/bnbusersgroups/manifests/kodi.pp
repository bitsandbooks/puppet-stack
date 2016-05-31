# Setup for kodi.
class bnbusersgroups::kodi inherits bnbusersgroups {
	$kodiuser   = 'kodi'
	$kodiuid    = '9003'
	$kodihome   = '/home/kodi'
	$kodipass   = 'KODI_PASSWORD_HASH_GOES_HERE'

	case $hostname {
		'zed':     { $kodigid = $zedgid }
		'zedtest': { $kodigid = $zedgid }
		default:   { $kodigid = $kodiuid }
	}
	user { 'kodi':
		ensure     => 'present',
		uid        => $kodiuid,
		gid        => $kodigid,
		password   => $kodipass,
		home       => $kodihome,
		managehome => 'true',
		shell      => '/usr/sbin/nologin',
		groups     => [
			'sambashare',
		]
	}
	file { "/etc/samba/include/smb.conf.$kodiuser":
		ensure  => 'present',
		owner   => 'root',
		group   => 'root',
		mode    => '0644',
		content => template('bnbusersgroups/smb.conf.kodi.erb'),
	}
	file { "$kodihome/media":
		ensure  => 'directory',
		owner   => $kodiuser,
		group   => $kodigid,
		mode    => '0660',
		require => User['kodi'],
	}
	file { "$kodihome/media/rob":
		ensure  => 'link',
		owner   => $kodiuser,
		group   => $kodigid,
		target  => '/mnt/storage/rob/media',
		require => File["$kodihome/media"],
	}
	file { "$kodihome/media/julie":
		ensure  => 'link',
		owner   => $kodiuser,
		group   => $kodigid,
		target  => '/mnt/storage/julie/media',
		require => File["$kodihome/media"],
	}
}
