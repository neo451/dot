return {
   "tpope/vim-sleuth",
   -- better escape
   "jdhao/better-escape.vim",
   {
      "rebelot/kanagawa.nvim",
      priority = 1000,
      config = function()
         vim.cmd.colorscheme("kanagawa")
      end,
   },
   {
      "folke/todo-comments.nvim",
      event = "VimEnter",
      dependencies = { "nvim-lua/plenary.nvim" },
      opts = { signs = false },
   },
   { "aserowy/tmux.nvim", opts = {} },
}
