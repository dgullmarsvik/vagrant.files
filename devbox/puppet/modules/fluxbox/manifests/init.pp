# .../fluxbox/manifests/init.pp

class fluxbox {
	require xorg
	include install_fluxbox
	include install_lxappearance
	include install_xdg_user_dirs
	include install_leafpad_epdfview
	include install_fonts
	include set_enable_upower
	include install_conky
	#include config_xinitrc
	notify{ "class_fluxbox": message => "class fluxbox" }
}

class install_fluxbox {
	package { ['fluxbox', 'menumaker']:
		ensure => 'installed',
		provider => 'pacman',
	}
}

class install_lxappearance {
	package { ['lxappearance']:
		ensure => 'installed',
		provider => 'pacman',
	}
}

class install_xdg_user_dirs {
	package { ['xdg-user-dirs']:
		ensure => 'installed',
		provider => 'pacman',
	}
}

class install_leafpad_epdfview {
	package { ['leafpad', 'epdfview']:
		ensure => 'installed',
		provider => 'pacman',
	}
}

class install_fonts {
	package { ['ttf-bitstream-vera', 'ttf-dejavu']:
		ensure => 'installed',
		provider => 'pacman',
	}
}

class install_upower {
	package { ['upower']:
		ensure => 'installed',
		provider => 'pacman',
	}
}

class install_conky {
	package { ['conky']:
		ensure => 'installed',
		provider => 'pacman',
	}
}

class set_enable_upower {
	require install_upower
	exec { 'enable upower':
	  require	=> Class[install_upower],
	  cwd		=> '/tmp',
	  command   => 'systemctl enable upower',
	  timeout	=> '60',
	}
}