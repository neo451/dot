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
   settings = {
      Lua = {
         runtime = {
            version = "LuaJIT",
         },
         inlay_hints = { enable = true },
         workspace = {
            -- library = vim.api.nvim_get_runtime_file("", true),
            library = {
               vim.env.VIMRUNTIME,
               -- [vim.fn.expand("$VIMRUNTIME/lua")] = true,
               -- [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
               -- ["/usr/share/awesome/lib/"] = true,
            },
         },
      },
   },
}
