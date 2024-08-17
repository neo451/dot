return {
   {
      "nvim-treesitter/nvim-treesitter",
      build = ":TSInstall",
      config = function()
         require("custom.treesitter")
      end,
   },
   "nvim-treesitter/nvim-treesitter-textobjects",
   "nvim-treesitter/nvim-treesitter-context",
}
