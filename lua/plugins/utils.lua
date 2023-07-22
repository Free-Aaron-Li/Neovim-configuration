return{
    {
        -- https://github.com/rhysd/accelerated-jk
        -- 随下拉（上拉）时间加快下滑（上滑）速度
        'rhysd/accelerated-jk',
        config=function()
            vim.keymap.set("n", "j", "<Plug>(accelerated_jk_gj)")
            vim.keymap.set("n", "k", "<Plug>(accelerated_jk_gk)")
        end,
    },
    {
        -- https://github.com/folke/persistence.nvim
        -- 保留退出前窗口结构和buffer
        "folke/persistence.nvim",
        event = "BufReadPre", -- this will only start session saving when an actual file was opened
        config = function()
            require("persistence").setup()
            vim.keymap.set("n","<leader>qs", [[<cmd>lua require("persistence").load()<cr>]])
            vim.keymap.set("n","<leader>ql", [[<cmd>lua require("persistence").load({ last = true})<cr>]])
            vim.keymap.set("n","<leader>qd", [[<cmd>lua require("persistence").stop()<cr>]])
        end,
    },
    {
        -- https://github.com/windwp/nvim-autopairs
        -- 标点符号自动补全
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        config=function()
            require('nvim-autopairs').setup({
                disable_filetype = { "TelescopePrompt" , "vim" }, -- Override default values
                -- Don't add pairs if it already has a close pair in the same line
                -- Before        Input         After
                ------------------------------------
                -- (  |))         (            (  (|))
                enable_check_bracket_line = false, -- check bracket in same line
                -- Don't add pairs if the next char is alphanumeric
                -- Before        Input         After
                ------------------------------------
                -- |foobar        (            (|foobar
                -- |.foobar       (            (|.foobar
                ignored_next_char = "[%w%.]", -- will ignore alphanumeric and `.` symbol
            })
        end,
    },
    {
        -- https://github.com/ethanholz/nvim-lastplace
        -- 保留上一次buffer光标位置
        'ethanholz/nvim-lastplace',
        config=function()
            require('nvim-lastplace').setup({
                lastplace_ignore_buftype = {"quickfix", "nofile", "help"}, 
                lastplace_ignore_filetype = {"gitcommit", "gitrebase", "svn", "hgcommit"},
                lastplace_open_folds = true
            })
        end,
    },
    {
        -- https://github.com/folke/flash.nvim
        -- 全局移动
        "folke/flash.nvim",
        event = "VeryLazy",
        config = function()
            require("flash").setup()
            vim.keymap.set({"n","x","o"},"fs",
                function()
                    require("flash").jump({
                        search = {
                            mode = function(str)
                                return "\\<" .. str
                            end,
                        },
                    })
                end
            )
            vim.keymap.set({"n","x","o"},"ff",
                function()
                    require("flash").treesitter()
                end
            )
            vim.keymap.set({"o"},"rn",
                function()
                    require("flash").remote()
                end
            )
            nim.keymap.set({"o","x"},"rf",
                function()
                    require("flash").treesitter_search()
                end
            )
        end,
    },
}
