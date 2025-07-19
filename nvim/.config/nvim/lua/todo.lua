local api = vim.api

local function open()
  local buf = api.nvim_create_buf(false, true)
  local win = api.nvim_open_win(buf, false, {
    anchor = "SE",
    relative = "editor",
    row = 0,
    col = vim.o.columns,
    width = math.floor(vim.o.columns / 4),
    height = math.floor(vim.o.lines / 4),
  })

  local function update(config)
    api.nvim_win_set_config(win, config)
  end

  vim.bo[buf].filetype = "markdown"
  vim.wo[win].number = false
  vim.wo[win].relativenumber = false
  vim.wo[win].wrap = false
  vim.wo[win].statuscolumn = ""
  vim.wo[win].signcolumn = "no"
  vim.api.nvim_win_call(win, function()
    vim.cmd.edit("/home/n451/Notes/TODO.md")
    update({
      height = api.nvim_buf_line_count(buf) - 6,
    })
    vim.api.nvim_win_set_cursor(win, { 1, 0 })
    vim.cmd("norm ]]zt")
  end)
end

return open
