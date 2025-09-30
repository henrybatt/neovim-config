return require("core.utils").apply_ft("tex", {
    {
        "lsp-config",
        virtual = true,
        dependencies = {
            {
                "WhoIsSethDaniel/mason-tool-installer.nvim",
                opts_extend = { "ensure_installed" },
                opts = { ensure_installed = { "texlab" } },
            },
        },

        opts = function()
            vim.lsp.config("texlab", {})
        end,
    },
    {
        "lervag/vimtex",
        lazy = false,
        init = function()
            vim.g.vimtex_syntax_enabled = 0
            vim.g.vimtex_view_zathura_use_synctex = 0
            vim.g.vimtex_view_method = "zathura"
            vim.g.vimtex_quickfix_ignore_filters = {
                [[Overfull \\[hv]box]],
                [[Underfull \\[hv]box]],
            }
        end
    }
})
