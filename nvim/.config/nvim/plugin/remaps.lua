local opts = { noremap = true, silent = true }

--ctrl + space for auto completion
--map('i', '<C-space>', 'coc#refresh()', { silent = true, expr = true })
--ctril + l to accept suggestion
map("i", "<C-l>", "<Right>")

-- map("i", "jk", "<ESC>")

--comments
map("n", "<A-q>", "gcc", { noremap = false })
map("v", "<A-q>", "gc", { noremap = false })
map("n", "<C-A-q>", "gcA", { noremap = false })
map("v", "<C-A-q>", "gb", { noremap = false })

--Map 'esc' to 'noh' to remove highlight after search
map("n", "<esc>", ":noh<cr><esc>", opts)

--save on ctrl+s
map("n", "<C-S>", ":update<CR>", opts)
map("v", "<C-S>", "<C-C>:update<CR>", opts)
map("i", "<C-S>", "<C-C>:update<CR>", opts)

--tab, shift+tab ident support
map("n", "<Tab>", ">>_")
map("n", "<S-Tab>", "<<_")
map("i", "<S-Tab>", "<C-D>")
map("v", "<Tab>", ">gv")
map("v", "<S-Tab>", "<gv")

--Move text up and down
map("n", "<A-k>", ":move .-2<CR>==", opts)
map("n", "<A-j>", ":move .+1<CR>==", opts)
map("v", "<A-k>", ":move '<-2<CR>gv=gv", opts)
map("v", "<A-j>", ":move '>+1<CR>gv=gv", opts)
map("i", "<A-j>", "<C-c>:move .+1<CR>==gi", opts)
map("i", "<A-k>", "<C-c>:move .-2<CR>==gi", opts)

--hold on to register and replace text
map("v", "p", '"_dP', opts)

--Ctrl c
map("n", "<C-c>", 'yyV"+y', opts) --Ctrl C copy whole line in normal mode
map("v", "<C-c>", '"+y', opts) --Ctrl C copy selection to clipboard in visual mode

--n4. keep it centered
map("n", "n", "nzzzv", opts)
map("n", "N", "Nzzzv", opts)
map("n", "J", "mzJ`z", opts)

--n3. break undo
map("i", ",", ",<c-g>u", opts)
map("i", ".", ".<c-g>u", opts)
map("i", "!", "!<c-g>u", opts)
map("i", "?", "?<c-g>u", opts)

-- Better window navigation
map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
map("n", "<C-Up>", ":resize -2<CR>", opts)
map("n", "<C-Down>", ":resize +2<CR>", opts)
map("n", "<C-Left>", ":vertical resize -2<CR>", opts)
map("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
map("n", "<A-l>", ":bnext<CR>", opts)
map("v", "<A-l>", ":bnext<CR>", opts)
map("n", "<A-h>", ":bprevious<CR>", opts)
map("v", "<A-h>", ":bprevious<CR>", opts)

--bufferline
map("n", "<C-w>", ":bdelete<cr>")
map("n", "<A-w>", ":BufferLinePick<cr>")
