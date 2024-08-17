return {
   "Bekaboo/dropbar.nvim",
   dependencies = {
      "nvim-telescope/telescope-fzf-native.nvim",
   },
   keys = {
      { "<leader>bb", "<cmd>lua require('dropbar.api').pick()<cr>" },
   },
}
