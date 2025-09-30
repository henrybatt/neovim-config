-- Run on lsp buffer attach
local function on_attach(client, buf)
    -- Enable lsp folding if available
    if client:supports_method("textDocument/foldingRange", buf) then
        require("config.options").lsp_foldexpr()
    end

    -- Highlight definitions on cursor hold
    if client:supports_method("textDocument/documentHighlight", buf) then
        local highlight_augroup = vim.api.nvim_create_augroup("lsp-highlight", { clear = true })
        vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
            desc = "Highlight definitions on cursor hold",
            group = highlight_augroup,
            buffer = buf,
            callback = vim.lsp.buf.document_highlight,
        })

        vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
            desc = "Unhighlight definitions on cursor move",
            group = highlight_augroup,
            buffer = buf,
            callback = vim.lsp.buf.clear_references,
        })

        vim.api.nvim_create_autocmd("LspDetach", {
            desc = "Unhighlight definitions on detach",
            group = highlight_augroup,
            buffer = buf,
            callback = vim.lsp.buf.clear_references,
        })
    end
end

return {
    "lsp-config",
    virtual = true,
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        {
            "mason-org/mason-lspconfig.nvim",
            opts = {},
            dependencies = {
                { "mason-org/mason.nvim", opts = {} },
            },
        },
        {
            "WhoIsSethDaniel/mason-tool-installer.nvim",
            opts = {
                ensure_installed = { "lua_ls" },
            },
        },
        { "neovim/nvim-lspconfig", config = function() end },
        {
            "saghen/blink.cmp",
            version = "1.*",
            dependencies = { "rafamadriz/friendly-snippets" },
            opts_extend = { "sources.default" },
            opts = {
                keymap = {
                    preset = "default",
                    ["<S-CR>"] = { "accept", "fallback" },
                    ["<C-CR>"] = { "accept", "fallback" },
                },
                completion = {
                    ghost_text = {
                        enabled = true,
                    },
                    accept = {
                        auto_brackets = {
                            enabled = true,
                        },
                    },
                },
            },
        },
    },

    keys = {
        { "<leader>rn",  vim.lsp.buf.rename,                                       desc = "[R]e[n]ame" },
        { "<leader>ca",  vim.lsp.buf.code_action,                                  desc = "[C]ode [A]ction" },
        { "<leader>fmt", vim.lsp.buf.format,                                       desc = "LSP [F]or[m]a[t]" },
        { "K",           function() vim.lsp.buf.hover({ border = "rounded" }) end, desc = "Hover Documentation" },
        { "gd",          function() Snacks.picker.lsp_definitions() end,           desc = "Goto [D]efinition" },
        { "gD",          function() Snacks.picker.lsp_declarations() end,          desc = "Goto [D]eclaration" },
        { "gr",          function() Snacks.picker.lsp_references() end,            "Goto [R]eferences",             { nowait = true } },
        { "gI",          function() Snacks.picker.lsp_implementations() end,       desc = "Goto [I]mplementation" },
        { "gy",          function() Snacks.picker.lsp_type_definitions() end,      desc = "Goto T[y]pe Definition" },
        { "<leader>ss",  function() Snacks.picker.lsp_symbols() end,               desc = "LSP Document [S]ymbols" },
        { "<leader>sS",  function() Snacks.picker.lsp_workspace_symbols() end,     desc = "LSP Workspace [S]ymbols" },
    },

    opts = function()
        vim.lsp.config("*", {
            on_attach = on_attach,
            root_markers = { ".git" },
        })

        vim.lsp.config("lua_ls", {
            settings = {
                Lua = {
                    runtime = {
                        version = "LuaJIT",
                    },
                    diagnostics = {
                        globals = {
                            "vim",
                        },
                    },
                    workspace = {
                        library = vim.api.nvim_get_runtime_file("", true),
                    },
                    telemetry = {
                        enable = false,
                    },
                },
            },
        })
    end,

    config = function() end,
}
