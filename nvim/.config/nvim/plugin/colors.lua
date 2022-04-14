--remove background
vim.api.nvim_command('autocmd colorscheme * :hi normal guibg=none')
vim.opt.termguicolors = true
vim.cmd [[silent! colorscheme snow]]

vim.cmd('colorscheme gruvbox')

vim.cmd[[
    let g:gruvbox_contrast_dark = 'hard'
    let g:gruvbox_invert_selection='0'

    highlight ColorColumn ctermbg=0 guibg=grey
    hi SignColumn guibg=none
    hi CursorLineNR guibg=None
    hi CursorLineNR guibg=None
    highlight Normal guibg=none

    highlight LineNr guifg=#5eacd3

    highlight netrwDir guifg=#5eacd3
    highlight qfFileName guifg=#aed75f
    hi TelescopeBorder guifg=#5eacd3
]]


vim.cmd[[
    if exists('+termguicolors')
      let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
      let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
endif

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

