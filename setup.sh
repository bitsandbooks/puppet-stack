#!/bin/bash
# Basic setup script for a fresh Ubuntu machine. Will set the machine's
# hostname and install Git, Puppet and ZFS.
# Run this script through sudo after installing Ubuntu Server.
#
# USAGE:
# user@box $ sudo ./setup.sh my_server

NAME="servername"
RELEASE=`lsb_release -s -c`

# Set the machine's hostname. If you pass a name as $1, that hostname
# will be used. Otherwise, just change the $NAME variable above.
if [ -n "$1" ]; then; unset $NAME && NAME=$1; fi
hostname $NAME
echo $NAME > /etc/hostname
echo "127.0.0.1 localhost
127.0.0.1 ${NAME}.local ${NAME}

# The following lines are desirable for IPv6 capable hosts
::1     localhost ip6-localhost ip6-loopback
ff02::1 ip6-allnodes
ff02::2 ip6-allrouters" > /etc/hosts

# Get Puppet metapackage.
wget http://apt.puppetlabs.com/puppetlabs-release-$RELEASE.deb
dpkg -i puppetlabs-release-$RELEASE.deb
rm puppetlabs-release-$RELEASE.deb

# Add the ZFS on Linux APT repository.
add-apt-repository ppa:zfs-native/stable

# Sync APT index and upgrade all currently-installed packages.
apt-get update -qq &&\
apt-get -y upgrade &&\
apt-get -y dist-upgrade &&\
apt-get -y autoremove

# Install packages and Puppet apt/network modules.
apt-get install -y git
apt-get install -y ubuntu-zfs
apt-get install -y ifupdown-extra
apt-get install -y puppet puppet-common
puppet module install puppetlabs-apt
puppet module install adrien-network
echo "# Defaults for puppet - sourced by /etc/init.d/puppet

# Enable puppet agent service?
# Setting this to 'yes' allows the puppet agent service to run.
# Setting this to 'no' keeps the puppet agent service from running.
START=yes

# Startup options
DAEMON_OPTS=\"\"" > /etc/default/puppet
