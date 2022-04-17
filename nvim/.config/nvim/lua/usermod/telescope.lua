local mappings = {}
mappings.search_dotfiles = function()
	require("telescope.builtin").find_files({
		prompt_title = "< Dotfiles >",
		cwd = '~/.dotfiles',
		hidden = true,
	})
end

mappings.current_buffer = function ()
    require("telescope.builtin").current_buffer_fuzzy_find({
        sorting_strategy="ascending"
    })
end

return mappings
