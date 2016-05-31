# Virtualbox Class.
class bnbvirtualbox {
	$vboxpkgs = [
		'docker.io',
		'lxc',
		'python3-docker',
		'vim-syntax-docker',
	]
	package { $packages: ensure => 'present', }
}
