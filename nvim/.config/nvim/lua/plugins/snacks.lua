---@diagnostic disable: missing-fields
local function gen_feed_sections()
  local feed = require("feed")
  local ids = feed.db:filter()
  local sections = {
    { section = "header" },
    { section = "keys", gap = 1, padding = 1 },
    { pane = 2, title = "Feeds", padding = 1 },
  }

  for i = 1, 5 do
    local id = ids[i]
    if not id then
      break
    end
    table.insert(sections, {
      pane = 2,
      icon = " ",
      padding = 1,
      desc = feed.headline(id),
      action = function()
        feed.show_entry({ id = id })
      end,
    })
  end
  table.insert(sections, { section = "startup" })
  return sections
end

return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@module 'snacks'
  ---@type snacks.Config
  opts = {
    image = {
      enabled = true,
      wo = {
        winhighlight = "FloatBorder:WhichKeyBorder",
      },
      doc = {
        inline = false,
        max_width = 45,
        max_height = 20,
      },
    },
    bigfile = { enabled = true },
    -- explorer = { enabled = true },
    indent = { enabled = true },
    input = { enabled = true },
    notifier = {
      enabled = false,
      timeout = 3000,
    },
    picker = {
      enabled = true,
    },
    -- scope = { enabled = true },
    scroll = { enabled = true },
    statuscolumn = { enabled = true },
    -- words = { enabled = true },
    dashboard = {
      --    sections = gen_feed_sections(),
    },
    styles = {
      notification = {
        wo = { wrap = true },
      },
      snacks_image = {
        relative = "editor",
        col = -1,
      },
    },
  },
  keys = {
    {
      "<leader>:",
      function()
        Snacks.picker.command_history()
      end,
      desc = "Command History",
    },
    {
      "<leader>e",
      function()
        Snacks.explorer()
      end,
      desc = "File Explorer",
    },
    -- find
    {
      "<leader>ff",
      function()
        Snacks.picker.files()
      end,
      desc = "Find Files",
    },
    {
      "<leader>fg",
      function()
        Snacks.picker.git_files()
      end,
      desc = "Find Git Files",
    },
    -- Grep
    {
      "<leader>sb",
      function()
        Snacks.picker.lines()
      end,
      desc = "Buffer Lines",
    },
    {
      "<leader>sB",
      function()
        Snacks.picker.grep_buffers()
      end,
      desc = "Grep Open Buffers",
    },
    {
      "<leader>sg",
      function()
        Snacks.picker.grep()
      end,
      desc = "Grep",
    },
    {
      "<leader>sw",
      function()
        Snacks.picker.grep_word()
      end,
      desc = "Visual selection or word",
      mode = { "n", "x" },
    },
    -- search
    {
      '<leader>s"',
      function()
        Snacks.picker.registers()
      end,
      desc = "Registers",
    },
    {
      "<leader>s/",
      function()
        Snacks.picker.search_history()
      end,
      desc = "Search History",
    },
    {
      "<leader>sa",
      function()
        Snacks.picker.autocmds()
      end,
      desc = "Autocmds",
    },
    {
      "<leader>sb",
      function()
        Snacks.picker.lines()
      end,
      desc = "Buffer Lines",
    },
    {
      "<leader>uC",
      function()
        Snacks.picker.colorschemes()
      end,
      desc = "Colorschemes",
    },
    -- LSP
    -- Other
    {
      "<leader>z",
      function()
        Snacks.zen()
      end,
      desc = "Toggle Zen Mode",
    },
    {
      "<leader>.",
      function()
        Snacks.scratch()
      end,
      desc = "Toggle Scratch Buffer",
    },
    {
      "<leader>gB",
      function()
        Snacks.gitbrowse()
      end,
      desc = "Git Browse",
      mode = { "n", "v" },
    },
    {
      "<leader>un",
      function()
        Snacks.notifier.hide()
      end,
      desc = "Dismiss All Notifications",
    },
  },
  init = function()
    vim.api.nvim_create_autocmd("User", {
      pattern = "VeryLazy",
      callback = function()
        -- Setup some globals for debugging (lazy-loaded)
        _G.dd = function(...)
          Snacks.debug.inspect(...)
        end
        _G.bt = function()
          Snacks.debug.backtrace()
        end
        vim.print = _G.dd -- Override print to use snacks for `:=` command

        -- Create some toggle mappings
        Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
        Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
        Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
        Snacks.toggle.diagnostics():map("<leader>ud")
        Snacks.toggle.line_number():map("<leader>ul")
        Snacks.toggle
          .option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
          :map("<leader>uc")
        Snacks.toggle.treesitter():map("<leader>uT")
        Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<leader>ub")
        Snacks.toggle.inlay_hints():map("<leader>uh")
        Snacks.toggle.indent():map("<leader>ug")
        Snacks.toggle.dim():map("<leader>uD")
      end,
    })
  end,
}
