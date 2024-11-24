local Harpoonline = require("harpoonline")
Harpoonline.setup({
	on_update = function()
		require("lualine").refresh()
	end,
})

local harpoon = { Harpoonline.format, "filename" }

local lualine = require("lualine")
lualine.setup({
	options = {
		component_separators = "",
		section_separators = "",
	},
})
