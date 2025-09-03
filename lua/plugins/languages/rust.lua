local function ensure_rustfmt()
    if vim.fn.executable("rustfmt") == 0 and vim.fm.executable("rustup") ~= 0 then
        vim.notify("Installing rustfmt via rustup...", vim.log.levels.INFO)
        vim.fn.jobstart({ "rustup", "component", "add", "rustfmt" }, {
            on_exit = function(_, code)
                if code == 0 then
                    vim.notify("rustfmt installed successfully", vim.log.levels.INFO)
                else
                    vim.notify("Failed to install rustfmt", vim.log.levels.ERROR)
                end
            end,
        })
    end
end

return require("core.utils").apply_ft("rust", {
    {
        "lsp-config",
        virtual = true,
        dependencies = {
            {
                "WhoIsSethDaniel/mason-tool-installer.nvim",
                opts_extend = { "ensure_installed" },
                opts = { ensure_installed = { "rust-analyzer", "codelldb" } },
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
            ensure_rustfmt()
            require("nvim-treesitter").install({ "rust", "toml" })
        end,
    },
    {
        "mrcjkb/rustaceanvim",
        lazy = false,
    }
})
