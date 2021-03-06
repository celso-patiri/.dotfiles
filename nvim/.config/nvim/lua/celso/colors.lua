--remove background
require("transparent").setup({
	enable = true,
})

--vim.api.nvim_command('autocmd colorscheme * :hi normal guibg=none ')
vim.opt.termguicolors = true
vim.cmd("let $NVIM_TUI_ENABLE_TRUE_COLOR = 1")
-- vim.opt.background = "dark"

--Theme specific customizations
vim.g.sonokai_style = "atlantis" -- Sonokai: 'default', 'atlantis', 'andromeda', 'shusia', 'maia', 'espresso'
vim.g.catppuccin_flavour = "frappe" -- latte, frappe, macchiato, mocha
vim.g.material_style = "palenight"
vim.g.gruvbox_invert_selection = "0"
vim.g.gruvbox_contrast_dark = "soft"
vim.g.everforest_background = "hard"
vim.g.tokyonight_style = "night"

vim.cmd([[silent! colorscheme catppuccin]])

--highlight ColorColumn ctermbg=0 guibg=grey
--hi Normal guibg=none ctermbg=none
-- hi ColorColumn guibg=none
-- hi SignColumn guibg=none
-- hi CursorLineNR guibg=None
-- hi CursorLineNR guibg=None
-- hi LineNr guibg=none
-- highlight netrwDir guifg=#5eacd3
-- highlight qfFileName guifg=#aed75f
-- hi TelescopeBorder guifg=#5eacd3
vim.cmd([[
    highlight LineNr guifg=#5eacd3
    hi Visual guibg=#51576D 
]])

vim.cmd([[
      let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
      let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
]])
