require("nvim-treesitter.configs").setup({
	ensure_installed = { "javascript", "typescript", "lua", "regex", "json", "html", "dockerfile", "css", "prisma" },
	sync_install = false,
	ignore_install = { "" },
	highlight = {
		enable = true,

		-- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
		disable = {},

		-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
		-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
		-- Using this option may slow down your editor, and you may see some duplicate highlights.
		-- Instead of true it can also be a list of languages
		additional_vim_regex_highlighting = false,
	},
	textobjects = { enable = true },
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "gnn",
			node_incremental = "<A-]>",
			scope_incremental = "grc",
			node_decremental = "<A-[>",
		},
	},
	rainbow = {
		enable = true,
		-- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
		extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
		max_file_lines = nil, -- Do not enable for files with more than n lines, int
		-- colors = {}, -- table of hex strings
		-- termcolors = {} -- table of colour name strings
	},
	matchup = {
		enable = true, -- mandatory, false will disable the whole extension
		--disable = { "c", "ruby" },  -- optional, list of language that will be disabled
	},
	-- smart comments
	context_commentstring = { enable = true },
})

--------------------------------------------------------------------------------------------------------------------

require("celso.treesitter.text-objects")
require("tsht").config.hint_keys = { "h", "j", "f", "d", "n", "v", "s", "l", "a" }
