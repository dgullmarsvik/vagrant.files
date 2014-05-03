# .../developer_tools/manifests/init.pp

class developer_tools {
}

class install_base_devel {
	package { "base-devel":
		ensure => "installed",
		provider => "pacman",
	}
}