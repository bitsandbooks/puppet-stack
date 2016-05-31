#  Bootstrap::ubuntu
class bnbbootstrap::ubuntu inherits bnbbootstrap {
	include apt

	ubuntupackages = [
		'aptitude',
		'auditd', # part of SELinux
		'build-essential',
		'fail2ban',
		'gdebi-core', # Do we really need this package?
		'selinux-basics',
		'selinux-policy-default',
		'software-properties-common', # Provides add-apt-repository.
		'update-motd', # Allows custom MOTDs
	]
	package { $ubuntupackages: ensure => latest, }

	cron { 'NIGHTLY - Sync apt cache and autoremove':
		command => '/usr/bin/apt-get update -qq; /usr/bin/apt-get autoremove -y;',
		user    => 'root',
		hour    => '0',
		minute  => '15',
	}

	# Sync local apt cache
	exec { 'apt-get update': command => '/usr/bin/apt-get update -qq', }

	# Add Docker apt repo.
	apt::source { 'docker':
		location => 'https://get.docker.com/ubuntu',
		release  => 'docker',
		repos    => 'main',
		key      => {
			'id'     => '36A1D7869245C8950F966E92D8576A8BA88D21E9',
			'server' => 'p80.pool.sks-keyservers.net',
		}
	}

}
