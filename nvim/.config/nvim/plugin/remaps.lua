--ctrl + space for auto completion
map('i', '<C-space>', 'coc#refresh()', { silent = true, expr = true })

map('i', 'jk', '<ESC>')
map('n', '<C-t>', ':NERDTreeToggle<CR>')
map('v', '<C-q>', '<plug>NERDCommenterToggle', { noremap = false })
map('n', '<C-q>', '<plug>NERDCommenterToggle', { noremap = false })

--Map 'esc' to 'noh' to remove highlight after search
map('n', '<esc>', ':noh<cr><esc>', { silent = true }) 

--save on ctrl+s
map('n', '<C-S>', ':update<CR>', { silent = true })
map('v', '<C-S>', '<C-C>:update<CR>', { silent = true })
map('i', '<C-S>', '<C-O>:update<CR>', { silent = true })

--tab, shift+tab ident support
map('n', '<Tab>', '>>_')
map('n', '<S-Tab>', '<<_')
map('i', '<S-Tab>', '<C-D>')
map('v', '<Tab>', '>gv')
map('v', '<S-Tab>', '<gv')

--Zen Mode
map('n', '<leader>tz', '<cmd>TZAtaraxis<cr>')

--Move lines up and down
map('n', '<A-k>', ":move .-2<CR>==")
map('n', '<A-j>', ":move .+1<CR>==")
map('v', '<A-k>', ":move '<-2<CR>gv=gv")
map('v', '<A-j>', ":move '>+1<CR>gv=gv")
map('i', '<A-j>', "<C-c>:move .+1<CR>==gi")
map('i', '<A-k>', "<C-c>:move .-2<CR>==gi")

--Ctrl c
map('n', '<C-c>', 'yy') --Ctrl C copy whole line in normal mode
map('v', '<C-c>', '"+y') --Ctrl C copy selection to clipboard in visual mode

--Ctrl x
map('n', '<C-x>', 'dd') --Cut whole line in normal mode
map('v', '<C-x>', 'd') --Cut selection in visual

--n4. keep it centered
map('n', 'n', 'nzzzv') 
map('n', 'N', 'Nzzzv') 
map('n', 'J', 'mzJ`z') 

--n3. break undo
map('i', ',', ',<c-g>u') 
map('i', '.', '.<c-g>u') 
map('i', '!', '!<c-g>u') 
map('i', '?', '?<c-g>u') 
