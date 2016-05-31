# Networking class
class bnbnetwork {
	case $hostname {
		'zed': {
			file { '/etc/network/interfaces':
				ensure => 'present',
				source => 'puppet:///modules/bnbnetwork/interfaces.zed',
			}
			# exec { 'ifdown p1p1 && ifup p1p1':
			# 	command => 'ifdown p1p1 && ifup p1p1',
			# 	require => File["/etc/network/interfaces"]
			# }
		}
		default: {
			file { '/etc/network/interfaces':
				ensure => 'present',
				source => 'puppet:///modules/bnbnetwork/interfaces.default',
			}
		}
	}
}
