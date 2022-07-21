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

return packer.startup(function(use)
	use("wbthomason/packer.nvim")
	use({ "github/copilot.vim", opt = true, cmd = "Copilot" })
	use("wakatime/vim-wakatime")
	use("tpope/vim-fugitive")
	use("lewis6991/gitsigns.nvim")
	use("nvim-lualine/lualine.nvim")
	use("kyazdani42/nvim-tree.lua")
	use({ "ms-jpq/chadtree", branch = "chad", run = "python3 -m chadtree deps" })

	use("kyazdani42/nvim-web-devicons")

	--performance/fix
	use("lewis6991/impatient.nvim")
	use("antoinemadec/FixCursorHold.nvim")
	use({
		"luukvbaal/stabilize.nvim",
		config = function()
			require("stabilize").setup()
		end,
	})

	--Lsp
	use("neovim/nvim-lspconfig")
	use({
		"SmiteshP/nvim-navic",
		requires = "neovim/nvim-lspconfig",
	})
	use("jose-elias-alvarez/null-ls.nvim")
	use("jose-elias-alvarez/nvim-lsp-ts-utils")
	use("j-hui/fidget.nvim")
	use("folke/trouble.nvim")
	use({
		"simrat39/symbols-outline.nvim",
		opt = true,
		cmd = "SymbolsOutline",
		config = function()
			require("symbols-outline").setup({
				-- disable if your cpu usage is higher than you want it
				highlight_hovered_item = true,
				-- whether to show outline guides
				show_guides = true,
			})
		end,
	})
	--use("williamboman/nvim-lsp-installer")
	-- use("glepnir/lspsaga.nvim")
	-- use("arkav/lualine-lsp-progress")
	-- use("nvim-lua/lsp-status.nvim")

	--cmp
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/nvim-cmp")
	use("hrsh7th/cmp-nvim-lua")
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/cmp-path")
	use({ "tzachar/cmp-tabnine", run = "./install.sh" })
	use("saadparwaiz1/cmp_luasnip")

	--Tree sitter
	use("nvim-lua/popup.nvim")
	use("nvim-lua/plenary.nvim")
	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
	use("nvim-treesitter/nvim-treesitter-textobjects")
	use({
		"romgrk/nvim-treesitter-context",
		config = function()
			require("treesitter-context").setup()
		end,
	})
	use("p00f/nvim-ts-rainbow")
	use("mfussenegger/nvim-ts-hint-textobject")

	--Telescope
	use("nvim-telescope/telescope.nvim")
	use({
		"nvim-telescope/telescope-fzf-native.nvim",
		run = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
	})
	use({
		"ahmedkhalf/project.nvim",
		config = function()
			require("project_nvim").setup({ show_hidden = true })
		end,
	})

	--DAP && Tests
	use("mfussenegger/nvim-dap")
	use({ "nvim-telescope/telescope-dap.nvim" })
	use("theHamsta/nvim-dap-virtual-text")
	use({ "rcarriga/nvim-dap-ui" })
	use({
		"nvim-neotest/neotest",
		requires = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"antoinemadec/FixCursorHold.nvim",
			"haydenmeade/neotest-jest",
		},
		config = function()
			require("neotest").setup({ adapters = {
				require("neotest-jest"),
			} })
		end,
	})

	--sippets
	use({ "L3MON4D3/LuaSnip", requires = { "rafamadriz/friendly-snippets" }, after = "cmp_luasnip" })
	use("rafamadriz/friendly-snippets")

	--Code manipulation and utils
	use({ "mbbill/undotree", opt = true, cmd = "UndotreeToggle" })
	use({ "mg979/vim-visual-multi", branch = "master" }) --Multi cursor
	use("andymass/vim-matchup")
	use("windwp/nvim-autopairs")
	use("tpope/vim-surround")
	use("tpope/vim-repeat")
	use("JoosepAlviste/nvim-ts-context-commentstring")
	use("numToStr/Comment.nvim")
	use({ "rrethy/vim-hexokinase", run = "make hexokinase" })

	--Themes ----------------------------
	-- use("EdenEast/nightfox.nvim")
	-- use("Rigellute/rigel")
	-- use("shaunsingh/moonlight.nvim")

	-- use("sainnhe/gruvbox-material")
	-- use("sainnhe/everforest")

	-- use({ "gruvbox-community/gruvbox" })
	-- use("luisiacc/gruvbox-baby")
	-- use("Mofiqul/dracula.nvim")
	-- use("ful1e5/onedark.nvim")

	use({ "catppuccin/nvim", as = "catppuccin" })
	-- use("sainnhe/sonokai")
	-- use("shaunsingh/nord.nvim")
	-- use("tiagovla/tokyodark.nvim")
	-- use("cpea2506/one_monokai.nvim")

	-- use({ "folke/tokyonight.nvim", branch = "main" })
	-- use("Shatur/neovim-ayu")
	-- use("marko-cerovac/material.nvim")
	-- use("rebelot/kanagawa.nvim")
	--Themes ----------------------------

	--Screen
	use("xiyaowong/nvim-transparent")
	use({
		"folke/zen-mode.nvim",
		config = function()
			require("zen-mode").setup({
				window = {
					width = 135,
				},
			})
		end,
	})

	--markdown
	use({ "ellisonleao/glow.nvim", branchinit = "main", opt = true, cmd = "Glow" }) -- markdown reader
	use({
		"iamcco/markdown-preview.nvim",
		run = function()
			vim.fn["mkdp#util#install"]()
		end,
	})
	use({
		"vimwiki/vimwiki",
		config = function()
			vim.g.vimwiki_list = {
				{
					path = "/home/celso/Documents/vimwiki",
					syntax = "markdown",
					ext = ".md",
				},
			}
		end,
	})
	-- use("tools-life/taskwiki")

	--use 'leafgarland/typescript-vim'
	--use 'pangloss/vim-javascript'
	--use 'maxmellon/vim-jsx-pretty'
	--use 'peitalin/vim-jsx-typescript'
	--use 'jparise/vim-graphql'
	--use ( 'styled-components/vim-styled-components', { branch= 'main' } )

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
