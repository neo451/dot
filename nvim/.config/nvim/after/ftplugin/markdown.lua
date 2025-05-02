vim.wo.spell = true

local buf = vim.api.nvim_get_current_buf()

local map = function(mode, lhs, rhs)
  vim.keymap.set(mode, lhs, rhs, {
    expr = true,
    silent = true,
    buffer = buf,
  })
end

map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'")
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'")

-- vim.keymap.set("n", "<Tab>", "za", { noremap = true })
-- vim.bo.omnifunc = "v:lua.vim.lsp.omnifunc"

vim.opt_local.formatoptions:append("r") -- `<CR>` in insert mode
vim.opt_local.formatoptions:append("o") -- `o` in normal mode
vim.opt_local.comments = {
  "b:>",
  "b:-",
}

-- vim.keymap.set("i", "<S-CR>", "<C-o>o<C-u>")
-- vim.keymap.set("n", "<leader><cr>", "o<bs><bs>")
--
-- local list_markers = {
--   ["-"] = true,
--   ["*"] = true,
-- }
--
-- ---@params inc boolean
-- local function do_spaces(inc)
--   return function()
--     local line = vim.api.nvim_get_current_line()
--     local trimmed = vim.trim(line)
--     local row = vim.api.nvim_win_get_cursor(0)[1]
--     local col = #line + (inc and vim.o.tabstop or -vim.o.tabstop)
--     if list_markers[trimmed:sub(1, 1)] then
--       vim.cmd.normal(inc and ">>" or "<<")
--       vim.api.nvim_win_set_cursor(0, { row, col })
--     end
--   end
-- end
--
-- vim.keymap.set({ "i", "n" }, "<Tab>", do_spaces(true))
-- vim.keymap.set({ "i", "n" }, "<S-Tab>", do_spaces(false))

-- vim.keymap.set("i", "<Tab>", "<C-o>>><C-o>A", { buffer = buf })
-- vim.keymap.set("i", "<S-Tab>", "<C-o><<<C-o>A", { buffer = buf })

vim.keymap.set("v", "<C-b>", "xi****<ESC>hhp", { desc = "Bold Selected Text" })
vim.keymap.set("n", "<leader>B", "$v0xi****<ESC>hhp", { desc = "Bold Entire Line" })
vim.keymap.set("n", "<C-b>", "bvexi****<ESC>hhp", { desc = "Bold Word Under Cursor" })

vim.keymap.set("n", "<leader>p", "<cmd>Obsidian paste_img<cr>", { desc = "ObsidianPasteImg" })

-- MiniPairs.map_buf(buf, "i", "*", { action = "open", pair = "**" })
-- MiniPairs.map_buf(buf, "i", "_", { action = "open", pair = "__" })
-- MiniPairs.map_buf(buf, "i", "`", { action = "open", pair = "``" })

vim.keymap.set("n", "grn", "<cmd>Obsidian rename<cr>", { buffer = buf })
