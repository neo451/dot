local opts = { noremap = true, silent = true }

local term_opts = { silent = true }
vim.g.mapleader = " "

-- normal_mode = "n",
-- insert_mode = "i",
-- visual_mode = "v",
-- visual_block_mode = "x",
-- term_mode = "t",
-- command_mode = "c",
local set = vim.keymap.set

-- my_plugs
set("n", "<leader>oi", "<cmd>lua require'orca'.start()<CR>", opts)
set("n", "<leader>os", "<cmd>lua require'orca'.stop()<CR>", opts)

local maps = {
   { "i", "jk", "<Esc>" },
   -- begin/end
   { "n", "H", "^" },
   { "n", "L", "$" },
   -- inc/dec
   { "n", "+", "<C-a>" },
   { "n", "_", "<C-x>" },
   -- splits
   { "n", "<C-h>", "<C-w>h" },
   { "n", "<C-j>", "<C-w>j" },
   { "n", "<C-k>", "<C-w>k" },
   { "n", "<C-l>", "<C-w>l" },
   --visual lines
   { "n", "j", "gj" },
   { "n", "k", "gk" },
   -- Stay in indent mode
   { "v", ">", ">gv" },
   { "v", "<", "<gv" },
   { "v", "p", '"_dP' },
   -- Better terminal navigation
   { "t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts },
   { "t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts },
   { "t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts },
   { "t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts },

   { "n", "<leader>ts", "<cmd>PlenaryBustedFile %<cr>", opts },
   { "n", "<leader><leader>x", "<cmd>w<cr>:so %<cr>", opts },
   { "n", "<leader>fl", "<cmd>Lazy<cr>", opts },
}

for _, map in pairs(maps) do
   set(unpack(map))
end
