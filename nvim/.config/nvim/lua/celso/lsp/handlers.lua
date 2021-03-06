local M = {}
local navic = require("nvim-navic")

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
	buf_map(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	buf_map(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
	buf_map(bufnr, "n", "gt", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
	buf_map(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	buf_map(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
	buf_map(bufnr, "n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
	buf_map(bufnr, "n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
	-- buf_map(bufnr, "n", "gl", '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics({ border = "rounded" })<CR>', opts)
	buf_map(bufnr, "n", "gl", '<cmd>lua vim.diagnostic.open_float({ border = "rounded" })<CR>', opts)
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

	require("fidget").setup({})
end

M.config = function(_config)
	return vim.tbl_deep_extend("force", {
		capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities()),

		on_attach = function(client, bufnr)
			-- client.name == "solargraph"
			if client.name == "sumneko_lua" then -- resolve null_ls formatting conflict
				client.resolved_capabilities.document_formatting = false
				client.resolved_capabilities.document_range_formatting = false
			end

			if not client.name == "solargraph" then
				navic.attach(client, bufnr)
			end

			lsp_keymaps(bufnr)
			lsp_highlight_document(client)
		end,
	}, _config or {})
end

M.vuels_config = function(_config)
	return vim.tbl_deep_extend("force", {
		capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities()),
		init_options = {
			config = {
				css = {},
				emmet = {},
				html = {
					suggest = {},
				},
				javascript = {
					format = {},
				},
				stylusSupremacy = {},
				typescript = {
					format = {},
				},
				vetur = {
					completion = {
						autoImport = true,
						tagCasing = "kebab",
						useScaffoldSnippets = false,
					},
					format = {
						defaultFormatter = {
							js = "none",
							ts = "none",
						},
						defaultFormatterOptions = {},
						scriptInitialIndent = false,
						styleInitialIndent = false,
					},
					useWorkspaceDependencies = true,
					validation = {
						script = true,
						style = true,
						template = true,
					},
				},
			},
		},

		on_attach = function(client, bufnr)
			lsp_keymaps(bufnr)
			lsp_highlight_document(client)
		end,
	}, _config or {})
end

local function filter(arr, fn)
	if type(arr) ~= "table" then
		return arr
	end

	local filtered = {}
	for k, v in pairs(arr) do
		if fn(v, k, arr) then
			table.insert(filtered, v)
		end
	end

	return filtered
end

local function filterReactDTS(value)
	return string.match(value.uri, "react/index.d.ts") == nil
end

M.tsconfig = function()
	return {
		capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities()),
		-- filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx", },

		on_attach = function(client, bufnr)
			client.resolved_capabilities.document_formatting = false
			client.resolved_capabilities.document_range_formatting = false
			navic.attach(client, bufnr)

			local ts_utils = require("nvim-lsp-ts-utils")
			ts_utils.setup({})
			ts_utils.setup_client(client)
			buf_map(bufnr, "n", "gs", ":TSLspOrganize<CR>")
			buf_map(bufnr, "n", "gi", ":TSLspRenameFile<CR>")
			buf_map(bufnr, "n", "go", ":TSLspImportAll<CR>")

			buf_map(bufnr, "n", "<A-O>", ":TSLspImportAll<CR>:TSLspOrganize<CR>") -- auto import and organize_imports

			lsp_keymaps(bufnr)
			lsp_highlight_document(client)
		end,
		handlers = {
			["textDocument/definition"] = function(err, result, method, ...)
				if vim.tbl_islist(result) and #result > 1 then
					local filtered_result = filter(result, filterReactDTS)
					return vim.lsp.handlers["textDocument/definition"](err, filtered_result, method, ...)
				end

				vim.lsp.handlers["textDocument/definition"](err, result, method, ...)
			end,
		},
	}
end

return M
