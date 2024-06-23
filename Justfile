# When I want to update flakes.lock
update-packages:
	nix flake update
# When making system changes run this
rebuild:
	sudo nixos-rebuild switch --flake .
# When making changes to home.nix
home-manager:
	home-manager switch --flake .
