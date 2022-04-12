require('telescope').setup{
    defaults = {    
        file_sorter = require('telescope.sorters').get_fzy_sorter,
        file_ignore_patterns = { "node_modules", ".git/" },
        --prompt_prefix = ' >',

  },
  extensions = {
      fzy_native = {
            override_generic_sorter = false,
            overrride_file_sorter = true,
      }
  }
}
require('telescope').load_extension('fzy_native')

map('n', '<leader>fs', ':lua require("telescope.builtin").grep_string({ search = vim.fn.input("Grep For > ")})<CR>')
map('n', '<leader>fw', ':lua require("telescope.builtin").grep_string({ search = vim.fn.expand("<cword>") })<CR>')
map('n', '<leader>vrc', ':lua require("usermod.telescope").search_dotfiles()<CR>')


map('n', '<C-p>', '<cmd>Telescope find_files<cr>')
map('n', '<leader>fb', '<cmd>Telescope find_buffers<cr>')
map('n', '<leader>fh', '<cmd>Telescope help_tags<cr>')
map('n', '<leader>fg', '<cmd>Telescope git_files<cr>')

