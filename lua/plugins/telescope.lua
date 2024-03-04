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
			"debugloop/telescope-undo.nvim",
			"BurntSushi/ripgrep",
		},
		config = function()
			local telescope = require("telescope")
			telescope.setup({})

			telescope.load_extension("fzf")
			telescope.load_extension("frecency")
			telescope.load_extension("undo")

			local builtin = require("telescope.builtin")

			vim.keymap.set("n", "<leader>?", builtin.oldfiles, {desc = "[?] Find recently opened files"})
			vim.keymap.set("n", "<leader><space>", builtin.buffers, {desc = "[ ] Find existing buffers"})
			vim.keymap.set("n", "<leader>/", builtin.current_buffer_fuzzy_find, {desc = "[/] Fuzzily search in current buffer"})
			vim.keymap.set("n", "<leader>sf", builtin.find_files, {desc = "[S]earch [F]iles"})
			vim.keymap.set("n", "<leader>sh", builtin.help_tags, {desc = "[S]earch [H]elp"})
			vim.keymap.set("n", "<leader>sw", builtin.grep_string, {desc = "[S]earch current [W]ord"})
			vim.keymap.set("n", "<leader>sg", builtin.live_grep, {desc = "[S]earch by [G]rep"})
			vim.keymap.set("n", "<leader>sd", builtin.diagnostics, {desc = "[S]earch [D]iagnostics"})

			vim.keymap.set("n", "<leader>su", "<cmd>Telescope undo<cr>", {desc = "[S]earch [U]ndo Tree"})
			vim.keymap.set("n", "<leader>sr", "<Cmd>Telescope frecency<CR>", {desc = "[S]earch F[R]ecency"})
		end,
	}
}
