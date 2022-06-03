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

require("celso.plugins")
require("impatient")
require("celso.colors")

require("celso.lsp.init")
require("celso.treesitter.treesitter")
require("celso.cmp")

require("celso.telescope.main")
require("celso.nvim-tree")

require("celso.lualine")
require("celso.gitsigns")

require("celso.autopair")
require("celso.comment")

require("celso.remaps")
require("celso.settings")
