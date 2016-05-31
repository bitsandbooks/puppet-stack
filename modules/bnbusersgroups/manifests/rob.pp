# Setup for rob.
class bnbusersgroups::rob inherits bnbusersgroups {
	$robuser     = 'rob'
	$robuid      = '9001'
	$robpass     = 'ROBS_PASSWORD_HASH_GOES_HERE'
	$robkey_rpjd = 'SSH_KEY_GOES_HERE'

	case $hostname {
		'zed':     {
			$robgid   = $zedgid
			$robgroup = $zedgroup
			$robhome  = '/mnt/storage/rob'
			file { "/etc/samba/include/smb.conf.$robuser":
				ensure  => 'present',
				owner   => 'root',
				group   => 'root',
				mode    => '0644',
				content => template('bnbusersgroups/smb.conf.rob.erb'),
			}
			cron { 'rhome':
				command => "/bin/chown -R $robuser:$robgroup $robhome; /bin/chmod -R 0700 $robhome/.ssh; /bin/chmod 0644 $robhome/.ssh/*.pub; /bin/chmod -R 0775 $robhome/media",
				user    => 'root',
				hour    => '4',
				minute  => '0',
			}
			cron { 'rprivate':
				command => "/bin/chmod -R 700 ~/media/private >/dev/null 2>&1; /bin/chmod -R 700 $robhome/backups >/dev/null 2>&1",
				user    => $robuser,
				hour    => '4',
				minute  => '30',
			}
		}
		'zedtest': {
			$robgid   = $zedgid
			$robgroup = $zedgroup
			$robhome  = '/mnt/storage/rob'
		}
		'cadigan': {
			$robgid   = $cadigangid
			$robgroup = $cadigangroup
			$robhome  = '/home/rob'
		}
		'rpjd': {
			$robgid   = 'rpjd'
			$robhome  = '/home/rob'
			ssh_authorized_key { 'rob@orwell.local':
				user => $robuser,
				type => 'ssh-rsa',
				key  => $robkey_rpjd,
			}
		}
		default:   {
			$robgid   = $robuid
			$robgroup = $robname
			$robhome  = '/home/rob'
		}
	}

	$robpkgs = [
		'htop',
		'zsh',
	]
	package { $robpkgs: ensure => 'latest', }
	user { 'rob':
		ensure     => present,
		uid        => $robuid,
		gid        => $robgid,
		password   => $robpass,
		home       => $robhome,
		managehome => false,
		shell      => '/bin/zsh',
		groups     => [
			'adm',
			'cdrom',
			'sudo',
			'dip',
			'plugdev',
			'puppet',
			'lpadmin',
			'sambashare',
		],
	}

	file { $robhome:
		ensure  => directory,
		owner   => $robuser,
		group   => $robgid,
		mode    => '0640',
		require => User['rob'],
	}
	->
	file { "$robhome/.ssh":
		ensure  => directory,
		owner   => $robuser,
		group   => $robgid,
		mode    => '0700',
	}
	->
	file { "$robhome/.ssh/authorized_keys":
		ensure  => present,
		owner   => $robuser,
		group   => $robgid,
		mode    => '0600',
	}
}
