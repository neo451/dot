return {
   {
      "williamboman/mason.nvim",
      opts = {
         github = {
            download_url_template = "https://mirror.ghproxy.com/https://github.com/%s/releases/download/%s/%s",
         },
      },
   },
   {
      "neovim/nvim-lspconfig",
      ft = { "lua", "zig" },
      dependencies = {
         "williamboman/mason.nvim",
         "williamboman/mason-lspconfig.nvim",
         "WhoIsSethDaniel/mason-tool-installer.nvim",
         "nvimdev/lspsaga.nvim",
         { "j-hui/fidget.nvim", opts = {} },
         "stevearc/conform.nvim",
      },
      config = function()
         require("custom.lsp")
      end,
   },
}
