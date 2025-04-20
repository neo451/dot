local has_blink = pcall(require, "blink.cmp")
local capabilities = has_blink and require("blink.cmp").get_lsp_capabilities()
  or vim.lsp.protocol.make_client_capabilities()

return {
  cmd = { "harper-ls", "--stdio" },
  capabilities = capabilities,
  root_markers = {
    ".git",
    -- for obsidian
    ".obsidian",
    ".trash",
  },
  filetypes = {
    "gitcommit",
    "typst",
    "markdown",
    "txt",
    "org",
    "norg",
  },
}
