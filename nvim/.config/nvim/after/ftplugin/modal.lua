vim.lsp.start({
   name = "modalsp",
   cmd = {
      "luajit",
      "/home/n451/modal/lsp/server.lua",
   },
   root_dir = "/home/n451/modal/lsp/",
   capabilities = vim.lsp.protocol.make_client_capabilities(),
   -- on_attach = function()
   --    vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = 0 })
   --    vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = 0 })
   --    vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, { buffer = 0 })
   --    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { buffer = 0 })
   --    vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, { buffer = 0 })
   --    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = 0 })
   --    vim.keymap.set("n", "<Up>", vim.diagnostic.goto_prev, { buffer = 0 })
   --    vim.keymap.set("n", "<Down>", vim.diagnostic.goto_next, { buffer = 0 })
   -- end,
})
print("tried!")
