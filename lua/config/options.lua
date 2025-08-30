local M = {}

-- Line numbers
vim.o.number = true
vim.o.relativenumber = true

-- Break indent
vim.o.breakindent = true

-- Undo
vim.o.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.o.undofile = true

-- Search
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.inccommand = "split"

-- Window splits
vim.o.splitright = true
vim.o.splitbelow = true

-- Auto file
vim.o.autowrite = true
vim.o.autoread = true

-- Swapfile
vim.o.swapfile = false

-- Indentation
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.wrap = true

-- Spelling
vim.o.spell = true
vim.o.spelllang = "en_au"
vim.o.spelloptions = "camel"

-- UI
vim.o.winborder = "rounded"
vim.o.scrolloff = 8
vim.o.signcolumn = "yes"
vim.o.cursorline = true
vim.o.termguicolors = true
vim.o.showmode = false

-- Diagnostic
vim.diagnostic.config({ virtual_text = true })

-- Misc
vim.o.mouse = "a"
vim.o.clipboard = "unnamedplus"
vim.o.updatetime = 250

-- Folding
function M.treesitter_foldexpr()
    vim.opt_local.foldmethod = "expr"
    vim.opt_local.foldexpr = "v:lua.vim.treesitter.foldexpr()"
    vim.opt_local.foldtext = "v:lua.custom_foldtext()"
end

function M.lsp_foldexpr()
    vim.opt_local.foldmethod = "expr"
    vim.opt_local.foldexpr = "v:lua.vim.lsp.foldexpr()"
    vim.opt_local.foldtext = "v:lua.custom_foldtext()"
end

vim.o.foldcolumn = "0"
vim.o.foldenable = true
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99

return M
