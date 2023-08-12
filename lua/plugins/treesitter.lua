return{
    {
        -- https://github.com/nvim-treesitter/nvim-treesitter
        -- 语法高亮、代码结构集合
        'nvim-treesitter/nvim-treesitter',
        dependencies={
            -- https://github.com/nvim-treesitter/playground
            'nvim-treesitter/playground',
            -- https://github.com/nvim-treesitter/nvim-treesitter-textobjects
            'nvim-treesitter/nvim-treesitter-textobjects',
            -- https://github.com/tree-sitter/tree-sitter
            -- 'tree-sitter/tree-sitter',
        },
        main='nvim-treesitter.configs',
        build=':TSUpdate',
        config=function()
            require'nvim-treesitter.configs'.setup ({
                -- A list of parser names, or "all" (the five listed parsers should always be installed)
                ensure_installed = "all",
                -- Install parsers synchronously (only applied to `ensure_installed`)
                sync_install = false,
                -- Automatically install missing parsers when entering buffer
                -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
                auto_install = true,
                -- List of parsers to ignore installing (for "all")
                ignore_install = { "javascript" },
                ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
                -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!
                highlight = {
                    enable = true,
                    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
                    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
                    -- the name of the parser)
                    -- list of language that will be disabled
                    disable = { "c", "rust" },
                    -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
                    -- disable = function(lang, buf)
                    --     local max_filesize = 100 * 1024 -- 100 KB
                    --     local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                    --         if ok and stats and stats.size > max_filesize then
                    --             return true
                    --         end
                    --     end,
                    -- Setting this to true will run `:h syntax` and tree-sitter at the same time. 
                    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
                    -- Using this option may slow down your editor, and you may see some duplicate highlights.
                    -- Instead of true it can also be a list of languages
                    additional_vim_regex_highlighting = false,
                },
                -- Indentation based on treesitter for the = operator. NOTE: This is an experimental feature.
                indent = {
                    enable = true
                },
                -- View treesitter information directly 
                 playground = {
                    enable = true,
                    disable = {},
                    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
                    persist_queries = false, -- Whether the query persists across vim sessions
                    keybindings = {
                        toggle_query_editor = 'o',
                        toggle_hl_groups = 'i',
                        toggle_injected_languages = 't',
                        toggle_anonymous_nodes = 'a',
                        toggle_language_display = 'I',
                        focus_language = 'f',
                        unfocus_language = 'F',
                        update = 'R',
                        goto_node = '<cr>',
                        show_help = '?',
                    },
                },
                textobjects = {
                    select = {
                        enable = true,
                        -- Automatically jump forward to textobj, similar to targets.vim
                        lookahead = true,
                        keymaps = {
                            -- You can use the capture groups defined in textobjects.scm
                            ["af"] = "@function.outer",
                            ["if"] = "@function.inner",
                            ["ac"] = "@class.outer",
                            -- You can optionally set descriptions to the mappings (used in the desc parameter of
                            -- nvim_buf_set_keymap) which plugins like which-key display
                            ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
                            -- You can also use captures from other query groups like `locals.scm`
                            ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
                        },
                        -- You can choose the select mode (default is charwise 'v')
                        --
                        -- Can also be a function which gets passed a table with the keys
                        -- * query_string: eg '@function.inner'
                        -- * method: eg 'v' or 'o'
                        -- and should return the mode ('v', 'V', or '<c-v>') or a table
                        -- mapping query_strings to modes.
                        selection_modes = {
                            ['@parameter.outer'] = 'v', -- charwise
                            ['@function.outer'] = 'V', -- linewise
                            ['@class.outer'] = '<c-v>', -- blockwise
                        },
                        -- Define your own mappings to swap the node under the cursor with the next or previous one, 
                        -- like function parameters or arguments.
                        swap = {
                            enable = true,
                            swap_next = {
                                ["<leader>a"] = "@parameter.inner",
                            },
                            swap_previous = {
                                ["<leader>A"] = "@parameter.inner",
                            },
                        },
                        -- If you set this to `true` (default is `false`) then any textobject is
                        -- extended to include preceding or succeeding whitespace. Succeeding
                        -- whitespace has priority in order to act similarly to eg the built-in
                        -- `ap`.
                        --
                        -- Can also be a function which gets passed a table with the keys
                        -- * query_string: eg '@function.inner'
                        -- * selection_mode: eg 'v'
                        -- and should return true of false
                        include_surrounding_whitespace = false,
                    },
                },
            })
        end,
    },
}
