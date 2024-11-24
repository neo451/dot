Pr = function(...)
   local tab = { ... }
   for _, v in ipairs(tab) do
      print(vim.inspect(v))
   end
end

vim.filetype.add({
   extension = {
      modal = "modal",
   },
})

vim.opt.runtimepath:prepend("/home/n451/Plugins/feed.nvim")
-- require("feed")
vim.opt.runtimepath:prepend("/home/n451/Plugins/treedoc.nvim")

vim.opt.runtimepath:prepend("/home/n451/nvim-zh/")
-- require("zh.lint")

vim.opt.runtimepath:prepend("/home/n451/modal.nvim/ftplugin")
vim.opt.runtimepath:prepend("/home/n451/modal.nvim/")

vim.opt.runtimepath:prepend("/home/n451/Plugins/conceal.nvim")

local fetch_co = require "feed.parser.fetch".fetch_co
local run = require "feed.utils".run

local function curl_under_cursor()
   local url = vim.ui._get_urls()[1]
   local buf = vim.api.nvim_create_buf(false, true)
   local buf2 = vim.api.nvim_create_buf(false, true)
   run(function()
      local res = fetch_co(url, {})
      vim.cmd "split"
      vim.schedule(function()
         vim.api.nvim_set_current_buf(buf)
         vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(res.body, "\n"))
         vim.api.nvim_set_option_value("filetype", "xml", { buf = buf })
         require "conform".format({ bufnr = buf })
      end)
      vim.schedule(function()
         vim.api.nvim_set_current_buf(buf2)
         vim.api.nvim_buf_set_lines(buf2, 0, -1, false, vim.split(vim.inspect(res.headers), "\n"))
      end)
      for i, v in ipairs({ buf, buf2 }) do
         vim.keymap.set("n", "H", function()
            if vim.api.nvim_get_current_buf() == buf then
               vim.api.nvim_set_current_buf(buf2)
            else
               vim.api.nvim_set_current_buf(buf)
            end
         end, { buffer = v })
         vim.keymap.set("n", "L", function()
            if vim.api.nvim_get_current_buf() == buf then
               vim.api.nvim_set_current_buf(buf2)
            else
               vim.api.nvim_set_current_buf(buf)
            end
         end, { buffer = v })
      end
   end)
end

vim.keymap.set("n", "<leader>cl", curl_under_cursor, { noremap = true, silent = true })
