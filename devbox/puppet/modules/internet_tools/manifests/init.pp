# .../internet_tools/manifests/init.pp

class internet_tools {
	class {'install_internet_tools': 
		require => Class['fluxbox']
	}
	include install_internet_tools
}

class install_internet_tools {
	package { 'firefox':
		ensure	=> present,
		provider => 'pacman',
	}
}