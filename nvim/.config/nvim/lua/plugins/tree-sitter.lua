for _, config in pairs(require("nvim-treesitter.parsers").get_parser_configs()) do
	config.install_info.url =
		config.install_info.url:gsub("https://github.com/", "https://mirror.ghproxy.com/https://github.com/")
end

---@diagnostic disable-next-line: missing-fields
require("nvim-treesitter.configs").setup({
	-- ensure_installed = { "xml", "html", "markdown" },
	-- ensure_installed = { "c", "haskell", "lua", "ocaml", "zig", "luadoc", "markdown", "markdown_inline" },
	-- auto_install = true,
	highlight = { enable = true },
	indent = { enable = true },
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "gnn",
			node_incremental = "+",
			node_decremental = "-",
		},
	},
})

vim.wo.foldmethod = "expr"
vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"

require("nvim-treesitter.configs").setup({
	textobjects = {
		swap = {
			enable = true,
			swap_next = {
				["<leader>]"] = "@parameter.inner",
			},
			swap_previous = {
				["<leader>["] = "@parameter.inner",
			},
		},
		select = {
			enable = true,
			lookahead = true,
			keymaps = {
				["af"] = "@function.outer",
				["if"] = "@function.inner",
			},
			selection_modes = {
				["@parameter.outer"] = "v", -- charwise
				["@function.outer"] = "V", -- linewise
			},
		},
	},
})
