local set = vim.keymap.set

set("n", "grl", function()
  vim.lsp.buf.document_link({ loclist = false })
end)

-- mini version controls
set("n", "ycc", function()
  return "yy" .. vim.v.count1 .. "gcc']p"
end, { remap = true, expr = true })

-- fix previous spell error
set("i", "<C-l>", "<c-g>u<Esc>[s1z=g<c-g>u")

--search within visual selection - this is magic
set("x", "/", "<Esc>/\\%V")

-- better J: keep cursor in place
set("n", "J", "mzJ`z:delmarks z<cr>")

set("i", "jk", "<esc>")

set("n", "<leader><leader>x", "<cmd>w<cr><cmd>so %<cr>")
-- set("n", "<leader><leader>x", function()
--   -- local base = vim.fs.basename(vim.fn.expand("%"))
--   -- if vim.startswith(base, "test_") then
--   --   return "<cmd>lua MiniTest.run_file()<cr>"
--   -- end
--   return "<cmd>w<cr><cmd>so %<cr>"
-- end, { expr = true })

set("n", "<C-/>", function()
  Snacks.terminal.toggle()
end, { desc = "Terminal" })

set("n", "<leader>/", function()
  Snacks.picker.grep()
end, { desc = "Grep" })

set("n", "<leader>fc", function()
  Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
end, { desc = "Find Config File" })

set("n", "<leader>fp", function()
  Snacks.picker.projects()
end, { desc = "Find Prject" })

set("n", "<leader>fR", function()
  Snacks.picker.resume()
end, { desc = "Resume" })

set("n", "<leader>,", function()
  Snacks.picker.buffers()
end, { desc = "Buffers" })

set("n", "<leader>fr", function()
  Snacks.picker.recent()
end, { desc = "Recent" })

set("n", "<leader>n", function()
  Snacks.notifier.show_history()
end, { desc = "Notification History" })

set("n", "<leader>P", function()
  Snacks.picker()
end, { desc = "All pickers" })

set("n", "<leader>os", function()
  local opt = require("obsidian").get_client().opts.legacy_commands
  local legacy = opt == true or (opt == nil)
  return legacy and "<cmd>ObsidianQuickSwitch<cr>" or "<cmd>Obsidian quick_switch<cr>"
end, { expr = true })

set("n", "<leader>on", function()
  local opt = require("obsidian").get_client().opts.legacy_commands
  local legacy = opt == true or (opt == nil)
  return legacy and "<cmd>ObsidianNew<cr>" or "<cmd>Obsidian new<cr>"
end, { expr = true })

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
set("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next Search Result" })
set("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
set("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
set("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "Prev Search Result" })
set("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })
set("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })

-- -- Resize window using <ctrl> arrow keys
-- map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
-- map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
-- map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
-- map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })
--
-- -- Move Lines
-- map("n", "<A-j>", "<cmd>execute 'move .+' . v:count1<cr>==", { desc = "Move Down" })
-- map("n", "<A-k>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = "Move Up" })
-- map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
-- map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
-- map("v", "<A-j>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = "Move Down" })
-- map("v", "<A-k>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = "Move Up" })
--
-- -- buffers
set("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
set("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next Buffer" })
-- map("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
-- map("n", "<leader>`", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
-- map("n", "<leader>bD", "<cmd>:bd<cr>", { desc = "Delete Buffer and Window" })
--
-- -- Clear search with <esc>
-- map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and Clear hlsearch" })
--
-- -- Clear search, diff update and redraw
-- -- taken from runtime/lua/_editor.lua
-- map(
--    "n",
--    "<leader>ur",
--    "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>",
--    { desc = "Redraw / Clear hlsearch / Diff Update" }
-- )

-- Add undo break-points
set("i", ",", ",<c-g>u")
set("i", ".", ".<c-g>u")
set("i", ";", ";<c-g>u")

-- keywordprg
set("n", "<leader>K", "<cmd>norm! K<cr>", { desc = "Keywordprg" })

-- better indenting
set("v", "<", "<gv")
set("v", ">", ">gv")

-- highlights under cursor
set("n", "<leader>ui", vim.show_pos, { desc = "Inspect Pos" })
set("n", "<leader>uI", "<cmd>InspectTree<cr>", { desc = "Inspect Tree" })
