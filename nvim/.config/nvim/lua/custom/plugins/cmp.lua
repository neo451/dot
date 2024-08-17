return {
   {
      "hrsh7th/nvim-cmp",
      lazy = false,
      priority = 100,
      dependencies = {
         "neovim/nvim-lspconfig",
         "onsails/lspkind.nvim",
         "hrsh7th/cmp-nvim-lsp",
         "hrsh7th/cmp-path",
         "hrsh7th/cmp-cmdline",
         "saadparwaiz1/cmp_luasnip",
         "hrsh7th/cmp-nvim-lua",
         { "L3MON4D3/LuaSnip", build = "make install_jsregexp" },
      },
      config = function()
         require("custom.completion")
      end,
   },
}
