return{
    {
        -- https://github.com/akinsho/bufferline.nvim
        -- buffer显示
        'akinsho/bufferline.nvim', 
        version = "*", 
        dependencies ={ 
            'nvim-tree/nvim-web-devicons',
            'moll/vim-bbye',
            'nvim-treesitter/nvim-treesitter',
        },
        config=function()
            vim.opt.termguicolors = true
                require("bufferline").setup({
                    options = {
                        -- 光标浮动显示删除符号
                        hover = {
                            enabled = true,
                            delay = 200,
                            reveal = {'close'}
                        },
                        -- 关闭 Tab 的命令，这里使用 moll/vim-bbye 的 :Bdelete 命令
                        close_command = "Bdelete! %d",
                        right_mouse_command = "Bdelete! %d",
                        -- 侧边栏配置
                        -- 左侧让出 nvim-tree 的位置，显示文字 File Explorer
                        offsets = {
                            {
                                filetype = "NvimTree",
                                text = "File Explorer",
                                highlight = "Directory",
                                text_align = "left",
                        },
                    },
                -- 使用 nvim 内置 LSP
                diagnostics = "nvim_lsp",
                -- 可选，显示 LSP 报错图标
                ---@diagnostic disable-next-line: unused-local
                diagnostics_indicator = function(count, level, diagnostics_dict, context)
                    local s = " "
                        for e, n in pairs(diagnostics_dict) do
                            local sym = e == "error" and " " or (e == "warning" and " " or "")
                            s = s .. n .. sym
                        end
                    return s
                  end,
                },
            })
        end,
    },
    {
        -- https://github.com/lukas-reineke/indent-blankline.nvim
        -- 缩进竖线
        "lukas-reineke/indent-blankline.nvim",
        config=function()
            vim.opt.termguicolors = true

            ------------------
            -- 彩虹括号rgb设定
            --
            vim.cmd [[highlight IndentBlanklineIndent1 guifg=#E06C75 gui=nocombine]]
            vim.cmd [[highlight IndentBlanklineIndent2 guifg=#E5C07B gui=nocombine]]
            vim.cmd [[highlight IndentBlanklineIndent3 guifg=#98C379 gui=nocombine]]
            vim.cmd [[highlight IndentBlanklineIndent4 guifg=#56B6C2 gui=nocombine]]
            vim.cmd [[highlight IndentBlanklineIndent5 guifg=#61AFEF gui=nocombine]]
            vim.cmd [[highlight IndentBlanklineIndent6 guifg=#C678DD gui=nocombine]]
            ------------------
            ------------------
            -- 空格使用·表示，换行添加符号
            -- vim.opt.list = true
            -- vim.opt.listchars:append "space:·"
            -- vim.opt.listchars:append "eol:"
            -------------------

            require("indent_blankline").setup({
                -- for example, context is off by default, use this to turn it on
                show_current_context = true,
                show_current_context_start = true,
                -- 彩虹竖线配置，需要上方前置rgb设定
                space_char_blankline = " ",
                char_highlight_list = {
                    "IndentBlanklineIndent1",
                    "IndentBlanklineIndent2",
                    "IndentBlanklineIndent3",
                    "IndentBlanklineIndent4",
                    "IndentBlanklineIndent5",
                    "IndentBlanklineIndent6",
                },
            })
        end,
    },
    {
        -- https://github.com/lewis6991/gitsigns.nvim
        -- 在侧边栏显示文档增删改git信息
        'lewis6991/gitsigns.nvim',
        config=function()
            require('gitsigns').setup ({
                signs = {
                    add          = { text = '│' },
                    change       = { text = '│' },
                    delete       = { text = '_' },
                    topdelete    = { text = '‾' },
                    changedelete = { text = '~' },
                    untracked    = { text = '┆' },
                },
                signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
                numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
                linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
                word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
                watch_gitdir = {
                    follow_files = true
                },
                attach_to_untracked = true,
                current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
                current_line_blame_opts = {
                    virt_text = true,
                    virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
                    delay = 1000,
                    ignore_whitespace = false,
                },
                current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
                sign_priority = 6,
                update_debounce = 100,
                status_formatter = nil, -- Use default
                max_file_length = 40000, -- Disable if file is longer than this (in lines)
                preview_config = {
                    -- Options passed to nvim_open_win
                    border = 'single',
                    style = 'minimal',
                    relative = 'cursor',
                    row = 0,
                    col = 1
                },
                yadm = {
                    enable = false
                },
            })
        end,
    },
}
