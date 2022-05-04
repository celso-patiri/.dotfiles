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

local buf_map = function(bufnr, mode, lhs, rhs, opts)
	vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts or {
		silent = true,
	})
end

local function lsp_highlight_document(client)
	-- Set autocommands conditional on server_capabilities
	if client.supports_method("textDocument/documentHighlight") then
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
	buf_map(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	buf_map(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
	buf_map(bufnr, "n", "gt", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
	buf_map(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	buf_map(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
	buf_map(bufnr, "n", "<leader>]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
	buf_map(bufnr, "n", "<leader>[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
	buf_map(bufnr, "n", "gl", '<cmd>lua vim.lsp.diagnostic.open_float({ border = "rounded" })<CR>', opts)
	buf_map(bufnr, "n", "<leader>sh", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)

	buf_map(bufnr, "n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
	buf_map(bufnr, "n", "<leader>do", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
	-- vim.cmd([[ command! Format execute 'lua vim.lsp.buf.formatting()' ]])
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

	-- vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
	-- 	border = "rounded",
	-- })
	--
	-- vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
	-- 	border = "rounded",
	-- })

	require("symbols-outline").setup({
		-- disable if your cpu usage is higher than you want it
		highlight_hovered_item = true,
		-- whether to show outline guides
		show_guides = true,
	})
	require("fidget").setup({})
end

-- nvim 0.8
local lsp_formatting = function(bufnr)
	vim.lsp.buf.format({
		filter = function(clients)
			-- filter out clients that you don't want to use
			return vim.tbl_filter(function(client)
				return client.name ~= "sumneko_lua" and client.name ~= "tsserver"
			end, clients)
		end,
		bufnr = bufnr,
	})
end

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

M.config = function(_config)
	return vim.tbl_deep_extend("force", {
		capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities()),

		on_attach = function(client, bufnr)
			if client.supports_method("textDocument/formatting") then -- removes formatting capabilities from lsp
				vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
				vim.api.nvim_create_autocmd("BufWritePre", {
					group = augroup,
					buffer = bufnr,
					callback = function()
						lsp_formatting(bufnr)
					end,
				})
			end
			lsp_keymaps(bufnr)
			lsp_highlight_document(client)
		end,
	}, _config or {})
end

M.tsconfig = function()
	return {
		capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities()),

		on_attach = function(client, bufnr)
			local ts_utils = require("nvim-lsp-ts-utils")
			ts_utils.setup({})
			ts_utils.setup_client(client)
			buf_map(bufnr, "n", "gs", ":TSLspOrganize<CR>")
			buf_map(bufnr, "n", "gi", ":TSLspRenameFile<CR>")
			buf_map(bufnr, "n", "go", ":TSLspImportAll<CR>")

			buf_map(bufnr, "n", "<A-O>", ":TSLspImportAll<CR>:TSLspOrganize<CR>") -- auto import and organize_imports

			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					lsp_formatting(bufnr)
				end,
			})

			lsp_keymaps(bufnr)
			lsp_highlight_document(client)
		end,
	}
end

return M
