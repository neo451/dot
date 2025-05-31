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
  { "folke/tokyonight.nvim", priority = 1000 },
  { "catppuccin/nvim", priority = 1000 },
  { "EdenEast/nightfox.nvim", priority = 1000 },
  {
    "RedsXDD/neopywal.nvim",
    name = "neopywal",
    lazy = false,
    priority = 1000,
    opts = {},
  },
}
