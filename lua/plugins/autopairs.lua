return {
    {
        "windwp/nvim-autopairs",
        event = { "InsertEnter" },
        config = function()
            local auto_pairs = require("nvim-autopairs")
            auto_pairs.setup({
                check_ts = true,
                ts_config = {
                    lua = { "string" },
                }
            })

            local ts_conds = require("nvim-autopairs.ts-conds")
            local Rule = require("nvim-autopairs.rule")
            auto_pairs.add_rules({
                Rule("%", "%", "lua") : with_pair(ts_conds.is_ts_node({'string','comment'})),
                Rule("$", "$", "lua") : with_pair(ts_conds.is_not_ts_node({'function'}))
            })
        end,
    },
}
