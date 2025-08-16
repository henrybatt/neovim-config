local map = require("core.utils").map

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Highlight search, but clear on <Esc> in normal mode
vim.o.hlsearch = true
map("n", "<Esc>", "<cmd>nohlsearch<CR>")