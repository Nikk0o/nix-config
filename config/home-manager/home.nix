{ config, pkgs, lib, ... }:


{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "niko";
  home.homeDirectory = "/home/niko";

  home.shellAliases = {
    rebuild = "sudo nixos-rebuild switch --flake /etc/nixos/#Antares";
    hm-rebuild = "home-manager switch --flake /etc/nixos";
  };

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
	extraLuaConfig = ''
  vim.g.have_nerd_font = false
  vim.opt.number = true
  vim.opt.undofile = true
  vim.opt.signcolumn = 'yes'
  vim.opt.updatetime = 250
  vim.opt.completeopt = menuone

  vim.cmd[[highlight clear SignColumn]]
  vim.cmd[[highlight GitGutterAdd    guifg=#009900 ctermfg=10]]
  vim.cmd[[highlight GitGutterChange guifg=#bbbb00 ctermfg=13]]
  vim.cmd[[highlight GitGutterDelete guifg=#ff2222 ctermfg=9]]

  vim.opt.tabstop = 4
  vim.opt.softtabstop = 4
  vim.opt.shiftwidth = 4

  vim.cmd('filetype plugin indent on')

  local map = vim.api.nvim_set_keymap
  local opts = {noremap = true, silent = true}
  map('n', '<A-q>', '<Cmd>BufferClose<CR>',    opts)
  for i=1,9 do map('n', '<A-' .. i .. '>', '<Cmd>BufferGoto ' .. i .. '<CR>', opts) end
  vim.cmd[[highlight BufferInactive ctermfg=0]]
  vim.cmd[[highlight TabLine ctermbg=none]]

  require('lualine').setup{options = {theme = '16color'}}
  vim.cmd[[colorscheme lunaperche]]
  vim.cmd([[ hi Normal guibg=NONE ctermbg=NONE ]])

  local map = vim.api.nvim_set_keymap
  local opts = { noremap = true, silent = true }

  -- Move to previous/next
  map('n', '<A-Left>', '<Cmd>BufferPrevious<CR>', opts)
  map('n', '<A-Right>', '<Cmd>BufferNext<CR>', opts)

require'alpha'.setup(require'alpha.themes.dashboard'.config)

local parser_install_dir = vim.fn.stdpath("cache") .. "/treesitters"
vim.fn.mkdir(parser_install_dir, "p")

require('nvim-treesitter.configs').setup {
  highlight = {
	  enabled = true,
  },

  ensure_installed = { "asm", "c", "haskell", "nix", "rust", "verilog" },
  parser_install_dir = parser_install_dir;
}

local on_attach = function(client, bufnr)
	vim.lsp.inlay_hint.enable(true, {bufnr = bufnr})
end

vim.g.rustaceanvim = {
	server = {
		cmd = {'${pkgs.rust-analyzer}/bin/rust-analyzer'},
		on_attach = on_attach
	}
}

vim.lsp.enable('clanged')

require("nvim-tree").setup()
vim.api.nvim_create_autocmd('VimEnter', {command = "TSEnable highlight"})

require("nvim-tree").setup()
vim.api.nvim_create_autocmd('VimEnter', {command = "NvimTreeOpen"})

require'nvim-web-devicons'.setup()
local dashboard = require("alpha.themes.dashboard")
dashboard.section.header.val = {
[[                                                       ,  ,                      ]],
[[                                                      / \/ \                     ]],
[[                                                     (/ //_ \_                   ]],
[[       .-._                                           \||  .  \                  ]],
[[        \  '-._                                 _,:__.-"/---\_ \                 ]],
[[   ______/___  '.      •═══════════════════════'~-'--.)__( , )\ \                ]],
[[  `'--.___  _\  /      ║   • ▪  •   .  ▪  .  . •  ,'(/    \)║\\`\|               ]],
[[       /_.-' _\ \    _:,_ .  . .▄▄▄•  , •  ▌  ▌·  •▐"  ▐·  "║||  )               ]],
[[        .'__ _.' \'-/,`-~` ▐  ▄ ▀▄.▀ ▪  · ▪█·█▌ ▪ ·██ ▐██▪  ║/                   ]],
[[           '. ___.> /=,║  ·█▌▐█ ▐▀▀ .▄█▀▄ ▐█ █•▐█·▐█ ▌▐▌▐   ║                    ]],
[[            / .-'/_ )  ║• ▐█▐▐▌ █▄▄▌▐█▌.▐▌ ███ ▐█ ▐█ ██▌▐▌· ║                    ]],
[[            )'  (/ (/  ║  ▐█▐█▌. ▀▀  ▀█▄▀•. ▀  ▐█▌▐▀ ▐▌  ▌  ║                    ]],
[[             __//"  "  ║▪  ▀ ▀▪  •  .   ▪   . • ▀▀▪ •   ▪  •║                    ]],
[[                       •════════════════════════════════════•                    ]],
}
'';

};

  imports = [ ];

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
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
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
