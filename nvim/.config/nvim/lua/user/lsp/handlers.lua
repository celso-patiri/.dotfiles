local M = {}

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
	local map = vim.api.nvim_buf_set_keymap
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
	map(bufnr, "n", "<leader>sh", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)

	map(bufnr, "n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
	--map({}, 'n', '<leader>do', '<cmd>lua vim.lsp.buf.code_action()<CR>', remapArgs)
	vim.cmd([[ command! Format execute 'lua vim.lsp.buf.formatting()' ]])
end

M.setup = function()
	local config = {
		signs = {
			active = signs,
		},

		virtual_text = true,
		update_in_insert = true,
		underline = true,
		severity_sort = true,
		float = {
			focusable = false,
			style = "minimal",
			border = "rounded",
			source = "always",
			header = "",
			prefix = "",
		},
	}
	vim.diagnostic.config(config)
	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
		border = "rounded",
	})

	vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
		border = "rounded",
	})

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
end

M.config = function(_config)
	return vim.tbl_deep_extend("force", {
		capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities()),
		on_attach = function(client, bufnr)
			if client.name == "tsserver" then
				client.resolved_capabilities.document_formatting = false
				client.resolved_capabilities.document_range_formatting = false
			end

			if client.name == "sumneko_lua" then
				client.resolved_capabilities.document_formatting = false
				client.resolved_capabilities.document_range_formatting = false
			end

			lsp_keymaps(bufnr)
			lsp_highlight_document(client)
		end,
	}, _config or {})
end

return M
