local mappings = {}
mappings.search_dotfiles = function()
	require("telescope.builtin").find_files({
		prompt_title = "< Dotfiles >",
		cwd = "~/.dotfiles",
		hidden = true,
	})
end

mappings.current_buffer = function()
	require("telescope.builtin").current_buffer_fuzzy_find({
		sorting_strategy = "ascending",
		layout_config = { prompt_position = "top" },
	})
end

mappings.bookmarks = function()
	require("telescope").extensions.bookmarks.bookmarks(require("telescope.themes").get_dropdown({
		layout_config = {
			width = 0.8,
			height = 0.8,
		},
		previewer = false,
	}))
end

return mappings
