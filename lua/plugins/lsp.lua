return {
    {
        -- https://www.github.com/neovim/nvim-lspconfig
        -- lsp配置
        "neovim/nvim-lspconfig",
        -- 读取文件或打开文件使用
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig",
            -- https://www.github.com/folke/neoconf.nvim
            -- 类似vscode的json配置
            "folke/neoconf.nvim",
            -- https://www.github.com/folke/neodev.nvim
            -- 正常识别vimAPI
            "folke/neodev.nvim",
            {
                -- https://www.github.com/j-hui/fidget.nvim
                -- 在右下角显示lsp配置进度
                "j-hui/fidget.nvim",
                tag = "legacy",
            },
            {
                -- https://www.github.com/nvimdev/lspsaga.nvim
                -- https://nvimdev.github.io/lspsaga
                -- 美化lsp UI
                "nvimdev/lspsaga.nvim",
                dependencies = {
                    'nvim-tree/nvim-web-devicons', -- optional
                },
            },
        },
        config = function()
            require("neoconf").setup()
            require("neodev").setup()
            require("fidget").setup()
            require("lspsaga").setup()
            require("mason").setup()
            -- 配置文件
            local servers = {
                lua_ls = { -- lua
                    Lua = {
                        workspace = { checkThirdParty = false },
                        telemetry = { enable = false },
                    },
                },
                pyright = {},                         -- python
                jsonls = {},                          -- json
                volar = {},                           -- vue
                dockerls = {},                        -- docker
                docker_compose_language_service = {}, -- docker
                bashls = {},                          -- bash
                taplo = {},                           -- toml
                clangd = {},                          -- c、c++
                quick_lint_js = {},                   -- javascript
                html = {},                            -- html
                jdtls = {},                           -- java
                -- prettier = {}, -- angular, css, flow, graphql, html, json, jsx, javascript, less, markdown, scss, typescript, vue, yaml
                -- sql-formatter = {}, -- sql
                -- cmakelint = {}, -- cmake
                cmake = {}, -- cmake
            }
            -- 当lsp触发时执行任务
            local on_attach = function(_, bufnr)
                -- Enable completion triggered by <c-x><c-o>
                local nmap = function(keys, func, desc)
                    if desc then
                        desc = 'LSP: ' .. desc
                    end
                    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
                end
                nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
                nmap('gd', require "telescope.builtin".lsp_definitions, '[G]oto [D]efinition')
                nmap('K', "<cmd>Lspsaga hover_doc<CR>", 'Hover Documentation')
                nmap('gi', require "telescope.builtin".lsp_implementations, '[G]oto [I]mplementation')
                nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')
                nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
                nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
                nmap('<leader>wl', function()
                    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                end, '[W]orkspace [L]ist Folders')
                nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
                nmap('<leader>rn', "<cmd>Lspsaga rename ++project<cr>", '[R]e[n]ame')
                nmap('<leader>ca', "<cmd>Lspsaga code_action<CR>", '[C]ode [A]ction')
                -- 代码错误项
                nmap('<leader><leader>er', require "telescope.builtin".diagnostics, '[D]i[A]gnostics')
                nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
                -- nmap('gr', vim.lsp.buf.references, '[G]oto [R]eferences')
                -- 格式化
                nmap("<space>f", function()
                    vim.lsp.buf.format { async = true }
                end, "[F]ormat code")
            end
            -- 自动安装、启用、关闭lsp
            local capabilities = require('cmp_nvim_lsp').default_capabilities()
            require("mason-lspconfig").setup({
                -- 通过上方servers告诉lspconfig需要安装的lsp
                ensure_installed = vim.tbl_keys(servers),
                handlers = {
                    function(server_name) -- default handler (optional)
                        require("lspconfig")[server_name].setup {
                            settings = servers[server_name],
                            on_attach = on_attach,
                            -- 自动补全
                            capabilities = capabilities,
                        }
                    end,
                }
            })
        end
    },
    {
        -- https://www.github.com/hrsh7th/nvim-cmp
        -- lsp自动补全
        "hrsh7th/nvim-cmp",
        dependencies = {
            -- https://www.github.com/hrsh7th/cmp-path
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-cmdline',
            {
                -- 语言引擎
                'saadparwaiz1/cmp_luasnip',
                dependencies = {
                    'L3MON4D3/LuaSnip',
                    dependencies = {
                        'rafamadriz/friendly-snippets',
                    },
                },
            }
        },
        config = function()
            -- tab键切换自动补全选项
            local has_words_before = function()
                unpack = unpack or table.unpack
                local line, col = unpack(vim.api.nvim_win_get_cursor(0))
                return col ~= 0 and
                    vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
            end

            local cmp = require('cmp')
            local luasnip = require('luasnip')
            local cmp_mappings = {
                ["<C-j>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                        -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
                        -- they way you will only jump inside the snippet region
                    elseif luasnip.expand_or_jumpable() then
                        luasnip.expand_or_jump()
                    elseif has_words_before() then
                        cmp.complete()
                    else
                        fallback()
                    end
                end, { "i", "s" }),

                ["<C-k>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif luasnip.jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { "i", "s" }),
                ['<CR>'] = cmp.mapping.confirm({ select = true }),

            }
            require('luasnip.loaders.from_vscode').lazy_load()
            cmp.setup {
                -- 启用引擎
                snippet = {
                    expand = function(args)
                        require('luasnip').lsp_expand(args.body)
                    end,
                },
                sources = cmp.config.sources({
                    -- 启动顺序
                    { name = 'nvim_lsp' },
                    { name = 'path' },
                    { name = 'luasnip' },
                    { name = 'buffer' },
                    { name = 'cmdline' },
                }),
                mapping = cmp.mapping.preset.insert(cmp_mappings),
                experimental = {
                    ghost_text = true,
                }
            }

            cmp.setup.cmdline('/', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = 'buffer' },
                    { name = 'cmdline' },
                })
            })

            cmp.setup.cmdline(':', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = 'path' },
                    { name = 'buffer' },
                    { name = 'cmdline' },
                })
            })
        end
    },
    {
        -- https://www.github.com/mfussenegger/nvim-dap
        -- Debug支持
        'mfussenegger/nvim-dap',
        dependencies = {
            -- https://www.github.com/rcarriga/nvim-dap-ui
            'rcarriga/nvim-dap-ui',
            -- https://www.github.com/theHamsta/nvim-dap-virtual-text
            'theHamsta/nvim-dap-virtual-text',
            'nvim-telescope/telescope-dap.nvim',
            -- https://www.github.com/mfussenegger/nvim-dap-python
        },
        config = function()
            require('nvim-dap-virtual-text').setup()
            require('dapui').setup()
            local dap, dapui = require("dap"), require("dapui")
            dap.listeners.after.event_initialized["dapui_config"] = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated["dapui_config"] = function()
                dapui.close()
            end
            dap.listeners.before.event_exited["dapui_config"] = function()
                dapui.close()
            end

        end

    },
}
