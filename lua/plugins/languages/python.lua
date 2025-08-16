return require("core.utils").apply_ft("python", {
    {
        "lsp-config",
        virtual = true,
        dependencies = {
            {
                "WhoIsSethDaniel/mason-tool-installer.nvim",
                opts_extend = { "ensure_installed" },
                opts = { ensure_installed = { "pylsp" } },
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
})