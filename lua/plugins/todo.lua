return {
    "folke/todo-comments.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
    keys = {
        { "<leader>st", function() Snacks.picker.todo_comments() end, desc = "Todo Comments" },
    }
}
