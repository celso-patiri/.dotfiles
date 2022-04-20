--------------------------------------------------------------------------------------------------------
local Plug = vim.fn["plug#"]
vim.call("plug#begin")

Plug("github/copilot.vim")
Plug("wakatime/vim-wakatime")
Plug("tpope/vim-fugitive")
Plug("lewis6991/gitsigns.nvim")
Plug("christoomey/vim-tmux-navigator")

--Lsp
Plug("neovim/nvim-lspconfig")
--Plug("williamboman/nvim-lsp-installer")
Plug("glepnir/lspsaga.nvim")
Plug("SmiteshP/nvim-gps")
Plug("j-hui/fidget.nvim")

--cmp
Plug("hrsh7th/cmp-nvim-lsp")
Plug("hrsh7th/nvim-cmp")
Plug("hrsh7th/cmp-nvim-lua")
Plug("hrsh7th/cmp-buffer")
Plug("hrsh7th/cmp-path")
Plug("tzachar/cmp-tabnine", {
	["do"] = function()
		local pipe = io.popen("sh", "w")
		pipe:write("./install.sh")
		pipe:close()
	end,
})
Plug("saadparwaiz1/cmp_luasnip")

--sippets
Plug("L3MON4D3/LuaSnip")
Plug("rafamadriz/friendly-snippets")

Plug("simrat39/symbols-outline.nvim")
Plug("norcalli/nvim-colorizer.lua")

--Plug 'leafgarland/typescript-vim'
--Plug 'pangloss/vim-javascript'
--Plug 'maxmellon/vim-jsx-pretty'
--Plug 'peitalin/vim-jsx-typescript'
--Plug 'jparise/vim-graphql'
--Plug ( 'styled-components/vim-styled-components', { branchs= 'main' } )

--Themes
Plug("ellisonleao/gruvbox.nvim")
--Plug("gruvbox-community/gruvbox")
Plug("sainnhe/gruvbox-material")
Plug("sainnhe/sonokai")
Plug("tanvirtin/monokai.nvim")
Plug("sainnhe/edge")
Plug("navarasu/onedark.nvim")
Plug("bluz71/vim-nightfly-guicolors")
Plug("shaunsingh/nord.nvim")
Plug("EdenEast/nightfox.nvim")
Plug("Mofiqul/dracula.nvim")
Plug("folke/tokyonight.nvim", { branch = "main" })
Plug("nvim-lualine/lualine.nvim")
Plug("kyazdani42/nvim-web-devicons")
Plug("kyazdani42/nvim-tree.lua")

--Tree sitter
Plug("nvim-lua/popup.nvim")
Plug("nvim-lua/plenary.nvim")
Plug("nvim-treesitter/nvim-treesitter", {
	["do"] = function()
		vim.cmd(":TSUpdate<cr>")
	end,
})
--Plug 'romgrk/nvim-treesitter-context'
Plug("p00f/nvim-ts-rainbow")

--Prettier
Plug("sbdchd/neoformat")

--Telescope
Plug("nvim-telescope/telescope.nvim")
Plug("nvim-telescope/telescope-fzy-native.nvim")

--Screen
Plug("TaDaa/vimade") --Fade background
Plug("xiyaowong/nvim-transparent")
Plug("ellisonleao/glow.nvim", { branchinit = "main" })
--Plug 'Pocco81/TrueZen.nvim' --Focus mode

--Code manipulation and utils
Plug("mg979/vim-visual-multi", { branch = "master" }) --Multi cursor
Plug("andymass/vim-matchup")
Plug("windwp/nvim-autopairs")
Plug("ur4ltz/surround.nvim")
Plug("tpope/vim-surround")
Plug("JoosepAlviste/nvim-ts-context-commentstring")
Plug("numToStr/Comment.nvim")
--Plug 'tpope/vim-sleuth'

vim.call("plug#end")

-----------------------------------------------------------------------------------------------------------

vim.g.mapleader = " "
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

--smart comments
vim.cmd("filetype plugin on")
require("nvim-treesitter.configs").setup({ context_commentstring = { enable = true } })

--disable copilot by default
vim.cmd("autocmd VimEnter * :Copilot disable")

--syntax sync in JSX and TSX files
vim.cmd("autocmd BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart ")
vim.cmd("autocmd BufLeave *.{js,jsx,ts,tsx} :syntax sync clear ")

--Prettier auto format
vim.cmd("autocmd BufWritePre *.{js,jsx,ts,tsx} Neoformat prettier ")
vim.cmd("autocmd BufWritePre *.lua Neoformat stylua")
--vim.cmd('let g:neoformat_try_node_exe = 1 ')

--NerdCommenter - keep selection after tab
vim.cmd("filetype plugin on")

--vim.g['NERDTreeIgnore'] = {'^node_modules$'}
set.encoding = "UTF-8"
-- set.mouse = "a"

set.smarttab = true
set.cindent = true
set.tabstop = 4
set.shiftwidth = 4
set.expandtab = true --always uses spaces instead of tab characters
set.scrolloff = 8

set.hidden = true
set.swapfile = false

set.incsearch = true
set.relativenumber = true
set.number = true

set.signcolumn = "yes"
--set.guicursor= 'i:block'

--keep undo persistence
vim.cmd([[
  if has('persistent_undo')
    set undofile
    set undodir=$HOME/.vim/undo
  endif
]])
----coc recommendations
set.backup = false
set.writebackup = false
----give more space for displaying messages
set.cmdheight = 2
----Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable delays and poor user experience.
set.updatetime = 300
