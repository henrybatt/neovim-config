return {
    {
        "nvim-telescope/telescope.nvim",
        -- event= "VimEnter",
        lazy = true,
        event = "VeryLazy",
        dependencies = {
            "nvim-lua/plenary.nvim",
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make",
                cond = function() return vim.fn.executable("make") == 1 end
            },
            { "nvim-telescope/telescope-frecency.nvim" },
            "nvim-telescope/telescope-ui-select.nvim",
            "debugloop/telescope-undo.nvim",
            "BurntSushi/ripgrep",
            { "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
            { "AckslD/nvim-neoclip.lua", dependencies = { "kkharji/sqlite.lua", module = "sqlite"},
                opts = { enable_persistent_history = true, },
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
                    },
                    command_history = {
                        prompt_prefix = " ",
                    },
                    git_files = {
                        prompt_prefix = "󰊢 ",
                        show_untracked = true,
                    },
                    find_files = {
                        prompt_prefix = " ",
                        find_command = { "fd", "-H" },
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
            return {
                { "<leader><space>", builtin.buffers,   desc = "[ ] Find existing buffers"  },
                { "<leader>/",  builtin.current_buffer_fuzzy_find,  desc = "[/] Fuzzily search in current buffer" },
                { "<leader>?",  builtin.oldfiles,       desc = "[?] Find recently opened files" },
                { "<leader>.",  builtin.resume,         desc = "[.] Resume Previous Telescope" },

                { "<leader>sf", builtin.find_files,     desc = "[S]earch [F]iles" },

                { "<leader>sw", builtin.grep_string,    desc = "[S]earch current [W]ord" },
                { "<leader>sg", builtin.live_grep,      desc = "[S]earch by [G]rep" },

			    { "<leader>sd", builtin.diagnostics,    desc = "[S]earch [D]iagnostics" },
			    { "<leader>ss", builtin.builtin,        desc = "[S]earch [S]elect Telescope" },
			    { "<leader>sh", builtin.help_tags,      desc = "[S]earch [H]elp" },
                { "<leader>sk", builtin.keymaps,        desc = "[S]earch [K]eymaps" },

                { "<leader>sn", function() builtin.find_files { cwd = vim.fn.stdpath "config" } end, desc = "[S]earch [N]eovim Files" },

                { "<leader>sy", "<cmd>Telescope neoclip<CR>",   desc = "[Search] Previous [Y]anked Content " },
                { "<leader>su", "<cmd>Telescope undo<CR>",      desc = "[S]earch [U]ndo Tree" },
                { "<leader>sr", "<Cmd>Telescope frecency<CR>",  desc = "[S]earch F[R]ecency" },
            }
        end,
    }
}
