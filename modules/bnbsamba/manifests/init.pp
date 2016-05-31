# Samba class.
class bnbsamba {
	$smbpkgs = [
		'python-samba',
		'samba',
		'samba-common',
		'samba-doc',
		'samba-testsuite',
	]
	package { $smbpkgs: ensure => 'latest', }
	file { '/etc/samba/smb.conf':
		ensure => 'present',
		source => 'puppet:///modules/bnbsamba/smb.conf',
		require => Package[$smbpkgs],
		notify  => Service['smbd'],
	}
	file { '/etc/samba/include':
		ensure => 'directory',
		owner  => 'root',
		group  => 'root',
		mode   => '0644',
	}
	service { 'smbd': ensure => 'running', }

	file { '/etc/avahi/services/smbd.service':
		ensure => 'present',
		source => 'puppet:///modules/bnbsamba/smbd.service',
		notify => Service['avahi-daemon'],
	}
}
