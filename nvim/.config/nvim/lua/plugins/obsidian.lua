---@diagnostic disable: missing-fields
return {
  {
    "obsidian-nvim/obsidian.nvim",
    dir = "~/Plugins/obsidian.nvim/",
    dev = true,
    cmd = { "ObsidianNew", "ObsidianQuickSwitch" },
    lazy = true,
    ---@module 'obsidian'
    ---@type obsidian.config.ClientOpts
    opts = {
      legacy_commands = true,
      prefer_config_from_obsidian_app = true,
      -- preferred_link_style = "markdown",

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
        nvim_cmp = vim.g.my_cmp == "cmp",
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
      },
    },
  },
}
