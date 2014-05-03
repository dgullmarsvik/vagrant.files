# .../add_accounts/manifests/init.pp

class add_accounts {
	require fluxbox
	require xorg
	notify{"class_add_accounts": message => "class add_accounts"}

	require accounts
	realize (Accounts::Virtual['gullet'])
}