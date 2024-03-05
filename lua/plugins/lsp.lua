return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		cmd = "Mason",
		dependencies = {
			{ "williamboman/mason.nvim" },
      		"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			{ "j-hui/fidget.nvim", opts = {}, },
			{"folke/neodev.nvim", opts = {}, },
			{ "hrsh7th/nvim-cmp",
				event = "InsertEnter",
				dependencies = {
					"hrsh7th/cmp-nvim-lsp",
					"hrsh7th/cmp-path",
					{ "L3MON4D3/LuaSnip",
						dependencies = {
							"saadparwaiz1/cmp_luasnip",
							"rafamadriz/friendly-snippets",
						},
						build = function ()
							if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
            					return
          					end
          					return 'make install_jsregexp'
						end,
					}
				},
			},
		},
		config = function()

			-- LSP + Mason Setup -- 
      		local capabilities = vim.lsp.protocol.make_client_capabilities()
      		capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

			local servers = {
				lua_ls = {},
			}

			require("mason").setup()

			local ensure_installed = vim.tbl_keys(servers or {})
      			vim.list_extend(ensure_installed, {
      		})

      		require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

			require("mason-lspconfig").setup({
				handlers = {
					function(server_name)
						local server = servers[server_name] or {}
			            server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
						require("lspconfig")[server_name].setup(server)
					end,
				}
			})

			-- CMP Autocomplete -- 
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			luasnip.config.setup({})

			cmp.setup({
				mapping = cmp.mapping.preset.insert({
					["<C-Space>"] = cmp.mapping.complete(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					['<C-l>'] = cmp.mapping(function()
            				if luasnip.expand_or_locally_jumpable() then
              					luasnip.expand_or_jump()
            				end
          				end, { 'i', 's' }),
          			['<C-h>'] = cmp.mapping(function()
            				if luasnip.locally_jumpable(-1) then
             					luasnip.jump(-1)
            				end
          				end, { 'i', 's' }),
				}),
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				sources = {
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "path" },
				},
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				completion = { completeopt = "menu,menuone,noinsert" },

			})


		end,
	},
}
