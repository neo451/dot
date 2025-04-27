local t = {
  ["/home/n451/Notes/dem jointz.md"] = [[
set nospell
  ]],
}

for file, cmd in pairs(t) do
  vim.api.nvim_create_autocmd("BufEnter", {
    pattern = file,
    callback = function()
      vim.cmd(cmd)
    end,
  })
end
