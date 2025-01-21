return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = function()
            vim.cmd.colorscheme "catppuccin"
            require("catppuccin").setup({
                transparent_background = true,
                integrations = {
                    cmp = true,
                    gitsigns = true,
                    nvimtree = true,
                    treesitter = true,
                    notify = true,
                    telescope = { enabled = true },
                    barbar = true,
                    alpha = true,
                    fidget = true,
                    hop = true,
                    mason = true,
                    noice = true,
                    which_key = true,
                },
            })
        end,
    },
    {
        "xiyaowong/transparent.nvim",
        lazy = false,
        opts = {},
    },
    {
    "goolord/alpha-nvim",
    event = "VimEnter",
    config = function()
        local status_ok, alpha = pcall(require, "alpha")
        if not status_ok then
            return
        end

        local dashboard = require("alpha.themes.dashboard")
        dashboard.section.buttons.val = {
            dashboard.button("f", "  Find file", ":Telescope find_files <CR>"),
            dashboard.button("e", "  New file", ":ene <CR>"),
            dashboard.button("r", "  Recently used files", ":Telescope oldfiles <CR>"),
            dashboard.button("gr", "  Find text", ":Telescope live_grep <CR>"),
            dashboard.button("n", "  Open file tree", ":NvimTreeOpen <CR>"),
            dashboard.button("q", "  Quit Neovim", ":qa<CR>"),
        }

        local v = vim.version()
        local version = " v" .. v.major .. "." .. v.minor .. "." .. v.patch
        local datetime = os.date(" %d-%m-%Y 󱑏 %H:%M:%S")

        vim.api.nvim_create_autocmd("User", {
            pattern = "LazyVimStarted",
            callback = function()
                local stats = require("lazy").stats()
                local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
                dashboard.section.footer.val = {
                    "",
                    "",
                    version,
                    "",
                    datetime,
                    "",
                    "⚡ Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms",
                }
                pcall(vim.cmd.AlphaRedraw)
            end,
        })

        dashboard.section.footer.val = {}

        dashboard.section.footer.opts.hl = "Type"
        dashboard.section.header.opts.hl = "Include"
        dashboard.section.buttons.opts.hl = "Keyword"

        dashboard.opts.opts.noautocmd = true
        alpha.setup(dashboard.opts)

    end
    }
}
