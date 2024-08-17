return {
   "NeogitOrg/neogit",
   event = "VeryLazy",
   dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
   },
   config = true,
   keys = {
      { "<leader>gg", "<cmd>Neogit<cr>", desc = "Open Neo[G]it" },
   },
}
