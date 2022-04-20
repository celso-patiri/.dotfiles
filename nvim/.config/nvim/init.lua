---@diagnostic disable: discard-returns

require("user.plugins")
require("impatient")

--smart comments
-- vim.cmd("filetype plugin on")
require("nvim-treesitter.configs").setup({ context_commentstring = { enable = true } })

require("user.lsp.init")
require("user.bufferline")
require("user.toggleterm")

-----------------------------------------------------------------------------------------------------------

vim.g.mapleader = " "
local set = vim.opt

function map(mode, lhs, rhs, opts)
	local options = { noremap = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

---------------------------------------------------------------------------------------------------------

-- disable copilot by default -- redundant since packer lazy loads copilot
-- vim.cmd("autocmd VimEnter * :Copilot disable")

--syntax sync in JSX and TSX files
-- vim.cmd("autocmd BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart ")
-- vim.cmd("autocmd BufLeave *.{js,jsx,ts,tsx} :syntax sync clear ")

--Prettier auto format
-- vim.cmd("autocmd BufWritePre *.{js,jsx,ts,tsx} Neoformat prettier ")
-- vim.cmd("autocmd BufWritePre *.lua Neoformat stylua")
-- vim.cmd('let g:neoformat_try_node_exe = 1 ') -- check .conf for prettier on project

set.encoding = "UTF-8"
set.mouse = "a"

set.smarttab = true
set.cindent = true
set.tabstop = 2
set.shiftwidth = 2
set.expandtab = true --always uses spaces instead of tab characters
set.scrolloff = 8

set.hidden = true
set.swapfile = false

set.incsearch = true
set.relativenumber = true
set.number = true

set.signcolumn = "yes"
--set.guicursor= 'i:block'

----coc recommendations
set.backup = false
set.writebackup = false
----give more space for displaying messages
set.cmdheight = 2
----Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable delays and poor user experience.
set.updatetime = 300
vim.cmd("let g:cursorhold_updatetime = 100")

--keep undo persistence
vim.cmd([[
if has('persistent_undo')
    set undofile
    set undodir=$HOME/.vim/undo
    endif
    ]])
