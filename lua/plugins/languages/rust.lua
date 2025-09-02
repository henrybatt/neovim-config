return require("core.utils").apply_ft("rust", {
    {
        "lsp-config",
        virtual = true,
        dependencies = {
            {
                "WhoIsSethDaniel/mason-tool-installer.nvim",
                opts_extend = { "ensure_installed" },
                opts = { ensure_installed = { "rust-analyzer" } },
            },
        },

        opts = function()
            vim.lsp.config("rust-analyzer", {
                cargo = {
                    loadOutDirsFromCheck = true,
                    runBuildScripts = true
                }
            })
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter",
        opts = function()
            require("nvim-treesitter").install({ "rust", "toml" })
        end,
    },
})
