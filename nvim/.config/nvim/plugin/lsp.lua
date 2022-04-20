local map = vim.api.nvim_buf_set_keymap

local signs = {
	{ name = "DiagnosticSignError", text = "" },
	{ name = "DiagnosticSignWarn", text = "" },
	{ name = "DiagnosticSignHint", text = "" },
	{ name = "DiagnosticSignInfo", text = "" },
}

for _, sign in ipairs(signs) do
	vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
end

local function lsp_highlight_document(client)
	-- Set autocommands conditional on server_capabilities
	if client.resolved_capabilities.document_highlight then
		vim.api.nvim_exec(
			[[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]],
			false
		)
	end
end

local function lsp_keymaps(bufnr)
	local opts = { noremap = true, silent = true }
	--map({}, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", remapArgs)
	map(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	map(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
	map(bufnr, "n", "gt", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
	map(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	map(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
	map(bufnr, "n", "<leader>]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
	map(bufnr, "n", "<leader>[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
	map(bufnr, "n", "gl", '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics({ border = "rounded" })<CR>', opts)
	map(bufnr, "n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)

	map(bufnr, "n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
	--map({}, 'n', '<leader>do', '<cmd>lua vim.lsp.buf.code_action()<CR>', remapArgs)
	vim.cmd([[ command! Format execute 'lua vim.lsp.buf.formatting()' ]])
end

local function config(_config)
	-- vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
	--[[ vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
		vim.lsp.handlers.signature_help,
		{ border = "rounded" }
	) ]]

	return vim.tbl_deep_extend("force", {
		capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities()),
		on_attach = function(client, bufnr)
			if client.name == "tsserver" then
				client.resolved_capabilities.document_formatting = false
			end
			lsp_keymaps(bufnr)
			lsp_highlight_document(client)
		end,
		signs = {
			active = signs,
		},
	}, _config or {})
end

require("lspconfig").tsserver.setup(config())
--vim.cmd('autocmd BufWritePre *.tsx,*.ts,*.jsx,*.js EslintFixAll')
require("lspconfig").eslint.setup({ config() })

require("lspconfig").jsonls.setup(config({
	settings = {
		json = {
			schemas = require("user.json-lsp-config"),
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
