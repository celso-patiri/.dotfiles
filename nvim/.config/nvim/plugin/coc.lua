--coc config
vim.g['coc_global_extensions'] = {
    'coc-pairs', 
    'coc-json',
    'coc-css',
    'coc-tsserver',
    'coc-emmet',
    'coc-prettier',
    'coc-eslint',
    'coc-lists'
}

--install coc prettier and eslint if project doesnt have them
--vim.cmd[[
    --if isdirectory('./node_modules') && isdirectory('./node_modules/prettier')
        --let g:coc_global_extensions += ['coc-prettier']
    --endif

    --if isdirectory('./node_modules') && isdirectory('./node_modules/eslint')
        --let g:coc_global_extensions += ['coc-eslint']
    --endif
--]]

--coc show hover
map('n', '<C-k>', ":call CocAction('doHover')<CR>", {silent = true})

--show diagnostics
map('n', '<leader>di', ':<C-u>CocList diagnostics<cr>', { silent = true })
map('n', '<leader>s', ':<C-u>CocList -I symbols<cr>', { silent = true })
map('n', '<leader>do', '<Plug>(coc-codeaction)' , { noremap = false })
map('n', '<F2>', '<Plug>(coc-rename)' , { noremap = false })
