return {
    "rcarriga/nvim-dap-ui",
    dependencies = {
        { "mfussenegger/nvim-dap" },
        { "nvim-neotest/nvim-nio" }
    },

    config = function(_, opts)
        local dap, dapui = require("dap"), require("dapui")
        dapui.setup(opts)

        dap.listeners.before.attach.dapui_config = dapui.open
        dap.listeners.before.launch.dapui_config = dapui.open
        dap.listeners.before.event_terminated.dapui_config = dapui.close
        dap.listeners.before.event_exited.dapui_config = dapui.close
    end,

    keys = {
        { "<leader>du", function() require("dapui").toggle({}) end, desc = "Dap UI: Toggle" },
        { "<leader>de", function() require("dapui").eval() end,     desc = "Dap UI: Eval",  mode = { "n", "v" } },
    },
}
