return require("core.utils").apply_ft("python", {
    {
        "lsp-config",
        virtual = true,
        dependencies = {
            {
                "WhoIsSethDaniel/mason-tool-installer.nvim",
                opts_extend = { "ensure_installed" },
                opts = { ensure_installed = { "ruff", "basedpyright" } },
            },
        },

        opts = function()
            vim.lsp.config("pylsp", {
                settings = {
                    pylsp = {
                        plugins = {
                            pycodestyle = {
                                ignore = {},
                            },
                        },
                    },
                }
            })
        end,
    },
    {
        "dap",
        virtual = true,
        dependencies = {
            {
                "mfussenegger/nvim-dap-python",
                config = function()
                    require("dap-python").setup("python3")
                end,
            },
            {
                "jay-babu/mason-nvim-dap.nvim",
                opts_extend = { "ensure_installed" },
                opts = { ensure_installed = { "python" } },
            },
        },
    },
    {
        "nvim-treesitter/nvim-treesitter",
        opts = function()
            require("nvim-treesitter").install({ "python" })
        end,
    },
})
