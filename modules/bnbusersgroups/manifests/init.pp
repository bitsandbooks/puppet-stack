# Default Users/Groups Class.
class bnbusersgroups {
	case $hostname {
		'zed': {
			group { $zedgroup:
				ensure => 'present',
				gid    => $zedgid,
			}
		}
		'servo': {  }
		default: {
			group { 'rpjd':
				ensure => 'present',
				gid    => '9000'
			}
		}
	}
}

