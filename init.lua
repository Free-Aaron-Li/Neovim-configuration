---------------
-- 前言
---------------

--[[
这是Neovim的终极配置文档，也是一切配置的起点和入口。
 一切关于Neovim的美好配置，皆在这里执行！
 祝您好运
]]
--

---------------
-- 基础设置
---------------

require("basic")

---------------
-- 快捷键设置
-- -------------

require("keybindings")

---------------
-- 插件配置
---------------

require("plugins")

---------------
-- 主题设置
---------------

require("colorscheme")

---------------插件配置---------------

---------------
-- nvim-tree配置
---------------

require("plugin-config.nvim-tree")

---------------
-- bufferline配置
---------------

require("plugin-config.bufferline")

---------------
-- lualine配置
---------------

require("plugin-config.lualine")

---------------
-- telescope配置
---------------

require("plugin-config.telescope")

---------------
-- dashboard配置
---------------

require("plugin-config.dashboard")

---------------
-- project配置
---------------

require("plugin-config.project")

---------------
-- nvim-treesitter配置
---------------

require("plugin-config.nvim-treesitter")

---------------
-- LSP配置
---------------

require("lsp.setup")
require("lsp.cmp")

---------------
-- UI配置
---------------

require("lsp.ui")
require("plugin-config.indent-blankline")

---------------
-- 代码格式化
---------------

require("lsp.formatter")
--- require("lsp.null-ls")

---------------
-- 自动生成括号
---------------

require("plugin-config.nvim-autopairs")

---------------
-- 注释
---------------

require("plugin-config.comment")
----------------------------------
---------------
-- 结束
---------------
