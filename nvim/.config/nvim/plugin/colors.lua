--remove background
--vim.api.nvim_command('autocmd colorscheme * :hi normal guibg=none')
vim.opt.termguicolors = true
--vim.cmd [[silent! colorscheme snow]]

vim.cmd('colorscheme sonokai')

--require('onedark').setup {
    --style = 'darker' --[ dark, darker, cool, deep, warm, warmer ]
--}
--require('onedark').load()

--highlight Normal guibg=none
vim.cmd[[
    let g:edge_style = 'neon'
    let g:edge_better_performance = 1

    let g:gruvbox_invert_selection='0'
    let g:gruvbox_contrast_dark = 'hard'

    highlight ColorColumn ctermbg=0 guibg=grey
    hi ColorColumn guibg=none
    hi SignColumn guibg=none
    hi CursorLineNR guibg=None
    hi CursorLineNR guibg=None

    highlight LineNr guifg=#5eacd3

    highlight netrwDir guifg=#5eacd3
    highlight qfFileName guifg=#aed75f
    hi TelescopeBorder guifg=#5eacd3
]]

vim.cmd[[
      let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
      let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
]]

require 'colorizer'.setup {
  'css';
  'javascript';
  'javascriptreact';
  'typescriptreact';
  'scss';
  'yaml';
  html = {
    mode = 'foreground';
  }
}

