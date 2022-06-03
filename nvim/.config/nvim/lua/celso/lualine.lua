local gps = require("nvim-gps")

-- local colors = {
-- 	yellow = "#ECBE7B",
-- 	cyan = "#008080",
-- 	darkblue = "#081633",
-- 	green = "#98be65",
-- 	orange = "#FF8800",
-- 	violet = "#a9a1e1",
-- 	magenta = "#c678dd",
-- 	blue = "#51afef",
-- 	red = "#ec5f67",
-- }

local addIconToMode = function(str)
	if str == "NORMAL" then
		return " NORMAL"
	end
	if str == "INSERT" then
		return " INSERT"
	end
	if str == "COMMAND" then
		return " COMMAND"
	end
	if str == "TERMINAL" then
		return " TERMINAL"
	end
	if str == "VISUAL" or string.find(str, "V-") then
		return " " .. str
	end
	return str
end

local function handleTerminalName(str)
	if string.find(str, "toggleterm") then
		return " ToggleTerm"
	else
		return str
	end
end

local config = {
	options = {
		icons_enabled = true,
		theme = "auto",
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = {},
		always_divide_middle = true,
		globalstatus = false,
	},
	sections = {
		lualine_a = { { "mode", fmt = addIconToMode } },
		lualine_b = { "branch", "diff" },
		lualine_c = {
			{ "filename", fmt = handleTerminalName },
			{ gps.get_location, cond = gps.is_available },
			"diagnostics",
		},
		lualine_x = { "encoding", "fileformat", "filetype" },
		-- lualine_x = { "vim.api.nvim_call_function('getcwd', {})", "encoding", "fileformat", "filetype" },
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
	extensions = {},
}

require("lualine").setup(config)
