return {
  {
    "aileot/nvim-thyme",
    version = "~v1.0.0",
    cond = false,
    config = function()
      -- See the "Setup Optional Interfaces" section below!
    end,
  },
  -- If you also manage macro plugin versions, please clear the Lua cache on the updates!
  {
    "aileot/nvim-laurel",
    build = ":ThymeCacheClear",
    -- and other settings
  },
  -- Optional dependency plugin.
  {
    "eraserhd/parinfer-rust",
    build = "cargo build --release",
  },
}
