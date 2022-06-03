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
set.autochdir = true --auto cd

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
-- vim.opt.showtabline = 2
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

--Markdown
vim.g.vimwiki_markdown_link_ext = 1 -- Makes vimwiki mardown links as [text](text.md)
vim.g.mkdp_browser = "/usr/bin/firefox"
vim.g.mkdp_refresh_slow = 0 --default is 0 -> set to 1 so preview will refresh only on save for performance
