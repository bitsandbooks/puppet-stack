class bnbtransmission (
  $transd                         = $transmission::params::transd,
  $transuser                      = $transmission::params::transuser,
  $transgroup                     = $transmission::params::transgroup,
  $alt_speed_down                 = $transmission::params::alt_speed_down,
  $alt_speed_enabled              = $transmission::params::alt_speed_enabled,
  $alt_speed_time_begin           = $transmission::params::alt_speed_time_begin,
  $alt_speed_time_day             = $transmission::params::alt_speed_time_day,
  $alt_speed_time_enabled         = $transmission::params::alt_speed_time_enabled,
  $alt_speed_time_end             = $transmission::params::alt_speed_time_end,
  $alt_speed_up                   = $transmission::params::alt_speed_up,
  $bind_address_ipv4              = $transmission::params::bind_address_ipv4,
  $bind_address_ipv6              = $transmission::params::bind_address_ipv6,
  $blocklist_enabled              = $transmission::params::blocklist_enabled,
  $blocklist_url                  = $transmission::params::blocklist_url,
  $cache_size_mb                  = $transmission::params::cache_size_mb,
  $dht_enabled                    = $transmission::params::dht_enabled,
  $download_dir                   = $transmission::params::download_dir,
  $download_queue_enabled         = $transmission::params::download_queue_enabled,
  $download_queue_size            = $transmission::params::download_queue_size,
  $encryption                     = $transmission::params::encryption,
  $idle_seeding_limit             = $transmission::params::idle_seeding_limit,
  $idle_seeding_limit_enabled     = $transmission::params::idle_seeding_limit_enabled,
  $incomplete_dir                 = $transmission::params::incomplete_dir,
  $incomplete_dir_enabled         = $transmission::params::incomplete_dir_enabled,
  $lpd_enabled                    = $transmission::params::lpd_enabled,
  $message_level                  = $transmission::params::message_level,
  $peer_congestion_algorithm      = $transmission::params::peer_congestion_algorithm,
  $peer_id_ttl_hours              = $transmission::params::peer_id_ttl_hours,
  $peer_limit_global              = $transmission::params::peer_limit_global,
  $peer_limit_per_torrent         = $transmission::params::peer_limit_per_torrent,
  $peer_port                      = $transmission::params::peer_port,
  $peer_port_random_high          = $transmission::params::peer_port_random_high,
  $peer_port_random_low           = $transmission::params::peer_port_random_low,
  $peer_port_random_on_start      = $transmission::params::peer_port_random_on_start,
  $peer_socket_tos                = $transmission::params::peer_socket_tos,
  $pex_enabled                    = $transmission::params::pex_enabled,
  $port_forwarding_enabled        = $transmission::params::port_forwarding_enabled,
  $preallocation                  = $transmission::params::preallocation,
  $prefetch_enabled               = $transmission::params::prefetch_enabled,
  $queue_stalled_enabled          = $transmission::params::queue_stalled_enabled,
  $queue_stalled_minutes          = $transmission::params::queue_stalled_minutes,
  $ratio_limit                    = $transmission::params::ratio_limit,
  $ratio_limit_enabled            = $transmission::params::ratio_limit_enabled,
  $rename_partial_files           = $transmission::params::rename_partial_files,
  $rpc_authentication_required    = $transmission::params::rpc_authentication_required,
  $rpc_bind_address               = $transmission::params::rpc_bind_address,
  $rpc_enabled                    = $transmission::params::rpc_enabled,
  $rpc_password                   = $transmission::params::rpc_password,
  $rpc_port                       = $transmission::params::rpc_port,
  $rpc_url                        = $transmission::params::rpc_url,
  $rpc_username                   = $transmission::params::rpc_username,
  $rpc_whitelist                  = $transmission::params::rpc_whitelist,
  $rpc_whitelist_enabled          = $transmission::params::rpc_whitelist_enabled,
  $scrape_paused_torrents_enabled = $transmission::params::scrape_paused_torrents_enabled,
  $script_torrent_done_enabled    = $transmission::params::script_torrent_done_enabled,
  $script_torrent_done_filename   = $transmission::params::script_torrent_done_filename,
  $seed_queue_enabled             = $transmission::params::seed_queue_enabled,
  $seed_queue_size                = $transmission::params::seed_queue_size,
  $speed_limit_down               = $transmission::params::speed_limit_down,
  $speed_limit_down_enabled       = $transmission::params::speed_limit_down_enabled,
  $speed_limit_up                 = $transmission::params::speed_limit_up,
  $speed_limit_up_enabled         = $transmission::params::speed_limit_up_enabled,
  $start_added_torrents           = $transmission::params::start_added_torrents,
  $trash_original_torrent_files   = $transmission::params::trash_original_torrent_files,
  $umask                          = $transmission::params::umask,
  $upload_slots_per_torrent       = $transmission::params::upload_slots_per_torrent,
  $utp_enabled                    = $transmission::params::utp_enabled,
) inherits bnbtransmission::params {
  File {
    ensure => directory,
    owner  => $transuser,
    group  => $transgroup,
    mode   => '0644',
  }
  user { $transuser:
    ensure  => present,
    home    => $transd,
    comment => 'Transmission BitTorrent',
    gid     => $transgroup,
    shell   => '/sbin/nologin',
  }
  group { $transgroup: ensure => present, }
  package { [ 'transmission-cli','transmission-common','transmission-daemon', ]:
    ensure  => installed,
    before  => File[trans-config-shell],
  }
  file { 'trans-config-shell':
    ensure  => file,
    path    => "${transd}/settingz.json",
    mode    => '0600',
    content => template("${module_name}/settings.json.erb"),
  }
  exec { 'stop daemon to update file':
    path      => $::path,
    cwd       => $transd,
    command   => "puppet resource service transmission-daemon ensure=stopped && /bin/cp -af ${transd}/settingz.json ${transd}/settings.json",
    unless    => 'diff -q settingz.json settings.json',
    subscribe => File['trans-config-shell'],
  }
  service { 'transmission-daemon':
    ensure    => running,
    subscribe => Exec['stop daemon to update file'],
  }
  if $download_dir == $incomplete_dir {
    $dirs = $download_dir
  } else {
    $dirs = [ $download_dir, $incomplete_dir ]
  }
  file { $dirs:
    require => Package['transmission-daemon'],
  }
}
