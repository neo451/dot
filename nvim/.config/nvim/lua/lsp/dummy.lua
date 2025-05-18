local ms = vim.lsp.protocol.Methods

local cap = {
  capabilities = {
    declarationProvider = true,
    documentLinkProvider = true,
    textDocumentSync = {
      openClose = true,
      change = 1,
    },
  },
  serverInfo = {
    name = "dummy-ls",
    version = "1.0.0",
  },
}

local res = {
  {
    target = "https://dummy.io", -- TODO: resolve to path
    range = {
      start = { line = 0, character = 0 },
      ["end"] = { line = 0, character = 10 },
    },
  },
}

return {
  cmd = function()
    return {
      request = function(method, params, handler, _)
        if method == ms.textDocument_documentLink then
          -- vim.print(res)
          handler(nil, res)
        elseif method == ms.initialize then
          handler(nil, cap)
        end
      end,
      notify = function(method, params, handler, _) end,
      is_closing = function() end,
      terminate = function() end,
    }
  end,
  filetypes = { "go" },
}
