-- Add rounded borders to windows
vim.o.winborder = "rounded"

-- Enable relative line numbers
vim.o.number = true
vim.o.relativenumber = true

-- Enable mouse support
vim.o.mouse = "a"

-- Disable showing mode (it's already in status line)
vim.o.showmode = false

-- Sync with OS clipboard
vim.o.clipboard = "unnamedplus"

-- Enable break indent
vim.o.breakindent = true

-- Enable undo history
vim.o.undofile = true

-- Smart searching (case insensitive)
vim.o.ignorecase = true
vim.o.smartcase = true

-- Enable signcolumn by default
vim.o.signcolumn = "yes"

-- Decrease update time
vim.o.updatetime = 250

-- Configure how new splits should be opened
vim.o.splitright = true
vim.o.splitbelow = true

-- Preview substitutions live
vim.o.inccommand = "split"

-- Show which line your cursor is on
vim.o.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 10

-- Write file contents
vim.o.autowrite = true

-- Reload file if changed externally
vim.o.autoread = true

-- Enable text wrapping mode
vim.o.wrap = true

-- Enable term full colours
vim.o.termguicolors = true

-- Indent on appropriate indent triggers (eg {))
vim.o.smartindent = true

-- Spaces not tabs. 
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.expandtab = true

-- Spelling
-- vim.o.spell = true
-- vim.o.spelllang = { "en_au", "en"}
-- vim.o.spelloptions = "camel"