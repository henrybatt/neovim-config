return {
    {
        "nvim-telescope/telescope.nvim",
        event = "VimEnter",
        dependencies = {
            "nvim-lua/plenary.nvim",
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make",
                cond = function() return vim.fn.executable("make") == 1 end
            },
            { "nvim-telescope/telescope-frecency.nvim" , version = "^0.9.0", }, -- Pin version for neovim 0.9.x support
            "nvim-telescope/telescope-ui-select.nvim",
            "debugloop/telescope-undo.nvim",
            "BurntSushi/ripgrep",
            { "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
            { "AckslD/nvim-neoclip.lua", dependencies = { "kkharji/sqlite.lua", module = "sqlite"},
                config = function()
                    require("neoclip").setup({ enable_persistent_history = true, })
                end,
            }
        },

        config = function(_, opts)
            local telescope = require("telescope")
            telescope.setup(opts)

            telescope.load_extension("fzf")
            telescope.load_extension("frecency")
            telescope.load_extension("ui-select")
            telescope.load_extension("undo")
            telescope.load_extension("neoclip")
        end,

        opts = function()
            return {
                defaults = {
                    border = true,
                    file_ignore_patterns = { ".git/" },
                    layout_config = {
                        horizontal = { height = 0.85, width = 0.90, preview_cuttof = 0, preview_width = 0.78 },
                        prompt_position = "top",
                    },
                    path_display = { "smart" },
                    prompt_prefix = " ",
                    selection_caret = "❯ ",
                    sorting_strategy = "ascending",
                    vimgrep_arguments = {
                        "rg",
                        "--color=never",
                        "--no-heading",
                        "--with-filename",
                        "--line-number",
                        "--column",
                        "--smart-case",
                        "--hidden",
                        "--trim",
                    },
                },
                pickers = {
                    buffers = {
                        prompt_prefix = "󰸩 ",
                    },
                    commands = {
                        prompt_prefix = " ",
                        layout_config = {
                            height = 0.99,
                            width = 0.99,
                        },
                    },
                    command_history = {
                        prompt_prefix = " ",
                        layout_config = {
                            height = 0.99,
                            width = 0.99,
                        },
                    },
                    git_files = {
                        prompt_prefix = "󰊢 ",
                        show_untracked = true,
                    },
                    find_files = {
                        prompt_prefix = " ",
                        find_command = { "fd", "-H" },
                        layout_config = {
                            height = 0.999,
                            width = 0.999,
                        },
                    },
                    live_grep = {
                        prompt_prefix = "󰱽 ",
                    },
                    grep_string = {
                        prompt_prefix = "󰱽 ",
                    },
                },
                extensions = {
                    ["ui-select"] = {
                            require("telescope.themes").get_dropdown(),
                        },
                },
            }
        end,

        -- Keymaps
        keys = function()
            local builtin = require("telescope.builtin")

            vim.keymap.set("n", "<leader><space>", builtin.buffers,   { desc = "[ ] Find existing buffers" })
            vim.keymap.set("n", "<leader>/",  builtin.current_buffer_fuzzy_find,  { desc = "[/] Fuzzily search in current buffer" })
            vim.keymap.set("n", "<leader>?",  builtin.oldfiles,       { desc = "[?] Find recently opened files" })
            vim.keymap.set("n", "<leader>.",  builtin.resume,         { desc = "[.] Resume Previous Telescope" })

            vim.keymap.set("n", "<leader>sf", builtin.find_files,     { desc = "[S]earch [F]iles" })

            vim.keymap.set("n", "<leader>sw", builtin.grep_string,    { desc = "[S]earch current [W]ord" })
            vim.keymap.set("n", "<leader>sg", builtin.live_grep,      { desc = "[S]earch by [G]rep" })

            vim.keymap.set("n", "<leader>sd", builtin.diagnostics,    { desc = "[S]earch [D]iagnostics" })
            vim.keymap.set("n", "<leader>ss", builtin.builtin,        { desc = "[S]earch [S]elect Telescope" })
            vim.keymap.set("n", "<leader>sh", builtin.help_tags,      { desc = "[S]earch [H]elp" })
            vim.keymap.set("n", "<leader>sk", builtin.keymaps,        { desc = "[S]earch [K]eymaps" })

            vim.keymap.set("n", "<leader>sn", function() builtin.find_files { cwd = vim.fn.stdpath "config" } end, { desc = "[S]earch [N]eovim Files" })

            vim.keymap.set("n", "<leader>sy", "<cmd>Telescope neoclip<CR>", { desc = "[Search] Previous [Y]anked Content " })
            vim.keymap.set("n", "<leader>su", "<cmd>Telescope undo<CR>",      { desc = "[S]earch [U]ndo Tree" })
            vim.keymap.set("n", "<leader>sr", "<Cmd>Telescope frecency<CR>",  { desc = "[S]earch F[R]ecency" })
        end,
    }
}
