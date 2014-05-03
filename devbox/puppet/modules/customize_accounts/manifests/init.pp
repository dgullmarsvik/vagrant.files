# .../customize_accounts/manifests/init.pp

class customize_accounts {
	require fluxbox
	require xorg
	require add_accounts
	notify{"class_customize_accounts": message => "class customize_accounts"}

	require customization
	realize (Customization::Virtual['gullet'])
}
