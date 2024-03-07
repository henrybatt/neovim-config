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
		config = function()
			local telescope = require("telescope")
			telescope.setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown(),
					},
				},
			})

			telescope.load_extension("fzf")
			telescope.load_extension("frecency")
			telescope.load_extension("ui-select")
			telescope.load_extension("undo")

			-- Keymaps
			local builtin = require("telescope.builtin")

			vim.keymap.set("n", "<leader><space>", builtin.buffers, {desc = "[ ] Find existing buffers"})
			vim.keymap.set("n", "<leader>/", builtin.current_buffer_fuzzy_find, {desc = "[/] Fuzzily search in current buffer"})
			vim.keymap.set("n", "<leader>?", builtin.oldfiles, {desc = "[?] Find recently opened files"})

			vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })

			vim.keymap.set("n", "<leader>sw", builtin.grep_string, {desc = "[S]earch current [W]ord"})
			vim.keymap.set("n", "<leader>sg", builtin.live_grep, {desc = "[S]earch by [G]rep"})

			vim.keymap.set("n", "<leader>sd", builtin.diagnostics, {desc = "[S]earch [D]iagnostics"})
			vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
			vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
			vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })

			vim.keymap.set('n', '<leader>sn', function() builtin.find_files { cwd = vim.fn.stdpath 'config' } end,
				{ desc = '[S]earch [N]eovim files' })

			vim.keymap.set("n", "<leader>su", "<cmd>Telescope undo<CR>", {desc = "[S]earch [U]ndo Tree"})
			vim.keymap.set("n", "<leader>sr", "<Cmd>Telescope frecency<CR>", {desc = "[S]earch F[R]ecency"})
		end,
	}
}
