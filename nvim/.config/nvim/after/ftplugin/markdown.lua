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

local list_markers = {
  ["-"] = true,
  ["*"] = true,
}

---@params inc boolean
local function do_spaces(inc)
  return function()
    local line = vim.api.nvim_get_current_line()
    local trimmed = vim.trim(line)
    if list_markers[trimmed:sub(1, 1)] then
      return inc and "<C-t>" or "<C-d>"
    else
      return inc and "<Tab>" or "<S-Tab>"
    end
  end
end

map("i", "<Tab>", do_spaces(true))
map("i", "<S-Tab>", do_spaces(false))

-- TODO: Auto callouts and lists
vim.opt_local.formatoptions:append("r") -- `<CR>` in insert mode
vim.opt_local.formatoptions:append("o") -- `o` in normal mode
vim.opt_local.comments = {
  "b:>",
  "b:-",
  "b:*",
}

-- TODO: new line without auto comment, see orgmode
-- vim.keymap.set("i", "<S-CR>", "<C-o>o<C-u>")
-- vim.keymap.set("n", "<leader><cr>", "o<bs><bs>")

vim.keymap.set("v", "<C-b>", "xi****<ESC>hhp", { desc = "Bold Selected Text" })
vim.keymap.set("n", "<leader>B", "$v0xi****<ESC>hhp", { desc = "Bold Entire Line" })
vim.keymap.set("n", "<C-b>", "bvexi****<ESC>hhp", { desc = "Bold Word Under Cursor" })

vim.keymap.set("n", "<leader>p", "<cmd>Obsidian paste_img<cr>", { desc = "Obsidian paste_img" })

-- for LSP diagnositics
local has_otter, otter = pcall(require, "otter")

if has_otter then
  otter.activate()
end
