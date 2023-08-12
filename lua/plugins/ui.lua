return{
    { -- https://github.com/akinsho/bufferline.nvim
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
                require("bufferline").setup({})
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
                -- space_char_blankline = " ",
                -- char_highlight_list = {
                --     "IndentBlanklineIndent1",
                --     "IndentBlanklineIndent2",
                --     "IndentBlanklineIndent3",
                --     "IndentBlanklineIndent4",
                --     "IndentBlanklineIndent5",
                --     "IndentBlanklineIndent6",
                -- },
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
                    add          = { text = '┃' },
                    change       = { text = '┃' },
                    delete       = { text = '▁' },
                    topdelete    = { text = '▔' },
                    changedelete = { text = '~' },
                    untracked    = { text = '┆' },
                },
                signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`      侧边栏显示增删改信息
                numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`      行号显示增删改信息
                linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`     代码块阴影显示增删改信息
                word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`  字符添加阴影显示增删改信息
                watch_gitdir = {
                    follow_files = true
                },
                attach_to_untracked = true,
                current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
                current_line_blame_opts = { -- 行后信息显示格式
                    virt_text = true,
                    virt_text_pos = 'right_align', -- 'eol' | 'overlay' | 'right_align'
                    delay = 1000,
                    ignore_whitespace = true,
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
                    row = 2,
                    col = 1
                },
                yadm = {
                    enable = false,
                },
            })
        end,
    },
    {
        -- https://github.com/goolord/alpha-nvim
        -- nvim首页
        'goolord/alpha-nvim',
        event = "VimEnter",
        dependencies = {
            'nvim-tree/nvim-web-devicons'
        },
        config=function()
            -- 前置条件
            require'alpha'.setup(require'alpha.themes.dashboard'.config)
            local alpha = require'alpha'
            local dashboard = require("alpha.themes.dashboard")

            -- 随机提取颜色（通过字符串、识别符、快捷键、数字）
            math.randomseed(os.time())
            local function pick_color()
                local colors = {"String", "Identifier", "Keyword", "Number"}
                return colors[math.random(#colors)]
            end

            -- 页脚
            local function footer()
                -- 获取系统时间、nvim版本
                local datetime = os.date(" %d-%m-%Y   %H:%M:%S")
                local tableTime = os.date("*t")
                local version = vim.version()
                -- 问候列表
                local greetingsTable = {
                    [1] = "  Sleep well",
                    [2] = "  Good morning",
                    [3] = "  Good afternoon",
                    [4] = "  Good evening",
                    [5] = "󰖔  Good night",
                }
                -- 名言列表
                local function  famous_quotation()
                    local mottos={
                        "   学无止境  志在千里   ",
                        "   青衿之志  履践致远   ", -- 年少的读书人要有志向，只有把根基打好了，才能走得更远。
                        "   浅予深深  长乐未央   ", -- 我们给予他人的东西虽然并不贵重，但是其中包含了我们深深的情意，这也使得我们的快乐可以永不停止。
                        "   筚路蓝缕  玉汝于成   ",
                        "   锲而不舍  金石可镂   ", -- 荀子
                        "   君子养心  莫善于诚   ", -- 荀子
                        "   知人者智  自知者明   ", -- 老子
                        "   鸿鹄高飞  一举千里   ", -- 司马迁
                    }
                    return mottos[math.random(#mottos)]
                end
                
                -- 判断时间以此显示正确的问候语句
                local greetingIndex = 0
                local hour = tableTime.hour
                if hour == 23 or hour < 7 then
                  greetingIndex = 1
                elseif hour < 12 then
                  greetingIndex = 2
                elseif hour >= 12 and hour < 18 then
                  greetingIndex = 3
                elseif hour >= 18 and hour < 21 then
                  greetingIndex = 4
                elseif hour >= 21 then
                  greetingIndex = 5
                end

                -- 获取lazy插件管理状态并以此得到插件数目、启动时间
                local stats = require("lazy").stats()
                local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
                local plugins = "\t⚡loaded " .. stats.count .. " plugins in " .. ms .. "ms"
                -- 获取nvim的版本信息
                local nvim_version_info = "    v" .. version.major .. "." .. version.minor .. "." .. version.patch

                -- 显示页脚
                return "\t" .. famous_quotation() .. "\n" 
                        .. datetime ..  nvim_version_info .. "\n " 
                        .. plugins .. "\n\t"
                        .. greetingsTable[greetingIndex] .. ", Aaron"
            end

            -- 页面logo
            local logo = {
                "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
                "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
                "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
                "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
                "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
                "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
            }

            -- logo显示
            dashboard.section.header.val = logo
            -- 随机显示标题头颜色
            dashboard.section.header.opts.hl = pick_color()
            -- 显示页脚
            dashboard.section.footer.val = footer()
            dashboard.section.footer.opts.hl = "Constant"
            -- 显示页面选项
            dashboard.section.buttons.val = {
                dashboard.button("<Leader>ff", "  File Explorer"),
                dashboard.button("<Leader>fo", "  Find File"),
                dashboard.button("<Leader>fw", "  Find Word"),
                dashboard.button("<Leader>ps", "  Update plugins"),
                dashboard.button("q", "  Quit", ":qa<cr>")
            }
        end,
    },
    {
        -- https://github.com/RRethy/vim-illuminate
        -- 阴影显示相同单词或内容
        'RRethy/vim-illuminate',
        config=function()
            require('illuminate').configure({
                -- providers: provider used to get references in the buffer, ordered by priority
                providers = {
                    'lsp',
                    'treesitter',
                    'regex',
                },
                -- delay: delay in milliseconds
                delay = 50,
                -- filetype_overrides: filetype specific overrides.
                -- The keys are strings to represent the filetype while the values are tables that
                -- supports the same keys passed to .configure except for filetypes_denylist and filetypes_allowlist
                filetype_overrides = {},
                -- filetypes_denylist: filetypes to not illuminate, this overrides filetypes_allowlist
                filetypes_denylist = {
                    'dirvish',
                    'fugitive',
                    'alpha',
                },
                -- filetypes_allowlist: filetypes to illuminate, this is overriden by filetypes_denylist
                filetypes_allowlist = {},
                -- modes_denylist: modes to not illuminate, this overrides modes_allowlist
                -- See `:help mode()` for possible values
                modes_denylist = {},
                -- modes_allowlist: modes to illuminate, this is overriden by modes_denylist
                -- See `:help mode()` for possible values
                modes_allowlist = {},
                -- providers_regex_syntax_denylist: syntax to not illuminate, this overrides providers_regex_syntax_allowlist
                -- Only applies to the 'regex' provider
                -- Use :echom synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name')
                providers_regex_syntax_denylist = {},
                -- providers_regex_syntax_allowlist: syntax to illuminate, this is overriden by providers_regex_syntax_denylist
                -- Only applies to the 'regex' provider
                -- Use :echom synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name')
                providers_regex_syntax_allowlist = {},
                -- under_cursor: whether or not to illuminate under the cursor
                under_cursor = true,
                -- large_file_cutoff: number of lines at which to use large_file_config
                -- The `under_cursor` option is disabled when this cutoff is hit
                large_file_cutoff = nil,
                -- large_file_config: config to use for large files (based on large_file_cutoff).
                -- Supports the same keys passed to .configure
                -- If nil, vim-illuminate will be disabled for large files.
                large_file_overrides = nil,
                -- min_count_to_highlight: minimum number of matches required to perform highlighting
                min_count_to_highlight = 1,
            })
        end,
    },
}
