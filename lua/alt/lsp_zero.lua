return {
	{
		"VonHeikemen/lsp-zero.nvim",
		enabled = false,
		branch = "v3.x",
		event = { "BufReadPre", "BufNewFile" },
		cmd = "Mason",
		dependencies = {
			"neovim/nvim-lspconfig" ,
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/nvim-cmp",
			"folke/neodev.nvim",
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			{ "L3MON4D3/LuaSnip",
				dependencies = {
					"saadparwaiz1/cmp_luasnip",
					"rafamadriz/friendly-snippets",
				},
			},
		},
		config = function()
			-- lsp-zer
			local lsp_zero = require("lsp-zero")

			lsp_zero.on_attach(function(client, bufnr)
				lsp_zero.default_keymaps({ buffer = bufnr })
			end)

			-- mason & mason-lspconfig
			require("mason").setup({})

			require("mason-lspconfig").setup({
				ensure_installed = {},
				handlers = {
					lsp_zero.default_setup,
				},
				automatic_install = true
			})

			require("lspconfig").lua_ls.setup(lsp_zero.nvim_lua_ls())

			-- luasnip
			require("luasnip.loaders.from_vscode").lazy_load()

			-- nvim-cmp
			local cmp = require("cmp")
			cmp.setup({
				mapping = cmp.mapping.preset.insert({
					["<C-Space>"] = cmp.mapping.complete(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
				}),
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				sources = {
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
				},
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end
				},
			})
		end,
	},
}
