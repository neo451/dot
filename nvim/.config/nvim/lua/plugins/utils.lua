return {
  {
    "dundalek/bloat.nvim",
    cmd = "Bloat",
  },
  {
    "kyza0d/vocal.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = {},
    cond = false,
  },
  {
    "mecattaf/murmur.nvim",
    cond = false,
    opts = {
      -- Optional: Override default configuration
      server = {
        host = "127.0.0.1", -- whisper.cpp server host
        port = 8009, -- whisper.cpp server port
        model = "whisper-small", -- Model to use
      },
      recording = {
        command = nil, -- Auto-detect (sox, arecord, or ffmpeg)
      },
      ui = {
        border = "single", -- Popup border style
        spinner = true, -- Show processing spinner
      },
    },
  },
  {
    "nvzone/typr",
    dependencies = "nvzone/volt",
    opts = {},
    cmd = { "Typr", "TyprStats" },
  },
  {
    "nvzone/showkeys",
    cmd = "ShowkeysToggle",
    opts = {
      position = "top-left",
      timeout = 1,
      maxkeys = 5,
      -- more opts
    },
  },
}
