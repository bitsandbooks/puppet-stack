# Setup for guest.
class bnbusersgroups::guest inherits bnbusersgroups {
	$guestuser   = 'guest'
	$guestuid    = '9004'
	$guesthome   = '/home/guest'
	$guestpass   = 'GUEST_PASS_HASH_GOES_HERE'
	case $hostname {
		'zed':     { $guestgid = $zedgid }
		'zedtest': { $guestgid = $zedgid }
		default:   { $guestgid = $guestuid }
	}
	user { 'guest':
		ensure     => 'present',
		uid        => $guestuid,
		gid        => $guestgid,
		password   => $guestpass,
		home       => $guesthome,
		managehome => 'true',
		shell      => '/usr/sbin/nologin',
	}
	file { "$guesthome/media":
		ensure  => 'directory',
		owner   => $guestuser,
		group   => $guestgid,
		require => User['guest'],
	}
	file { "$guesthome/media/rob":
		ensure  => 'link',
		target  => '/mnt/storage/rob/media',
		require => File["$guesthome/media"],
	}
	file { "$guesthome/media/julie":
		ensure  => 'link',
		target  => '/mnt/storage/julie/media',
		require => File["$guesthome/media"],
	}
}
