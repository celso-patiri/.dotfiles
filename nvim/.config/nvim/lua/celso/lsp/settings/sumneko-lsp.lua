local sumneko_root_path = "/home/celso/personal/lua-language-server"
local sumneko_binary = sumneko_root_path .. "/bin/lua-language-server"
local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

local M = {}
M.root = sumneko_root_path
M.binary = sumneko_binary
M.lua_runtime = runtime_path
return M
