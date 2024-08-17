local lspconfig = require("lspconfig")
local configs = require("lspconfig.configs")
local capabilities = nil
if pcall(require, "cmp_nvim_lsp") then
   capabilities = require("cmp_nvim_lsp").default_capabilities()
end

vim.g.rime_enabled = false

if not configs.rime_ls then
   configs.rime_ls = {
      default_config = {
         name = "rime_ls",
         cmd = { "rime_ls" },
         -- cmd = vim.lsp.rpc.connect('127.0.0.1', 9257),
         filetypes = { "*" },
         single_file_support = true,
      },
      settings = {},
   }
end

local rime_on_attach = function(client, _)
   client.request("workspace/executeCommand", { command = "rime-ls.toggle-rime" }, function(_, result, ctx, _)
      if ctx.client_id == client.id then
         vim.g.rime_enabled = result
      end
   end)
   vim.keymap.set("n", "<leader>rr", function()
      client.request("workspace/executeCommand", { command = "rime-ls.toggle-rime" }, function(_, result, ctx, _)
         if ctx.client_id == client.id then
            vim.g.rime_enabled = result
         end
      end)
   end)
   vim.keymap.set("n", "<leader>rs", function()
      vim.lsp.buf.execute_command({ command = "rime-ls.sync-user-data" })
   end)
end

local servers = {
   rime_ls = {
      filetypes = { "md", "norg" },
      init_options = {
         enabled = vim.g.rime_enabled,
         shared_data_dir = "/usr/share/rime-data",
         user_data_dir = "~/.local/share/rime-ls",
         log_dir = "~/.local/share/rime-ls",
         max_candidates = 9,
         trigger_characters = {},
         schema_trigger_character = "&", -- [since v0.2.0] 当输入此字符串时请求补全会触发 “方案选单”
      },
      on_attach = rime_on_attach,
   },
   lua_ls = {
      filetypes = { "lua" },
      settings = {
         Lua = {
            runtime = { version = "LuaJIT", path = vim.split(package.path, ";") },
            diagnostics = { enable = true, globals = { "vim", "describe", "it" } },
            workspace = {
               library = {
                  [vim.fn.expand("$VIMRUNTIME/lua")] = true,
               },
            },
         },
      },
   },
   zls = true,
}

for name, config in pairs(servers) do
   if config == true then
      config = {}
   end
   config = vim.tbl_deep_extend("force", {}, {
      capabilities = capabilities,
   }, config)

   lspconfig[name].setup(config)
end

local disable_semantic_tokens = {
   lua = true,
}

vim.api.nvim_create_autocmd("BufWritePre", {
   callback = function(args)
      vim.lsp.buf.format()
   end,
})

vim.api.nvim_create_autocmd("LspAttach", {
   callback = function(args)
      require("lspsaga").setup({})
      local bufnr = args.buf
      local client = assert(vim.lsp.get_client_by_id(args.data.client_id), "must have valid client")
      local set = vim.keymap.set

      vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"
      set("n", "gd", vim.lsp.buf.definition, { buffer = 0 })
      set("n", "gf", vim.lsp.buf.format, { buffer = 0 })
      set("n", "gr", "<cmd>Lspsaga rename<cr>", { buffer = 0 })
      set("n", "gs", "<cmd>Lspsaga peek_definition<cr>", { buffer = 0 })
      set("n", "ga", "<cmd>Lspsaga code_action<cr>", { buffer = 0 })
      set("n", "g/", "<cmd>Lspsaga finder<cr>", { buffer = 0 })
      set({ "n", "t" }, "<A-d>", "<cmd>Lspsaga term_toggle<cr>")
      set("n", "K", vim.lsp.buf.hover)

      set("n", "gD", vim.lsp.buf.declaration, { buffer = 0 })
      set("n", "gT", vim.lsp.buf.type_definition, { buffer = 0 })

      local filetype = vim.bo[bufnr].filetype
      if disable_semantic_tokens[filetype] then
         client.server_capabilities.semanticTokensProvider = nil
      end
   end,
})
