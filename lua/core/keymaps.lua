vim.g.mapleader = ','
vim.g.maplocalleader = ','

-- Highlight search, but clear on <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

