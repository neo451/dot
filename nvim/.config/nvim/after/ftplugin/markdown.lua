vim.opt.fillchars = {
   foldopen = "",
   foldclose = "",
   fold = " ",
   foldsep = " ",
   diff = "╱",
   eob = " ",
}
vim.wo.foldmethod = "expr"
vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.wo.smoothscroll = true
vim.wo.foldtext = ""
vim.wo.foldlevel = 99
vim.bo.shiftwidth = 2

local buf = vim.api.nvim_get_current_buf()

vim.keymap.set("n", "<Tab>", "za", { buffer = buf })
