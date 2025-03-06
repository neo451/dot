local M = {}

M.config = {
   cmd = { vim.o.shell },
   winopt = {
      relative = "editor",
      col = math.floor(vim.o.columns * 0.1),
      row = math.floor(vim.o.lines * 0.1),
      width = math.floor(vim.o.columns * 0.8),
      height = math.floor(vim.o.lines * 0.8),
      border = "rounded",
      style = "minimal",
      title = "toggleterm!",
      hide = true,
   },
}

M.toggleterm = function()
   if not vim.api.nvim_buf_is_valid(M.buf or -1) then
      M.buf = vim.api.nvim_create_buf(false, false)
   end
   M.win = vim.iter(vim.fn.win_findbuf(M.buf)):find(function(b_wid)
      return vim.iter(vim.api.nvim_tabpage_list_wins(0)):any(function(t_wid)
         return b_wid == t_wid
      end)
   end) or vim.api.nvim_open_win(M.buf, false, M.config.winopt)

   if vim.api.nvim_win_get_config(M.win).hide then
      vim.api.nvim_win_set_config(M.win, { hide = false })
      vim.api.nvim_set_current_win(M.win)
      if vim.bo[M.buf].channel <= 0 then
         vim.fn.termopen(M.config.cmd)
      end
      vim.cmd("startinsert")
   else
      vim.api.nvim_win_set_config(M.win, { hide = true })
      vim.api.nvim_set_current_win(vim.fn.win_getid(vim.fn.winnr("#")))
   end
end

-- vim.keymap.set("n", "<leader>tt", M.toggleterm)
-- vim.keymap.set("n", "<C-/>", M.toggleterm)
vim.keymap.set("t", "<C-/>", "<cmd>close<cr>")
--
return M
