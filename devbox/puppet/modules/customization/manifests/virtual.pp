# .../CUStomization/manifests/virtual.pp

define customization::virtual ($git_email, $git_name) {
	exec { "copy poky to /usr/share/fonts for ${title}":
		cwd		=> '/tmp',
	  	command   => "cp /vagrant/private/fonts/Poky.ttf /usr/share/fonts/TTF/Poky.ttf",
	  	timeout	=> '60',
	}
	exec { "cache poky ${title}":
		require => Exec["copy poky to /usr/share/fonts for ${title}"],
		cwd		=> "/home/${title}",
	  	command   => "fc-cache -vf",
	  	timeout	=> '60',
	}
	file { "/home/${title}/.fluxbox":
		ensure => "directory",
		mode => 750,
		owner => "${title}",
		group => "${title}",
	}
	file { "/home/${title}/.fluxbox/backgrounds":
		ensure => "directory",
		mode => 750,
		owner => "${title}",
		group => "${title}",
	}
	exec { "copy bg to ${title} home":
		require => File ["/home/${title}/.fluxbox", "/home/${title}/.fluxbox/backgrounds"],
	  	cwd		=> '/tmp',
	  	command   => "cp /vagrant/private/images/default_bg.jpg /home/${title}/.fluxbox/backgrounds/default.jpg",
	  	timeout	=> '60',
	}
	exec { "set bg owner for ${title}":
		require => Exec["copy bg to ${title} home"],
		cwd => '/tmp',
		command => "chown ${title}:${title} /home/${title}/.fluxbox/backgrounds/default.jpg",
		timeout => '60',
	}
	file { "/home/${title}/.ssh":
		ensure => "directory",
		mode => 750,
		owner => "${title}",
		group => "${title}",
	}
	exec { "copy keys to ${title} home":
		require => File["/home/${title}/.ssh"],
	  	cwd		=> '/tmp',
	  	command   => "cp -r /vagrant/private/keys/* /home/${title}/.ssh",
	  	timeout	=> '60',
	}
	exec { "set key owner for ${title}":
		require => Exec["copy keys to ${title} home"],
		cwd => '/tmp',
		command => "chown -R ${title}:${title} /home/${title}/.ssh/",
		timeout => '60',
	}
	exec { "set key permission for ${title}":
		require => Exec["copy keys to ${title} home"],
		cwd => '/tmp',
		command => "chmod -R 700 /home/${title}/.ssh/",
		timeout => '60',
	}
	exec { "get fluxbox startup for ${title}":
		require => File["/home/${title}/.fluxbox"],
		cwd => "/home/${title}/.fluxbox/",
		command => "curl https://raw.githubusercontent.com/dgullmarsvik/arch.files/master/mbp/startup >> startup",
		timeout => '60',
	}
	exec { "get fluxbox menu for ${title}":
		require => File["/home/${title}/.fluxbox"],
		cwd => "/home/${title}/.fluxbox/",
		command => "curl https://raw.githubusercontent.com/dgullmarsvik/arch.files/master/mbp/menu >> menu",
		timeout => '60',
	}
	exec { "get fluxbox init for ${title}":
		require => File["/home/${title}/.fluxbox"],
		cwd => "/home/${title}/.fluxbox/",
		command => "curl https://raw.githubusercontent.com/dgullmarsvik/arch.files/master/mbp/init >> init",
		timeout => '60',
	}
	exec { "get fluxbox overlay for ${title}":
		require => File["/home/${title}/.fluxbox"],
		cwd => "/home/${title}/.fluxbox/",
		command => "curl https://raw.githubusercontent.com/dgullmarsvik/arch.files/master/mbp/overlay >> overlay",
		timeout => '60',
	}
	exec { "set fluxbox owner for ${title}":
		require => Exec["get fluxbox startup for ${title}", "get fluxbox menu for ${title}", "get fluxbox init for ${title}", "get fluxbox overlay for ${title}"],
		cwd => '/tmp',
		command => "chown -R ${title}:${title} /home/${title}/.fluxbox/",
		timeout => '60',
	}
	exec { "set fluxbox permission for ${title}":
		require => Exec["set fluxbox owner for ${title}"],
		cwd => '/tmp',
		command => "chmod -R 750 /home/${title}/.fluxbox/",
		timeout => '60',
	}
	exec { "get .conkyrc for ${title}":
		cwd => "/home/${title}/",
		command => "curl https://raw.githubusercontent.com/dgullmarsvik/arch.files/master/mbp/.conkyrc >> .conkyrc",
		timeout => '60',
	}
	exec { "set .conkyrc owner for ${title}":
		require => Exec["get .conkyrc for ${title}"],
		cwd => '/tmp',
		command => "chown ${title}:${title} /home/${title}/.conkyrc",
		timeout => '60',
	}
	exec { "set .conkyrc permission for ${title}":
		require => Exec["get .conkyrc for ${title}"],
		cwd => '/tmp',
		command => "chmod 644 /home/${title}/.conkyrc",
		timeout => '60',
	}
	exec { "get .bash_profile for ${title}":
		cwd => "/home/${title}/",
		command => "curl https://raw.githubusercontent.com/dgullmarsvik/arch.files/master/.bash_profile >> .bash_profile",
		timeout => '60',
	}
	exec { "set .bash_profile owner for ${title}":
		require => Exec["get .bash_profile for ${title}"],
		cwd => '/tmp',
		command => "chown ${title}:${title} /home/${title}/.bash_profile",
		timeout => '60',
	}
	exec { "set .bash_profile permission for ${title}":
		require => Exec["get .bash_profile for ${title}"],
		cwd => '/tmp',
		command => "chmod 644 /home/${title}/.bash_profile",
		timeout => '60',
	}
	file { "/home/${title}/.gitconfig":
		mode => 750,
		owner => "${title}",
		group => "${title}",
	}
	exec { "add user to .gitconfig for ${title}":
		require => File["/home/${title}/.gitconfig"],
		cwd => "/home/${title}/",
		command => 'echo "[user]" >> .gitconfig',
		timeout => '60',
	}
	exec { "add user.email to .gitconfig for ${title}":
		require => Exec["add user to .gitconfig for ${title}"],
		cwd => "/home/${title}/",
		command => "echo '    email = ${git_email}' >> .gitconfig",
		timeout => '60',
	}
	exec { "add user.name to .gitconfig for ${title}":
		require => Exec["add user to .gitconfig for ${title}"],
		cwd => "/home/${title}/",
		command => "echo '    name = ${git_name}' >> .gitconfig",
		timeout => '60',
	}
	exec { "get .vimrc for ${title}":
		cwd => "/home/${title}/",
		command => "curl https://raw.githubusercontent.com/dgullmarsvik/arch.files/master/.vimrc >> .vimrc",
		timeout => '60',
	}
	exec { "set .vimrc owner for ${title}":
		require => Exec["get .vimrc for ${title}"],
		cwd => '/tmp',
		command => "chown ${title}:${title} /home/${title}/.vimrc",
		timeout => '60',
	}
	exec { "set .vimrc permission for ${title}":
		require => Exec["get .vimrc for ${title}"],
		cwd => '/tmp',
		command => "chmod 644 /home/${title}/.vimrc",
		timeout => '60',
	}
	file { "/home/${title}/.vim":
		ensure => "directory",
		mode => 750,
		owner => "${title}",
		group => "${title}",
	}
	file { "/home/${title}/.vim/autoload":
		require => File["/home/${title}/.vim"],
		ensure => "directory",
		mode => 750,
		owner => "${title}",
		group => "${title}",
	}
	file { "/home/${title}/.vim/bundle":
		require => File["/home/${title}/.vim"],
		ensure => "directory",
		mode => 750,
		owner => "${title}",
		group => "${title}",
	}
	exec { "get pathogen for ${title}":
		require => File["/home/${title}/.vim/autoload"],
		cwd => "/home/${title}/.vim/autoload",
		command => "curl https://raw.githubusercontent.com/tpope/vim-pathogen/master/autoload/pathogen.vim > pathogen.vim",
		timeout => '60',
	}
	exec { "set pathogen.vim owner for ${title}":
		require => Exec["get pathogen for ${title}"],
		cwd => '/tmp',
		command => "chown ${title}:${title} /home/${title}/.vim/autoload/pathogen.vim",
		timeout => '60',
	}
	exec { "set pathogen.vim permission for ${title}":
		require => Exec["get pathogen for ${title}"],
		cwd => '/tmp',
		command => "chmod 754 /home/${title}/.vim/autoload/pathogen.vim",
		timeout => '60',
	}
	file { "/home/${title}/code":
		ensure => "directory",
		mode => 750,
		owner => "${title}",
		group => "${title}",
	}
	file { "/home/${title}/code/c":
		require => File["/home/${title}/code"],
		ensure => "directory",
		mode => 750,
		owner => "${title}",
		group => "${title}",
	}
	file { "/home/${title}/code/cpp":
		require => File["/home/${title}/code"],
		ensure => "directory",
		mode => 750,
		owner => "${title}",
		group => "${title}",
	}
	file { "/home/${title}/code/node":
		require => File["/home/${title}/code"],
		ensure => "directory",
		mode => 750,
		owner => "${title}",
		group => "${title}",
	}
	file { "/home/${title}/code/python":
		require => File["/home/${title}/code"],
		ensure => "directory",
		mode => 750,
		owner => "${title}",
		group => "${title}",
	}
	file { "/home/${title}/code/haskell":
		require => File["/home/${title}/code"],
		ensure => "directory",
		mode => 750,
		owner => "${title}",
		group => "${title}",
	}
}
