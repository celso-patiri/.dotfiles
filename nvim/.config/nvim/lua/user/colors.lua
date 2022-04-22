--Specific theme customizations
--vim.g.tokyonight_style = "night"
vim.cmd([[
    "let g:edge_style = 'neon'
    "let g:edge_better_performance = 1
    "let g:gruvbox_invert_selection='0'
    "let g:gruvbox_contrast_dark = 'hard'
]])

--remove background
require("transparent").setup({
	enable = true,
})
--vim.api.nvim_command('autocmd colorscheme * :hi normal guibg=none ')
vim.opt.termguicolors = true
vim.cmd("let $NVIM_TUI_ENABLE_TRUE_COLOR = 1")
-- vim.opt.background = "dark"

map("n", "<leader>tr", ":TransparentToggle<cr>:hi LineNR guifg=#5eacd3<cr>")
vim.cmd([[silent! colorscheme gruvbox-material]])

--highlight ColorColumn ctermbg=0 guibg=grey
--hi Normal guibg=none ctermbg=none
vim.cmd([[
    hi ColorColumn guibg=none
    hi SignColumn guibg=none
    hi CursorLineNR guibg=None
    hi CursorLineNR guibg=None

    hi LineNr guibg=none
    highlight LineNr guifg=#5eacd3

    highlight netrwDir guifg=#5eacd3
    highlight qfFileName guifg=#aed75f
    hi TelescopeBorder guifg=#5eacd3

]])

vim.cmd([[
      let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
      let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
]])

require("colorizer").setup({
	"css",
	"javascript",
	"javascriptreact",
	"typescriptreact",
	"scss",
	"yaml",
	html = {
		mode = "foreground",
	},
})
