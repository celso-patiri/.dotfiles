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

map("n", "<leader>fg", ':lua require("telescope.builtin").grep_string({ search = vim.fn.input("Grep For > ")})<CR>')
map("n", "<leader>fw", ':lua require("telescope.builtin").live_grep({})<CR>')
map("n", "<leader>fp", "<cmd>Telescope projects<cr>")
--map('n', '<leader>fw', ':lua require("telescope.builtin").grep_string({ search = vim.fn.expand("<cword>") })<CR>')

map("n", "<C-p>", "<cmd>Telescope git_files<cr>")
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>")
map("n", "<leader>fb", "<cmd>Telescope buffers<cr>")
map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>")
map("n", "<leader>fd", "<cmd>Telescope diagnostics<cr>")
map("n", "<leader>fr", "<cmd>Telescope lsp_references<cr>")
-- map("n", "<leader>fds", "<cmd>Telescope lsp_document_symbols<cr>")

map(
	"n",
	"<leader>do",
	':lua require("telescope.builtin").lsp_code_actions(require("telescope.themes").get_cursor({}))<cr>'
)

map("n", "<leader>dot", ':lua require("user.telescope-functions").search_dotfiles()<CR>')
map("n", "<leader>fcb", ':lua require("user.telescope-functions").current_buffer()<CR>')
