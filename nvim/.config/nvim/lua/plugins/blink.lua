return {
  "saghen/blink.cmp",
  event = "InsertEnter",
  dependencies = {
    "rafamadriz/friendly-snippets",
    "MahanRahmati/blink-nerdfont.nvim",
    "fang2hou/blink-copilot",
    "moyiz/blink-emoji.nvim",
    -- {
    --   "copilotlsp-nvim/copilot-lsp",
    --   init = function()
    --     vim.g.copilot_nes_debounce = 500
    --     vim.lsp.enable("copilot")
    --     vim.keymap.set("n", "<tab>", function()
    --       require("copilot-lsp.nes").apply_pending_nes()
    --     end)
    --   end,
    -- },
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
      },
    },
  },
  cond = vim.g.my_cmp == "blink",
  -- build = "cargo build --release",
  -- build = "nix run .#build-plugin",
  -- version = "*",
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    fuzzy = { implementation = "lua" },
    keymap = {
      preset = "default",
      ["<Tab>"] = {
        function(cmp)
          if vim.b[vim.api.nvim_get_current_buf()].nes_state then
            cmp.hide()
            return require("copilot-lsp.nes").apply_pending_nes()
          end
          if cmp.snippet_active() then
            return cmp.accept()
          else
            return cmp.select_and_accept()
          end
        end,
        "snippet_forward",
        "fallback",
      },
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
      default = {
        "lazydev",
        "lsp",
        "path",
        "snippets",
        "buffer",
        "nerdfont",
        -- "emoji",
        "copilot",
      },
      -- "copilot" },
      providers = {
        copilot = {
          name = "copilot",
          module = "blink-copilot",
          score_offset = 80,
          async = true,
        },
        lazydev = {
          name = "LazyDev",
          module = "lazydev.integrations.blink",
          score_offset = 100,
        },
        nerdfont = {
          module = "blink-nerdfont",
          name = "Nerd Fonts",
          score_offset = 15, -- Tune by preference
          opts = { insert = true },
        },
        emoji = {
          module = "blink-emoji",
          name = "Emoji",
          score_offset = 15, -- Tune by preference
          opts = { insert = true }, -- Insert emoji (default) or complete its name
          should_show_items = function()
            return vim.tbl_contains(
              -- Enable emoji completion only for git commits and markdown.
              -- By default, enabled for all file-types.
              { "gitcommit", "markdown" },
              vim.o.filetype
            )
          end,
        },
      },
    },
  },
  opts_extend = { "sources.default" },
}
