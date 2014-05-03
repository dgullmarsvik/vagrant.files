# .../xorg/manifests/submodule_test.pp

class xorg::submodule_test {
	package { 'nmap':
		ensure => 'present',
		provider => 'pacman',
	}
}

class xorg::test2 {
	exec { 'install xorg::test':
	  cwd		=> '/tmp',
	  command   => 'pacman -S git --noconfirm',
	  timeout 	=> "360",
	}
}