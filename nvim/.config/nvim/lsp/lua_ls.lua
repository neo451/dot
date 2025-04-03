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
   capabilities = require("blink.cmp").get_lsp_capabilities(),
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
            },
         },
      },
   },
}
