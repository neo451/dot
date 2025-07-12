return {
  {
    "derektata/lorem.nvim",
    config = function()
      require("lorem").opts({
        sentence_length = "medium",
        comma_chance = 0.2,
        max_commas = 2,
      })
    end,
  },
  {
    "preservim/vim-litecorrect",
    ft = "markdown",
  },
  -- Lua
  {
    "folke/twilight.nvim",
    ft = "markdown",
    cond = false,
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
  },
  -- visual mode maps for adding links, bold, italic and inline
  {
    "antonk52/markdowny.nvim",
    opts = {},
  },

  {
    "hamidi-dev/org-list.nvim",
    dependencies = {
      "tpope/vim-repeat", -- for repeatable actions with '.'
    },
    opts = {
      checkbox_toggle = {
        key = "<leader>cH",
      },
    },
  },

  {
    "dhruvasagar/vim-table-mode",
    ft = { "markdown" },
  },
}
