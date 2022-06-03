require("telescope").setup({
	defaults = {
		file_ignore_patterns = { "node_modules", ".git/", ".png", ".ico", ".jpg" },
		prompt_prefix = "  > ",
	},
	extensions = {
		fzf = {
			fuzzy = true, -- false will only do exact matching
			override_generic_sorter = true, -- override the generic sorter
			override_file_sorter = true, -- override the file sorter
			case_mode = "smart_case", --  "ignore_case" | "respect_case" |"smart_case"
		},
	},
	pickers = {
		live_grep = { hidden = true },
		find_files = { hidden = true },
	},
})
require("telescope").load_extension("fzf")

local opts = { noremap = true, silent = true }

map(
	"n",
	"<leader>fg",
	':lua require("telescope.builtin").grep_string({ search = vim.fn.input("Grep For > ")})<CR>',
	opts
)
map("n", "<leader>fw", ':lua require("telescope.builtin").live_grep({})<CR>', opts)
map("n", "<leader>fp", "<cmd>Telescope projects<cr>", opts)
--map('n', '<leader>fw', ':lua require("telescope.builtin").grep_string({ search = vim.fn.expand("<cword>") })<CR>', opts)

map("n", "<C-p>", "<cmd>Telescope git_files<cr>", opts)
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", opts)
-- map("n", "<leader>fb", "<cmd>Telescope buffers<cr>", opts)
map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", opts)
map("n", "<leader>fdi", "<cmd>Telescope diagnostics<cr>", opts)
map("n", "<leader>fr", "<cmd>Telescope lsp_references<cr>", opts)
map("n", "<leader>fds", "<cmd>Telescope lsp_document_symbols<cr>", opts)

map("n", "<leader>dot", ':lua require("celso.telescope.functions").search_dotfiles()<CR>', opts)
map("n", "<leader>fcb", ':lua require("celso.telescope.functions").current_buffer()<CR>', opts)
map("n", "<leader>fbm", ':lua require("celso.telescope.functions").bookmarks()<CR>', opts)
map("n", "<leader>fcs", ':lua require("telescope.builtin").colorscheme()<CR>', opts)
map("n", "<leader>fco", ':lua require("telescope.builtin").commands()<CR>', opts)
