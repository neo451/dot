local has_blink = pcall(require, "blink.cmp")
local capabilities = has_blink and require("blink.cmp").get_lsp_capabilities()
  or vim.lsp.protocol.make_client_capabilities()
return {
  cmd = { "lua-language-server" },
  root_markers = {
    ".luarc.json",
    ".luarc.jsonc",
    ".luacheckrc",
    ".stylua.toml",
    "stylua.toml",
    "selene.toml",
    "selene.yml",
    ".git",
  },
  filetypes = { "lua" },
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
      },
      hint = {
        enable = true,
      },
      workspace = {
        library = {
          vim.env.VIMRUNTIME,
          "${3rd}/luv/library",
          "${3rd}/busted/library",
        },
      },
    },
  },
}
