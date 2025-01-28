return {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,

    opts = {
        view = {
            side = "right",
        },
    },

    config = function(_, opts)
        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1
        require("nvim-tree").setup(opts)
    end,
}
