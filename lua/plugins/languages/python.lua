return {
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        opts = {
            ensure_installed = {
                "pylsp",
            },
        },
    },
    {
        "neovim/nvim-lspconfig",
        opts = function()
            vim.lsp.config("pylsp", {
                settings = {
                    pylsp = {
                        plugins = {
                            pycodestyle = {
                                ignore = { },
                            },
                        },
                    },
                }
            })
        end,
    },
}
