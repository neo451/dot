vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.shortmess:append("c")

local lspkind = require("lspkind")
lspkind.init({})
local cmp = require("cmp")
local compare = require("cmp.config.compare")

cmp.setup({
	formatting = {
		format = lspkind.cmp_format({
			mode = "symbol",
			maxwidth = 50,
			ellipsis_char = "...",
			show_labelDetails = true,
			before = function(_, vim_item)
				return vim_item
			end,
		}),
	},

	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},

	mapping = {
		["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
		["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
		["<C-y>"] = cmp.mapping(
			cmp.mapping.confirm({
				behavior = cmp.ConfirmBehavior.Insert,
				select = true,
			}),
			{ "i", "c" }
		),
		-- ["<Space>"] = cmp.mapping(function(fallback)
		-- 	local entry = cmp.get_selected_entry()
		-- 	if entry == nil then
		-- 		entry = cmp.core.view:get_first_entry()
		-- 	end
		-- 	if entry and entry.source.name == "nvim_lsp" and entry.source.source.client.name == "rime_ls" then
		-- 		cmp.confirm({
		-- 			behavior = cmp.ConfirmBehavior.Replace,
		-- 			select = true,
		-- 		})
		-- 	else
		-- 		fallback()
		-- 	end
		-- end, { "i", "s" }),
		-- ["<CR>"] = cmp.mapping(function(fallback)
		-- 	local entry = cmp.get_selected_entry()
		-- 	if entry == nil then
		-- 		entry = cmp.core.view:get_first_entry()
		-- 	end
		-- 	if entry and entry.source.name == "nvim_lsp" and entry.source.source.client.name == "rime_ls" then
		-- 		cmp.abort()
		-- 	else
		-- 		if entry ~= nil then
		-- 			cmp.confirm({
		-- 				behavior = cmp.ConfirmBehavior.Replace,
		-- 				select = true,
		-- 			})
		-- 		else
		-- 			fallback()
		-- 		end
		-- 	end
		-- end, { "i", "s" }),
	},
	sorting = {
		comparators = {
			compare.sort_text,
			compare.offset,
			compare.exact,
			compare.score,
			compare.recently_used,
			compare.kind,
			compare.length,
			compare.order,
		},
	},
	sources = {
		{ name = "lazydev", group_index = 0 },
		{ name = "nvim_lsp_signature_help" },
		{ name = "nvim_lua" },
		{ name = "nvim_lsp" },
		{ name = "buffer" },
		{ name = "path" },
		{ name = "emoji" },
		{ name = "copilot", group_index = 2 },
	},
	snippet = {
		expand = function(args)
			vim.snippet.expand(args.body)
		end,
	},
})

-- Set configuration for specific filetype.
cmp.setup.filetype("gitcommit", {
	sources = cmp.config.sources({
		{ name = "git" }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
	}, {
		{ name = "buffer" },
	}),
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ "/", "?" }, {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = "buffer" },
	},
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{ name = "cmdline" },
	}),
})
