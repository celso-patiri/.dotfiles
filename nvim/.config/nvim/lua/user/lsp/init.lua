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
				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
				version = "LuaJIT",
				-- Setup your lua path
				path = sumneko.runtime,
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { "vim" },
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = vim.api.nvim_get_runtime_file("", true),
			},
			-- Do not send telemetry data containing a randomized but unique identifier
			telemetry = {
				enable = false,
			},
		},
	},
}))
--sumneko lua lsp--------------------------------------------------------------------------------------------------------

handlers.setup()

require("user.lsp.null-ls")
