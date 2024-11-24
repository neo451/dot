return {
	"echasnovski/mini.nvim",
	config = function()
		require("mini.pick").setup({})
		require("mini.icons").setup({})
		require("mini.notify").setup({})
	end,
}
