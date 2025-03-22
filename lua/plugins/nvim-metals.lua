return {
    "scalameta/nvim-metals",
    ft = { "scala", "sbt", "java" },
    dependencies = { "mfussenegger/nvim-dap", },
    enabled = false,

    opts = function()
        local metals_config = require("metals").bare_config()

        metals_config.init_options.statusBarProvider = "off"
        metals_config.capabilities = require("cmp_nvim_lsp").default_capabilities()
        metals_config.on_attach = function(client, bufnr)
            require("metals").setup_dap()
        end
        return metals_config
    end,

    config = function(self, metals_config)
        local dap = require("dap")

        dap.configurations.scala = {
            {
                type = "scala",
                request = "launch",
                name = "RunOrTest",
                metals = {
                    runType = "runOrTestFile",
                },
            },
            {
                type = "scala",
                request = "launch",
                name = "Test Target",
                metals = {
                    runType = "testTarget",
                },
            },
        }

        local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
        vim.api.nvim_create_autocmd("FileType", {
            pattern = self.ft,
            callback = function()
                require("metals").initialize_or_attach(metals_config)
            end,
            group = nvim_metals_group,
        })
    end
}
