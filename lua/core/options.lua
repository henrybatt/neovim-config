-- Enable relative line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Enable mouse support
vim.opt.mouse = "a"

-- Disable showing mode (it's already in status line")
vim.opt.showmode = false

-- Sync with OS clipboard
vim.opt.clipboard = "unnamedplus"

-- Enable break indent
vim.opt.breakindent = true

-- Enable undo history
vim.opt.undofile = true

-- Smart searching (case insensitive)
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Enable signcolumn by default
vim.opt.signcolumn = "yes"

-- Decrease update time
vim.opt.updatetime = 250

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- Write file contents
vim.opt.autowrite = true

-- Reload file if changed externally
vim.opt.autoread = true

-- Enable text wrapping mode
vim.opt.wrap = true

-- Enable term full colours
vim.opt.termguicolors = true

-- Indent on appropriate indent triggers (eg {)
vim.opt.smartindent = true

-- Set tabs options
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
