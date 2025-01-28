return {
    "stevearc/oil.nvim",

    opts = {
        delete_to_trash = false,
        float = {
            padding = 8,
        },
        keymaps = {
            ["gd"] = {
                desc = "Toggle file detail view",
                callback = function()
                    detail = not detail
                    if detail then
                        require("oil").set_columns({ "icon", "permissions", "size", "mtime" })
                    else
                        require("oil").set_columns({ "icon" })
                    end
                end,
            },
            ["q"] = { "actions.close", mode = "n", desc = "Close OIL" },
            ["<Esc>"] = { "actions.close", mode = "n", desc = "Close OIL" },
        },
        view_options = {
            show_hidden = true,
            is_always_hidden = function(name, _)
                return vim.startswith(name, '.DS_Store')
            end,
        },
    },

    keys = function()
        return {
            { "-", require("oil").open_float, desc = "Open parent directory - OIL" },
        }
    end,
}
