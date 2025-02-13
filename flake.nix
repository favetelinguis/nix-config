{
	description = "My system configuration";

	inputs = {	
		# nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
		nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
		home-manager = {
			# url = "github:nix-community/home-manager/release-24.05";
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, ... }:
		let
			system = "x86_64-linux";
			pkgs = nixpkgs.legacyPackages.${system};
			pkgs-unstable = nixpkgs-unstable.legacyPackages.${system};
		in {
		nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
			inherit system;
			modules = [ ./nixos/configuration.nix ];
			specialArgs = {
				inherit pkgs-unstable;
			};
		};

		homeConfigurations.henke = home-manager.lib.homeManagerConfiguration {
			inherit pkgs;
			modules = [ ./home.nix ];
			extraSpecialArgs = {
				inherit pkgs-unstable;
			};
		};
	};
}
