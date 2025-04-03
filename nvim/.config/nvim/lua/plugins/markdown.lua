return {
   -- {
   -- "OXY2DEV/markview.nvim",
   -- -- lazy = true,
   -- enabled = true,
   -- },
   {
      "MeanderingProgrammer/render-markdown.nvim",
      dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.icons" },
      ---@module 'render-markdown'
      ---@type render.md.UserConfig
      opts = {
         win_options = {
            concealcursor = {
               rendered = "nvc",
            },
         },
      },
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
