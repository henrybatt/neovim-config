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
                bo = {
                    filetype = "snacks_terminal",
                },
                wo = {},
                keys = {
                    q = "hide",
                    gf = function(self)
                        local f = vim.fn.findfile(vim.fn.expand("<cfile>"), "**")
                        if f == "" then
                            Snacks.notify.warn("No file under cursor")
                        else
                            self:hide()
                            vim.schedule(function()
                                vim.cmd("e " .. f)
                            end)
                        end
                    end,
                    term_normal = {
                        "<esc>",
                        function()
                            vim.cmd("stopinsert")
                        end,
                        mode = "t",
                        expr = true,
                        desc = "Double escape to normal mode",
                    },
                },
            }
        },
    },

    keys = {
        { "<leader>tt", function() Snacks.terminal() end, desc = "[T]oggle [T]erminal Open" },
    },
}
