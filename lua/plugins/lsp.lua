return {
    {
        -- https://www.github.com/neovim/nvim-lspconfig
        -- lsp配置
        "neovim/nvim-lspconfig",
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
                    'nvim-tree/nvim-web-devicons',     -- optional
                },
            },
        },
        config = function()
            require("neoconf").setup()
            require("neodev").setup()
            require("fidget").setup()
            require("lspsaga").setup()
            require("mason").setup()
            -- local capabilities = require('cmp_nvim_lsp').default_capabilities()
            -- 配置文件
            local servers = {
                lua_ls = { -- lua
                    Lua = {
                        workspace = { checkThirdParty = false},
                        telemetry = { enable = false },
                    },
                },
                pyright = {}, -- python
                jsonls = {}, -- json
                volar = {}, -- vue
                dockerls = {}, -- docker
                docker_compose_language_service = {}, -- docker
                bashls = {}, -- bash
                taplo = {}, -- toml
                clangd = {}, -- c、c++
                quick_lint_js = {}, -- javascript
                html = {}, -- html
                jdtls = {}, -- java
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
                nmap("<space>f", function()
                    vim.lsp.buf.format { async = true }
                end, "[F]ormat code")
            end
            -- 自动安装、启用、关闭lsp
            require("mason-lspconfig").setup({
                -- 通过上方servers告诉lspconfig需要安装的lsp
                ensure_installed = vim.tbl_keys(servers),
                handlers = {
                    function(server_name) -- default handler (optional)
                        require("lspconfig")[server_name].setup {
                            settings = servers[server_name],
                            on_attach = on_attach,
                            -- capabilities = capabilities,
                        }
                    end,
                }
            })
        end
    },
    {

    },
}
