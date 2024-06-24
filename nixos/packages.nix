{ pkgs, ... }: {
	nixpkgs.config = {
		allowUnfree = true;
	};

	environment.systemPackages = with pkgs; [
	
	# CLI tools
	just

	# Desktop apps
	google-chrome

	# Golang
  go
  gopls
  delve

  # Clojure
  clojure
  clojure-lsp
  babashka
  cljfmt
  clj-kondo
  
	# Other
	home-manager
	];

	fonts.packages = with pkgs; [
		jetbrains-mono
	];
}
