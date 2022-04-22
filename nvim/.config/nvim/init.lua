---@diagnostic disable: discard-returns

-----------------------------------------------------------------------------------------------------------

function map(mode, lhs, rhs, opts)
	local options = { noremap = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

---------------------------------------------------------------------------------------------------------

require("user.plugins")
require("impatient")

require("user.lsp.init")
require("user.treesitter")
require("user.cmp")

require("user.telescope")
require("user.nvim-tree")
require("user.toggleterm")

require("user.bufferline")
require("user.staline")
require("user.gitsigns")

require("user.autopair")
require("user.comment")

require("user.colors")
require("user.settings")
require("user.remaps")
