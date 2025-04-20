---@diagnostic disable: missing-fields
return {
  {
    "obsidian-nvim/obsidian.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    dir = "~/Plugins/obsidian.nvim/",
    -- enabled = false,
    dev = true,
    lazy = false,
    ---@module 'obsidian'
    ---@type obsidian.config.ClientOpts
    opts = {
      note_id_func = function(title)
        return title
      end,

      prefer_config_from_obsidian_app = true,

      picker = { name = "telescope.nvim" },

      attachments = {
        confirm_img_paste = true,
      },
      -- preferred_link_style = "markdown",
      follow_img_func = function(img)
        vim.ui.open(img)
      end,
      templates = {
        folder = "templates",
        date_format = "%Y-%m-%d",
        time_format = "%H:%M",
      },
      completion = {
        blink = false,
        nvim_cmp = false,
        -- min_chars = 2,
      },
      workspaces = {
        {
          name = "notes",
          path = "~/Notes",
        },
      },
      ui = {
        enable = false,
      },
    },
    keys = {
      {
        "<leader>os",
        "<cmd>ObsidianSearch<cr>",
      },
      {
        "<leader>on",
        "<cmd>ObsidianNew<cr>",
      },
    },
  },
}
