# Setup for web user.
class bnbusersgroups::webuser inherits bnbusersgroups {
	$wwwuser   = 'www-data'
	$wwwuid    = '9901'
	$wwwgid    = '9900'
	$wwwhome   = '/var/www'
	$wwwpass   = '$1$7MHsO6To$SP4CX.PZGU4jDuVjuY.Fu.'
	group { 'www-data':
		ensure => 'present',
		gid    => $wwwgid,
	}
	user { 'www-data':
		ensure     => 'present',
		uid        => $wwwuid,
		gid        => $wwwgid,
		password   => $wwwpass,
		home       => $wwwhome,
		managehome => 'false',
		shell      => '/usr/sbin/nologin',
	}
}
