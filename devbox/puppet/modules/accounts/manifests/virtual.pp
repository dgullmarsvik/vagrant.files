# .../accounts/manifests/virtual.pp

define accounts::virtual ($uid, $pass) {
	group { $title:
		ensure => present,
		gid => $uid,
	}

	user { $title:
		ensure => present,
		uid => $uid,
		gid => $title,
		shell => '/bin/bash',
		home => "/home/${title}",
		managehome => true,
		password => $pass,
		require => Group[$title],
	}

	exec { "set password ${title}":
		require => User[$title],
		cwd => '/tmp',
		command => "echo ${title}:${title} | chpasswd",
		timeout => "60",
	}

	file { "/home/${title}":
		ensure => directory,
		owner => $title,
		group => $title,
		mode => 0750,
		require => [ Group[$title], Group[$title] ],
	}

	exec { "copy .xinitrc skeleton file ${title}":
		require => [File["/home/${title}"]], 
		cwd		=> '/tmp',
		command   => "cp -fv /etc/skel/.xinitrc /home/${title}/",
		timeout	=> '60',
	}
	exec { "add startfluxbox to .xinitrc ${title}":
		require	=> Exec["copy .xinitrc skeleton file ${title}"],
		cwd		=> '/tmp',
		command   => "echo -e 'exec startfluxbox' >> /home/${title}/.xinitrc",
		timeout	=> '60',
	}
	exec { "set permissions .xinitrc ${title}":
		require	=> Exec["add startfluxbox to .xinitrc ${title}"],
		cwd		=> '/tmp',
		command   => "chown -R root:users /home/${title}/.xinitrc",
		timeout	=> '60',
	}
}