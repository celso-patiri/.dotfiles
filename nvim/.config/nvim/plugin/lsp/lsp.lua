local map = vim.api.nvim_buf_set_keymap

local remapArgs = { noremap = true, silent = true }
local function config(_config)
	return vim.tbl_deep_extend("force", {
		capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities()),
		on_attach = function()
			--map({}, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", remapArgs)
			map(0, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", remapArgs)
			map(0, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", remapArgs)
			map(0, "n", "gt", "<cmd>lua vim.lsp.buf.type_definition()<CR>", remapArgs)
			map(0, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", remapArgs)
			map(0, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", remapArgs)
			map(0, "n", "<leader>]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", remapArgs)
			map(0, "n", "<leader>[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", remapArgs)

			map(0, "n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<CR>", remapArgs)
			--map({}, 'n', '<leader>do', '<cmd>lua vim.lsp.buf.code_action()<CR>', remapArgs)
		end,
	}, _config or {})
end

require("lspconfig").tsserver.setup(config())
--vim.cmd('autocmd BufWritePre *.tsx,*.ts,*.jsx,*.js EslintFixAll')
require("lspconfig").eslint.setup({ config() })
--require'lspconfig'.graphql.setup{ config() }
--require'lspconfig'.tailwindcss.setup{ config() }
--require'lspconfig'.emmet_ls.setup( config( { filetypes = {"html", "javascript", "javascriptreact", "typescriptreact"}}) )
--require'lspconfig'.dockerls.setup{ config() }
--require'lspconfig'.cssls.setup( config( { filetypes = { "css", "scss", "javascript", "javascriptreact", "typescriptreact" }}) )

--sumneko lua lsp--------------------------------------------------------------------------------------------------------
local sumneko_root_path = "/home/driven/personal/lua-language-server"
local sumneko_binary = sumneko_root_path .. "/bin/lua-language-server"
local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

require("lspconfig").sumneko_lua.setup(config({
	cmd = { sumneko_binary, "-E", sumneko_root_path .. "/main.lua" },
	settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
				version = "LuaJIT",
				-- Setup your lua path
				path = runtime_path,
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

local soArgs = {
	-- whether to highlight the currently hovered symbol
	-- disable if your cpu usage is higher than you want it
	-- or you just hate the highlight
	-- default: true
	highlight_hovered_item = true,

	-- whether to show outline guides
	-- default: true
	show_guides = true,
}
require("symbols-outline").setup(soArgs)

require("fidget").setup({})

--saga
--local saga = require("lspsaga")
--saga.init_lsp_saga()
--map({}, "n", "<F3>", "<cmd>lua require('lspsaga.rename').rename()<CR>", remapArgs)
