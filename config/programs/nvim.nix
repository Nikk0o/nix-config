{
	programs.neovim = {
	enable = true;
	vimAlias = true;
	viAlias = true;
	plugins = with pkgs.vimPlugins; [
		nvim-treesitter.withPlugins = (p: [ p.c p.nix p.vim p.verilog ])
		vim-gitgutter
		indent-blankline-nvim
		lualine-nvim
		alpha-nvim
		barbar-nvim
		nvim-web-devicons
		lsp_signature-nvim
		nvim-lspconfig
	];

}
