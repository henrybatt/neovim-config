return {
    "folke/noice.nvim",
    event = "VeryLazy",

    opts = {
        lsp = {
            override = {
                ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                ["vim.lsp.util.stylize_markdown"] = true,
                ["cmp.entry.get_documentation"] = true,
            },
        },
        views = {
            cmdline_popup = {
                position = {
                    row = 7,
                    col = "55%",
                },
            },
            cmdline_popupmenu = {
                position = {
                    row = 7,
                    col = "55%",
                },
            },
        },
    },
}
