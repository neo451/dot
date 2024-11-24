vim.api.nvim_create_autocmd("BufWritePre", {
   callback = function()
      -- vim.lsp.buf.format()
      require("conform").format()
   end,
})

vim.api.nvim_create_autocmd("LspAttach", {
   callback = function(args)
      local bufnr = args.buf
      local opts = { buffer = bufnr }
      local set = vim.keymap.set
      set("n", "K", vim.lsp.buf.hover, opts)
      set("n", "gd", vim.lsp.buf.definition, opts)
      set("n", "gf", require "conform".format, opts)
      vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"
      -- local filetype = vim.bo[bufnr].filetype
      -- if disable_semantic_tokens[filetype] then
      -- 	client.server_capabilities.semanticTokensProvider = nil
      -- end
   end,
})

-- local lspconfig = require("lspconfig")
--
-- lspconfig.grammarly.setup({})
