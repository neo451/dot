return {
  {
    "folke/styler.nvim",
    opts = {
      themes = {
        markdown = { colorscheme = "duskfox" },
        help = { colorscheme = "github_dark", background = "dark" },
        feed = { colorscheme = "kanagawa" },
      },
    },
  },
  { "projekt0n/github-nvim-theme", name = "github-theme" },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    config = function()
      vim.cmd("colorscheme rose-pine")
    end,
  },
  {
    "rasulomaroff/reactive.nvim",
    event = "BufEnter",
    opts = {
      builtin = {
        cursorline = true,
        cursor = true,
        modemsg = true,
      },
    },
  },
  { "folke/tokyonight.nvim", priority = 1000 },
  { "catppuccin/nvim", priority = 1000 },
  { "EdenEast/nightfox.nvim", priority = 1000 },
  { "rebelot/kanagawa.nvim", priority = 1000 },
}
