return {
    "mfussenegger/nvim-dap",

    keys = {
        { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Dap: Breakpoint Condition" },
        { "<leader>db", function() require("dap").toggle_breakpoint() end,                                    desc = "Dap: Toggle Breakpoint" },
        { "<leader>dc", function() require("dap").continue() end,                                             desc = "Dap: Run/Continue" },
        { "<leader>dC", function() require("dap").run_to_cursor() end,                                        desc = "Dap: Run to Cursor" },
        { "<leader>dg", function() require("dap").goto_() end,                                                desc = "Dap: Go to Line (No Execute)" },
        { "<leader>di", function() require("dap").step_into() end,                                            desc = "Dap: Step Into" },
        { "<leader>dj", function() require("dap").down() end,                                                 desc = "Dap: Down" },
        { "<leader>dk", function() require("dap").up() end,                                                   desc = "Dap: Up" },
        { "<leader>dl", function() require("dap").run_last() end,                                             desc = "Dap: Run Last" },
        { "<leader>do", function() require("dap").step_out() end,                                             desc = "Dap: Step Out" },
        { "<leader>dO", function() require("dap").step_over() end,                                            desc = "Dap: Step Over" },
        { "<leader>dP", function() require("dap").pause() end,                                                desc = "Dap: Pause" },
        { "<leader>dr", function() require("dap").repl.toggle() end,                                          desc = "Dap: Toggle REPL" },
        { "<leader>ds", function() require("dap").session() end,                                              desc = "Dap: Session" },
        { "<leader>dt", function() require("dap").terminate() end,                                            desc = "Dap: Terminate" },
        { "<leader>dw", function() require("dap.ui.widgets").hover() end,                                     desc = "Dap: Widgets" },
    },
}
