#puppet essential
group { 'puppet': ensure => 'present' }

Exec { path => ['/bin', '/sbin', '/usr/bin', 'usr/sbin'] }

class devbox {
}

include devbox
require update_system
require coreutils
#require sound
require xorg
require fluxbox
require internet_tools
require developer_tools
require add_accounts
require customize_accounts

#require xorg::submodule_test
