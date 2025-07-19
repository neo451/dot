return {
  init = function()
    -- Setup some globals for debugging (lazy-loaded)
    ---@diagnostic disable-next-line: duplicate-set-field
    _G.dd = function(...)
      Snacks.debug.inspect(...)
    end
    ---@diagnostic disable-next-line: duplicate-set-field
    _G.bt = function()
      Snacks.debug.backtrace()
    end
    -- vim.print = _G.dd -- Override print to use snacks for `:=` command

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
  setup = function()
    require("snacks").setup({
      scroll = { enabled = true },
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
      -- bigfile = { enabled = true },
      input = { enabled = true },
      picker = {
        enabled = true,
      },
      statuscolumn = { enabled = true },
      styles = {
        notification = {
          wo = { wrap = true },
        },
        snacks_image = {
          relative = "editor",
          col = -1,
        },
      },
      notifier = {
        enabled = true,
        timeout = 3000,
      },
      scope = { enabled = true },
      -- dashboard = {
      --   sections = {
      --     { section = "header" },
      --     { section = "keys", gap = 1, padding = 1 },
      --     -- {
      --     --   desc = require("fortune").get_fortune(),
      --     -- },
      --   },
      -- },
    })
  end,
}
