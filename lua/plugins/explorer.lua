return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,

    opts = {
        explorer = {
            enabled = true,
            replace_netrw = false,
        },
        picker = {
            sources = {
                explorer = {
                    layout = {
                        layout = { position = "right" }
                    },
                }
            }
        }
    },

    keys = {
        { "<leader>ee", function() Snacks.explorer() end, desc = "" }
    }
}
