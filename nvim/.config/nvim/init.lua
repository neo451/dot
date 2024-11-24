vim.g.mapleader = " "
vim.g.maplocalleader = " "

local function prequire(mod)
	local ok = pcall(require, mod)
	if not ok then
		vim.notify("config." .. mod .. "failed")
	end
end

-- prequire "rock"
prequire("lazy-nvim")
prequire("key")
prequire("opt")
prequire("auto")
prequire("lsp")
prequire("dev")
vim.cmd.colorscheme("catppuccin")
