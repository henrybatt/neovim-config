return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,

    config = function(_, opts)
        require("snacks").setup(opts)

        -- Create command to show notification history if snacks.notifier is enabled
        if opts.notifier and opts.notifier.enabled then
            vim.api.nvim_create_user_command("Notifications", function()
                Snacks.notifier.show_history()
            end, {})
        end
    end,

    opts = {
        indent = { enabled = true },
        input = { enabled = true },
        notifier = { enabled = true },
        notify = { enabled = true },
        scope = { enabled = true },
        scroll = { enabled = true },
        statuscolumn = { enabled = true },
        words = { enabled = true },
    },
}
