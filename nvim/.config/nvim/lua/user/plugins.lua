local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

-- Install your plugins here
return packer.startup(function(use)
	use("wbthomason/packer.nvim")
	use({ "github/copilot.vim", opt = true, cmd = "Copilot" })
	use("wakatime/vim-wakatime")
	use("tpope/vim-fugitive")
	use("lewis6991/gitsigns.nvim")
	use("akinsho/toggleterm.nvim")
	-- use("christoomey/vim-tmux-navigator")

	--performance/fix
	use("lewis6991/impatient.nvim")
	use("antoinemadec/FixCursorHold.nvim")
	use({
		"luukvbaal/stabilize.nvim",
		config = function()
			require("stabilize").setup()
		end,
	})

	use("kyazdani42/nvim-web-devicons")
	use("kyazdani42/nvim-tree.lua")
	use("akinsho/bufferline.nvim")
	use("nvim-lualine/lualine.nvim")
	-- use("tamton-aquib/staline.nvim")

	--Lsp
	--use("williamboman/nvim-lsp-installer")
	-- use("glepnir/lspsaga.nvim")
	-- use("arkav/lualine-lsp-progress")
	use("neovim/nvim-lspconfig")
	use({
		"SmiteshP/nvim-gps",
		config = function()
			require("nvim-gps").setup()
		end,
	})
	use("jose-elias-alvarez/null-ls.nvim")
	use("jose-elias-alvarez/nvim-lsp-ts-utils")
	use("j-hui/fidget.nvim")
	-- use("nvim-lua/lsp-status.nvim")
	-- use({ "stevearc/dressing.nvim" })

	--cmp
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/nvim-cmp")
	use("hrsh7th/cmp-nvim-lua")
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/cmp-path")
	use({ "tzachar/cmp-tabnine", run = "./install.sh" })
	use("saadparwaiz1/cmp_luasnip")

	--sippets
	use("L3MON4D3/LuaSnip")
	use("rafamadriz/friendly-snippets")

	use("simrat39/symbols-outline.nvim")
	use("norcalli/nvim-colorizer.lua")

	--use 'leafgarland/typescript-vim'
	--use 'pangloss/vim-javascript'
	--use 'maxmellon/vim-jsx-pretty'
	--use 'peitalin/vim-jsx-typescript'
	--use 'jparise/vim-graphql'
	--use ( 'styled-components/vim-styled-components', { branch= 'main' } )

	--Themes
	-- use("navarasu/onedark.nvim")
	-- use("EdenEast/nightfox.nvim")
	-- use("sainnhe/gruvbox-material")
	-- use("sainnhe/everforest")
	-- use("ellisonleao/gruvbox.nvim")
	-- use("wadackel/vim-dogrun")
	use({ "gruvbox-community/gruvbox" })
	use("sainnhe/edge")
	use("sainnhe/sonokai")
	use("olimorris/onedarkpro.nvim")
	use("ful1e5/onedark.nvim")
	use("shaunsingh/nord.nvim")
	use("Mofiqul/dracula.nvim")
	use({ "folke/tokyonight.nvim", branch = "main" })
	use("martinsione/darkplus.nvim")

	--Tree sitter
	--use 'romgrk/nvim-treesitter-context'
	use("nvim-lua/popup.nvim")
	use("nvim-lua/plenary.nvim")
	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
	use("nvim-treesitter/nvim-treesitter-textobjects")
	use({
		"romgrk/nvim-treesitter-context",
		config = function()
			require("treesitter-context.config").setup({ enable = true })
		end,
	})
	use({
		"folke/twilight.nvim",
		config = function()
			require("twilight").setup({})
		end,
	})
	use("p00f/nvim-ts-rainbow")
	use("mfussenegger/nvim-ts-hint-textobject")

	--Prettier
	-- use("sbdchd/neoformat")

	--Telescope
	use("nvim-telescope/telescope.nvim")
	use("nvim-telescope/telescope-fzy-native.nvim")
	use({
		"ahmedkhalf/project.nvim",
		config = function()
			require("project_nvim").setup({ show_hidden = true })
		end,
	})
	use("dhruvmanila/telescope-bookmarks.nvim")

	--Screen
	-- use("TaDaa/vimade") --Fade background
	use("xiyaowong/nvim-transparent")
	use({ "ellisonleao/glow.nvim", branchinit = "main", opt = true, cmd = "Glow" }) -- markdown reader

	--Code manipulation and utils
	use({ "mg979/vim-visual-multi", branch = "master" }) --Multi cursor
	use("andymass/vim-matchup")
	use("windwp/nvim-autopairs")
	use({
		"ur4ltz/surround.nvim",
		config = function()
			require("surround").setup({ mappings_style = "sandwich", prefix = "<leader>s" })
		end,
	})
	use("tpope/vim-surround")
	use("JoosepAlviste/nvim-ts-context-commentstring")
	use("numToStr/Comment.nvim")
	--use 'tpope/vim-sleuth'

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
