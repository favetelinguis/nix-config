{ pkgs, pkgs-unstable, ... }: {
  home = {
    username = "henke";
    homeDirectory = "/home/henke";
    stateVersion = "24.05";
    packages = (with pkgs; [ ]) ++ (with pkgs-unstable; [
      leiningen
      clojure
      rlwrap
      cljfmt
      clj-kondo
      clojure-lsp
      # chatgpt-cli # only old version so installed manually to .local/bin
      emacs
      jdk21
      maven
      nixfmt-classic
      unzip
      jetbrains-mono
      wl-clipboard # need this to get copy past working with helix
    ]);
  };

  programs.gh = { enable = true; };

  programs.gh-dash = { enable = true; };

  programs.k9s = { enable = true; };

  # rust tldr clone
  programs.tealdeer = { enable = true; };

  programs.broot = { enable = true; 
  settings = {
    verbs = [
        {
        "invocation"= "gitu";
        "shortcut"="gg";
        "key"= "ctrl-g";
        "execution"= "gitu";
        "leave_broot"= false;
    }
        {
        "invocation"= "edit";
        "shortcut"="e";
        "key"= "enter";
        "apply_to"= "text_file";
        "execution"= "$EDITOR {file}:{line}";
        "leave_broot"= false;
    }
          { invocation = "git_filelog"; shortcut = "gl"; "leave_broot" = false; "execution" = "git log -p --follow -- {file}";  } 
          { invocation = "git_blame"; shortcut = "gb"; "leave_broot" = false; "execution" = "git blame {file}";  } 
               {
         key = "ctrl-k";
         execution = ":line_up";
     }
     {
         key = "ctrl-j";
         execution= ":line_down";
     }
     {
         key= "ctrl-u";
         execution= ":page_up";
     }
     {
         key= "ctrl-d";
         execution = ":page_down";
     }
     {
         key= "ctrl-h";
         execution = ":panel_left_no_open";
     }
     {
         key= "ctrl-l";
         execution = ":panel_right";
     }
         {
         invocation= "home";
         key= "ctrl-home";
         execution= ":focus ~";
     }

     {
         invocation= "gtr";
         execution= ":focus {git-root}";
     }
        ];  
        };
  };

  programs.zoxide = { enable = true;
  options = ["--cmd j"]; };

  programs.bash = {
    enable = true;
    shellAliases = {
      gg = "gitui";
      q = "chatgpt --prompt ~/repos/prompts/explain_code.md";
      ll = "br";    
      };
    initExtra = ''
      source ~/torg/torg.sh
      export PS1="\w\$([ \j -gt 0 ] && echo [\j]) \n$ "
    '';
    profileExtra = ''
      PATH=$PATH:~/.config/emacs/bin:~/.local/bin
    ''; # add to path .local/bin is what I should use for my own installs
  };

  programs.git = {
    enable = true;
    userName = "Henrik Larsson";
    userEmail = "t1@henkelarsson.se";
    extraConfig.init.defaultBranch = "main";
    difftastic = {
      enable = false;
    };
  };

  programs.gitui = {
    enable = true;
    theme = ''
      	(
          selected_tab: Some("Reset"),
          command_fg: Some("#c6d0f5"),
          selection_bg: Some("#626880"),
          selection_fg: Some("#c6d0f5"),
          cmdbar_bg: Some("#292c3c"),
          cmdbar_extra_lines_bg: Some("#292c3c"),
          disabled_fg: Some("#838ba7"),
          diff_line_add: Some("#a6d189"),
          diff_line_delete: Some("#e78284"),
          diff_file_added: Some("#a6d189"),
          diff_file_removed: Some("#ea999c"),
          diff_file_moved: Some("#ca9ee6"),
          diff_file_modified: Some("#ef9f76"),
          commit_hash: Some("#babbf1"),
          commit_time: Some("#b5bfe2"),
          commit_author: Some("#85c1dc"),
          danger_fg: Some("#e78284"),
          push_gauge_bg: Some("#8caaee"),
          push_gauge_fg: Some("#303446"),
          tag_fg: Some("#f2d5cf"),
          branch_fg: Some("#81c8be")
      )
      	'';
    keyConfig = ''
      (
          open_help: Some(( code: F(1), modifiers: "")),

          move_left: Some(( code: Char('h'), modifiers: "")),
          move_right: Some(( code: Char('l'), modifiers: "")),
          move_up: Some(( code: Char('k'), modifiers: "")),
          move_down: Some(( code: Char('j'), modifiers: "")),

          popup_up: Some(( code: Char('p'), modifiers: "CONTROL")),
          popup_down: Some(( code: Char('n'), modifiers: "CONTROL")),
          page_up: Some(( code: Char('b'), modifiers: "CONTROL")),
          page_down: Some(( code: Char('f'), modifiers: "CONTROL")),
          home: Some(( code: Char('g'), modifiers: "")),
          end: Some(( code: Char('G'), modifiers: "SHIFT")),
          shift_up: Some(( code: Char('K'), modifiers: "SHIFT")),
          shift_down: Some(( code: Char('J'), modifiers: "SHIFT")),

          edit_file: Some(( code: Char('I'), modifiers: "SHIFT")),

          status_reset_item: Some(( code: Char('U'), modifiers: "SHIFT")),

          diff_reset_lines: Some(( code: Char('u'), modifiers: "")),
          diff_stage_lines: Some(( code: Char('s'), modifiers: "")),

          stashing_save: Some(( code: Char('w'), modifiers: "")),
          stashing_toggle_index: Some(( code: Char('m'), modifiers: "")),

          stash_open: Some(( code: Char('l'), modifiers: "")),

          abort_merge: Some(( code: Char('M'), modifiers: "SHIFT")),
      )
      	'';
  };

  programs.helix = {
    enable = true;
    defaultEditor = true;
    package = pkgs-unstable.helix; # evil-helix
    settings = {
      keys.normal = {
        # C-g = [":new" ":insert-output gitui" ":buffer-close!" ":redraw"];
        # C-e = [":new" ":insert-output broot" ":buffer-close!" ":redraw"];
      };
      theme = "catppuccin_mocha";
      editor = {
        gutters = [ "diagnostics" "spacer" "diff" ];
        soft-wrap = { enable = true; };
      };
    };
    extraPackages = [
      pkgs.marksman
      pkgs.nil
      pkgs.gopls
      pkgs.golangci-lint-langserver
      pkgs.delve
      pkgs.clojure-lsp
      pkgs.rust-analyzer
      pkgs.taplo
      pkgs.lldb
      pkgs.vscode-langservers-extracted
      pkgs.yaml-language-server
      pkgs.ansible-language-server
      pkgs.nodePackages.typescript-language-server
    ];
  };

  programs.wezterm = {
    enable = true;
    # extraConfig = ''
    #   local wezterm = require 'wezterm'
    #   local mux = wezterm.mux
    #   local act = wezterm.action
    #   local config = wezterm.config_builder()
    #   config.xcursor_theme = "Adwaita"
    #   config.xcursor_size = 24

    #   config.window_decorations = "RESIZE"
    #   config.hide_tab_bar_if_only_one_tab = true

    #   config.color_scheme = 'Catppuccin Frappe'
    #   config.font_size = 12
    #   config.line_height = 1.2
    #   config.disable_default_key_bindings = true

    #   config.keys = {
    #     { key = 'P', mods = 'CTRL|ALT|SHIFT', action = wezterm.action.ActivateCommandPalette, },
    #     { key = 'L', mods = 'CTRL|ALT|SHIFT', action = wezterm.action.ShowDebugOverlay },
    #   	{ key = 't', mods = 'CTRL|ALT', action = wezterm.action.TogglePaneZoomState, },
    #   	{ key = 'v', mods = 'CTRL|ALT', action = act.SplitVertical{ domain =  'CurrentPaneDomain' } },
    #   	{ key = 's', mods = 'CTRL|ALT', action = act.SplitHorizontal{ domain =  'CurrentPaneDomain' } },
    #     { key = 'h', mods = 'CTRL|ALT', action = act.ActivatePaneDirection 'Left', },
    #     { key = 'j', mods = 'CTRL|ALT', action = act.ActivatePaneDirection 'Down', },
    #     { key = 'k', mods = 'CTRL|ALT', action = act.ActivatePaneDirection 'Up', },
    #     { key = 'l', mods = 'CTRL|ALT', action = act.ActivatePaneDirection 'Right', },
    #   	{ key = 'Enter', mods = 'CTRL|ALT', action = act.ActivateCopyMode },
    #   	{ key = 'y', mods = 'CTRL|ALT', action = act.CopyTo 'Clipboard' },
    #   	{ key = 'p', mods = 'CTRL|ALT', action = act.PasteFrom 'Clipboard' },
    #   }

    #   return config
    #   	'';
  };

  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    nix-direnv.enable = true;
    config = {
      global = {
        load_dotenv = true;
      };
    };
  };

  programs.password-store = { enable = true; };

  programs.ripgrep = { enable = true; };

  programs.fd = { enable = true; };
}
