-- normal_mode = "n",
-- insert_mode = "i",
-- visual_mode = "v",
-- visual_block_mode = "x",
-- term_mode = "t",
-- command_mode = "c",

local opts = { noremap = true, silent = true }
local term_opts = { silent = true }
vim.g.mapleader = " "

local function eval_buffer()
	local current_file = vim.fn.expand("%")
	if current_file:find("_spec") then
		-- require "neotest".run.run(vim.fn.expand("%"))
		vim.cmd("PlenaryBustedFile %")
	else
		vim.cmd("w")
		vim.cmd("so %")
	end
end

local telescope = require("telescope.builtin")
local motion = require("zh.motion")

local maps = {
	{ "i", "jk", "<Esc>" },

	{ { "n", "x" }, "w", motion.w },

	-- begin/end
	{ "n", "H", "^" },
	{ "n", "L", "$" },

	-- restore for clean
	{ "n", "<C-d>", "<C-d>" },
	{ "n", "<C-u>", "<C-u>" },

	-- inc/dec
	{ "n", "+", "<C-a>" },
	{ "n", "_", "<C-x>" },

	-- splits
	{ "n", "<C-w>s", "<cmd>split<cr>" },
	{ "n", "<C-w>v", "<cmd>vsplit<cr>" },
	{ "n", "<C-h>", "<C-w>h" },
	{ "n", "<C-j>", "<C-w>j" },
	{ "n", "<C-k>", "<C-w>k" },
	{ "n", "<C-l>", "<C-w>l" },

	--visual lines
	{ { "n", "v" }, "j", "gj" },
	{ { "n", "v" }, "k", "gk" },

	-- Stay in indent mode
	{ "v", ">", ">gv" },
	{ "v", "<", "<gv" },
	{ "v", "p", '"_dP' },

	-- Better terminal navigation
	{ "t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts },
	{ "t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts },
	{ "t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts },
	{ "t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts },

	{ "n", "<leader><leader>x", eval_buffer, opts },
	{ "n", "-", "<CMD>Oil<CR>" },
	{ "n", "<leader>g", "", desc = "git" },
	{ "n", "<leader>gg", "<cmd>Neogit<cr>", desc = "Open Neo[G]it" },

	-- { "<leader>ni", "<cmd>Neorg index<cr>", desc = "Open [N]eorg [I]ndex" },
	-- { "<M-CR>", "<Plug>(neorg.itero.next-iteration)" },
	-- { "<leader>lg", "<Plug>(neorg.looking-glass.magnify-code-block)", desc = "Neorg [L]ooking [G]lass" },

	{ "n", "<leader>q", require("notify").dismiss, desc = "Dismiss all notifications" },

	-- telescope
	{ "n", "<leader>s", "", desc = "telscope" },
	{ "n", "<leader>sf", telescope.find_files, desc = "[S]earch [F]iles" },
	{ "n", "<leader>sb", telescope.builtin, desc = "[S]earch [B]uiltin" },
	{ "n", "<leader>sr", telescope.resume, desc = "[S]earch [R]esume" },
	{ "n", "<leader>sg", telescope.live_grep, desc = "[S]earch [G]rep" },
	{
		"n",
		"<leader>sn",
		function()
			telescope.find_files({ cwd = vim.fn.stdpath("config") })
		end,
		desc = "[S]earch [N]eovim files",
	},

	-- lsp
	{ "n", "K", vim.lsp.buf.hover },
	{ "n", "gd", vim.lsp.buf.definition },

	-- some shorthands
	{ "n", "<leader>rr", ":Rocks! install " },
	{ "n", "<leader>la", ":lua " },

	{ "n", "<Esc>", "<cmd>noh<cr>" },
}

vim.keymap.set({ "i", "s" }, "<c-k>", function()
	if vim.snippet.active({ direction = 1 }) then
		return "<Cmd>lua vim.snippet.jump(1)<CR>"
	else
		return "<c-k>"
	end
end, { expr = true })

vim.keymap.set({ "i", "s" }, "<c-j>", function()
	if vim.snippet.active({ direction = -1 }) then
		return "<Cmd>lua vim.snippet.jump(-1)<CR>"
	else
		return "<c-j>"
	end
end, { expr = true })

local function myset(t)
	local options = {}
	for k, v in pairs(t) do
		if not vim.islist(v) and type(v) == "table" then
			options = vim.tbl_extend("force", options, v)
		end
		if type(k) == "string" then
			options[k] = v
		end
	end
	return vim.keymap.set(t[1], t[2], t[3], options)
end

local map = vim.keymap
map.set("n", "fw", "<cmd>lua require'zh.leap'.leap_jieba()<CR>") -- 搜索当前行的中文词
map.set("n", "fs", "<cmd>lua require'zh.leap'.leap_zh()<CR>") -- 向下搜索
map.set("n", "fb", "<cmd>lua require'zh.leap'.leap_zh_bak()<CR>") -- 向上搜索
map.set("n", "fb", "<cmd>lua require'zh.leap'.leap_zh_all()<CR>") -- 同时向上下搜索，默认先跳转到向后搜素的第一个结果
map.set("n", "fw", "<cmd>lua require'zh.leap'.leap_jieba()<CR>") -- 搜索当前行的中文词

for _, map in ipairs(maps) do
	myset(map)
end
