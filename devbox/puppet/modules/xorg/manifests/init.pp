# .../xorg/manifests/init.pp

class xorg {
	include install_xorg
	include install_xorg_twm_xterm
	include install_xf86_input
	include install_mesa
	include install_gamin
	include install_xmessage_feh
	include install_urxvt
	include set_keymap_to_sv-latin1
	notify{ "class_xorg": message => "class xorg" }
}

class install_xorg {
	package { ['xorg-server', 'xorg-server-utils', 'xorg-xinit']:
		ensure => 'installed',
		provider => 'pacman',
	}
}

#xcompmgr for transparancy
class install_xorg_twm_xterm {
	package { ['xorg-twm', 'xterm', 'xorg-xclock', 'xcompmgr']:
		require => Class['install_xorg'],
		ensure => 'installed',
		provider => 'pacman',
	}
}

class install_xf86_input {
	require install_xorg
	package { ['xf86-input-synaptics', 'xf86-input-mouse', 'xf86-input-keyboard']:
		ensure => 'installed',
		provider => 'pacman',
	}
}

class install_mesa {
	require install_xf86_input
	package { ['mesa', 'mesa-libgl']:
		ensure => 'installed',
		provider => 'pacman',
	}
}

class install_gamin {
	require install_mesa
	package { 'gamin':
		ensure => 'installed',
		provider => 'pacman',
	}
}

#xmessage for fluxbox fbsetbg
#feh for setting bg image
class install_xmessage_feh {
	require install_gamin
	package { ['xorg-xmessage', 'feh']:
		ensure => 'installed',
		provider => 'pacman',
	}
}

#Virtual Terminal
class install_urxvt {
	package {'rxvt-unicode':
		ensure => 'installed',
		provider => 'pacman',
	}
}

class set_keymap_to_sv-latin1 {
	require install_gamin
	exec { 'set keymap to sv-latin1':
	  	cwd		=> '/tmp',
	  	command   => 'localectl set-keymap sv-latin1',
	  	timeout	=> '60',
	}
	exec { 'set x11 keymap to se':
		command => 'localectl set-x11-keymap se',
		timeout => '60',
	}
}