local opt = vim.opt

-- ui
opt.number = true
opt.relativenumber = true
opt.wrap = true
opt.breakindent = true
opt.showmode = false
opt.cursorline = true
opt.list = true
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
opt.expandtab = true
opt.undofile = true
opt.splitright = true
opt.splitbelow = true
opt.tabstop = 2 -- Number of spaces tabs count for
opt.shiftwidth = 3

-- editing
opt.termguicolors = true -- True color support
opt.timeoutlen = 300
opt.wildmode = "longest:full,full" -- Command-line completion mode
opt.undofile = true
opt.undolevels = 10000
opt.updatetime = 200 -- Save swap file and trigger CursorHold
opt.winminwidth = 5 -- Minimum window width
opt.foldlevelstart = 99 -- Start with all folds closed
opt.ignorecase = true

-- writing
opt.spelllang = "en,cjk"
opt.conceallevel = 2 -- So that I can see `` in markdown files
