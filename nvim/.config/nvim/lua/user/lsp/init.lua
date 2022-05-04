local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
	return
end

local handlers = require("user.lsp.handlers")

lspconfig.eslint.setup(handlers.config())

-- lspconfig.graphql.setup({ handlers.config() })
lspconfig.tailwindcss.setup({ handlers.config() })
lspconfig.emmet_ls.setup(
	handlers.config({ filetypes = { "html", "javascript", "javascriptreact", "typescriptreact" } })
)
lspconfig.dockerls.setup({ handlers.config() })
--lspconfig.cssls.setup( handlers.config( { filetypes = { "css", "scss", "javascript", "javascriptreact", "typescriptreact" }}) )

lspconfig.tsserver.setup(handlers.tsconfig())
--jsonlsp---------------------------------------------------------------------------------------------------------------
lspconfig.jsonls.setup(handlers.config({
	settings = {
		json = {
			schemas = require("user.lsp.settings.json-lsp-schemas"),
		},
	},
	init_options = {
		provideFormatter = false,
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
