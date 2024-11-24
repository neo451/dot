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
   -- local current_file = vim.fn.expand("%")
   -- if current_file:find("_spec") then
   -- 	-- require "neotest".run.run(vim.fn.expand("%"))
   -- 	vim.cmd("PlenaryBustedFile %")
   -- else
   vim.cmd("w")
   vim.cmd("so %")
   -- end
end

-- local motion = require("zh.motion")

-- vim.keymap.del("n", "q:")
local maps = {
   { "i",          "jk",                "<Esc>" },

   -- { { "n", "x" }, "w", motion.w },

   -- begin/end
   { { "n", "v" }, "H",                 "^" },
   { { "n", "v" }, "L",                 "$" },

   -- restore for clean
   { "n",          "<C-d>",             "<C-d>" },
   { "n",          "<C-u>",             "<C-u>" },

   -- inc/dec
   { "n",          "+",                 "<C-a>" },
   { "n",          "_",                 "<C-x>" },

   -- splits
   { "n",          "<C-w>s",            "<cmd>split<cr>" },
   { "n",          "<C-w>v",            "<cmd>vsplit<cr>" },
   { "n",          "<C-h>",             "<C-w>h" },
   { "n",          "<C-j>",             "<C-w>j" },
   { "n",          "<C-k>",             "<C-w>k" },
   { "n",          "<C-l>",             "<C-w>l" },

   --visual lines
   { { "n", "v" }, "j",                 "gj" },
   { { "n", "v" }, "k",                 "gk" },

   { { "n", "v" }, "<leader>p",         '"+p' },
   -- { { "n", "v" }, "<leader>y", '"+p' },

   -- Stay in indent mode
   { "v",          ">",                 ">gv" },
   { "v",          "<",                 "<gv" },
   { "v",          "p",                 '"_dP' },

   { "n",          "]c",                "<cmd>cnext<cr>" },
   { "n",          "[c",                "<cmd>cprev<cr>" },

   -- Better terminal navigation
   { "t",          "<C-h>",             "<C-\\><C-N><C-w>h",            term_opts },
   { "t",          "<C-j>",             "<C-\\><C-N><C-w>j",            term_opts },
   { "t",          "<C-k>",             "<C-\\><C-N><C-w>k",            term_opts },
   { "t",          "<C-l>",             "<C-\\><C-N><C-w>l",            term_opts },

   { "n",          "<leader><leader>x", eval_buffer,                    opts },
   { "n",          "-",                 "<CMD>Oil<CR>" },
   { "n",          "<leader>g",         "",                             desc = "git" },
   { "n",          "<leader>gg",        "<cmd>Neogit<cr>",              desc = "Open Neo[G]it" },

   -- { "<leader>ni", "<cmd>Neorg index<cr>", desc = "Open [N]eorg [I]ndex" },
   -- { "<M-CR>", "<Plug>(neorg.itero.next-iteration)" },
   -- { "<leader>lg", "<Plug>(neorg.looking-glass.magnify-code-block)", desc = "Neorg [L]ooking [G]lass" },

   -- { "n", "<leader>q", require("notify").dismiss, desc = "Dismiss all notifications" },

   -- some shorthands
   -- { "n", "<leader>rr", ":Rocks! install " },
   { "n",          "<leader>la",        ":lua " },

   { "n",          "<Esc>",             "<cmd>noh<cr>" },

   { "n",          "<leader>ni",        "<cmd>Neorg index<CR>" },
   { "n",          "<leader>nn",        "<cmd>Neorg<CR>" },
   { "n",          "<leader>nw",        "<cmd>Neorg workspace work<CR>" },

   -- { "n", "<leader>ff", "<cmd>Feed<cr>", desc = "Feed" },
   -- { "n", "<leader>fu", "<cmd>Feed update<cr>", desc = "Feed update" },
   -- { "n", "<leader>fl", "<cmd>Feed list_feeds<cr>", desc = "Feed list_feeds" },
   -- { "n", "<leader>ft", "<cmd>Feed telescope<cr>", desc = "Feed telescope" },
   -- { "n", "<leader>fb", "<cmd>Feed blowup<cr>", desc = "Feed blowup" },
   -- { "n", "q:", telescope.command_history, desc = "telescope q:" },
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

vim.keymap.set("n", "gf", function()
   pcall(vim.lsp.buf.format)
end)

local map = vim.keymap
-- map.set("n", "fw", "<cmd>lua require'zh.leap'.leap_jieba()<CR>") -- 搜索当前行的中文词
-- map.set("n", "fs", "<cmd>lua require'zh.leap'.leap_zh()<CR>") -- 向下搜索
-- map.set("n", "fb", "<cmd>lua require'zh.leap'.leap_zh_bak()<CR>") -- 向上搜索
-- map.set("n", "fb", "<cmd>lua require'zh.leap'.leap_zh_all()<CR>") -- 同时向上下搜索，默认先跳转到向后搜素的第一个结果
-- map.set("n", "fw", "<cmd>lua require'zh.leap'.leap_jieba()<CR>") -- 搜索当前行的中文词

for _, maping in ipairs(maps) do
   myset(maping)
end
