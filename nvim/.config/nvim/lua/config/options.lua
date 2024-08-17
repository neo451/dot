vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opt = vim.opt
opt.breakindent = true
opt.wrap = true
opt.autowrite = true -- Enable auto write
opt.showmode = false
opt.completeopt = "menu,menuone,noselect"
opt.confirm = true -- Confirm to save changes before exiting modified buffer
opt.cursorline = true -- Enable highlighting of the current line
opt.expandtab = true -- Use spaces instead of tabs
opt.inccommand = "split" -- preview incremental substitute
opt.laststatus = 2
opt.list = true -- Show some invisible characters (tabs...
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
opt.number = true -- Print line number
opt.relativenumber = true -- Relative line numbers
opt.pumblend = 30 -- Popup blend
opt.pumheight = 10 -- Maximum number of entries in a popup
opt.scrolloff = 10 -- Lines of context
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize" }
opt.shiftround = true -- Round indent
opt.shortmess:append({ W = true, I = true, c = true, C = true })
opt.sidescrolloff = 8 -- Columns of context
opt.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time
opt.shiftwidth = 2 -- Size of an indent
opt.smartcase = true -- Don't ignore case with capitals
opt.spelllang = { "en", "cjk" }
opt.spell = true

-- splits
opt.splitkeep = "screen"
opt.splitright = true -- Put new windows right of current

-- editing
opt.tabstop = 2 -- Number of spaces tabs count for
opt.termguicolors = true -- True color support
opt.timeoutlen = 300
opt.wildmode = "longest:full,full" -- Command-line completion mode
opt.undofile = true
opt.undolevels = 10000
opt.updatetime = 200 -- Save swap file and trigger CursorHold
opt.winminwidth = 5 -- Minimum window width

opt.foldlevelstart = 99 -- Start with all folds closed
opt.conceallevel = 2 -- So that I can see `` in markdown files
