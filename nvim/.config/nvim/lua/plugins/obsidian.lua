---@diagnostic disable: missing-fields
return {
  {
    "marcocofano/excalidraw.nvim",
    opts = {},
  },
  -- TODO: https://github.com/ViViDboarder/vim-settings/blob/23cf5fc1feabcc1baf66a622ffb869117b51e50f/neovim/lua/plugins/obsidian.lua
  -- TODO: https://github.com/B4rc1/obsidian-companion.nvim?tab=readme-ov-file
  -- TODO: https://github.com/oflisback/obsidian-bridge.nvim
  {
    "oflisback/obsidian-bridge.nvim",
    opts = {
      -- your config here
    },
    event = {
      "BufReadPre *.md",
      "BufNewFile *.md",
    },
    lazy = true,
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    cond = false,
  },
  {
    "efirlus/quickadd.nvim",
    cond = false,
    opts = {
      -- daily_note_path = "~/notes/daily/",
      -- todo_path = "~/notes/project/todolist.md",
    },
  },
  {
    "arakkkkk/kanban.nvim",
    cond = false,
    opts = {
      markdown = {
        description_folder = "./tasks/", -- Path to save the file corresponding to the task.
        list_head = "## ",
      },
    },
  },
  {
    "delphinus/obsidian-kensaku.nvim",
    dependencies = {
      "lambdalisue/kensaku.vim",
      "vim-denops/denops.vim",
    },
    cond = false,
  },

  {
    "obsidian-nvim/obsidian.nvim",
    version = "*",
    -- commit = "9d165ea54a85cd1677413871f1cc65521b5fad2a",
    dir = "~/Plugins/obsidian.nvim/",
    -- event = "BufReadPre /home/n451/Notes/*.md",
    -- cmd = "Obsidian",
    ---@module 'obsidian'
    ---@type obsidian.config.ClientOpts
    opts = {
      cache = {
        enable = false,
      },

      mappings = {
        ["<CR>"] = {
          action = function()
            return require("obsidian").util.smart_action()
          end,
          opts = { buffer = true, expr = true },
        },
        ["<leader>ch"] = {
          action = function()
            return require("obsidian").util.toggle_checkbox()
          end,
          opts = { buffer = true },
        },
      },

      backlinks = {
        parse_headers = false,
      },

      prefer_config_from_obsidian_app = true,

      statusline = {
        enabled = true,
      },

      open = {
        use_advanced_uri = true,
      },

      daily_notes = {
        folder = "daily_notes",
        -- alias_format = "%B %-d, %Y",
        -- workdays_only = false,
        func = function(datetime)
          local note = os.date("%Y/%m-%B/%Y-%m-%d", datetime)
          return "daily_notes/" .. note .. "!.md"
        end,
      },

      calendar = {
        cmd = "CalendarT",
        close_after = true,
      },

      picker = { name = "telescope.nvim" },

      -- note_frontmatter_func = function(note)
      --   -- Add the title of the note as an alias.
      --   local out = { id = note.id, tags = note.tags }
      --   -- `note.metadata` contains any manually added fields in the frontmatter.
      --   -- So here we just make sure those fields are kept in the frontmatter.
      --   if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
      --     for k, v in pairs(note.metadata) do
      --       out[k] = v
      --     end
      --   end
      --   return out
      -- end,

      attachments = {
        confirm_img_paste = false,
        img_text_func = function(client, path)
          path = client:vault_relative_path(path) or path
          local path_string = vim.uri_encode(vim.fs.basename(tostring(path)))
          return string.format("![%s](%s)", path.name, path_string)
        end,
      },

      note_id_func = function(title)
        return title
      end,

      templates = {
        folder = "templates",
        date_format = "%Y-%m-%d",
        time_format = "%H:%M",
        customizations = {
          zettel = {
            dir = "zettel",
            note_id_func = function(title)
              return "my-cool-id+" .. title
            end,
          },
        },
        substitutions = {
          -- pretty_title = function(ctx)
          --   return tostring(ctx.destination_path.stem)
          -- end,
          -- ---@param target obsidian.Path
          -- curr_date = function(target)
          --   return target.stem
          -- end,
          --
          -- ---@param target obsidian.Path
          -- next_date = function(target)
          --   return shift_iso_date(target.stem, 1)
          -- end,
          --
          -- ---@param target obsidian.Path
          -- prev_date = function(target)
          --   return shift_iso_date(target.stem, -1)
          -- end,
        },
      },

      completion = {
        blink = vim.g.my_cmp == "blink",
        -- blink = true,
        nvim_cmp = vim.g.my_cmp == "cmp",
        -- nvim_cmp = false,
      },
      workspaces = {
        {
          name = "notes",
          path = "~/Notes",
        },
        {
          name = "work",
          path = "~/Work",
        },
        {
          name = "hub",
          path = "~/Vualts/obsidian-hub/",
        },
        {
          name = "stress test",
          path = "~/.local/share/nvim/nightmare_vault/",
        },
      },
      ui = {
        enable = true,
        checkboxes = {
          [" "] = { order = 1, char = "󰄱", hl_group = "ObsidianTodo" },
          ["x"] = { order = 5, char = "", hl_group = "ObsidianDone" },
        },
      },
    },
  },
}
