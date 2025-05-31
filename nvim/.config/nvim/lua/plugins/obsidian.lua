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
    dir = "~/Plugins/obsidian.nvim/",
    -- event = "BufReadPre /home/n451/Notes/*.md",
    -- cmd = "Obsidian",
    dev = true,
    ---@module 'obsidian'
    ---@type obsidian.config.ClientOpts
    opts = {
      cache = {
        use_cache = true,
      },

      -- open_notes_in = "vsplit_force",

      backlinks = {
        parse_headers = false,
      },

      prefer_config_from_obsidian_app = true,

      statusline = {
        enabled = true,
      },

      daily_notes = {
        folder = "daily_notes",
      },

      calendar = {
        cmd = "CalendarT",
        close_after = true,
      },

      picker = { name = "telescope.nvim" },

      note_frontmatter_func = function(note)
        -- Add the title of the note as an alias.
        local out = { id = note.id, tags = note.tags }
        -- `note.metadata` contains any manually added fields in the frontmatter.
        -- So here we just make sure those fields are kept in the frontmatter.
        if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
          for k, v in pairs(note.metadata) do
            out[k] = v
          end
        end
        return out
      end,

      attachments = {
        confirm_img_paste = false,
        -- img_text_func = function(client, path)
        --   path = client:vault_relative_path(path) or path
        --   local path_string = vim.uri_encode(vim.fs.basename(tostring(path)))
        --   return string.format("![%s](%s)", path.name, path_string)
        -- end,
      },

      note_id_func = function(title)
        return title
      end,

      templates = {
        folder = "templates",
        date_format = "%Y-%m-%d",
        time_format = "%H:%M",
        customization = {
          zettel = {
            dir = "zettel",
            note_id_func = function(title)
              return "my-cool-id+" .. title
            end,
          },
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
      },
      ui = {
        enable = false,
        checkboxes = {
          [" "] = { order = 1, char = "󰄱", hl_group = "ObsidianTodo" },
          ["x"] = { order = 5, char = "", hl_group = "ObsidianDone" },
        },
      },
    },
  },
}
