local map = vim.api.nvim_buf_set_keymap

-- Setup nvim-cmp.
vim.opt.completeopt = { "menu", "menuone", "noselect" }
local cmp = require("cmp")

local check_backspace = function()
	local col = vim.fn.col(".") - 1
	return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
end

--   פּ ﯟ   some other good icons
local kind_icons = {
	Text = "",
	Method = "m",
	Function = "",
	Constructor = "",
	Field = "",
	Variable = "",
	Class = "",
	Interface = "",
	Module = "",
	Property = "",
	Unit = "",
	Value = "",
	Enum = "",
	Keyword = "",
	Snippet = "",
	Color = "",
	File = "",
	Reference = "",
	Folder = "",
	EnumMember = "",
	Constant = "",
	Struct = "",
	Event = "",
	Operator = "",
	TypeParameter = "",
}
-- find more here: https://www.nerdfonts.com/cheat-sheet

local luasnip = require("luasnip")
cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body) -- For `luasnip` users.
		end,
	},

	mapping = cmp.mapping.preset.insert({
		["<C-k>"] = cmp.mapping.select_prev_item(),
		["<C-j>"] = cmp.mapping.select_next_item(),
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping({
			i = cmp.mapping.abort(),
			c = cmp.mapping.close(),
		}),
		["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
		["<C-l>"] = cmp.mapping.confirm({ select = true }),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expandable() then
				luasnip.expand()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			elseif check_backspace() then
				fallback()
			else
				fallback()
			end
		end, {
			"i",
			"s",
		}),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, {
			"i",
			"s",
		}),
	}),

	formatting = {
		format = function(_, vim_item)
			vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind)
			return vim_item
		end,
	},

	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},

	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "luasnip" }, -- For luasnip users.
		{ name = "cmp_tabnine" },
	}, {
		{ name = "buffer" },
		{ name = "path" },
	}),
})

local tabnine = require("cmp_tabnine.config")
tabnine:setup({
	max_lines = 1000,
	max_num_results = 20,
	sort = true,
	run_on_every_keystroke = true,
	snippet_placeholder = "..",
	ignored_file_types = {
		-- lua = true
	},
	show_prediction_strength = false,
})

local remapArgs = { noremap = true, silent = true }
local function config(_config)
	return vim.tbl_deep_extend("force", {
		capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities()),
		on_attach = function()
			--map(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
			map({}, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", remapArgs)
			map({}, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", remapArgs)
			map({}, "n", "gt", "<cmd>lua vim.lsp.buf.type_definition()<CR>", remapArgs)
			map({}, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", remapArgs)
			map({}, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", remapArgs)
			map({}, "n", "<leader>]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", remapArgs)
			map({}, "n", "<leader>[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", remapArgs)

			map({}, "n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<CR>", remapArgs)
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

--local function cssConfig()
--local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
--capabilities.textDocument.completion.completionItem.snippetSupport = true
--return vim.tbl_deep_extend("force", {
--capabilities = capabilities,
--on_attach = function()
----map(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
--map({}, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', remapArgs)
--map({}, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', remapArgs)
--map({}, 'n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', remapArgs)
--map({}, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', remapArgs)
--map({}, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', remapArgs)
--map({}, 'n', '<leader>]d', '<cmd>lua vim.diagnostic.goto_next()<CR>', remapArgs)
--map({}, 'n', '<leader>[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', remapArgs)

--map({}, 'n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<CR>', remapArgs)
--map({}, 'n', '<leader>do', '<cmd>lua vim.lsp.buf.code_action()<CR>', remapArgs)
--end,
--}, _config or {})
--end

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

--snippets
local snippets_paths = function()
	local plugins = { "friendly-snippets" }
	local paths = {}
	local path
	local root_path = vim.env.HOME .. "/.vim/plugged/"
	for _, plug in ipairs(plugins) do
		path = root_path .. plug
		if vim.fn.isdirectory(path) ~= 0 then
			table.insert(paths, path)
		end
	end
	return paths
end

require("luasnip.loaders.from_vscode").lazy_load({
	paths = snippets_paths(),
	include = nil, -- Load all languages
	exclude = {},
})
--snippets

require("fidget").setup({})

--saga
--local saga = require("lspsaga")
--saga.init_lsp_saga()
--map({}, "n", "<F3>", "<cmd>lua require('lspsaga.rename').rename()<CR>", remapArgs)
