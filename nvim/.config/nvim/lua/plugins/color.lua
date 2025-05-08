return {
  {
    "webhooked/kanso.nvim",
    lazy = false,
    priority = 1000,
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
  {
    "folke/tokyonight.nvim",
    cond = true,
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
