return {
    {
        -- https://github.com/nvim-lua/kickstart.nvim/blob/master/init.lua 可借鉴代码
        -- https://github.com/nvim-telescope/telescope.nvim
        -- 文件、文字搜素
        'nvim-telescope/telescope.nvim',
        event = 'VeryLazy',
        branch = '0.1.x',
        dependencies = {
            'nvim-lua/plenary.nvim',
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                build = 'make',
            },
            {
                -- https://www.github.com/nvim-telescope/telescope-file-browser.nvim
                'nvim-telescope/telescope-file-browser.nvim',
                dependencies = {
                    'nvim-telescope/telescope.nvim',
                    'nvim-lua/plenary.nvim'
                }
            },
            'nvim-telescope/telescope-project.nvim',
        },
        config = function()
            local fb_actions = require "telescope".extensions.file_browser.actions
            -- local project_actions = require("telescope._extensions.project.actions")
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
                            ["j"] = "move_selection_next",
                            ["k"] = "move_selection_previous",
                            -- 历史记录
                            -- ["<C-n>"] = "cycle_history_next",
                            -- ["<C-p>"] = "cycle_history_prev",
                            -- 关闭窗口
                            -- ["<C-c>"] = "close",
                            ["<S-n>"] = "close",
                            -- 预览窗口上下滚动
                            -- ["<C-u>"] = "preview_scrolling_up",
                            -- ["<C-d>"] = "preview_scrolling_down",
                        },
                        n = {
                            ["<S-n>"] = "close",
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
                        fuzzy = true,                   -- false will only do exact matching
                        override_generic_sorter = true, -- override the generic sorter
                        override_file_sorter = true,    -- override the file sorter
                        case_mode = "smart_case",       -- or "ignore_case" or "respect_case",the default case_mode is "smart_case"
                    },
                    file_browser = {
                        -- disables netrw and use telescope-file-browser in its place
                        hijack_netrw = true,
                        mappings = {
                            ["i"] = {
                                -- your custom insert mode mappings
                            },
                            ["n"] = {
                                -- your custom normal mode mappings
                                ['c'] = fb_actions.create,
                                ['r'] = fb_actions.rename,
                                ['m'] = fb_actions.move,
                                ['y'] = fb_actions.copy,
                                ['d'] = fb_actions.remove,
                                ['o'] = fb_actions.open,
                                ['h'] = fb_actions.toggle_hidden,
                                ['e'] = fb_actions.goto_home_dir,
                            }
                        }
                    },
                    project = {
                        base_dirs = {},
                        hidden_files = false, -- default: false
                        -- theme = "dropdown",
                        order_by = "recent",
                        search_by = "title",
                        -- sync_with_nvim_tree = false, -- default false
                        -- default for on_project_selected = find project files
                        -- on_project_selected = function(prompt_bufnr)
                        --     -- Do anything you want in here. For example:
                        --     project_actions.change_working_directory(prompt_bufnr, false)
                        --     require("harpoon.ui").nav_file(1)
                        -- end
                    },
                },
            })
            require('telescope').load_extension('fzf')
            require('telescope').load_extension('file_browser')

            -- 打开telescope快捷键
            local builtin = require('telescope.builtin')
            -- 查找文件
            vim.keymap.set('n', '<leader><leader>ff', builtin.find_files, { desc = '[S]earch [F]iles' })
            -- 全局查找
            vim.keymap.set('n', '<leader><leader>fl', builtin.live_grep, { desc = '[S]earch by [G]rep' })
            -- buffer检索
            vim.keymap.set('n', '<leader><leader>fb', builtin.buffers, { desc = '[ ] Find existing buffers' })
            -- 查找历史文件
            vim.keymap.set('n', '<leader><leader>fo', builtin.oldfiles, { desc = '[?] Find recently opened files' })
            -- 查看目录（查看当前目录）
            vim.keymap.set('n', '<leader><leader>pr', ':Telescope file_browser path=%:p:h select_buffer=true<cr>',
                { desc = '[F]iles browser' })
            -- 查看工作空间
            vim.keymap.set('n', '<leader><leader>pj', ":lua require'telescope'.extensions.project.project{}<cr>",
                { noremap = true, silent = true, desc = '[O]pen workspace' })
            -- 当前目录下内容查找
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
