---------------
-- 引言
---------------

--[[
 Neovim可以通过插件扩展新功能，修改现有功能和增强开发体验。
 在这里使用的插件管理器为packer.nvim
 packer.nvim支持插件间依赖，指定版本，指定分支等。且全用lua编写，专门针对Neovim v0
 5.0以上版本
 在接下来，将会安装一系列插件用于Neovim的优化和扩展，并详细介绍每个插件具体用法。
 祝你好运！
]]
--

---------------
-- 命令
---------------

--[[
 保存并退出该文件后，进入Neovim，可以使用一下命令安装、更新、清除、加载插件
 :PackerCompile（包编译）：每次改变插件配置后，使用该命令（或使用PackerSync 包同步重新生成编译完成的加载文件
 :PackerClean（包清理）：清除所有不用的插件
 :PackerInstall（包下载）：清除并安装未安装的插件
 :PackerUpdate（包更新）：清除，更新并安装未安装的插件
 :PackerSync（包同步）：可解释为：执行PackerUpdate，并执行PackerCompile
 :PackerLoad（包加载）：加载opt插件
 由此可以看出：:PackerSync包含:PackerUpdate和:PackerCompile，:PackerUpdate命令包含:PackerClean和:PackerInstall
 综上所述，一般情况下，无论是安装还是更新，只需执行:PackerSync这一条命令即可。
 每次修改完plugins.lua文件，保存并退出，执行:PackerSync命令即可
]]
--

---------------
-- 安装位置
---------------

--[[
 Neovim推荐将数据存储在标准数据目录下（:h base-directories 查看详细的说明文档）,
 标准数据目录默认为~/.local/share/nvim，可以通过调用 :echo stdpath("data")查看
统实际路径
 Packer设置默认插件位置安装在 标准数据目录/site/pack/packer/start中，
]]
--

local packer = require('packer')
packer.startup({
    function(use)
        --[[
      通常安装插件规范为“use 'name/repo' ”,其中name指项目名，repo指具体的库。例如
    下面的wbthomason/packer.nvim指向的便是https://github.com/wbthomason/packer.n
    im
    ]]
        --
        -- Packer 用于管理插件
        use('wbthomason/packer.nvim')

        -------------插件列表-------------
        --                              --
        --                              --
        --                              --
        ---------------主题---------------
        --[[
      注意事项：

      1、一个现代化的主题，应该支持nvim-treesitter语法高亮（可以通过nvim-treesitter wiki(https://github.com/nvim-treesitter/nvim-treesitter/wiki/Colorschemes)查看支持的主题）
      2、能够支持很多流行Lua插件的配色

    ]]
        --
        -- 主题一：tokyonight
        -- 背景色：蓝黑色偏淡紫色 RGB：#24283b
        -- 该主题移植于VScode TokyoNight theme。
        -- github 1.3k+ 星星
        use('folke/tokyonight.nvim')
        ----------------------------------
        -- 主题二：OceanicNext
        -- 背景色：深绿色 RGB：#1b2c34
        --[[
      Oceanic-Next是受Oceanic Next for Sublime启发制作出来的主题，但是只用到了基础色系，并不是直接移植。
      支持Neovim和Vim8。
      github 1k+ 星星
      ]]
        --
        -- use('mhartington/oceanic-next')
        ----------------------------------
        -- 主题三：gruvbox
        -- 背景色：棕黑色 RGB：#282828
        --[[
      gruvbox是非常著名的配色gruvbox community的Lua移植版，支持treesitter。
    ]]
        --
        -- use({ 'ellisonleao/gruvbox.nvim', requires = { 'rktjmp/lush.nvim' } })
        ----------------------------------
        -- 主题四：zephyr
        -- 背景色：黑色 RGB：#282a37
        --[[
      zephyr是由中国人开发的一款配色，但是存在问题，即某次Treesitter更新后与该配色发生冲突，
      可以参考“https://link.juejin.cn/?target=https%3A%2F%2Fgithub.com%2Fglepnir%2Fzephyr-nvim%2Fissues%2F29”修复该问题
      或者等待作者修复。 
      github 200+ 星星
    ]]
        --
        -- use('glepnir/zephyr-nvim')
        ----------------------------------
        -- 主题五：nord
        -- 背景色：黑色 RGB：#2e333f
        --[[
      主题配色为现代化的配色，同时支持非常多的插件。整体观感偏素。
    ]]
        --
        -- use('shaunsingh/nord.nvim')
        ----------------------------------
        -- 主题六：onedark
        -- 背景色：黑色 RGB：#292c34
        -- 经典主题，支持许多插件，支持Treesitter和LSP
        -- use('ful1e5/onedark.nvim')
        ----------------------------------
        -- 主题七：nightfox
        -- 背景色：黑色 RGB：#1a2330
        --[[
      包含许多种配色：Nightfox/Nordfox/Dayfox/Dawnfox/Duskfox，支持众多插件
      相对来说配置项偏多，配置复杂。
      github 600+ 星星
    ]]
        --
        -- use('EdenEast/nightfox.nvim')
        ----------------------------------
        --                              --
        --                              --
        ---------------插件---------------
        -- 插件一：nvim-tree：侧边栏浏览器
        --[[
      注意：requires语句：表示nvim-tree依赖于nvim-web-devicons，当安装插件时，两组件都会安装
    ]]
        --
        use({
            'kyazdani42/nvim-tree.lua',
            requires = 'kyazdani42/nvim-web-devicons', -- 文件图标
        })
        ----------------------------------
        -- 插件二：bufferline：Tab页面
        use({
            'akinsho/bufferline.nvim',
            requires = { -- 依赖项
                'kyazdani42/nvim-web-devicons', --[[ 图标 ]] --
                'moll/vim-bbye', --[[解决关闭当前buffer时导致的窗口关闭以及布局混乱等问题]] --
            },
        })
        ----------------------------------
        -- 插件三：lualine：底部状态栏
        use({
            'nvim-lualine/lualine.nvim',
            requires = {
                'kyazdani42/nvim-web-devicons', --[[ 图标 ]] --
            },
        })
        use('arkav/lualine-lsp-progress') --[[ lualine扩展 ]] --
        ----------------------------------
        -- 插件四：telescope：模糊查询
        use({
            'nvim-telescope/telescope.nvim',
            requires = {
                'nvim-lua/plenary.nvim', --[[ 所有lua函数只用写一次。(⊙v⊙)嗯，好吧我也没明白什么意思。github原文：All the lua functions I don't want to write twice.]] --
            },
        })
        use('LinArcX/telescope-env.nvim') --[[ telescope插件扩展，用于列出系统环境变量 ]] --
        ----------------------------------
        -- 插件五：dashboard-nvim：启动画面
        use('glepnir/dashboard-nvim')
        ----------------------------------
        -- 插件六：nvim-treesitter：代码高亮及语法树
        use({
            'nvim-treesitter/nvim-treesitter',
            run = ':TSUpdate', --[[这个命令是Packer.nvim中的一个Post-install hook，表示当组件安装或更新时会执行:TSUpdate命令 ]] --
            --[[ 该命令执行原因是：特定的nvim-treesitter插件版本只与特定的language parser（语言解释器）版本匹配，
        当我们更新插件时，也必须更新所有已经安装了的语言解释器。
        ]]
            --
        })
        ----------------------------------
        -- 插件五：nvim-lspconfig：提供服务配置
        use({ 'neovim/nvim-lspconfig' })
        ----------------------------------
        -- 插件六：nvim-lsp-installer：安装语言服务器
        -- 插件已经停止服务，更换为mason.nvim
        -- use('williamboman/nvim-lsp-installer')
        ----------------------------------
        -- 插件七：mason.nvim：提供安装LSP server服务
        use({ 'williamboman/mason.nvim' })
        ----------------------------------
        -- 插件八：mason-lspconfig：提供服务
        use({ 'williamboman/mason-lspconfig.nvim' })
        ----------------------------------
        -- 插件九：nvim-dap：mason依赖插件
        use({ 'mfussenegger/nvim-dap' })
        ----------------------------------
        -- 插件十：null-ls.nvim：mason依赖插件
        -- use({ "jose-elias-alvarez/null-ls.nvim" })
        ----------------------------------
        -- 插件十一：补全
        -- 补全引擎：cmp
        -- 为Neovim提供代码补全全核心功能
        use('hrsh7th/nvim-cmp')
        -- 补全引擎：snippet
        -- 自定义代码段引擎
        use('hrsh7th/vim-vsnip')
        -- 补全源
        use('hrsh7th/cmp-vsnip')
        use('hrsh7th/cmp-nvim-lsp') --[[ { name = nvim_lsp }  Neovim内置LSP提供的补全内容 ]] --
        use('hrsh7th/cmp-buffer') --[[ { name = 'buffer' }, 补全当前buffer内容 ]] --
        use('hrsh7th/cmp-path') --[[ { name = 'path' } 路径补全 ]] --
        use('hrsh7th/cmp-cmdline') --[[ { name = 'cmdline' } 命令行补全 ]] --
        --[[ 常见语言代码段 包含大部分常用语言的代码段，非常强大。 ]]
        --
        use('rafamadriz/friendly-snippets')
        ----------------------------------
        -- 插件十二：美化
        --[[ 插件1：lspkind-nvim：提供小图标。用于代码补全作为图标 ]]
        --
        use('onsails/lspkind-nvim')
        --[[ 插件2：indent-blankline.nvim：代码间产生联系竖线 ]]
        --
        use('lukas-reineke/indent-blankline.nvim')
        -- 插件3：lspsaga
        use('tami5/lspsaga.nvim')
        ----------------------------------
        -- 插件十三：formatter.nvim：代码格式化
        use('mhartington/formatter.nvim')
        ----------------------------------
        -- 插件十四：null-ls.nvim：代码格式化
        use({ 'jose-elias-alvarez/null-ls.nvim', requires = 'nvim-lua/plenary.nvim' })
        ----------------------------------
        -- 插件十五：schemastore.nvim JSON增强
        use('b0o/schemastore.nvim')
        ----------------------------------
        -- 插件十六：TypeScript增强
        use({ 'jose-elias-alvarez/nvim-lsp-ts-utils', requires = 'nvim-lua/plenary.nvim' })
        ----------------------------------
        -- 插件十七：自动补全括号
        use('windwp/nvim-autopairs')
        ----------------------------------
        -- 插件十八：快速注释代码
        use('numToStr/Comment.nvim')
        ----------------------------------
        -- 插件十九：项目管理
        -- 同时使nvim-tree支持项目切换
        use('ahmedkhalf/project.nvim')
        ----------------------------------
        --                              --
        --                              --
        --                              --
        ----------------------------------
        --
    end,

    ----------
    -- 配置文件
    ----------

    config = {
        -- 并发数限制
        max_jobs = 16,
        -- 自定义源
        git = {
            -- 代理网址
            -- default_url_format = 'https://github.do/%s',
            -- default_url_format = "https://gitclone.com/%s",
            -- default_url_format = 'https://gitclone.com/%s',
            -- default_url_format = 'https://ghproxy.com/%s',
            -- 该代理站点还不错 o(￣▽￣)d
            -- default_url_format = 'https://hub.0z.gs/%s',
            -- default_url_format = 'https://github.com.cnpmjs.org/',
            -- default_url_format = 'https://hub.fastgit.org/',
            -- default_url_format = 'https://github.wuyanzheshui.workers.dev/',
            -- default_url_format = 'https://github.z-o.top/%s',
            -- default_url_format = 'https://hub.fastgit.xyz/%s',
            -- default_url_format = 'https://gh.api.99988866.xyz/%s',
            -- default_url_format = 'http://github.com/%s',
            default_url_format = 'git@github.com:%s',
        },
        ----------
        -- 以浮动窗口打开安装列表
        ----------
        display = {
            open_fn = function()
                return require('packer.util').float({ border = 'single' })
            end,
        },
    },
})

--[[ 解决bug：telescope导致在nvim-treesitter插件中的fold模块生效前被加载，折叠无法生效
  为此，解决方法是通过执行zx或者:e命令恢复fold功能，缺点是每次打开一个文件都需要重来。
  所以自定义autocmd放在plugins.lua文件中。
  原理：
  每次打开一个文件就执行一次:z命令
  ]]
--
pcall(
    vim.cmd,
    [[
  augroup fold_fix
  autocmd!
  autocmd BufRead * autocmd BufWinEnter * ++once normal! zx zR
  augroup end
]]
)

---------------
-- 结束
---------------
