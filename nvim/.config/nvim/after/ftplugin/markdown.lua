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
vim.wo.conceallevel = 1

local buf = vim.api.nvim_get_current_buf()

local map = function(mode, lhs, rhs)
  vim.keymap.set(mode, lhs, rhs, {
    expr = true,
    silent = true,
    buffer = buf,
  })
end

map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'")
map({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'")
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'")
map({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'")

-- vim.keymap.set("n", "<Tab>", "za", { noremap = true })
vim.bo.omnifunc = "v:lua.vim.lsp.omnifunc"

local f = Snacks and Snacks.picker.lsp_symbols or vim.lsp.buf.workspace_symbol

vim.keymap.set("n", "gO", f, {
  buffer = buf,
})
