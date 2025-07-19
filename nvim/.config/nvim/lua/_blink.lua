require("blink.cmp").setup({
  fuzzy = { implementation = "lua" },
  keymap = {

    preset = "default",
    ["<C-b>"] = { "scroll_documentation_up" },
    ["<C-f>"] = { "scroll_documentation_down" },
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
              if ctx.item.client_name == "obsidian-ls" then
                return ""
              end
              local kind_icon, _, _ = require("mini.icons").get("lsp", ctx.kind)
              return kind_icon
            end,
            -- highlight = function(ctx)
            --    local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
            --    return hl
            -- end,
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
      enabled = true,
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
    default = {
      "lsp",
      "path",
      "snippets",
      "buffer",
      "lazydev",
      -- "emoji",
      -- "dictionary",
    },
    providers = {
      -- dictionary = {
      --   module = "blink-cmp-dictionary",
      --   name = "Dict",
      --   -- Make sure this is at least 2.
      --   -- 3 is recommended
      --   min_keyword_length = 3,
      --   opts = {
      --     -- options for blink-cmp-dictionary
      --     dictionary_files = { vim.fn.expand("~/.config/nvim/dictionary/words.dict") },
      --   },
      -- },
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
      lazydev = {
        name = "LazyDev",
        module = "lazydev.integrations.blink",
        score_offset = 100,
      },
      -- emoji = {
      --   module = "blink-emoji",
      --   name = "Emoji",
      --   score_offset = 15, -- Tune by preference
      --   opts = { insert = true }, -- Insert emoji (default) or complete its name
      --   should_show_items = function()
      --     return vim.tbl_contains(
      --       -- Enable emoji completion only for git commits and markdown.
      --       -- By default, enabled for all file-types.
      --       { "gitcommit", "markdown" },
      --       vim.o.filetype
      --     )
      --   end,
      -- },
    },
  },
})
