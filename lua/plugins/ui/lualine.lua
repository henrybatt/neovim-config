local countableFileTypes = {}
local function addTypes(types)
    for _, type in ipairs(types) do
        countableFileTypes[type] = true
    end
end
addTypes({ "md", "txt", "markdown", "tex", "latex", "typst", "typ" })

return {
    {
        "nvim-lualine/lualine.nvim",
        event = { "VeryLazy" },

        init = function()
            vim.g.lualine_laststatus = vim.o.laststatus
            if vim.fn.argc(-1) > 0 then
                vim.o.statusline = " "
            end
        end,

        opts = {
           sections = {
               lualine_x = {
                    function()
                        if countableFileTypes[vim.bo.filetype] then
                            return (vim.fn.wordcount().visual_words or vim.fn.wordcount().words) .. " words"
                        end
                        return ""
                    end,
                    "oil", "encoding", "fileformat", "filetype"}
           }
        },
    },
}
