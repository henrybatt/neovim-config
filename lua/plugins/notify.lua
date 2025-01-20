return {
    "rcarriga/nvim-notify",
    version = "3.14.1",

    config = function(_, opts)
        require("notify").setup(opts)
        vim.notify = require("notify")
    end,

    opts = {
        stages = "static",
        timeout = 1500,
    },
}
