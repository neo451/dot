local has_blink = pcall(require, "blink.cmp")
local capabilities = has_blink and require("blink.cmp").get_lsp_capabilities()
  or vim.lsp.protocol.make_client_capabilities()

return {
  cmd = { "gopls" },
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  root_markers = {
    "go.work",
    "go.mod",
    ".git",
  },
  capabilities = capabilities,
}
