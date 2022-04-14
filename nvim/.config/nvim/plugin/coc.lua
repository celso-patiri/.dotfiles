--coc config
--vim.g['coc_global_extensions'] = {
    --'coc-pairs', 
    --'coc-json',
    --'coc-css',
    --'coc-tsserver',
    --'coc-emmet',
    --'coc-prettier',
    --'coc-eslint',
    --'coc-lists'
--}

---- Highlight the symbol and its references when holding the cursor.
--vim.cmd( "autocmd CursorHold * silent call CocActionAsync('highlight')" )

----install coc prettier and eslint if project doesnt have them
----vim.cmd[[
    ----if isdirectory('./node_modules') && isdirectory('./node_modules/prettier')
        ----let g:coc_global_extensions += ['coc-prettier']
    ----endif

    ----if isdirectory('./node_modules') && isdirectory('./node_modules/eslint')
        ----let g:coc_global_extensions += ['coc-eslint']
    ----endif
----]]

----coc show hover
--map('n', '<C-h>', ":call CocAction('doHover')<CR>", {silent = true})

----show diagnostics
--map('n', '<leader>di', ':<C-u>CocList diagnostics<cr>', { silent = true })
--map('n', '<leader>s', ':<C-u>CocList -I symbols<cr>', { silent = true })

--map('n', '<leader>qf', '<Plug>(coc-fix-current)', { noremap = false })
----map('n', '<leader>cl', '<Plug>(coc-codelens-action)', { noremap = false })

--map('n', '<leader>do', '<Plug>(coc-codeaction)' , { noremap = false })
--map('n', '<F2>', '<Plug>(coc-rename)' , { noremap = false })
--map('n', '<leader>gd', '<Plug>(coc-definition)' , { noremap = false , silent = true})
--map('n', '<leader>gt', '<Plug>(coc-type-definition)' , { noremap = false , silent = true})
--map('n', '<leader>gi', '<Plug>(coc-implementation)' , { noremap = false , silent = true})
--map('n', '<leader>gr', '<Plug>(coc-references)' , { noremap = false , silent = true})
