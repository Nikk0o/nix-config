{ config, pkgs, lib, ... }:
{
  home.username = "niko";
  home.homeDirectory = "/home/niko";

  programs.neovim = {
	enable = true;
	vimAlias = true;
	viAlias = true;
	plugins = with pkgs.vimPlugins; [
		(nvim-treesitter.withPlugins (p: [ p.c p.java p.nix p.python p.vim p.lua p.asm p.haskell p.rust p.verilog ]))
		vim-gitgutter
		indent-blankline-nvim
		lualine-nvim
		alpha-nvim
		barbar-nvim
		nvim-web-devicons
		lsp_signature-nvim
		nvim-lspconfig
		nvim-tree-lua
		rustaceanvim
	];
	extraLuaConfig = builtins.readFile ../other_files/init.lua;
};

  imports = [ ];

  wayland.windowManager.hyprland = {
  	enable = true;

		extraConfig = lib.readFile ../other_files/hyprland.conf;
  };

	services.hyprpaper.settings = {
		preload = [
			"/home/niko/Wallpapers/Buizilla-feet.jpg"
		];

		wallpaper = [
			"eDP-1,/home/niko/Wallpapers/Buizilla-feet.jpg"
		];
	};

  services.hypridle = {
    enable = true;
    settings = {
      general = {
        before_sleep_cmd = "loginctl lock-session";
	lock_cmd = "pidof hyprlock || hyprlock";
      };
      listener = [
        {
         timeout = 150;
	 on-timeout = "brightnessctl -s set 10";
         on-resume = "brightnessctl -r";
	}
	{
	 timeout = 300;
	 on-timeout = "systemctl suspend";
	}
      ];
    };
  };

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
 # # environment.
  home.packages = with pkgs; [
    xorg.libX11
    htop
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/niko/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
