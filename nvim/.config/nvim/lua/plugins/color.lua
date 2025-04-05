return {
   {
      "rasulomaroff/reactive.nvim",
      opts = {
         builtin = {
            cursorline = true,
            cursor = true,
            modemsg = true,
         },
      },
   },
   {
      "catppuccin/nvim",
      name = "catppuccin",
      priority = 1000,
      config = function()
         vim.cmd.colorscheme("catppuccin")
      end,
   },
   { "folke/tokyonight.nvim" },
   "rebelot/kanagawa.nvim",
   "alexxGmZ/e-ink.nvim",
}
