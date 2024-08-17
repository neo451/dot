return {
   "folke/trouble.nvim",
   opts = {},
   cmd = "Trouble",
   keys = {
      {
         "<leader>td",
         "<cmd>Trouble diagnostics toggle<cr>",
         desc = "Diagnostics (Trouble)",
      },
      { "<leader>ts", "<cmd>Trouble lsp toggle<cr>", desc = "LSP ref/def (Trouble)" },
   },
}