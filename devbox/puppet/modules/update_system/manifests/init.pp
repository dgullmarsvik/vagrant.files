# .../update_system/manifests/init.pp

class update_system {
	include update_packages
}

class update_packages {
	exec { 'update packages':
	  cwd      => '/tmp',
	  command   => 'pacman -Syu --noconfirm',
	  timeout	=> '360',
	}
}