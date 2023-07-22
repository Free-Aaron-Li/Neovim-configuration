return{
    {
        -- https://github.com/folke/tokyonight.nvim
        -- tokyonight主题
        "folke/tokyonight.nvim",
        dependencies={
            -- 额外补充插件
            -- https://github.com/utilyre/barbecue.nvim
            -- 页眉展示
            -- 展示当前文件位置、函数位置等
            {
                "utilyre/barbecue.nvim",
                dependencies={
                    "SmiteshP/nvim-navic",
                    "nvim-tree/nvim-web-devicons", -- optional dependency
                },
            },
            -- https://github.com/nvim-lualine/lualine.nvim
            -- 状态栏
            {
                'nvim-lualine/lualine.nvim',
                dependencies={
                    'nvim-tree/nvim-web-devicons', 
                },
            },
        },
        lazy = false,
        priority = 1000,
        config=function()
            vim.cmd[[colorscheme tokyonight-night]]
            require('barbecue').setup({
                theme = 'tokyonight',
            })
            require('lualine').setup({
                extensions = {
                    "nvim-tree",
                    "toggleterm", 
                },
                options={
                    theme = 'tokyonight',
                },
            })
        end,
    },
}
