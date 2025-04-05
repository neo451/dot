return {
   "stevearc/conform.nvim",
   opts = {
      format_on_save = {
         timeout_ms = 500,
         lsp_format = "fallback",
      },
      formatters_by_ft = {
         nix = { "nixfmt" },
         lua = { "stylua" },
         markdown = { "prettier", "injected" },
         html = { "prettier" },
         javascript = { "prettier" },
         typescript = { "prettier" },
      },
   },
}
