-- if not vim.g.lua_loaded then
local root_files = {
	".luarc.json",
	".luarc.jsonc",
	".luacheckrc",
	".stylua.toml",
	"stylua.toml",
	"selene.toml",
	"selene.yml",
	".busted",
	"README.md",
}

local root = vim.fs.root(0, root_files)

vim.lsp.start({
	name = "lua_ls",
	cmd = { "lua-language-server" },
	root_dir = root,
	--capabilities = require("blink.cmp").get_lsp_capabilities({}),
})

local set = vim.opt_local

set.formatoptions:remove("o")
-- vim.g.lua_loaded = true
-- end
