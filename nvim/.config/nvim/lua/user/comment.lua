local status_ok, comment = pcall(require, "Comment")
if not status_ok then
	return
end

comment.setup({

	--smart comments - jsx/tsx context
	pre_hook = function(ctx)
		local U = require("Comment.utils")

		local location = nil
		if ctx.ctype == U.ctype.block then
			location = require("ts_context_commentstring.utils").get_cursor_location()
		elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
			location = require("ts_context_commentstring.utils").get_visual_start_location()
		end

		return require("ts_context_commentstring.internal").calculate_commentstring({
			key = ctx.ctype == U.ctype.line and "__default" or "__multiline",
			location = location,
		})
	end,

	--default settings-----------------------------------------------------------------
	---Lines to be ignored while comment/uncomment.
	---Could be a regex string or a function that returns a regex string.
	---Example: Use '^$' to ignore empty lines
	---@type string|fun():string
	ignore = "^$",

	---LHS of toggle mappings in NORMAL + VISUAL mode
	toggler = {
		line = "gcc", ---Line-comment toggle keymap
		block = "gbc", ---Block-comment toggle keymap
	},

	---LHS of operator-pending mappings in NORMAL + VISUAL mode
	opleader = {
		line = "gc", ---Line-comment keymap
		block = "gb", ---Block-comment keymap
	},

	---LHS of extra mappings
	extra = {
		above = "gcO", ---Add comment on the line above
		below = "gco", ---Add comment on the line below
		eol = "gcA", ---Add comment at the end of line
	},
})
