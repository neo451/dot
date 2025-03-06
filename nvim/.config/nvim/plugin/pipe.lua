local api = vim.api

---@param lines? string[]
---@return { win: integer, buf: integer }
local function create_split(lines)
   lines = lines or {}
   local buf = api.nvim_create_buf(false, true)
   local win = api.nvim_open_win(buf, true, {
      relative = "editor",
      row = math.floor(vim.o.lines / 2),
      col = 0,
      height = math.floor(vim.o.lines / 2),
      width = vim.o.columns,
   })

   api.nvim_buf_set_lines(buf, 0, -1, false, lines)
   api.nvim_set_option_value("number", false, { win = win })
   api.nvim_set_option_value("relativenumber", false, { win = win })
   api.nvim_set_option_value("modifiable", false, { buf = buf })

   api.nvim_win_set_cursor(win, { #lines, 0 })
   return { win = win, buf = buf }
end

local M = {}

M.open = function(cmd)
   cmd = vim.F.if_nil(cmd, "mes")
   local output = vim.api.nvim_exec2(cmd, { output = true }).output
   create_split(vim.split(output, "\n"))
   vim.keymap.set("n", "q", "<cmd>close<cr>")
end

vim.api.nvim_create_user_command("M", function(opt)
   if not vim.tbl_isempty(opt.fargs) then
      M.open(table.concat(opt.fargs, " "))
   else
      M.open()
   end
end, {
   nargs = "*",
   complete = function()
      return { "jumps", "hi", "aunmenu" }
   end,
})

return M
