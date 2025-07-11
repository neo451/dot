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
    dependencies = {
      {
        "obsidian-nvim/obsidian-markmap.nvim",
        dir = "~/Plugins/obsidian-markmap.nvim/",
        cond = vim.fs.exists("~/Plugins/obsidian-markmap.nvim/"),
      },
    },
    -- commit = "9d165ea54a85cd1677413871f1cc65521b5fad2a",
    dir = "~/Plugins/obsidian.nvim/",
    legacy_commands = false,
    -- event = "BufReadPre /home/n451/Notes/*.md",
    -- cmd = "Obsidian",
    ---@module 'obsidian'
    ---@type obsidian.config
    opts = {
      -- prefer_config_from_obsidian_app = true,

      checkbox = {
        order = { "?", " " },
      },

      -- backlinks = {
      --   parse_headers = false,
      -- },
      --

      daily_notes = {
        folder = "daily_notes",
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
      },

      completion = {
        blink = vim.g.my_cmp == "blink",
        -- nvim_cmp = vim.g.my_cmp == "cmp",
      },

      workspaces = {
        -- {
        --   name = "notes",
        --   path = "~/Notes",
        -- },
        {
          name = "hub",
          path = "~/obsidian-hub/",
        },
      },
    },
  },
}
