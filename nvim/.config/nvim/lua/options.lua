vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local opt = vim.opt
local o = vim.o

vim.g.markdown_recommended_style = 0

-- ui
o.cmdheight = 1
o.number = true
o.relativenumber = true
o.breakindent = true
o.showmode = false
o.cursorline = true
o.list = true
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- search
o.ignorecase = true

-- term
o.shell = "fish"

-- typing
o.expandtab = true
-- o.undofile = true
o.tabstop = 2 -- Number of spaces tabs count for
o.shiftwidth = 3

-- window manage
o.splitright = true
o.splitbelow = true

-- editing
o.autowrite = true
o.clipboard = vim.env.SSH_TTY and "" or "unnamedplus" -- Sync with system clipboard

-- completion
o.completeopt = "menu,menuone"
o.wildmode = "longest:full,full" -- Command-line completion mode

-- undo
o.undofile = true
o.undolevels = 10000
o.updatetime = 200 -- Save swap file and trigger CursorHold

o.formatoptions = "jcroqlnt" -- Format options

-- writing
o.spelllang = "en,cjk"

-- diagnostic
vim.diagnostic.config({
  virtual_text = true,
  -- virtual_lines = {
  --   current_line = true,
  -- },
})
