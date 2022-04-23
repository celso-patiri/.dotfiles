local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
	return
end

local handlers = require("user.lsp.handlers")

lspconfig.tsserver.setup(handlers.config())
lspconfig.eslint.setup({ handlers.config() })

--lspconfig.graphql.setup{ handlers.config() }
--lspconfig.tailwindcss.setup{ handlers.config() }
--lspconfig.emmet_ls.setup( handlers.config( { filetypes = {"html", "javascript", "javascriptreact", "typescriptreact"}}) )
--lspconfig.dockerls.setup{ handlers.config() }
--lspconfig.cssls.setup( handlers.config( { filetypes = { "css", "scss", "javascript", "javascriptreact", "typescriptreact" }}) )

--jsonlsp---------------------------------------------------------------------------------------------------------------
lspconfig.jsonls.setup(handlers.config({
	settings = {
		json = {
			schemas = require("user.lsp.settings.json-lsp-schemas"),
		},
	},
	setup = {
		commands = {
			Format = {
				function()
					vim.lsp.buf.range_formatting({}, { 0, 0 }, { vim.fn.line("$"), 0 })
				end,
			},
		},
	},
}))
--jsonlsp---------------------------------------------------------------------------------------------------------------

--sumneko lua lsp--------------------------------------------------------------------------------------------------------
local sumneko = require("user.lsp.settings.sumneko-lsp")
lspconfig.sumneko_lua.setup(handlers.config({
	cmd = { sumneko.binary, "-E", sumneko.root .. "/main.lua" },
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
				path = sumneko.lua_runtime,
			},
			diagnostics = { globals = { "vim" } },
			workspace = { library = vim.api.nvim_get_runtime_file("", true) },
			telemetry = { enable = false },
		},
	},
}))
--sumneko lua lsp--------------------------------------------------------------------------------------------------------

handlers.setup()

require("user.lsp.null-ls")

require("dressing").setup({
	input = {
		-- Set to false to disable the vim.ui.input implementation
		enabled = true,

		-- Default prompt string
		default_prompt = "Input:",

		-- Can be 'left', 'right', or 'center'
		prompt_align = "left",

		-- When true, <Esc> will close the modal
		insert_only = true,

		-- These are passed to nvim_open_win
		anchor = "SW",
		border = "rounded",
		-- 'editor' and 'win' will default to being centered
		relative = "cursor",

		-- These can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
		prefer_width = 40,
		width = nil,
		-- min_width and max_width can be a list of mixed types.
		-- min_width = {20, 0.2} means "the greater of 20 columns or 20% of total"
		max_width = { 140, 0.9 },
		min_width = { 20, 0.2 },

		-- Window transparency (0-100)
		winblend = 10,
		-- Change default highlight groups (see :help winhl)
		winhighlight = "",

		override = function(conf)
			-- This is the config that will be passed to nvim_open_win.
			-- Change values here to customize the layout
			return conf
		end,

		-- see :help dressing_get_config
		get_config = nil,
	},
	select = {
		-- Set to false to disable the vim.ui.select implementation
		enabled = true,

		-- Priority list of preferred vim.select implementations
		backend = { "telescope", "fzf_lua", "fzf", "builtin", "nui" },

		-- Options for telescope selector
		-- These are passed into the telescope picker directly. Can be used like:
		-- telescope = require('telescope.themes').get_ivy({...})
		telescope = nil,

		-- Options for built-in selector
		builtin = {
			-- These are passed to nvim_open_win
			anchor = "NW",
			border = "rounded",
			-- 'editor' and 'win' will default to being centered
			relative = "editor",

			-- Window transparency (0-100)
			winblend = 10,
			-- Change default highlight groups (see :help winhl)
			winhighlight = "",

			-- These can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
			-- the min_ and max_ options can be a list of mixed types.
			-- max_width = {140, 0.8} means "the lesser of 140 columns or 80% of total"
			width = nil,
			max_width = { 140, 0.8 },
			min_width = { 40, 0.2 },
			height = nil,
			max_height = 0.9,
			min_height = { 10, 0.2 },

			override = function(conf)
				-- This is the config that will be passed to nvim_open_win.
				-- Change values here to customize the layout
				return conf
			end,
		},

		-- Used to override format_item. See :help dressing-format
		format_item_override = {},

		-- see :help dressing_get_config
		get_config = nil,
	},
})
