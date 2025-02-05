-- Terminal Mappings
local function term_nav(dir)
    return function(self)
        return self:is_floating() and "<c-" .. dir .. ">" or vim.schedule(function()
            vim.cmd.wincmd(dir)
        end)
    end
end


return {
    "snacks.nvim",
    priority = 1000,
    lazy = false,

    opts = {
        bigfile = { enabled = true },
        quickfile = { enabled = true },
        terminal = {
            win = {
                keys = {
                    nav_h = { "<C-h>", term_nav("h"), desc = "Go to Left Window", expr = true, mode = "t" },
                    nav_j = { "<C-j>", term_nav("j"), desc = "Go to Lower Window", expr = true, mode = "t" },
                    nav_k = { "<C-k>", term_nav("k"), desc = "Go to Upper Window", expr = true, mode = "t" },
                    nav_l = { "<C-l>", term_nav("l"), desc = "Go to Right Window", expr = true, mode = "t" },
                },
            },
        },

        styles = {
            terminal = {
                keys = {
                    quick_hide = {
                        "<C-q>",
                        "hide",
                        mode = "t",
                        expr = true,
                        desc = "Hide the terminal directly from insertion",
                    },
                },
            }
        },
    },

    keys = {
        { "<leader>tt", function() Snacks.terminal() end, desc = "[T]oggle [T]erminal Open" },
    },
}
