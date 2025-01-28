local opt = vim.opt

-- Enable relative line numbers
opt.number = true
opt.relativenumber = true

-- Enable mouse support
opt.mouse = "a"

-- Disable showing mode (it's already in status line)
opt.showmode = false

-- Sync with OS clipboard
opt.clipboard = "unnamedplus"

-- Enable break indent
opt.breakindent = true

-- Enable undo history
opt.undofile = true

-- Smart searching (case insensitive)
opt.ignorecase = true
opt.smartcase = true

-- Enable signcolumn by default
opt.signcolumn = "yes"

-- Decrease update time
opt.updatetime = 250

-- Configure how new splits should be opened
opt.splitright = true
opt.splitbelow = true

-- Preview substitutions live
opt.inccommand = 'split'

-- Show which line your cursor is on
opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
opt.scrolloff = 10

-- Write file contents
opt.autowrite = true

-- Reload file if changed externally
opt.autoread = true

-- Enable text wrapping mode
opt.wrap = true

-- Enable term full colours
opt.termguicolors = true

-- Indent on appropriate indent triggers (eg {)
opt.smartindent = true

-- Spaces not tabs. 
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.expandtab = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.expandtab = true
