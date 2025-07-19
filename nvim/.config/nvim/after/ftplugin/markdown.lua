-- pcall(function()
--   require("otter").activate()
-- end)

vim.keymap.del("i", "<leader>f", { buffer = true })
vim.keymap.del("i", "<leader>r", { buffer = true })

vim.keymap.set("i", "<localleader>f", "<Plug>AddVimFootnote", { buffer = true })
vim.keymap.set("i", "<localleader>r", "<Plug>ReturnFromFootnote", { buffer = true })
