-- 
require("nvim-web-devicons").setup({
	override = {
		["test.js"] = {
			icon = "ﭧ",
			color = "#cbcb41",
			name = "JavascriptTest",
		},
		["test.ts"] = {
			icon = "ﭧ",
			color = "#007acc",
			name = "TypeScriptTest",
		},
		["test.ts"] = {
			icon = "ﭧ",
			color = "#007acc",
			name = "TypeScriptTest",
		},
		["Dockerfile"] = {
			icon = "",
			color = "#007acc",
			name = "dockerfile",
		},
		["docker-compose.yml"] = {
			icon = "",
			color = "#cbcb41",
			name = "dockercompose",
		},
		["prisma"] = {
			icon = "喝",
			color = "#007acc",
			name = "Prisma",
		},
	},
	default = true,
})

local present, nvim_tree_config = pcall(require, "nvim-tree.config")
if not present then
	return
end

local tree_cb = nvim_tree_config.nvim_tree_callback
if not tree_cb then
	return
end

require("nvim-tree").setup({ -- BEGIN_DEFAULT_OPTS
	auto_reload_on_write = true,
	disable_netrw = false,
	-- hide_root_folder = false,
	hijack_cursor = false,
	hijack_netrw = true,
	hijack_unnamed_buffer_when_opening = false,
	ignore_buffer_on_setup = false,
	open_on_setup = false,
	open_on_setup_file = false,
	open_on_tab = false,
	sort_by = "name",

	--Project.nvim config
	update_cwd = true,
	update_focused_file = {
		enable = true,
		update_cwd = true,
		ignore_list = {},
	},

	view = {
		width = 35,
		height = 30,
		side = "left",
		preserve_window_proportions = false,
		number = false,
		relativenumber = false,
		signcolumn = "yes",
		-- auto_resize = true,
		mappings = {
			custom_only = false,
			list = {
				{ key = { "l", "<CR>", "o" }, cb = tree_cb("edit") },
				{ key = "h", cb = tree_cb("close_node") },
				{ key = "v", cb = tree_cb("vsplit") },
			},
		},
	},

	renderer = {
		indent_markers = {
			enable = false,
			icons = {
				corner = "└ ",
				edge = "│ ",
				none = "  ",
			},
		},
		icons = {
			glyphs = {
				default = "",
				symlink = "",
				git = {
					unstaged = "",
					staged = "S",
					unmerged = "",
					renamed = "➜",
					deleted = "",
					untracked = "U",
					ignored = "◌",
				},
				folder = {
					default = "",
					open = "",
					empty = "",
					empty_open = "",
					symlink = "",
				},
			},
		},
	},

	hijack_directories = {
		enable = true,
		auto_open = true,
	},
	ignore_ft_on_setup = {},
	system_open = {
		cmd = nil,
		args = {},
	},

	diagnostics = {
		enable = true,
		show_on_dirs = true,
		icons = {
			hint = "",
			info = "",
			warning = "",
			error = "",
		},
	},
	filters = {
		dotfiles = false,
		custom = {},
		exclude = {},
	},
	git = {
		enable = true,
		ignore = false,
		timeout = 400,
	},

	actions = {
		use_system_clipboard = true,
		change_dir = {
			enable = true,
			global = false,
		},
		open_file = {
			quit_on_open = true,
			resize_window = false,
			window_picker = {
				enable = true,
				chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
				exclude = {
					filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
					buftype = { "nofile", "terminal", "help" },
				},
			},
		},
	},

	trash = {
		cmd = "trash",
		require_confirm = true,
	},
	log = {
		enable = false,
		truncate = false,
		types = {
			all = false,
			config = false,
			copy_paste = false,
			git = false,
			profile = false,
		},
	},
}) -- END_DEFAULT_OPTS

-- map("n", "<C-b>", "<cmd>NvimTreeToggle<CR>")
