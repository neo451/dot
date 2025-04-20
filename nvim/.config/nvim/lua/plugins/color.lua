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
    "folke/tokyonight.nvim",
    -- name = "catppuccin",
    priority = 1000,
    -- config = function()
    --   vim.cmd.colorscheme("dracula")
    -- end,
  },
  "catppuccin/nvim",
  "rebelot/kanagawa.nvim",
  "thesimonho/kanagawa-paper.nvim",
  "ramojus/mellifluous.nvim",
  "ribru17/bamboo.nvim",
  {
    "fynnfluegge/monet.nvim",
    name = "monet",
  },
  {
    "catgoose/nvim-colorizer.lua",
    event = "BufReadPre",
    opts = { -- set to setup table
    },
  },
}
