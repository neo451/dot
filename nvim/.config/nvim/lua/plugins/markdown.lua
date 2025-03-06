return {
   {
      "OXY2DEV/markview.nvim",
      -- lazy = true,
      enabled = false,
   },
   {
      "MeanderingProgrammer/render-markdown.nvim",
      dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.icons" },
      ---@module 'render-markdown'
      ---@type render.md.UserConfig
      opts = {},
      enabled = true,
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
