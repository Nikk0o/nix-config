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

  -- ensure_installed = { "asm", "c", "haskell", "nix", "rust", "verilog" },
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
