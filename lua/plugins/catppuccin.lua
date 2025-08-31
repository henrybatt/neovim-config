return {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,

    config = function(_, opts)
        require("catppuccin").setup(opts)
        vim.cmd.colorscheme "catppuccin"
    end,

    opts = {
        transparent_background = true,
        integrations = {
            blink_cmp = true,
            gitsigns = true,
            mason = true,
            mini = { enabled = true },
            noice = true,
            snacks = { enabled = true },
            lsp_trouble = false,
            which_key = true,
        },
    },
}
