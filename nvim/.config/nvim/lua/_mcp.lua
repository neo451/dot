vim.g.mcphub = {
  -- Required options
  port = 3000, -- Port for MCP Hub server
  config = vim.fn.expand("~/.config/nvim/mcpservers.json"), -- Absolute path to config file

  use_bundled_binary = true, -- Use bundled mcp-hub binary

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
}
