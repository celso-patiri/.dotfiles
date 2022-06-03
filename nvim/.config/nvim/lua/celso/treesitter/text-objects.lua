require("nvim-treesitter.configs").setup({
	textobjects = {

		select = {
			enable = true,
			-- Automatically jump forward to textobj, similar to targets.vim
			lookahead = true,
			keymaps = {
				-- You can use the capture groups defined in textobjects.scm
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["ac"] = "@conditional.outer",
				["ic"] = "@conditional.inner",
				["ab"] = "@block.outer",
				["ib"] = "@block.inner",
			},
		},

		swap = {
			enable = true,
			swap_next = {
				["<leader>p"] = "@parameter.inner",
			},
			swap_previous = {
				["<leader>P"] = "@parameter.inner",
			},
		},
		lsp_interop = {
			enable = true,
			border = "none",
			peek_definition_code = {
				["<leader>df"] = "@function.outer",
				["<leader>dF"] = "@class.outer",
			},
		},

		move = {
			enable = true,
			set_jumps = true, -- whether to set jumps in the jumplist
			goto_next_start = {
				["]f"] = "@function.outer",
				["]b"] = "@block.outer",
			},
			goto_next_end = {
				["]F"] = "@function.outer",
				["]B"] = "@block.outer",
			},
			goto_previous_start = {
				["[f"] = "@function.outer",
				["[b"] = "@block.outer",
			},
			goto_previous_end = {
				["[F"] = "@function.outer",
				["[B"] = "@block.outer",
			},
		},
	},
})
