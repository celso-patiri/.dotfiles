--remove background
vim.api.nvim_command('autocmd colorscheme * :hi normal guibg=none')
vim.opt.termguicolors = true
vim.cmd [[silent! colorscheme snow]]

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
  'scss';
  html = {
    mode = 'foreground';
  }
}

