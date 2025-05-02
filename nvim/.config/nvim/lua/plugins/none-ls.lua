return {
  "nvimtools/none-ls.nvim",
  cond = vim.fn.has"nvim-0.11" ~= 1,
  config = function()
    local null_ls = require("null-ls")
    null_ls.setup({
      sources = {
        null_ls.builtins.code_actions.gitsigns,
        null_ls.builtins.code_actions.refactoring,
        null_ls.builtins.diagnostics.selene,
      },
    })
  end,
}
