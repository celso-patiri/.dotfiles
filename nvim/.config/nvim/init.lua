--------------------------------------------------------------------------------------------------------
local Plug = vim.fn['plug#']
vim.call('plug#begin')
    Plug 'github/copilot.vim'
    Plug 'wakatime/vim-wakatime'
    Plug 'tpope/vim-fugitive'

    --Lsp and cmp
    Plug 'neovim/nvim-lspconfig'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-path'
    Plug 'hrsh7th/nvim-cmp'
    Plug ('tzachar/cmp-tabnine', {
        [ 'do' ] = function ()
            local pipe = io.popen("sh", "w")
            pipe:write('./install.sh')
            pipe:close()
        end
    })

    Plug 'simrat39/symbols-outline.nvim'
    Plug 'norcalli/nvim-colorizer.lua'

    --sippets
    Plug 'rafamadriz/friendly-snippets'
    Plug 'L3MON4D3/LuaSnip'
    Plug 'saadparwaiz1/cmp_luasnip'
    Plug 'windwp/nvim-autopairs'

    --Plug 'leafgarland/typescript-vim'
    --Plug 'pangloss/vim-javascript'
    --Plug 'maxmellon/vim-jsx-pretty'
    --Plug 'peitalin/vim-jsx-typescript'
    --Plug 'jparise/vim-graphql'
    --Plug ( 'styled-components/vim-styled-components', { branchs= 'main' } )

    --Themes
    Plug 'gruvbox-community/gruvbox'
    --Plug 'joshdick/onedark.vim'
    Plug 'sainnhe/gruvbox-material'
    Plug 'sainnhe/sonokai'
    Plug 'sainnhe/edge'
    Plug 'navarasu/onedark.nvim'
    Plug 'pacokwon/onedarkhc.vim'
    Plug 'drewtempelmeyer/palenight.vim'
    Plug 'rafalbromirski/vim-aurora'

    Plug 'nvim-lualine/lualine.nvim'
    Plug 'kyazdani42/nvim-web-devicons'
    Plug 'kyazdani42/nvim-tree.lua'

    Plug 'christoomey/vim-tmux-navigator'
    Plug 'preservim/nerdcommenter'

    --Tree sitter
    Plug 'nvim-lua/popup.nvim'
    Plug 'nvim-lua/plenary.nvim'
    Plug ('nvim-treesitter/nvim-treesitter', {
        ['do'] = function()
            vim.cmd(':TSUpdate<cr>')
        end
    })
    --Plug 'romgrk/nvim-treesitter-context'
    Plug 'p00f/nvim-ts-rainbow'

    --Prettier
    Plug 'sbdchd/neoformat'

    --Telescope
    Plug 'nvim-telescope/telescope.nvim'
    Plug 'nvim-telescope/telescope-fzy-native.nvim'

    --Screen
    Plug 'TaDaa/vimade' --Fade background
    --Plug 'Pocco81/TrueZen.nvim' --Focus mode

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

require("surround").setup({ mappings_style = "sandwich", prefix = "<leader>s" })

--disable copilot by default
vim.cmd('autocmd VimEnter * :Copilot disable')

--syntax sync in JSX and TSX files
vim.cmd('autocmd BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart ')
vim.cmd('autocmd BufLeave *.{js,jsx,ts,tsx} :syntax sync clear ')

--Prettier auto format
vim.cmd('autocmd BufWritePre,InsertLeave *.{js,jsx,ts,tsx} Neoformat prettier ')
--vim.cmd('let g:neoformat_try_node_exe = 1 ')


--NerdCommenter - keep selection after tab
vim.cmd('filetype plugin on')

--vim.g['NERDTreeIgnore'] = {'^node_modules$'}
set.encoding = 'UTF-8'

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
--set.guicursor= 'i:block'

--keep undo persistence
vim.cmd[[
  if has('persistent_undo')
    set undofile
    set undodir=$HOME/.vim/undo
  endif
]]
----coc recommendations
set.backup = false
set.writebackup = false
----give more space for displaying messages
set.cmdheight=2
----Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable delays and poor user experience.
set.updatetime=300

