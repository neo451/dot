return {
   "nvim-lualine/lualine.nvim",
   dependencies = { "nvim-tree/nvim-web-devicons", "abeldekat/harpoonline" },
   config = function()
      local Harpoonline = require("harpoonline")
      Harpoonline.setup({
         on_update = function()
            require("lualine").refresh()
         end,
      })
      -- update lualine
      local function rime_status()
         if vim.g.rime_enabled then
            return "ㄓ"
         else
            return ""
         end
      end
      require("lualine").setup({
         sections = {
            lualine_a = {
               {
                  "mode",
                  fmt = function(str)
                     return str:sub(1, 1)
                  end,
               },
            },

            lualine_b = { "branch" },
            lualine_c = {
               "diagnostics",
               Harpoonline.format,
               "filename",
               function()
                  if vim.opt.iminsert:get() > 0 and vim.b.keymap_name then
                     return "⌨ " .. vim.b.keymap_name
                  end
                  return ""
               end,
            },
            lualine_x = { "copilot", rime_status, "filetype" }, -- I added copilot here
            lualine_y = { "progress" },
            lualine_z = { "location" },
         },
         options = {
            globalstatus = true,
            section_separators = { left = "", right = "" },
            component_separators = { left = "", right = "" },
         },
      })
   end,
}
