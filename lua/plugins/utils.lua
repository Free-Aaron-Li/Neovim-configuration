return{
    { -- https://github.com/rhysd/accelerated-jk
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
        -- 命令f+目标内容单词，通过f前往目标单词，shift+f回到上一个单词
        "folke/flash.nvim",
        event = "VeryLazy",
        config = function()
            require("flash").setup()
            vim.keymap.set({"n","x","o"},"es",
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
            vim.keymap.set({"n","x","o"},"ed",
                function()
                    require("flash").treesitter()
                end
            )
            vim.keymap.set({"o"},"rn",
                function()
                    require("flash").remote()
                end
            )
            vim.keymap.set({"o","x"},"rf",
                function()
                    require("flash").treesitter_search()
                end
            )
        end,
    },
    {
        -- https://github.com/kamykn/spelunker.vim
        -- 单词检查
        'kamykn/spelunker.vim',
        config=function()
            -- Enable spelunker.vim. (default: 1)
            -- 1: enable
            -- 0: disable
            vim.g.enable_spelunker_vim = 1

            -- Enable spelunker.vim on readonly files or buffer. (default: 0)
            -- 1: enable
            -- 0: disable
            vim.g.enable_spelunker_vim_on_readonly = 0

            -- Check spelling for words longer than set characters. (default: 4)
            vim.g.spelunker_target_min_char_len = 4

            -- Max amount of word suggestions. (default: 15)
            vim.g.spelunker_max_suggest_words = 15

            -- Max amount of highlighted words in buffer. (default: 100)
            vim.g.spelunker_max_hi_words_each_buf = 100

            -- Spellcheck type: (default: 1)
            -- 1: File is checked for spelling mistakes when opening and saving. This
            -- may take a bit of time on large files.
            -- 2: Spellcheck displayed words in buffer. Fast and dynamic. The waiting time
            -- depends on the setting of CursorHold `set updatetime=1000`.
            vim.g.spelunker_check_type = 2

            -- Highlight type: (default: 1)
            -- 1: Highlight all types (SpellBad, SpellCap, SpellRare, SpellLocal).
            -- 2: Highlight only SpellBad.
            -- FYI: https://vim-jp.org/vimdoc-en/spell.html#spell-quickstart
            vim.g.spelunker_highlight_type = 1

            -- Option to disable word checking.
            -- Disable URI checking. (default: 0)
            vim.g.spelunker_disable_uri_checking = 1

            -- Disable email-like words checking. (default: 0)
            vim.g.spelunker_disable_email_checking = 1

            -- Disable account name checking, e.g. @foobar, foobar@. (default: 0)
            -- NOTE: Spell checking is also disabled for JAVA annotations.
            vim.g.spelunker_disable_account_name_checking = 1

            -- Disable acronym checking. (default: 0)
            vim.g.spelunker_disable_acronym_checking = 1

            -- Disable checking words in backtick/backquote. (default: 0)
            vim.g.spelunker_disable_backquoted_checking = 1

            -- Disable default autogroup. (default: 0)
            vim.g.spelunker_disable_auto_group = 1

            -- Override highlight group name of incorrectly spelled words. (default:
            -- 'SpelunkerSpellBad')
            vim.g.spelunker_spell_bad_group = 'SpelunkerSpellBad'

            -- Override highlight group name of complex or compound words. (default:
            -- 'SpelunkerComplexOrCompoundWord')
            vim.g.spelunker_complex_or_compound_word_group = 'SpelunkerComplexOrCompoundWord'

            -- Override highlight setting.
            -- vim.cmd([[
            --     highlight SpelunkerSpellBad cterm=underline ctermfg=247 gui=underline guifg=#9e9e9e
            --     highlight SpelunkerComplexOrCompoundWord cterm=underline ctermfg=NONE gui=underline guifg=NONE
            -- ]])
        end,
    },
    {
        -- https://github.com/nvim-tree/nvim-tree.lua
        -- 文件目录树
        'nvim-tree/nvim-tree.lua',
        dependencies = {
          'nvim-tree/nvim-web-devicons', -- file icons
        },
        config=function()
            require("nvim-tree").setup({
                sort_by = "case_sensitive",
                create_in_closed_folder = true,
                hijack_cursor = true,
                open_on_setup = true,
                open_on_setup_file = true,
                focus_empty_on_setup = true,
                sync_root_with_cwd = true,
                view = {
                    width = 30,
                    adaptive_size = false,
                    mappings = {
                        list = {
                            -- { key = { "<2-RightMouse>", "<C-]>" }, action = "" }, -- cd
                            -- { key = "<C-v>", action = "" }, -- vsplit
                            -- { key = "<C-x>", action = "" }, -- split
                            -- { key = "<C-t>", action = "" }, -- tabnew
                            -- { key = "<BS>", action = "" }, -- close_node
                            -- { key = "<Tab>", action = "" }, -- preview
                            -- { key = "D", action = "" }, -- trash
                            -- { key = "[e", action = "" }, -- prev_diag_item
                            -- { key = "]e", action = "" }, -- next_diag_item
                            -- { key = "[c", action = "" }, -- prev_git_item
                            -- { key = "]c", action = "" }, -- next_git_item
                            -- { key = "o", action = "" }, -- dir_up
                            -- j key = "s", action = "" }, -- system_open
                            -- { key = "W", action = "" }, -- collapse_all
                            -- { key = "g?", action = "" }, -- toggle_help
                            {key = "g.",action="toggle_hidden"},
                            -- { key = "d", action = "cd" }, -- remove
                            -- { key = "x", action = "remove" }, -- cut
                            --
                            -- { key = "t", action = "cut" },
                            -- { key = "<Space>p", action = "prev_diag_item" },
                            -- { key = "<Space>.", action = "next_diag_item" },
                            -- { key = "<Space>k", action = "prev_git_item" },
                            -- { key = "<Space>j", action = "next_git_item" },
                            -- { key = "u", action = "dir_up" },
                            -- { key = "'", action = "close_node" },
                            -- { key = '"', action = "collapse_all" },
                            -- { key = "?", action = "toggle_help" },
                        },
                    },
                },
                renderer = {
                    full_name = true,
                    group_empty = true,
                    special_files = {},
                    symlink_destination = false,
                    indent_markers = {
                        enable = true,
                    },
                    icons = {
                        git_placement = "signcolumn",
                        show = {
                            file = true,
                            folder = false,
                            folder_arrow = false,
                            git = true,
                        },
                    },
                },
                update_focused_file = {
                    enable = true,
                    update_root = true,
                    ignore_list = { "help" },
                },
                diagnostics = {
                    enable = true,
                    show_on_dirs = true,
                },
                filters = {
                    custom = {
                        "^.git$",
                    },
                },
                actions = {
                    change_dir = {
                        enable = false,
                        restrict_above_cwd = false,
                    },
                    open_file = {
                        resize_window = true,
                        window_picker = {
                            chars = "aoeui",
                        },
                    },
                    remove_file = {
                        close_window = true,
                    },
                },
                log = {
                    enable = false,
                    truncate = true,
                    types = {
                        all = false,
                        config = false,
                        copy_paste = false,
                        diagnostics = false,
                        git = false,
                        profile = false,
                        watcher = false,
                    },
                },
            })
            -- 打开与关闭快捷键
            vim.keymap.set("n","<leader><leader>pr", ":NvimTreeOpen<CR>", {})
            vim.keymap.set("n","<S-n>", ":NvimTreeClose<CR>", {})

            -- 自动关闭
            vim.cmd([[
                autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif
            ]])
        end,
    },
    {
        -- https://github.com/folke/which-key.nvim
        -- 查看快捷键所属、映射
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 10000
        end,
        opts = {
          -- your configuration comes here
          -- or leave it empty to use the default settings
          -- refer to the configuration section below
        }

    },
    {
        -- https://github.com/echasnovski/mini.ai
        -- 增强textobject
        -- 'echasnovski/mini.ai',
        -- config=true,
    },
    {
        -- https://github.com/echasnovski/mini.comment
        -- 代码注释
        'echasnovski/mini.comment',
        config=function()
            require('mini.comment').setup({
                mappings = {
                    -- Toggle comment (like `gcip` - comment inner paragraph) for both
                    -- -- Normal and Visual modes
                    -- 注释 -> exegesis
                    comment = 'eg',
                    -- Toggle comment on current line
                    comment_line = 'egg',
                    -- Define 'comment' textobject (like `dgc` - delete whole comment block)
                    -- textobject = 'eg',
                },
            })
        end,
    },
    {
        -- https://github.com/s1n7ax/nvim-window-picker
        -- 为窗口编号
        's1n7ax/nvim-window-picker',
        name = 'window-picker',
        event = 'VeryLazy',
        version = '2.*',
        config = function()
            require'window-picker'.setup({
                filter_rules = {
                    include_current_win = true,
                    bo = {
                        filetype = { "fidget", "nvim-tree" }
                    }
                }
            })
            -- 快捷键
            vim.keymap.set("n",
                "<leader>wn",
                function()
                    local window_number = require('window-picker').pick_window()
                    if window_number then vim.api.nvim_set_current_win(window_number) end
                end
            )
        end,
    },
    {
        -- 编码时间
        'wakatime/vim-wakatime',
        config=function()
        end,
    },
    {
        -- markdown预览
        "iamcco/markdown-preview.nvim",
        build = "cd app && npm install",
        ft = { "markdown" },
        config=function()
            vim.g.mkdp_filetypes = { "markdown" }
            -- set default theme (dark or light)
            -- By default the theme is define according to the preferences of the system
            vim.g.mkdp_theme='light'
            -- specify browser to open preview page
            -- for path with space
            -- valid: `/path/with\ space/xxx`
            -- invalid: `/path/with\\ space/xxx`
            -- default: ''
            vim.g.mkdp_browser = '/home/aaron/Software/firefox/firefox-bin'
        end,
    },
    {
        -- https://github.com/dhruvasagar/vim-table-mode
        -- 表格预览
        "dhruvasagar/vim-table-mode",
        -- ft = "markdown",
    },
    {
        -- https://github.com/img-paste-devs/img-paste.vim
        -- 从剪贴板插入图片
        "ferrine/md-img-paste.vim",
        -- ft = "markdown",
    },
    {
        -- https://github.com/lilydjwg/fcitx.vim
        -- 自动切换输入法
        'welandx/fcitx5-switch.nvim',
        opt = true,
        event = "BufRead",
        config = function ()
            require('fcitx5-switch').Leave_enter_cmd()
        end
    },
}
