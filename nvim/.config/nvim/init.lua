---------------------------------------------------------------------------------------------------------
local Plug = vim.fn['plug#']
vim.call('plug#begin')

    Plug 'github/copilot.vim'
    Plug 'wakatime/vim-wakatime'
    Plug 'tpope/vim-fugitive'

    Plug 'neovim/nvim-lspconfig'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-path'
    Plug 'hrsh7th/nvim-cmp'

    Plug 'L3MON4D3/LuaSnip'

    --COC
    --Plug 'dense-analysis/ale'
    --Plug('neoclide/coc.nvim', { branch= 'release' })
    --Plug 'leafgarland/typescript-vim'
    --Plug 'pangloss/vim-javascript'
    --Plug 'maxmellon/vim-jsx-pretty'
    --Plug 'peitalin/vim-jsx-typescript'
    --Plug 'jparise/vim-graphql'
    --Plug ( 'styled-components/vim-styled-components', { branchs= 'main' } )

    --Plug 'ryanoasis/vim-devicons'
    --FileTree 
    --Plug 'scrooloose/nerdtree' 
    --Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
    --Plug 'Xuyuanp/nerdtree-git-plugin'

    Plug 'mattn/emmet-vim'
    Plug 'norcalli/nvim-colorizer.lua'

    Plug 'gruvbox-community/gruvbox'
    Plug 'joshdick/onedark.vim'

    Plug 'nvim-lualine/lualine.nvim'
    Plug 'kyazdani42/nvim-web-devicons'
    Plug 'kyazdani42/nvim-tree.lua'

    Plug 'christoomey/vim-tmux-navigator' 
    Plug 'preservim/nerdcommenter'
    
    --Telescope
    Plug 'nvim-lua/popup.nvim'
    Plug 'nvim-lua/plenary.nvim'
    Plug ('nvim-treesitter/nvim-treesitter', {
    ['do'] = function()
      vim.cmd(':TSUpdate')
    end
    })
    Plug 'nvim-telescope/telescope.nvim'
    Plug 'nvim-telescope/telescope-fzy-native.nvim'

    --Screen
    Plug 'TaDaa/vimade' --Fade background
    Plug 'Pocco81/TrueZen.nvim' --Focus mode

    --Code manipulation
    Plug ('mg979/vim-visual-multi', { branch = 'master' }) --Multi cursor
    Plug 'ur4ltz/surround.nvim' 

vim.call('plug#end')

-----------------------------------------------------------------------------------------------------------

vim.g.mapleader = ' '
local set = vim.opt

function map(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

---------------------------------------------------------------------------------------------------------

require("surround").setup{}

--disable copilot by default
vim.cmd('autocmd VimEnter * :Copilot disable')

--syntax sync in JSX and TSX files
vim.cmd('autocmd BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart ')
vim.cmd('autocmd BufLeave *.{js,jsx,ts,tsx} :syntax sync clear ')

--NerdCommenter - keep selection after tab
vim.cmd('filetype plugin on')

--vim.g['NERDTreeIgnore'] = {'^node_modules$'}
set.encoding = 'UTF-8'
vim.cmd('colorscheme gruvbox')

set.smarttab = true
set.cindent = true
set.tabstop = 4
set.shiftwidth = 4
set.expandtab = true  --always uses spaces instead of tab characters
set.scrolloff = 8

set.hidden = true
set.swapfile = false

set.incsearch = true
set.relativenumber = true
set.number = true

set.signcolumn = 'yes'
set.guicursor= 'i:block'

--remove background
--vim.api.nvim_command('autocmd colorscheme * :hi normal guibg=none')
vim.o.termguicolors = true
--vim.cmd [[silent! colorscheme snow]]

--keep undo persistence
vim.cmd[[
  if has('persistent_undo')      
    set undofile                
    set undodir=$HOME/.vim/undo
  endif     
]]
