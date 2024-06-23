{ pkgs, ... }: {	
	home = {
		username = "henke";
		homeDirectory = "/home/henke";
		stateVersion = "24.05";
	};

        programs.bash = {
                enable = true;
                shellAliases = {
                        rebuild = "sudo nixos-rebuild switch";
                };
        };

        programs.git = {
                enable = true;
                userName = "Henrik Larsson";
                userEmail = "t1@henkelarsson.se";
                extraConfig.init.defaultBranch = "main";
        };

        programs.emacs = {
                enable = true;
                package = pkgs.emacs;
		extraPackages = epkgs: [
			epkgs.nord-theme
		];
		extraConfig = ''
		(use-package emacs
			:config
			(setq use-package-always-ensure nil))
		
		(use-package nord-theme
		  	:config
			(load-theme 'nord t))
		'';
        };

	programs.direnv = {
		enable = true;
		enableBashIntegration = true;
		nix-direnv.enable = true;
	};

	programs.password-store = {
		enable = true;
	};

	programs.ripgrep = {
		enable = true;
	};

	programs.fd = {
		enable = true;
	};
}
