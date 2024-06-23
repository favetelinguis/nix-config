{ pkgs, ... }: {
	nixpkgs.config = {
		allowUnfree = true;
	};

	environment.systemPackages = with pkgs; [
	
	# CLI tools
	just
	chezmoi

	# Desktop apps
	google-chrome
	
	# Other
	home-manager
	];

	fonts.packages = with pkgs; [
		jetbrains-mono
	];
}
