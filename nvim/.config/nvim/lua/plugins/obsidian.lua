---@diagnostic disable: missing-fields
return {
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
      attachments = {
         -- confirm_img_paste = false,
         -- img_name_func = function()
         --    return string.format("%s-", os.date("%Y%m%d%H%M%S"))
         --    -- return string.format("Pasted image %s", os.date("%Y%m%d%H%M%S"))
         -- end,
         -- img_text_func = function()
         -- end,
      },
      follow_img_func = function(img)
         -- vim.fn.jobstart({ "qlmanage", "-p", img }) -- Mac OS quick look preview
         vim.ui.open(img)
         -- vim.cmd(':silent exec "!start ' .. url .. '"') -- Windows
      end,
      templates = {
         folder = "templates",
         date_format = "%Y-%m-%d",
         time_format = "%H:%M",
      },
      ui = {
         enable = false,
      },
      picker = {
         name = "snacks.pick",
      },
      completion = {
         blink = true,
         nvim_cmp = false,
         -- min_chars = 2,
      },
      workspaces = {
         {
            name = "notes",
            path = "~/Notes",
         },
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
}
