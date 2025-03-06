return {
   {
      "stevearc/oil.nvim",
      config = function()
         vim.keymap.set("n", "-", "<cmd>Oil<cr>")
         require("oil").setup({
            skip_confirm_for_simple_edits = true,
            win_options = {
               signcolumn = "yes:2",
            },
            view_options = {
               show_hidden = true,
            },
         })
      end,
   },
   {
      "refractalize/oil-git-status.nvim",
      config = true,
   },
   {
      "JezerM/oil-lsp-diagnostics.nvim",
      dependencies = { "stevearc/oil.nvim" },
      opts = {},
   },
}
