Pr = function(...)
	local tab = { ... }
	for _, v in ipairs(tab) do
		print(vim.inspect(v))
	end
end

vim.opt.runtimepath:prepend("/home/n451/Plugins/feed.nvim")
require("feed")

vim.opt.runtimepath:prepend("/home/n451/nvim-zh/")
require("zh.lint")
