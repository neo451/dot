return {
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
  {
    "folke/tokyonight.nvim",
    cond = false,
  },
  {
    "catppuccin/nvim",
    cond = false,
  },
  {
    "EdenEast/nightfox.nvim",
    priority = 1000,
  },
}
