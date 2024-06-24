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
  package = pkgs.emacs-gtk;
	extraPackages = epkgs: [
		epkgs.nix-mode
    epkgs.just-mode
    epkgs.markdown-mode
    epkgs.dockerfile-mode
    epkgs.clojure-mode
    epkgs.cider
    epkgs.clay
    epkgs.pass
    epkgs.helpful
    epkgs.elisp-demos
    epkgs.dired-hide-dotfiles
    epkgs.denote
    epkgs.wgrep
    epkgs.nov
    epkgs.which-key
    epkgs.vterm
    epkgs.corfu
    epkgs.vertico
    epkgs.marginalia
    epkgs.orderless
    epkgs.apheleia
    epkgs.envrc
    epkgs.tldr
    epkgs.gptel
    epkgs.git-timemachine
    epkgs.justl
    epkgs.lsp-mode
    epkgs.dap-mode
    epkgs.yasnippet
    epkgs.go-mode
	];
	extraConfig = ''
		(use-package nix-mode
		:mode "\\.nix\\'")
		
		(use-package emacs
		:custom
		(use-package-enable-imenu-support t)
		(use-package-always-ensure nil) ; always use nix as package manager
		(global-subword-mode t)
		(global-superword-mode t)
		(electric-pair-mode t)
		(line-spacing 0.2)
		(indent-tabs-mode nil)
		(custom-file (concat user-emacs-directory "custom.el"))
		(auto-save-default nil)
		(backup-by-copying t)
		(create-lockfiles nil)
		(version-control t)
		(delete-old-versions t)
		(kept-new-versions 20)
		(kept-old-versions 5)
		(global-visual-line-mode t)
		(scroll-margin 0)
    (hscroll-margin 1)
    (savehist-mode t)
    (disabled-command-function nil)
    (mark-ring-max 6)
    (global-mark-ring-max 8)
    (set-mark-command-repeat-pop t)
    (switch-to-buffer-obey-display-actions t)
    (inhibit-startup-message t)
    (set-fringe-mode 10)
    (visible-bell t)
    (use-short-answers t)
    (help-window-select t)
    (scroll-bar-mode nil)
    (tool-bar-mode nil)
    (tooltip-mode nil)
    (menu-bar-mode nil)
    (scroll-bar-mode nil)
    (tool-bar-mode nil)
    (blink-cursor-mode nil)
    (read-extended-command-predicate #'command-completion-default-include-p)
		:bind
		(("M-i" . imenu)
		("M-o" . other-window))
		:config
    (setq backup-directory-alist (list (cons "." (concat user-emacs-directory "backup"))))
		(load-theme 'modus-operandi)
		(set-face-attribute 'default nil :font "JetBrains Mono-12"))

		(use-package vertico
    :config
    (vertico-mode +1)
    (setq vertico-cycle t))

    (use-package which-key
    :config
    (which-key-mode))

    (use-package corfu
    :custom
    (corfu-cycle t)
    (corfu-auto t)
    :config
    (global-corfu-mode))

    (use-package orderless
    :config
    (setq completion-styles '(orderless)))

    (use-package marginalia
    :config
    (marginalia-mode))

    (use-package project
    :custom
    (project-vc-extra-root-markers '(".project"))
    :preface
    (defun my/project-refresh ()
    (interactive)
    (project-remember-projects-under "~/repos" t)))

    (use-package clojure-mode)
    (use-package cider)
    (use-package clay)

    (use-package apheleia
    :config
    (apheleia-global-mode +1))

    (use-package envrc
    :hook (after-init . envrc-global-mode))

    (use-package tldr)

    (use-package gptel
    :preface
    (defun my/read-openai-key ()
    (with-temp-buffer
    (insert-file-contents "~/.key.txt")
    (string-trim (buffer-string))))

    :bind (("C-c C-j" . gptel-send))
    :custom
    (gptel-model "gpt-4o")
    (gptel-default-mode 'org-mode)
    (gptel-api-key #'my/read-openai-key))

    (use-package markdown-mode)

    (use-package vterm
    :bind
    ((:map project-prefix-map ("s" . vterm))))
    (use-package git-timemachine)

    (use-package just-mode)
    (use-package go-mode)
    (use-package dockerfile-mode)

    (use-package justl
    :config
    (setq justl-per-recipe-buffer t)
    :bind
    (:map project-prefix-map ("j" . justl)))

    (use-package wgrep)

    (use-package nov
    :ensure t
    :mode ("\\.epub\\'" . nov-mode))

    (use-package org
    :straight nil
    :bind (("C-c C-n n" . org-capture)
    ("C-c C-n a" . org-agenda))
    :config
    (setq org-agenda-files '("~/org"))
    (setq org-agenda-start-with-log-mode 't)
    (setq org-log-done 'note)
    (setq org-capture-templates
    '(("t" "Todo" entry
    (file+headline "~/org/todo.org" "Tasks")
    "* TODO %?\n  %i\n  %a"
    :prepen t))))

    (use-package denote
    :after org
    :config
    (setq denote-directory (expand-file-name "~/org"))
    (setq denote-known-keywords '("konowledge" "meeting"))
    (add-to-list 'org-capture-templates
    '("n" "New note (with Denote)" plain
    (file denote-last-path)
    #'denote-org-capture
    :no-save t
    :immediate-finish nil
    :kill-buffer t
    :jump-to-captured t)))
    (use-package dired-hide-dotfiles
    :hook
    (dired-mode . dired-hide-dotfiles-mode)
    :bind
    (:map dired-mode-map ("." . dired-hide-dotfiles-mode)))

    (use-package helpful
    :bind (("C-h f" . #'helpful-callable)
    ("C-h v" . #'helpful-variable)
    ("C-h k" . #'helpful-key)
    ("C-c C-d" . #'helpful-at-point) ; Maybe this should go in to elisp local map?
    ("C-h F" . #'helpful-function)))

    (use-package elisp-demos
    :after helpful
    :config
    (advice-add 'helpful-update :after #'elisp-demos-advice-helpful-update))

    (use-package ibuffer
    :config
    (define-key global-map [remap list-buffers] #'ibuffer))

    (use-package pass)

    (use-package lsp-mode
    :init
    ;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
    (setq lsp-keymap-prefix "C-c l")
    :hook (;; replace XXX-mode with concrete major-mode(e. g. python-mode)
    (XXX-mode . lsp)
    ;; if you want which-key integration
    (lsp-mode . lsp-enable-which-key-integration))
    :commands lsp)

    (use-package dap-mode)
    (use-package dap-dlv-go) ; debugger for go

    (use-package yasnippet) ; required by lsp-mode
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
