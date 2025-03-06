return {
   "NeogitOrg/neogit",
   dependencies = {
      "nvim-lua/plenary.nvim", -- required
      "sindrets/diffview.nvim", -- optional - Diff integration
   },
   config = true,
   keys = {
      {
         "<leader>gg",
         "<cmd>Neogit<cr>",
         desc = "Neo Git",
      },
   },
}
