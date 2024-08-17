-- vim.opt.local_shiftwidth = 10
print("meta!")
local on_attach = function()
	vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = 0 })
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = 0 })
	vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, { buffer = 0 })
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { buffer = 0 })
	vim.keymap.set("n", "gr", vim.lsp.buf.rename, { buffer = 0 })
	vim.keymap.set("n", "ga", vim.lsp.buf.code_action, { buffer = 0 })
	vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { buffer = 0 })
	vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { buffer = 0 })
end

local lspconfig = require("lspconfig")

lspconfig.lua_ls.setup({
	settings = {
		Lua = {
			runtime = { version = "LuaJIT", path = vim.split(package.path, ";") },
			diagnostics = { enable = true, globals = { "vim" } },
			workspace = {
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					-- [vim.fn.expand("~/build/neovim/src/nvim/lua")] = true,
				},
			},
		},
	},
	on_attach = on_attach,
})
