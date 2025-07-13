local harpoon = require("harpoon")
harpoon:setup()

vim.keymap.set("n", "<leader>a", function()
  harpoon:list():add()
end)

vim.keymap.set("n", "<C-e>", function()
  harpoon.ui:toggle_quick_menu(harpoon:list())

  local winids = vim.api.nvim_list_wins()

  local harpoon_win = vim.iter(winids):find(function(winid)
    local buf = vim.api.nvim_win_get_buf(winid)
    return vim.bo[buf].filetype == "harpoon"
  end)

  if not harpoon_win then
    return
  end

  vim.api.nvim_win_set_config(harpoon_win, {
    anchor = "NW",
    col = 0,
    row = 0,
    relative = "editor",
  })
end)

for i = 1, 5 do
  vim.keymap.set("n", "<leader>" .. i, function()
    harpoon:list():select(i)
  end)
end
