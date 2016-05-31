# Delany server's class.
class bnbserver::delany inherits bnbserver {
	file { '/etc/ssh/sshd_config':
		ensure => 'present',
		source => 'puppet:///modules/bnbserver/sshd_config.default',
	}
}
