# .../coreutils/manifests/init.pp

class coreutils {
	include install_git
	#include install_dnsutils
	include install_base-devel
	#include install_ruby-shadow
}

class install_git {
	package { 'git':
		ensure	=> present,
		provider => 'pacman',
	}
}

## Used to enable puppet to create users with passwords
class install_ruby-shadow {
	package { 'ruby-shadow':
	  ensure	=> 'installed',
	  provider   => 'gem',
	}
}

class install_dnsutils {
	package { 'dnsutils':
		ensure	=> 'present',
		provider => 'pacman',
	}
}

## Needed for gem install (install_ruby-shadow)
## if ran as package, gem install ruby-shadow will not work (default pacman-groups?)
class install_base-devel {
	exec { 'install base-devel':
	  cwd		=> '/tmp',
	  command   => 'pacman -S base-devel --noconfirm',
	  timeout	=> '60',
	}
}