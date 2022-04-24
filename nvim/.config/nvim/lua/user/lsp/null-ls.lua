local null_ls_status_ok, null_ls = pcall(require, "null-ls")

if not null_ls_status_ok then
	return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics
-- local code_actions = null_ls.builtins.code_actions

null_ls.setup({
	debug = false,
	sources = {
		formatting.prettier,
		formatting.stylua,
		diagnostics.codespell,
		-- diagnostics.eslint_d,
		-- code_actions.eslint_d,
	},
	on_attach = function(client, bufnr)
		local map = vim.api.nvim_buf_set_keymap
		local opts = { noremap = true, silent = true }
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
		-- vim.cmd([[ command! Format execute 'lua vim.lsp.buf.formatting()' ]])

		if client.resolved_capabilities.document_formatting then
			vim.cmd([[
            augroup LspFormatting
                autocmd! * <buffer>
                autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
            augroup END
            ]])
		end
	end,
})
