local dap = require("dap")
local dapui = require("dapui")

dap.configurations.lua = {
	{
		type = "nlua",
		request = "attach",
		name = "Attach to running Neovim instance",
	},
}

dap.adapters.nlua = function(callback, config)
	callback({ type = "server", host = config.host or "127.0.0.1", port = config.port or 8086 })
end

dapui.setup({})

dap.listeners.before.attach.dapui_config = function()
	dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
	dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
	dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
	dapui.close()
end
--
-- dap.adapters["local-lua"] = {
--   type = "executable",
--   command = "node",
--   args = {
--     "/home/n451/local-lua-debugger-vscode/extension/debugAdapter.js"
--   },
--   enrich_config = function(config, on_config)
--     if not config["extensionPath"] then
--       local c = vim.deepcopy(config)
--       -- 💀 If this is missing or wrong you'll see
--       -- "module 'lldebugger' not found" errors in the dap-repl when trying to launch a debug session
--       c.extensionPath = "/home/n451/local-lua-debugger-vscode/"
--       on_config(c)
--     else
--       on_config(config)
--     end
--   end,
-- }
--
-- vim.keymap.set("n", "<leader>dt",dap.toggle_breakpoint)
-- vim.keymap.set("n", "<leader>dc",dap.continue)
vim.api.nvim_set_keymap("n", "<F8>", [[:lua require"dap".toggle_breakpoint()<CR>]], { noremap = true })
vim.api.nvim_set_keymap("n", "<F9>", [[:lua require"dap".continue()<CR>]], { noremap = true })
vim.api.nvim_set_keymap("n", "<F10>", [[:lua require"dap".step_over()<CR>]], { noremap = true })
vim.api.nvim_set_keymap("n", "<S-F10>", [[:lua require"dap".step_into()<CR>]], { noremap = true })
vim.api.nvim_set_keymap("n", "<F1>", [[:lua require"dap.ui.widgets".hover()<CR>]], { noremap = true })
vim.api.nvim_set_keymap("n", "<F5>", [[:lua require"osv".launch({port = 8086})<CR>]], { noremap = true })
