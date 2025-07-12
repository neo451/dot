--- @type vim.lsp.ClientConfig
return {
  name = "fish_lsp",
  cmd = { "fish-lsp", "start" },
  filetypes = { "fish" },
  root_markers = {
    ".git",
    "config.fish",
  },
}
