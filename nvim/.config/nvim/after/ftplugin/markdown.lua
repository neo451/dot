local buf = vim.api.nvim_get_current_buf()
vim.wo.smoothscroll = true
vim.bo.shiftwidth = 2

local map = function(mode, lhs, rhs)
  vim.keymap.set(mode, lhs, rhs, {
    expr = true,
    silent = true,
    buffer = buf,
  })
end

-- visual lines TODO: make it togglable? some times need og jk for marcos
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

vim.keymap.set("v", "<C-b>", ":lua require('markdowny').bold()<cr>", { buffer = buf })
vim.keymap.set("v", "<C-i>", ":lua require('markdowny').italic()<cr>", { buffer = buf })
vim.keymap.set("v", "<C-k>", ":lua require('markdowny').link()<cr>", { buffer = buf })
vim.keymap.set("v", "<C-e>", ":lua require('markdowny').code()<cr>", { buffer = buf })

vim.keymap.set("n", "<leader>p", "<cmd>Obsidian paste_img<cr>", { desc = "Obsidian paste_img" })

-- for LSP diagnositics
local has_otter, otter = pcall(require, "otter")
--
-- if has_otter then
--   otter.activate()
-- end
