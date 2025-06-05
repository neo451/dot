local servers = {
  "lua_ls",
  "gopls",
  "harper_ls",
  "nixd",
  "rime_ls",
  "zls",
  -- "copilot_ls",
  -- "dummy",
}

for name in vim.iter(servers) do
  pcall(vim.lsp.enable, name)
end
