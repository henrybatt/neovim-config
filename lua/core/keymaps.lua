local function map(mode, keys, command, opts)
    local options = { noremap = true, silent = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.keymap.set(mode, keys, command, options)
end

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Highlight search, but clear on <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
map("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
map("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Actual delete keymaps
map({"n", "v"}, "<leader>d", '"_d', { desc = "Delete [count] characters before the cursor. [Not into register]" })
map({"n", "v"}, "<leader>dd", '"_dd', { desc = "Delete [count] lines linewise. [Not into register]" })