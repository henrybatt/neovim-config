return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,

    opts = {
        picker = {
            enabled = true,
            matcher = { frecency = true },
            win = {
                input = {
                    keys = {
                        ["<C-q>"] = { "close", mode = { "n", "i" } },
                        ["J"] = { "preview_scroll_down", mode = { "n" } },
                        ["K"] = { "preview_scroll_up", mode = { "n" } },
                        ["H"] = { "preview_scroll_left", mode = { "n" } },
                        ["L"] = { "preview_scroll_right", mode = { "n" } },
                        ["<C-j>"] = { "preview_scroll_down", mode = { "i" } },
                        ["<C-k>"] = { "preview_scroll_up", mode = { "i" } },
                        ["<C-h>"] = { "preview_scroll_left", mode = { "i" } },
                        ["<C-l>"] = { "preview_scroll_right", mode = { "i" } },
                    },
                },
            },
            preset = "default",
            layout = {
                layout = {
                    box = "horizontal",
                    width = 0.9,
                    min_width = 120,
                    height = 0.85,
                    {
                        box = "vertical",
                        title = "{title} {live} {flags}",
                        { win = "input", border = "rounded", title = "{title} {live} {flags}", height = 1 },
                        { win = "list",  border = "rounded", title = "Results" },
                    },
                    { win = "preview", title = "{preview}", border = "rounded", width = 0.8 },
                },
            },
            layouts = {
                vertical_list_only = {
                    layout = {
                        backdrop = false,
                        width = 0.9,
                        min_width = 80,
                        height = 0.8,
                        min_height = 30,
                        box = "vertical",
                        { win = "input", border = "rounded", title = "{title} {live} {flags}", height = 1 },
                        { win = "list",  border = "rounded", title = "Results" },
                    }
                }
            }
        },
    },

    keys = {
        -- Top Pickers
        { "<leader><space>", function() Snacks.picker.smart() end, desc = "Smart Find Files" },
        { "<leader>.",       function() Snacks.picker.files() end, desc = "Find Files" },
        {
            "<leader>,",
            function()
                Snacks.picker.buffers({
                    on_show = function() vim.cmd.stopinsert() end,
                    win = { input = { keys = { ["d"] = "bufdelete" } } },
                })
            end,
            desc = "Buffers"
        },
        { "<leader>/", function() Snacks.picker.grep() end,            desc = "Grep" },
        { "<leader>:", function() Snacks.picker.command_history() end, desc = "Command History" },
        { "<leader>n", function() Snacks.picker.notifications() end,   desc = "Notification History" },

        -- Find
        {
            "<leader>fc",
            function()
                Snacks.picker.files({
                    cwd = vim.fn.stdpath("config") })
            end,
            desc = "Find Config File"
        },
        { "<leader>fg", function() Snacks.picker.git_files() end,          desc = "Find Git Files" },
        { "<leader>fp", function() Snacks.picker.projects() end,           desc = "Projects" },
        { "<leader>fr", function() Snacks.picker.recent() end,             desc = "Recent" },

        -- Grep
        { "<leader>sb", function() Snacks.picker.lines() end,              desc = "Buffer Lines" },
        { "<leader>sB", function() Snacks.picker.grep_buffers() end,       desc = "Grep Open Buffers" },
        { "<leader>sg", function() Snacks.picker.grep() end,               desc = "Grep" },
        { "<leader>sw", function() Snacks.picker.grep_word() end,          desc = "Visual selection or word", mode = { "n", "x" } },

        -- Search
        { '<leader>s"', function() Snacks.picker.registers() end,          desc = "Registers" },
        { '<leader>s/', function() Snacks.picker.search_history() end,     desc = "Search History" },
        { "<leader>sb", function() Snacks.picker.lines() end,              desc = "Buffer Lines" },
        { "<leader>sc", function() Snacks.picker.command_history() end,    desc = "Command History" },
        { "<leader>sC", function() Snacks.picker.commands() end,           desc = "Commands" },
        { "<leader>sd", function() Snacks.picker.diagnostics() end,        desc = "Diagnostics" },
        { "<leader>sD", function() Snacks.picker.diagnostics_buffer() end, desc = "Buffer Diagnostics" },
        { "<leader>sh", function() Snacks.picker.help() end,               desc = "Help Pages" },
        { "<leader>sH", function() Snacks.picker.highlights() end,         desc = "Highlights" },
        { "<leader>sj", function() Snacks.picker.jumps() end,              desc = "Jumps" },
        {
            "<leader>sk",
            function()
                Snacks.picker.keymaps({
                    layout = "vertical_list_only" })
            end,
            desc = "Keymaps"
        },
        { "<leader>sq", function() Snacks.picker.qflist() end,                desc = "Quickfix List" },
        { "<leader>sR", function() Snacks.picker.resume() end,                desc = "Resume" },
        { "<leader>su", function() Snacks.picker.undo() end,                  desc = "Undo History" },

        -- -- LSP
        -- { "gd",         function() Snacks.picker.lsp_definitions() end,       desc = "Goto Definition" },
        -- { "gD",         function() Snacks.picker.lsp_declarations() end,      desc = "Goto Declaration" },
        -- { "gr",         function() Snacks.picker.lsp_references() end,        desc = "References",            nowait = true, },
        -- { "gI",         function() Snacks.picker.lsp_implementations() end,   desc = "Goto Implementation" },
        -- { "gy",         function() Snacks.picker.lsp_type_definitions() end,  desc = "Goto T[y]pe Definition" },
        -- { "<leader>ss", function() Snacks.picker.lsp_symbols() end,           desc = "LSP Symbols" },
        -- { "<leader>sS", function() Snacks.picker.lsp_workspace_symbols() end, desc = "LSP Workspace Symbols" },
    },
}
