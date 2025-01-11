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
			"nvim-telescope/telescope-frecency.nvim",
			"nvim-telescope/telescope-ui-select.nvim",
			"debugloop/telescope-undo.nvim",
			"BurntSushi/ripgrep",
			{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
		},

		config = function(_, opts)
			local telescope = require("telescope")
			telescope.setup(opts)

			telescope.load_extension("fzf")
			telescope.load_extension("frecency")
			telescope.load_extension("ui-select")
			telescope.load_extension("undo")

		end,

        opts = function()
            return {
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
                { "<leader><space>", builtin.buffers,   { desc = "[ ] Find existing buffers" } },
                { "<leader>/",  builtin.current_buffer_fuzzy_find,  { desc = "[/] Fuzzily search in current buffer" } },
                { "<leader>?",  builtin.oldfiles,       { desc = "[?] Find recently opened files" } },
                { "<leader>.",  builtin.resume,         { desc = "[.] Resume previous Telescope" } },

                { "<leader>sf", builtin.find_files,     { desc = "[S]earch [F]iles" } },

                { "<leader>sw", builtin.grep_string,    { desc = "[S]earch current [W]ord" } },
                { "<leader>sg", builtin.live_grep,      { desc = "[S]earch by [G]rep" } },

			    { "<leader>sd", builtin.diagnostics,    { desc = "[S]earch [D]iagnostics" } },
			    { "<leader>ss", builtin.builtin,        { desc = "[S]earch [S]elect Telescope" } },
			    { "<leader>sh", builtin.help_tags,      { desc = "[S]earch [H]elp" } },
                { "<leader>sk", builtin.keymaps,        { desc = "[S]earch [K]eymaps" } },

                { "<leader>sn", function() builtin.find_files { cwd = vim.fn.stdpath "config" } end, { desc = "[S]earch [N]eovim files" } },

                { "<leader>su", "<cmd>Telescope undo<CR>",      { desc = "[S]earch [U]ndo Tree" } },
                { "<leader>sr", "<Cmd>Telescope frecency<CR>",  { desc = "[S]earch F[R]ecency" } },
            }
        end,
	}
}