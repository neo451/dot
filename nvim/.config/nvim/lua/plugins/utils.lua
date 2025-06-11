return {
  {
    { "nvzone/volt", lazy = true },
    {
      "nvzone/minty",
      cmd = { "Shades", "Huefy" },
    },
  },
  { "2kabhishek/nerdy.nvim", cmd = "Nerdy" },
  { "attilarepka/header.nvim", config = true },
  {
    "ThePrimeagen/refactoring.nvim",
    cmd = "Refactor",
    config = true,
    opts = {},
  },
  {
    "dundalek/bloat.nvim",
    cmd = "Bloat",
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
