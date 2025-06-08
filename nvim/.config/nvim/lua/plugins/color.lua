return {
  {
    "folke/styler.nvim",
    opts = {
      themes = {
        markdown = { colorscheme = "duskfox" },
        help = { colorscheme = "github_dark", background = "dark" },
      },
    },
  },
  { "projekt0n/github-nvim-theme", name = "github-theme" },
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
}
