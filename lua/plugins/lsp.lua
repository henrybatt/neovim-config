local servers = {}

servers.configs = {
    lua_ls = {
        settings = {
            Lua = {
                workspace = { checkThirdParty = false },
                telemetry = { enable = false },
            },
        },
    },
    pylsp = {
        settings = {
            pylsp = {
                plugins = {
                    pycodestyle = {
                        ignore = { "W191", "W291", "E261", "E266", "W293", "W391", "W504", "W503", "E501", "W501" },
                    }
                }
            }
        }
    },
    clangd = {},
    rust_analyzer = {},
    neocmake = {},
    glsl_analyzer = {},
    tinymist = {
        settings = {
            systemFonts = false,
            formatterMode = "typstyle",
            previewFeature = "disable"
        }
    },
    marksman = {},
    jdtls = {},
    harper_ls = {
        settings = {
            ["harper-ls"] = {
                linters = {
                    SpellCheck = false,
                },
            },
        }
    },
}

servers.ensure_installed = {
    "lua_ls",
    "pylsp"
}

return {
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        cmd = "Mason",
        dependencies = {
            { "williamboman/mason.nvim" },
            "williamboman/mason-lspconfig.nvim",
            "WhoIsSethDaniel/mason-tool-installer.nvim",
            { "folke/neodev.nvim",      opts = {}, },
            {
                "hrsh7th/nvim-cmp",
                event = "InsertEnter",
                dependencies = {
                    "hrsh7th/cmp-nvim-lsp",
                    "hrsh7th/cmp-path",
                    {
                        "L3MON4D3/LuaSnip",
                        dependencies = {
                            "saadparwaiz1/cmp_luasnip",
                            "rafamadriz/friendly-snippets",
                        },
                        build = function()
                            if vim.fn.has "win32" == 1 or vim.fn.executable "make" == 0 then
                                return
                            end
                            return "make install_jsregexp"
                        end,
                    }
                },
            },
        },

        config = function()
            -- LSP + Mason Setup --
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

            require("mason").setup({})

            require("mason-tool-installer").setup({ ensure_installed = servers.ensure_installed or {} })

            require("mason-lspconfig").setup({
                ensure_installed = servers.ensure_installed or {},
                automatic_installation = true,
                handlers = {
                    function(server_name)
                        local server = servers.configs[server_name] or {}
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
                    ["<C-l>"] = cmp.mapping(function()
                        if luasnip.expand_or_locally_jumpable() then
                            luasnip.expand_or_jump()
                        end
                    end, { "i", "s" }),
                    ["<C-h>"] = cmp.mapping(function()
                        if luasnip.locally_jumpable(-1) then
                            luasnip.jump(-1)
                        end
                    end, { "i", "s" }),
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

            -- Keymappings & automations
            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
                callback = function(event)
                    local map = function(keys, func, desc)
                        vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
                    end

                    map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
                    map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
                    map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")

                    map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

                    map("<leader>gd", vim.diagnostic.open_float, "Open [D]iagnostic")

                    map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
                    map("<leader>lds", require("telescope.builtin").lsp_document_symbols, "[L]SP [D]ocument [S]ymbols")
                    map("<leader>lws", require("telescope.builtin").lsp_dynamic_workspace_symbols,
                        "[L]SP [W]orkspace [S]ymbols")
                    map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
                    map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
                    map("<leader>fmt", vim.lsp.buf.format, "LSP [F]or[m]a[t]")

                    map("K", vim.lsp.buf.hover, "Hover Documentation")

                    -- Highlight definitions when cursor holds on it
                    local client = vim.lsp.get_client_by_id(event.data.client_id)
                    if client and client.server_capabilities.documentHighlightProvider then
                        vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                            buffer = event.buf,
                            callback = vim.lsp.buf.document_highlight,
                        })

                        vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
                            buffer = event.buf,
                            callback = vim.lsp.buf.clear_references,
                        })
                    end
                end
            })
        end,
    },
}
