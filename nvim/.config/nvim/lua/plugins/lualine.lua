-- update lualine
local function rime_status()
	if vim.g.rime_enabled then
		return "ㄓ"
	else
		return ""
	end
end

require("lualine").setup({
	sections = {
		lualine_x = {
			rime_status,
		},
		lualine_y = {},
	},
	options = {
		globalstatus = true,
		section_separators = { left = "", right = "" },
		component_separators = { left = "", right = "" },
	},
})
