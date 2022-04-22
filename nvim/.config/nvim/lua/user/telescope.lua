require("telescope").setup({
	defaults = {
		file_sorter = require("telescope.sorters").get_fzy_sorter,
		file_ignore_patterns = { "node_modules", ".git/", ".png", ".ico", ".jpg" },
		prompt_prefix = " 🔭 > ",
	},
	extensions = {
		fzy_native = {
			override_generic_sorter = false,
			overrride_file_sorter = true,
		},
	},
	pickers = {
		find_files = { hidden = true },
	},
})
require("telescope").load_extension("fzy_native")
require("telescope").load_extension("projects")

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
map("n", "<leader>fb", "<cmd>Telescope buffers<cr>", opts)
map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", opts)
map("n", "<leader>fd", "<cmd>Telescope diagnostics<cr>", opts)
map("n", "<leader>fr", "<cmd>Telescope lsp_references<cr>", opts)
map("n", "<leader>fds", "<cmd>Telescope lsp_document_symbols<cr>", opts)

map(
	"n",
	"<leader>do",
	':lua require("telescope.builtin").lsp_code_actions(require("telescope.themes").get_cursor({}))<cr>',
	opts
)

map("n", "<leader>dot", ':lua require("user.telescope-functions").search_dotfiles()<CR>', opts)
map("n", "<leader>fcb", ':lua require("user.telescope-functions").current_buffer()<CR>', opts)
map("n", "<leader>fcs", ':lua require("telescope.builtin").colorscheme()<CR>', opts)
map("n", "<leader>fco", ':lua require("telescope.builtin").commands()<CR>', opts)
