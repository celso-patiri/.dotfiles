require("telescope").load_extension("dap")
require("nvim-dap-virtual-text").setup()
require("dapui").setup()

local dap = require("dap")

local function get_plaid_path()
	local plaid_path = os.getenv("PLAID_PATH")
	if plaid_path ~= nil then
		return plaid_path
	end
	return ""
end

dap.adapters.node2 = {
	type = "executable",
	command = "node",
	args = { os.getenv("HOME") .. "/personal/debuggers/vscode-node-debug2/out/src/nodeDebug.js" },
}

dap.configurations.typescript = {
	{
		type = "node2",
		request = "launch",
		name = "Launch File",
		program = "${file}",
		cwd = vim.fn.getcwd(),
		sourceMaps = true,
		restart = true,
		protocol = "inspector",
		console = "integratedTerminal",
		outFiles = { "${workspaceFolder}/dist/**/*.js", "!**/node_modules/**" },
	},
}

dap.configurations.javascript = {
	{
		name = "Launch",
		type = "node2",
		request = "launch",
		program = "${file}",
		cwd = vim.fn.getcwd(),
		sourceMaps = true,
		protocol = "inspector",
		console = "integratedTerminal",
	},
	{
		-- For this to work you need to make sure the node process is started with the `--inspect` flag.
		name = "Attach to process",
		type = "node2",
		request = "attach",
		processId = require("dap.utils").pick_process,
	},
}
