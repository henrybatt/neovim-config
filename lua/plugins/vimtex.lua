return {
    "lervag/vimtex",
    lazy = false,
    init = function()
        vim.g.vimtex_view_method = "zathura"
        vim.g.vimtex_quickfix_ignore_filters = {
            [[Overfull \\[hv]box]],
            [[Underfull \\[hv]box]],
        }
    end
}
