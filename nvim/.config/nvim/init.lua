--@diagnostic disable: discard-returns
-----------------------------------------------------------------------------------------------------------

vim.g.mapleader = " "

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
require("user.colors")

require("user.lsp.init")
require("user.treesitter")
require("user.cmp")

require("user.telescope.main")
require("user.nvim-tree")
require("user.vimwiki")
-- require("user.toggleterm")

-- require("user.bufferline")
require("user.lualine")
require("user.gitsigns")

require("user.autopair")
require("user.comment")

require("user.remaps")
require("user.settings")
