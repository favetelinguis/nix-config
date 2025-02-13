# When I want to update flakes.lock run this then i can run home-manager for example to update all packages
update-packages:
	sudo nix flake update
# When making system changes run this
rebuild:
	sudo nixos-rebuild switch --flake .
# When making changes to home.nix
home-manager:
	home-manager switch --flake .
