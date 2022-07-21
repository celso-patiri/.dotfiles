local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
	return
end

local handlers = require("celso.lsp.handlers")

lspconfig.tsserver.setup(handlers.tsconfig())
lspconfig.solargraph.setup(handlers.config())

lspconfig.cssls.setup(handlers.config({ filetypes = { "css", "scss" } }))
lspconfig.tailwindcss.setup({ handlers.config() })
-- lspconfig.volar.setup(handlers.config({ filetypes = { "vue" } }))
lspconfig.vuels.setup(handlers.vuels_config())
-- lspconfig.vuels.setup(handlers.config())

lspconfig.emmet_ls.setup(handlers.config({ filetypes = { "html", "javascriptreact", "typescriptreact" } }))

-- lspconfig.eslint.setup(handlers.config())lsp

--lspconfig.graphql.setup{ handlers.config() }
lspconfig.dockerls.setup({ handlers.config() })
lspconfig.bashls.setup({ handlers.config() })
lspconfig.prismals.setup({ handlers.config() })

--jsonlsp---------------------------------------------------------------------------------------------------------------
lspconfig.jsonls.setup(handlers.config({
	settings = {
		json = {
			schemas = require("celso.lsp.settings.json-lsp-schemas"),
		},
	},
	init_options = {
		provideFormatter = false,
	},
}))
--jsonlsp---------------------------------------------------------------------------------------------------------------

--sumneko lua lsp--------------------------------------------------------------------------------------------------------
local sumneko = require("celso.lsp.settings.sumneko-lsp")
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

require("celso.lsp.null-ls")
