{
	programs.neovim = {
	enable = true;
	vimAlias = true;
	viAlias = true;
	plugins = with pkgs.vimPlugins; [
		(nvim-treesitter.withPlugins (plugins: pkgs.tree-sitter.allGrammars))
		vim-gitgutter
		indent-blankline-nvim
		lualine-nvim
		alpha-nvim
		barbar-nvim
		nvim-web-devicons
		lsp_signature-nvim
		nvim-lspconfig
		nerdtree
		nvim-tree-lua
	];
	let configPath = "/etc/nixos/config/programs";
	in home.file."${config.xdg.configHome}/nvim/init.lua" = {
		source = mkForce (config.lib.file.mkOutOfStoreSymlink "${configPath}/init.lua");
	};
}
