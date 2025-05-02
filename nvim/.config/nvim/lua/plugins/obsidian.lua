---@diagnostic disable: missing-fields
return {
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
    -- event = "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md",
    event = "BufReadPre /home/n451/Notes/*.md",
    cmd = "Obsidian",
    dev = true,
    -- cmd = { "Obsidian", "ObsidianNew", "ObsidianQuickSwitch" },
    -- lazy = true,
    ---@module 'obsidian'
    ---@type obsidian.config.ClientOpts
    opts = {
      legacy_commands = false,
      prefer_config_from_obsidian_app = true,
      preferred_link_style = "markdown",

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

      picker = { name = "snacks.pick" },

      attachments = {
        confirm_img_paste = false,
      },

      note_id_func = function(title)
        return title
      end,

      templates = {
        folder = "templates",
        date_format = "%Y-%m-%d",
        time_format = "%H:%M",
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
      },
      ui = {
        enable = false,
        checkboxes = {
          [" "] = { order = 1, char = "󰄱", hl_group = "ObsidianTodo" },
          ["x"] = { order = 5, char = "", hl_group = "ObsidianDone" },
        },
      },
    },

    keys = {
      {
        "<leader>O",
        "<cmd>Obsidian<cr>",
        desc = "Obsidian",
      },
    },
  },
}
