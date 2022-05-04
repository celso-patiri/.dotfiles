local set = vim.opt
--syntax sync in JSX and TSX files
-- vim.cmd("autocmd BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart ")
-- vim.cmd("autocmd BufLeave *.{js,jsx,ts,tsx} :syntax sync clear ")

--Prettier auto format
-- vim.cmd("autocmd BufWritePre *.{js,jsx,ts,tsx} Neoformat prettier ")
-- vim.cmd("autocmd BufWritePre *.lua Neoformat stylua")
-- vim.cmd('let g:neoformat_try_node_exe = 1 ') -- check .conf for prettier on project

--smart comments
-- vim.cmd("filetype plugin on")

--set.guicursor= 'i:block'

--visual-multi-cursors
vim.g["VM_default_mappings"] = 0
vim.g["VM_mouse_mappings"] = 1
vim.cmd([[
	let g:VM_maps = {}
  let g:VM_maps["Select Cursor Up"] = "<C-S-Up>" 
  let g:VM_maps["Select Cursor Down"] = "<C-S-Down>" 
]])

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

set.backup = false
set.writebackup = false
set.cmdheight = 2

----Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable delays and poor user experience.
set.updatetime = 300
vim.g["cursorhold_updatetime"] = 100

--keep undo persistence
vim.cmd([[
    if has('persistent_undo')
      set undofile
      set undodir=$HOME/.vim/undo
    endif
]])

--bufferline
-- vim.opt.showtabline = 0
vim.opt.laststatus = 2
set.showmode = true

vim.api.nvim_create_autocmd("FileType", {
	pattern = "*",
	callback = function()
		vim.cmd("setlocal formatoptions-=cro")
	end,
	desc = "Stop comment continuation on line below",
})

--fix extra space at the bottom on start
vim.cmd("resize+1")

--neovide
if vim.g.neovide == true then
	vim.o.guifont = "Hack Nerd Font:h12"
	vim.g["neovide_transparency"] = 0.95
	vim.api.nvim_set_keymap("n", "<F11>", ":let g:neovide_fullscreen = !g:neovide_fullscreen<CR>", {})
end
