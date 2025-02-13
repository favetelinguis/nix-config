{ pkgs, pkgs-unstable, ... }: {
	nixpkgs.config = {
		allowUnfree = true;
	};

	environment.systemPackages = (with pkgs; [
	
	# CLI tools
	just
	vlc
	kubectl
	kind
	kubernetes-helm

	# Desktop apps
	google-chrome
	jetbrains.idea-ultimate

	# Other
	home-manager
	docker-compose
	ghostty
	])

	++

	(with pkgs-unstable; []);

	fonts.packages = with pkgs; [
		jetbrains-mono
	];
}
