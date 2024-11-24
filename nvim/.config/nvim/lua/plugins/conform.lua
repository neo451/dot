require("conform").setup({
   formatters_by_ft = {
      markdown = { "markdownlint", "injected" },
      lua = { "stylua" },
      cpp = { "clang-format" },
      xml = { "xmllint" },
   },
})
