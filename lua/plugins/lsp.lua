return {
    "mason-org/mason-lspconfig.nvim",
    event = { "BufReadPre", "BufNewFile" },
    cmd = "Mason",
    opts = {},
    dependencies = {
        { "mason-org/mason.nvim", opts = {}, },
        {
            "WhoIsSethDaniel/mason-tool-installer.nvim",
            opts = {
                ensure_installed = {
                    "lua_ls",
                },
            },
        },
        {
            "neovim/nvim-lspconfig",

            config = function(_, opts) end,

            opts = function()
                vim.lsp.config("*", { capabilities = vim.lsp.protocol.make_client_capabilities() })

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
        },
    },
}