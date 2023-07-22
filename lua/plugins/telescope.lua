return{
    {
        -- https://github.com/nvim-lua/kickstart.nvim/blob/master/init.lua 可借鉴代码
        -- https://github.com/nvim-telescope/telescope.nvim
        -- 文件、文字搜素
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        dependencies = {
            'nvim-lua/plenary.nvim',
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                build = 'make',
            },
        },
        config=function()
            require('telescope').setup({
                    defaults = {
                    -- 打开弹窗后进入的初始模式，默认为 insert
                    initial_mode = "insert",
                    -- 快捷键设置
                    mappings = {
                        i = {
                            -- map actions.which_key to <C-h> (default: <C-/>)
                            -- actions.which_key shows the mappings for your picker,
                            -- e.g. git_{create, delete, ...}_branch for the git_branches picker
                            -- 上下移动
                            ["<C-j>"] = "move_selection_next",
                            ["<C-k>"] = "move_selection_previous",
                            -- 插件默认配置
                            -- ["<Down>"] = "move_selection_next",
                            -- ["<Up>"] = "move_selection_previous",
                            -- 历史记录
                            -- ["<C-n>"] = "cycle_history_next",
                            -- ["<C-p>"] = "cycle_history_prev",
                            -- 关闭窗口
                            -- ["<C-c>"] = "close",
                            ["<A-j>"] = "close",
                            -- 预览窗口上下滚动
                            -- ["<C-u>"] = "preview_scrolling_up",
                            -- ["<C-d>"] = "preview_scrolling_down",
                        }
                    }
                },
                pickers = { 
                    -- 内置 pickers 配置
                    find_files = {
                    -- dropdown, cursor, ivy
                    theme = "dropdown", 
                    }
                },
                extensions = {
                   -- 扩展插件配置
                   fzf = {
                    fuzzy = true,                    -- false will only do exact matching
                    override_generic_sorter = true,  -- override the generic sorter
                    override_file_sorter = true,     -- override the file sorter
                    case_mode = "smart_case",        -- or "ignore_case" or "respect_case",the default case_mode is "smart_case"
                    }
                },
            })
            require('telescope').load_extension('fzf')
            -- 打开telescope快捷键
            local builtin = require('telescope.builtin')
            vim.keymap.set('n', '<leader><leader>ff', builtin.find_files, {desc = '[S]earch [F]iles'})
            vim.keymap.set('n', '<leader><leader>fl', builtin.live_grep, {desc = '[S]earch by [G]rep'})
            vim.keymap.set('n', '<leader><leader>fb', builtin.buffers, {desc = '[ ] Find existing buffers'})
            vim.keymap.set('n', '<leader><leader>fo', builtin.oldfiles, {desc = '[?] Find recently opened files'})
            vim.keymap.set('n', '<leader><leader>/', function()
                -- You can pass additional configuration to telescope to change theme, layout, etc.
                require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
                    winblend = 10,
                    previewer = false,
                })
            end, { desc = '[/] Fuzzily search in current buffer' })
        end,
    },
}
