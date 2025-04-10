return {
   {
      "nvim-lualine/lualine.nvim",
      enabled = false,
      opts = {
         options = {
            section_separators = "",
            component_separators = "",
         },
         sections = {
            lualine_x = {
               {
                  "g:feed_progress",
               },
               "encoding",
               "fileformat",
               "filetype",
            },
         },
         extensions = {
            "lazy",
            "oil",
            "quickfix",
            "man",
            --"feed",
         },
      },
   },
   {
      "ravitemer/mcphub.nvim",
      dependencies = {
         "nvim-lua/plenary.nvim", -- Required for Job and HTTP requests
      },
      enabled = false,
      -- build = "npm install -g mcp-hub@latest", -- Installs required mcp-hub npm module
      config = function()
         require("mcphub").setup({
            -- Required options
            port = 3000, -- Port for MCP Hub server
            config = vim.fn.expand("~/.config/nvim/mcpservers.json"), -- Absolute path to config file

            -- Optional options
            on_ready = function(hub)
               -- Called when hub is ready
            end,
            on_error = function(err)
               -- Called on errors
            end,
            shutdown_delay = 0, -- Wait 0ms before shutting down server after last client exits
            log = {
               level = vim.log.levels.WARN,
               to_file = false,
               file_path = nil,
               prefix = "MCPHub",
            },
         })
      end,
   },
}
