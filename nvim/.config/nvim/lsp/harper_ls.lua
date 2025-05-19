return {
  cmd = { "harper-ls", "--stdio" },
  root_markers = {
    ".git",
    -- for obsidian
    ".obsidian",
    ".trash",
  },
  filetypes = {
    "gitcommit",
    "typst",
    "markdown",
    "txt",
    "org",
    "norg",
  },
}
