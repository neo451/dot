vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.shortmess:append("c")

local lspkind = require("lspkind")
lspkind.init({})
local cmp = require("cmp")
local compare = require("cmp.config.compare")
cmp.setup({
   formatting = {
      format = lspkind.cmp_format({
         mode = "text_symbol", -- show only symbol annotations
         maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
         -- can also be a function to dynamically calculate max width such as
         -- maxwidth = function() return math.floor(0.45 * vim.o.columns) end,
         ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
         show_labelDetails = true, -- show labelDetails in menu. Disabled by default

         -- The function below will be called before any actual modifications from lspkind
         -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
         before = function(entry, vim_item)
            -- ...
            return vim_item
         end,
      }),
   },
   window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
   },
   mapping = {
      ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
      ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
      ["<C-y>"] = cmp.mapping(
         cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Insert,
            select = true,
         }),
         { "i", "c" }
      ),
      ["<Space>"] = cmp.mapping(function(fallback)
         local entry = cmp.get_selected_entry()
         if entry == nil then
            entry = cmp.core.view:get_first_entry()
         end
         if entry and entry.source.name == "nvim_lsp" and entry.source.source.client.name == "rime_ls" then
            cmp.confirm({
               behavior = cmp.ConfirmBehavior.Replace,
               select = true,
            })
         else
            fallback()
         end
      end, { "i", "s" }),
      ["<CR>"] = cmp.mapping(function(fallback)
         local entry = cmp.get_selected_entry()
         if entry == nil then
            entry = cmp.core.view:get_first_entry()
         end
         if entry and entry.source.name == "nvim_lsp" and entry.source.source.client.name == "rime_ls" then
            cmp.abort()
         else
            if entry ~= nil then
               cmp.confirm({
                  behavior = cmp.ConfirmBehavior.Replace,
                  select = true,
               })
            else
               fallback()
            end
         end
      end, { "i", "s" }),
   },
   sorting = {
      comparators = {
         compare.sort_text,
         compare.offset,
         compare.exact,
         compare.score,
         compare.recently_used,
         compare.kind,
         compare.length,
         compare.order,
      },
   },
   sources = {
      { name = "luasnip" },
      { name = "nvim_lsp" },
      { name = "path" },
      { name = "copilot" },
   },
   snippet = {
      expand = function(args)
         require("luasnip").lsp_expand(args.body)
      end,
   },
})

-- Set configuration for specific filetype.
cmp.setup.filetype("gitcommit", {
   sources = cmp.config.sources({
      { name = "git" }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
   }, {
      { name = "buffer" },
   }),
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ "/", "?" }, {
   mapping = cmp.mapping.preset.cmdline(),
   sources = {
      { name = "buffer" },
   },
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
   mapping = cmp.mapping.preset.cmdline(),
   sources = cmp.config.sources({
      { name = "path" },
   }, {
      { name = "cmdline" },
   }),
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()
require("lspconfig").lua_ls.setup({
   capabilities = capabilities,
})

local ls = require("luasnip")
ls.config.set_config({
   history = false,
   updateevents = "TextChanged,TextChangedI",
})

for _, ft_path in ipairs(vim.api.nvim_get_runtime_file("lua/custom/snippets/*.lua", true)) do
   loadfile(ft_path)()
end

vim.keymap.set({ "i", "s" }, "<c-k>", function()
   if ls.expand_or_jumpable() then
      ls.expand_or_jump()
   end
end, { silent = true })

vim.keymap.set({ "i", "s" }, "<c-j>", function()
   if ls.jumpable(-1) then
      ls.jump(-1)
   end
end, { silent = true })
