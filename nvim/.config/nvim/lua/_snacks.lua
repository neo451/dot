require "snacks".setup {
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
}
