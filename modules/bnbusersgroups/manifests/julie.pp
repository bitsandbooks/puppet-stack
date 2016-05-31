# Setup for julie.
class bnbusersgroups::julie inherits bnbusersgroups {
	$julieuser   = 'julie'
	$julieuid    = '9002'
	$juliehome   = '/mnt/storage/julie'
	$juliepass   = 'JULIES_PASSWORD_HASH_GOES_HERE'

	case $hostname {
		'zed':     {
			$juliegid   = $zedgid
			$juliegroup = $zedgroup
			file { "/etc/samba/include/smb.conf.$julieuser":
				ensure  => 'present',
				owner   => 'root',
				group   => 'root',
				mode    => '0644',
				content => template('bnbusersgroups/smb.conf.julie.erb'),
			}
			cron { 'jhome':
				command => "/bin/chown -R $julieuser:$juliegroup $juliehome; /bin/chmod -R 0700 $juliehome/.ssh; /bin/chmod 0644 $juliehome/.ssh/*.pub; /bin/chmod -Rv 0775 $juliehome/media",
				user    => 'root',
				hour    => '3',
				minute  => '45',
			}
			cron { 'jprivate':
				command => "/bin/chmod -R 700 $juliehome/backups >/dev/null 2>&1",
				user    => $julieuser,
				hour    => '4',
				minute  => '30',
			}
		}
		default:   {
			$juliegid   = '9000'
			$juliegroup = $juliename
		}
	}
	user { 'julie':
		ensure     => 'present',
		uid        => $julieuid,
		gid        => $juliegid,
		password   => $juliepass,
		home       => $juliehome,
		managehome => 'false',
		shell      => '/bin/bash',
		groups     => [
			'lpadmin',
			'sambashare',
		]
	}
	file { $juliehome:
		ensure  => 'directory',
		owner   => $julieuser,
		group   => $juliegid,
		mode    => '0640',
		require => User['julie'],
	}
	->
	file { "$juliehome/.ssh":
		ensure  => 'directory',
		owner   => $julieuser,
		group   => $juliegid,
		mode    => '0700',
		recurse => true,
	}
}
