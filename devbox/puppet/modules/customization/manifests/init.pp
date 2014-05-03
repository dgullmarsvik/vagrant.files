# .../customization/manifests/init.pp

class customization {
	@customization::virtual { 'gullet':
		require => [Class['fluxbox'], Class['xorg'], Class['add_accounts']],
		git_email => 'user@example.org',
		git_name => 'Some User',
	}
}
