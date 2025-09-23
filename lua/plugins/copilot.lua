return {
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
        opts = {
            suggestion = { enabled = false },
            panel = { enabled = false }
        },
    },
    {
        "saghen/blink.cmp",
        dependencies = {
            { "giuxtaposition/blink-cmp-copilot" },
        },

        opts_extend = { "default", "providers.copilot" },
        opts = {
            sources = {
                default = { "lsp", "path", "snippets", "buffer", "copilot" },
                providers = {
                    copilot = {
                        name = "copilot",
                        module = "blink-cmp-copilot",
                        score_offset = 100,
                        async = true,
                    },
                },
            },
        },
    }
}
