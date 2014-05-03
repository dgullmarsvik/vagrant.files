# .../accounts/manifests/init.pp

class accounts {
	@accounts::virtual { 'gullet':
		require => [Class['fluxbox'], Class['xorg']],
		uid => 1005,
		pass => '$6$S6Irhba.$EQibuGtQFraofne1kPRO3oz3QnAVMu7z645o.WO1o1NPC9zBILdo8UbZg9UIzC0t7gcIySgflfFSSYF/VWzvu1',
	}
}