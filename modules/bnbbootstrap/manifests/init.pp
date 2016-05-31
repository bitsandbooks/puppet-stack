# Bootstrap class. This class gets Puppet up and running.
class bnbbootstrap {
	# Base package install list.
	$packages = [
		'ntp',
		'vim',
	]

	# Silence Puppet and Vagrant annoyance about the puppet group.
	group { 'puppet': ensure => 'present', }

	# Install packages.
	package { $packages: ensure  => 'latest', }

	# Allow members of the above 'puppet' group access to /etc/puppet.
	file { '/etc/puppet':
		ensure  => 'directory',
		group   => 'puppet',
		recurse => 'true',
	}
}
