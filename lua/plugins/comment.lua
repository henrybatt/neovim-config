return {
    "numToStr/Comment.nvim",
    event = { "BufReadPre", "BufNewFile" },

    opts = {
        ignore = "^$",
    },

    config = function(_, opts)
        require("Comment").setup(opts)
    end,
}
