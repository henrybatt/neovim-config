local map = require("core.utils").map

local bufnr = vim.api.nvim_get_current_buf()

map("n", "<leader>a", function() vim.cmd.RustLsp("codeAction") end, { buffer = bufnr, desc = "LSP: Code Actions" })
map("n", "K", function() vim.cmd.RustLsp({ "hover", "actions" }) end, { buffer = bufnr, desc = "LSP: Hover Documentation" })
