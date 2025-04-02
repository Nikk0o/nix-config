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

  local highlight = {"Purple", "White", "Gray", "Black"}
  local hooks = require "ibl.hooks"
  hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
    vim.api.nvim_set_hl(0, "Purple", {ctermfg = 13})
    vim.api.nvim_set_hl(0, "White",  {ctermfg = 15})
    vim.api.nvim_set_hl(0, "Gray",   {ctermfg = 3})
    vim.api.nvim_set_hl(0, "Black",  {ctermfg = 0})
  end)
  require("ibl").setup {indent = {highlight = highlight, char = "▏"}, scope = {enabled = true}}

  local map = vim.api.nvim_set_keymap
  local opts = {noremap = true, silent = true}
  map('n', '<A-q>', '<Cmd>BufferClose<CR>',    opts)
  for i=1,9 do map('n', '<A-' .. i .. '>', '<Cmd>BufferGoto ' .. i .. '<CR>', opts) end
  vim.cmd[[highlight BufferInactive ctermfg=0]]
  vim.cmd[[highlight TabLine ctermbg=none]]

  require('lualine').setup{options = {theme = '16color'}}
  vim.cmd([[ hi Normal guibg=NONE ctermbg=NONE ]])

  local map = vim.api.nvim_set_keymap
  local opts = { noremap = true, silent = true }

  -- Move to previous/next
  map('n', '<A-Left>', '<Cmd>BufferPrevious<CR>', opts)
  map('n', '<A-Right>', '<Cmd>BufferNext<CR>', opts)

require'alpha'.setup(require'alpha.themes.dashboard'.config)

a

vim.cmd[[colorscheme torte]]

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

