require("conform").setup({
	formatters_by_ft = {
		markdown = { "markdownlint" },
		lua = { "stylua" },
		zig = { "zig fmt" },
		cpp = { "clang-format" },
	},
})
