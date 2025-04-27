return {
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
      heading = {
        icons = { "◉ ", "◎ ", "○ ", "✺ ", "▶ ", "⤷ " },
      },
    },
    cond = vim.g.markdown_renderer == "render-markdown",
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
