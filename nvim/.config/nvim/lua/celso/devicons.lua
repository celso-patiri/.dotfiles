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
