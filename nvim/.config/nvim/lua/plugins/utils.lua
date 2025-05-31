return {
  { "attilarepka/header.nvim", config = true },
  {
    "rubiin/fortune.nvim",
    opts = {},
  },
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
