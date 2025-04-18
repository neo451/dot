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
      opts = {
         -- win_options = {
         --    concealcursor = {
         --       -- rendered = "nvc",
         --    },
         -- },
         checkbox = {
            custom = {
               -- todo = { raw = "[-]", rendered = "󰥔 ", highlight = "RenderMarkdownTodo", scope_highlight = nil },
               -- ["x"] = { order = 5, char = "", hl_group = "ObsidianDone" },
               -- [" "] = { order = 1, char = "󰄱", hl_group = "ObsidianTodo" },
               tilde = { raw = "[~]", rendered = "󰰱 ", highlight = "RenderMarkdownTodo" },
               important = { raw = "[!]", rendered = " ", highlight = "RenderMarkdownTodo" },
               right_arrow = { raw = "[>]", rendered = " ", highlight = "RenderMarkdownTodo" },
            },
         },
      },
      enabled = false,
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
