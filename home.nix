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
        };

	programs.ripgrep = {
		enable = true;
	};

	programs.fd = {
		enable = true;
	};
}
