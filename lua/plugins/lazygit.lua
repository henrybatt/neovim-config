return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,

    opts = {
        lazygit = {
            enabled = true,
            theme_path = nil,
        },
    },

    keys = {
        { "<leader>lg", function() Snacks.lazygit() end },
    }
}
