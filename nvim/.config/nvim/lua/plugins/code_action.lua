return {
  {
    cond = false,
    "yarospace/dev-tools.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    specs = {
      {
        "folke/snacks.nvim",
        opts = { picker = { enabled = true } },
      },
    },
    opts = {
      -- actions = {},
      --
      filetypes = { -- filetypes for which to attach the LSP
        include = { "lua" },
        exclude = {},
      },
      --
      -- builtin_actions = {
      --   include = {}, -- filetype/category/title of actions to include
      --   exclude = {}, -- filetype/category/title of actions to exclude or true to exclude all
      -- },
      --
      -- override_ui = true, -- override vim.ui.select with dev-tools actions picker
      -- debug = false, -- extra debug info on errors
      -- cache = true, -- cache actions at startup (disable when developing actions)
    },
  },
}
