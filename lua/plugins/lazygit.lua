return {
    "kdheepak/lazygit.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },

    keys = function()
        vim.keymap.set("n", "<leader>lg", require("lazygit").lazygit, { desc = "[L]azy[G]it" })
    end,
}
