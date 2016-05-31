class bnbtransmission::params {
  $transd                         = '/var/lib/transmission'
  $transuser                      = 'transmission'
  $transgroup                     = 'zedusers'
  $alt_speed_down                 = 25
  $alt_speed_enabled              = true
  $alt_speed_time_begin           = 420
  $alt_speed_time_day             = 127
  $alt_speed_time_enabled         = false
  $alt_speed_time_end             = 120
  $alt_speed_up                   = 5
  $bind_address_ipv4              = "0.0.0.0"
  $bind_address_ipv6              = "::"
  $blocklist_enabled              = true
  $blocklist_url                  = "http://list.iblocklist.com/?list=ydxerpxkpcfqjaybcssw&fileformat=p2p&archiveformat=gz"
  $cache_size_mb                  = 8
  $dht_enabled                    = true
  $download_dir                   = "/mnt/storage/apps/transmission-daemon/downloads"
  $download_queue_enabled         = true
  $download_queue_size            = 5
  $encryption                     = 1
  $idle_seeding_limit             = 30
  $idle_seeding_limit_enabled     = true
  $incomplete_dir                 = "/mnt/storage/apps/transmission-daemon/incomplete"
  $incomplete_dir_enabled         = true
  $lpd_enabled                    = false
  $message_level                  = 2
  $peer_congestion_algorithm      = ""
  $peer_id_ttl_hours              = 6
  $peer_limit_global              = 240
  $peer_limit_per_torrent         = 60
  $peer_port                      = 51413
  $peer_port_random_high          = 65535
  $peer_port_random_low           = 49152
  $peer_port_random_on_start      = false
  $peer_socket_tos                = "default"
  $pex_enabled                    = true
  $port_forwarding_enabled        = true
  $preallocation                  = 1
  $prefetch_enabled               = 1
  $queue_stalled_enabled          = true
  $queue_stalled_minutes          = 30
  $ratio_limit                    = 2
  $ratio_limit_enabled            = true
  $rename_partial_files           = true
  $rpc_authentication_required    = true
  $rpc_bind_address               = "0.0.0.0"
  $rpc_enabled                    = false
  $rpc_password                   = "SECURE_PASSWORD_GOES_HERE"
  $rpc_port                       = 9091
  $rpc_url                        = "/"
  $rpc_username                   = "USER_NAME_GOES_HERE"
  $rpc_whitelist                  = "127.0.0.1,192.168.*.*"
  $rpc_whitelist_enabled          = true
  $scrape_paused_torrents_enabled = true
  $script_torrent_done_enabled    = false
  $script_torrent_done_filename   = ""
  $seed_queue_enabled             = false
  $seed_queue_size                = 10
  $speed_limit_down               = 100
  $speed_limit_down_enabled       = false
  $speed_limit_up                 = 100
  $speed_limit_up_enabled         = false
  $start_added_torrents           = true
  $trash_original_torrent_files   = false
  $umask                          = 18
  $upload_slots_per_torrent       = 14
  $utp_enabled                    = true
}