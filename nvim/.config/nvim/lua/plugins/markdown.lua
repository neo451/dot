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
  {
    "michaelb/sniprun",
    build = "sh install.sh",
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
    "jmbuhr/otter.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    ft = { "markdown" },
    opts = {},
  },

  {
    "dhruvasagar/vim-table-mode",
    ft = { "markdown" },
  },

  {
    "OXY2DEV/markview.nvim",
    lazy = false,
    cond = vim.g.markdown_renderer == "markview",
  },

  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.icons" },
    ft = { "markdown" },
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {
      latex = {
        enabled = false,
      },
      heading = {
        icons = { "◉ ", "◎ ", "○ ", "✺ ", "▶ ", "⤷ " },
      },
    },
    -- cond = vim.g.markdown_renderer == "render-markdown",
  },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = "cd app && yarn install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
  },
}
