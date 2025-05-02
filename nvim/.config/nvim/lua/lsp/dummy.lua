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
    kind = 15,
    target = "https://dummy.io", -- TODO: resolve to path
    range = {
      start = { line = 1, character = 1 },
      ["end"] = { line = 1, character = 1 },
    },
  },
}

return {
  cmd = function()
    return {
      request = function(method, params, handler, _)
        if method == ms.textDocument_documentLink then
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
