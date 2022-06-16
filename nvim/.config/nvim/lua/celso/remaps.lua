local opts = { noremap = true, silent = true }

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
--Map ZZ to write quit all buffers
map("n", "ZZ", ":wqa<cr>", opts)
map("n", "ZQ", ":qa<cr>", opts)

--save on ctrl+s
map("n", "<C-S>", ":w<CR>", opts)
map("v", "<C-S>", "<C-C>:w<CR>", opts)
map("i", "<C-S>", "<C-C>:w<CR>", opts)

--tab, shift+tab ident support
map("n", "<Tab>", ">>_")
map("n", "<S-Tab>", "<<_")
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
map("n", "<C-y>", 'yyV"+y', opts) --Ctrl C copy whole line in normal mode
map("v", "<C-y>", '"+y', opts) --Ctrl C copy selection to clipboard in visual mode
map("i", "<C-y>", '<esc>"+y', opts) --Ctrl C copy selection to clipboard in visual mode
--Ctrl x
map("n", "<C-x>", 'yyV"+d', opts) --Ctrl C copy whole line in normal mode
map("v", "<C-x>", '"+d', opts) --Ctrl C copy whole line in normal mode
--Ctrl a
map("n", "<C-a>", "ggVG", opts) --Ctrl C copy whole line in normal mode
map("v", "<C-a>", "gg<esc>VG", opts) --Ctrl C copy whole line in normal mode

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
map("n", "<leader><C-w>", ":bdelete<cr>", opts)
map("n", "<A-w>", ":BufferLinePick<cr>", opts)

--toggle terminal
--map("n", "<C-]>", ":lua HORIZONTAL_TOGGLE()<cr>", opts)
--map("n", "<C-A-]>", ":lua LAZYGIT_TOGGLE()<cr>", opts)
map("n", "<C-Bslash>", ":lua FLOAT_TOGGLE()<cr>", opts)

--treehopper
map("v", "<leader>l", ":lua require('tsht').nodes()<CR>", opts)
map("n", "<leader>l", "v:lua require('tsht').nodes()<CR>", opts)
map("o", "<leader>l", "<C-u>:lua require('tsht').nodes()<CR>", { silent = true, noremap = false })

--transparent toggle
map("n", "<leader>tra", ":TransparentToggle<cr>:hi LineNr guifg=#5eacd3<cr>", opts)

--disable arrows
map("n", "<Up>", "<nop>", opts)
map("n", "<Left>", "<nop>", opts)
map("n", "<Right>", "<nop>", opts)
map("n", "<Down>", "<nop>", opts)

--trouble
map("n", "<leader>tro", ":Trouble<cr>", opts)
map("n", "<leader>trw", ":Trouble workspace_diagnostics<cr>", opts)
map("n", "<leader>trd", ":Trouble document_diagnostics<cr>", opts)
map("n", "gR", ":Trouble lsp_references<cr>", opts)

--zen mode
map("n", "<leader>Z", ":ZenMode<cr>", opts)

--tmux-sessionizer
map("n", "<C-f>", ":!tmux neww tmux-sessionizer<CR>", opts)

--vim-fugitive
map("n", "<leader>G", ":0G<CR>", opts)
