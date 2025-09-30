return {
    "dap",
    virtual = true,
    dependencies = {
        "jay-babu/mason-nvim-dap.nvim",
        cmd = { "DapInstall", "DapUninstall" },
        dependencies = {
            { "williamboman/mason.nvim" },
            { "mfussenegger/nvim-dap" },
        },
        opts = {
            handlers = {
                function(config)
                    require('mason-nvim-dap').default_setup(config)
                end,
            },
        }
    },
}
