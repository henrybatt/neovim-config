local ensure_installed = {
    "lua_ls",
}

-- Run on lsp buffer attach
local function on_attach(client, buf)
    local function map(keys, func, desc)
        require("core.utils").map("n", keys, func, { buffer = buf, desc = "LSP: " .. desc })
    end

    -- Keymappings
    map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
    map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
    map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")

    map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

    map("<leader>gd", vim.diagnostic.open_float, "Open [D]iagnostic")

    map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
    map("<leader>lds", require("telescope.builtin").lsp_document_symbols, "[L]SP [D]ocument [S]ymbols")
    map("<leader>lws", require("telescope.builtin").lsp_dynamic_workspace_symbols,
        "[L]SP [W]orkspace [S]ymbols")
    map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
    map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
    map("<leader>fmt", vim.lsp.buf.format, "LSP [F]or[m]a[t]")

    map("K", vim.lsp.buf.hover, "Hover Documentation")

    -- Enable lsp folding is available
    if client:supports_method("textDocument/foldingRange", buf) then
        require("config.options").lsp_foldexpr()
    end

    -- Highligh definitions on cursor hold
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
                ensure_installed = ensure_installed
            },
        },
        { "neovim/nvim-lspconfig", config = function(_, opts) end },
        {
            "saghen/blink.cmp",
            version = "1.*",
            dependencies = { "rafamadriz/friendly-snippets" },
            opts_extend = { "sources.default" },
            opts = {},
        },
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