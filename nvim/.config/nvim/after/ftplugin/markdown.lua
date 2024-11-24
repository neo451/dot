-- print("md!")
-- vim.g.rime_enabled = false

---@param client vim.lsp.Client
local rime_on_attach = function(client, _)
	-- local buf = vim.api.nvim_get_current_buf()
	client:exec_cmd({ command = "rime-ls.toggle-rime" }, { bufnr = buf }, function(_, result, ctx)
		if ctx.client_id == client.id then
			vim.g.rime_enabled = result
		end
	end)

	-- print(client.exec_cmd)
	-- client.request("workspace/executeCommand", { command = "rime-ls.toggle-rime" }, function(_, result, ctx, _)
	-- 	if ctx.client_id == client.id then
	-- 		vim.g.rime_enabled = result
	-- 	end
	-- end)
	-- vim.keymap.set("n", "<leader>rr", function()
	-- 	client.request("workspace/executeCommand", { command = "rime-ls.toggle-rime" }, function(_, result, ctx, _)
	-- 		if ctx.client_id == client.id then
	-- 			vim.g.rime_enabled = result
	-- 		end
	-- 	end)
	-- end)
	-- vim.keymap.set("n", "<leader>rs", function()
	-- 	vim.lsp.buf.execute_command({ command = "rime-ls.sync-user-data" })
	-- end)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
-- local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)

-- if vim.fs.root(0, "index.norg") then
vim.lsp.start({
	name = "rime-ls",
	cmd = { "rime_ls" },
	init_options = {
		enabled = false,
		shared_data_dir = "/usr/share/rime-data",
		user_data_dir = "~/.local/share/rime-ls",
		log_dir = "~/.local/share/rime-ls",
		max_candidates = 9,
		trigger_characters = {},
		schema_trigger_character = "&", -- [since v0.2.0] 当输入此字符串时请求补全会触发 “方案选单”
	},
	capabilities = capabilities,
	-- capabilities = require("blink.cmp").get_lsp_capabilities({}),
	on_attach = rime_on_attach,
})
