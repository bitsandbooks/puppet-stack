/**
 * Title:     site.pp
 * Author:    [Rob Dumas](https://rpjd.io/)
 * Created:   4 January 2015
 * Copyright: Copyright (c) 2015 Rob Dumas.
 * License:   MIT License (See LICENSE file.)
 */

node 'rpjd.io' {
	include bnbbootstrap
	include bnbbootstrap::ubuntu
	include bnbserver::rpjd
	include bnbusersgroups
	include bnbusersgroups::rob
}

node 'delany.rpjd.io' {
	include bnbbootstrap
	include bnbbootstrap::ubuntu
}

node 'zed.rpjd.io' {
	# Node definition for home server.
	# Requirements:
	# - Static network address.
	# - HFS+ support (read-only) for external HDDs.
	# - Samba for shares.
	# - Netatalk/Avahi for Time Machine.

	$zedgroup  = 'zedusers'
	$zedgid    = '9000'

	include bnbbootstrap
	include bnbbootstrap::ubuntu
	include bnbserver::zed
	include bnbnetwork
	include bnbusersgroups
	include bnbusersgroups::rob
	include bnbusersgroups::julie
	include bnbusersgroups::kodi
}

# Virtual machine for testing Zed's config.
node 'zedtest.rpjd.io' {
	$zedgroup  = 'zedusers'
	$zedgid    = '9000'

	include bnbbootstrap
	include bnbbootstrap::ubuntu
	include bnbserver::zed
	include bnbnetwork
	include bnbusersgroups
	include bnbusersgroups::rob
	include bnbusersgroups::julie
	include bnbusersgroups::kodi
}

node 'cadigan.rpjd.io' {
	# Node definition for Cadigan.
	# General notes:
	# - For most sites on this host, http://site redirects to https://site
	# Requirements:
	# - https://rpjd.io
	# - https://portfolio.rpjd.io
	# - https://sitehub.rpjd.io
	$cadigangroup  = 'cadiganusers'
	$cadigangid    = '9000'

	include bnbbootstrap
	include bnbbootstrap::ubuntu
	include bnbserver::cadigan
	include bnbusersgroups
	include bnbusersgroups::rob
}
