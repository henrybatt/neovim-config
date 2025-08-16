local save_and_close = {
    callback = function()
        local oil = require("oil")
        oil.save(nil, function() oil.close() end)
    end,
    mode = "n",
    desc = "Save and close OIL"
}

return {
    {
        "refractalize/oil-git-status.nvim",
        ft = { "oil" },
        opts = {},
    },
    {
        "JezerM/oil-lsp-diagnostics.nvim",
        ft = { "oil" },
        opts = {},
    },
    {
        "stevearc/oil.nvim",

        dependencies = {
            { "echasnovski/mini.icons", opts = {} },
        },

        opts = {
            delete_to_trash = true,
            float = {
                padding = 8,
            },
            win_options = {
                signcolumn = "yes:2",
            },
            keymaps = {
                ["gd"] = {
                    desc = "Toggle file detail view",
                    callback = function()
                        _G.detail = not detail
                        if detail then
                            require("oil").set_columns({ "icon", "permissions", "size", "mtime" })
                        else
                            require("oil").set_columns({ "icon" })
                        end
                    end,
                },
                ["q"] = save_and_close,
                ["<Esc>"] = save_and_close,
            },
            view_options = {
                show_hidden = true,
                is_always_hidden = function(name, _)
                    return vim.startswith(name, ".DS_Store")
                end,
            },
        },

        keys = function()
            return {
                { "-", require("oil").open_float, desc = "Open parent directory - OIL" },
            }
        end,
    }
}
