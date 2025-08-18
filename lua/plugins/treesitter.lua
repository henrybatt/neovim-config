return {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    branch = "main",
    build = ":TSUpdate",

    dependencies = {
        { "nvim-treesitter/nvim-treesitter-context" },
        { "HiPhish/rainbow-delimiters.nvim" },
    },

    config = function()
        require("config.options").treesitter_foldexpr()

        -- Install default parsers using nvim-treesitter
        require("nvim-treesitter").install({ "bash", "c", "lua", "markdown", "markdown_inline", "query", "regex", "vimdoc" })

        -- autocmd to automatically install and start treesitter parsers based on filetype
        -- from: https://www.reddit.com/r/neovim/comments/1kuj9xm/has_anyone_successfully_switched_to_the_new/
        vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
            desc = "Start (and install missing) treesitter parsers based on filetype",
            group = vim.api.nvim_create_augroup("treesitter-buf-win-enter", { clear = true }),
            callback = function(event)
                local filetype = vim.api.nvim_get_option_value("filetype", { buf = event.buf })

                if filetype == "" then
                    return
                end

                local name = vim.treesitter.language.get_lang(filetype)

                if name and require("nvim-treesitter.parsers")[name] then
                    if not vim.treesitter.language.add(name) then
                        require("nvim-treesitter").install({ name }):wait(60000)
                        if not vim.treesitter.language.add(name) then
                            vim.notify("Failed to find " .. name .. " parser after installation.",
                                vim.log.levels.WARN,
                                { title = "treesitter" }
                            )
                            return
                        end
                    end

                    vim.treesitter.start(event.buf, name)
                end
            end,
        })
    end,
}
