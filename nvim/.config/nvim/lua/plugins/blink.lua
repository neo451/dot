return {
   "saghen/blink.cmp",
   dependencies = {
      "rafamadriz/friendly-snippets",
      "MahanRahmati/blink-nerdfont.nvim",
      "fang2hou/blink-copilot",
      {
         "zbirenbaum/copilot.lua",
         cmd = "Copilot",
         event = "InsertEnter",
         opts = {
            filetypes = {
               markdown = false,
            },
            suggestion = { enabled = false },
            panel = { enabled = false },
            filetypes = {
               markdown = true,
               help = true,
            },
         },
      },
   },

   version = "*",
   ---@module 'blink.cmp'
   ---@type blink.cmp.Config
   opts = {
      -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept, C-n/C-p for up/down)
      -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys for up/down)
      -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
      --
      -- All presets have the following mappings:
      -- C-space: Open menu or open docs if already open
      -- C-e: Hide menu
      -- C-k: Toggle signature help
      --
      -- See the full "keymap" documentation for information on defining your own keymap.
      keymap = {
         preset = "default",
         [";"] = {
            function(cmp)
               if not vim.g.rime_enabled then
                  return false
               end
               local rime_item_index = require("rime").get_n_rime_item_index(1)
               if #rime_item_index ~= 1 then
                  return false
               end
               -- If you want to select more than once,
               -- just update this cmp.accept with vim.api.nvim_feedkeys('1', 'n', true)
               -- The rest can be updated similarly
               return cmp.accept({ index = rime_item_index[1] })
            end,
            "fallback",
         },
      },
      appearance = {
         use_nvim_cmp_as_default = true,
         nerd_font_variant = "mono",
      },
      completion = {
         menu = {
            draw = {
               padding = 1,
               components = {
                  kind_icon = {
                     ellipsis = false,
                     text = function(ctx)
                        local kind_icon, _, _ = require("mini.icons").get("lsp", ctx.kind)
                        return kind_icon
                     end,
                     highlight = function(ctx)
                        local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
                        return hl
                     end,
                  },
                  source_name = {
                     text = function(ctx)
                        return "[" .. ctx.source_name .. "]"
                     end,
                  },
               },
            },
         },
         ghost_text = {
            enabled = vim.g.ghost_text,
         },
         accept = {
            auto_brackets = {
               enabled = true, -- experimental auto-brackets support
            },
         },
         documentation = {
            auto_show = true,
            auto_show_delay_ms = 0,
         },
      },

      sources = {
         default = { "lazydev", "lsp", "path", "snippets", "buffer", "nerdfont", "copilot" },
         providers = {
            copilot = {
               name = "copilot",
               module = "blink-copilot",
               score_offset = 100,
               async = true,
            },
            lazydev = {
               name = "LazyDev",
               module = "lazydev.integrations.blink",
               -- make lazydev completions top priority (see `:h blink.cmp`)
               score_offset = 100,
            },
            nerdfont = {
               module = "blink-nerdfont",
               name = "Nerd Fonts",
               score_offset = 15, -- Tune by preference
               opts = { insert = true }, -- Insert nerdfont icon (default) or complete its name
            },
            lsp = {
               transform_items = function(_, items)
                  -- the default transformer will do this
                  for _, item in ipairs(items) do
                     if item.kind == require("blink.cmp.types").CompletionItemKind.Snippet then
                        item.score_offset = item.score_offset - 3
                     end
                  end
                  -- you can define your own filter for rime item
                  return items
               end,
            },
         },
      },
   },
   opts_extend = { "sources.default" },
}
