return {
	{
		"nvim-treesitter/nvim-treesitter",
		enable = false,
		event = { "BufReadPre", "BufNewFile" },
		cmd = { "TSInstallInfo", "TSInstall" },
		build = ":TSUpdate",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-context",
			"HiPhish/rainbow-delimiters.nvim",
			 "nvim-treesitter/nvim-treesitter-textobjects",
		},
		config = function()
			local configs = require("nvim-treesitter.configs")

			configs.setup({
          		ensure_installed = {
					"c", "cpp", "python", "lua", "vim",
				},
				ignore_install = {},
          		sync_install = false,
				auto_install = false,
          		highlight = { enable = true },
          		indent = { enable = true, disable = {"python"} },
				autotag = { enable = true },
				autopairs = { enable = true },
				query_linter = {
   	 				enable = true,
    				use_virtual_text = true,
    				lint_events = {"BufWrite", "CursorHold"},
				},
        	})
		end,
	},
}
