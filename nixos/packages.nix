{ pkgs, pkgs-unstable, ... }: {
	nixpkgs.config = {
		allowUnfree = true;
	};

	environment.systemPackages = (with pkgs; [
	
	# CLI tools
	just

	# Desktop apps
	google-chrome

	# Other
	home-manager
	])

	++

	(with pkgs-unstable; []);

	fonts.packages = with pkgs; [
		jetbrains-mono
	];
}
