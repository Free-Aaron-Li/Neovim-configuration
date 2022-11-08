---------------
-- 引言
---------------

--[[
  nvim-treesitter项目对使用Neovim开发的开发者来说是一个很有创意和帮助的项目。其来源于Tree-sitter项目，Tree-sitter是一个解析器生成器和增量解析库，它可以在代码开发过程中实时生成语法树。
  由此而来的nvim-treesitter插件是Neovim下的Tree-sitter具体配置和抽象层。为Neovim提供一个简单的Tree-sitter接口。并提供多个基于Tree-sitter的基础功能模块。
  可以在Neovim中高效的是实现代码高亮，增加选择等基础功能。
  nvim-treesitter对不同的colorscheme（主题）支持度不同，不同的主题配色显示也就会不一样。可以在nvim-treesitter的wiki中查看不同主题的显示效果。
  引用：
  Tree-sitter项目URL：https://tree-sitter.github.io/tree-sitter/
  nvim-treesitter项目URL：https://github.com/nvim-treesitter/nvim-treesitter/
  nvim-treesitter wiki URL：https://github.com/nvim-treesitter/nvim-treesitter/wiki/Colorschemes/
  祝您好运！
]]--




---------------
-- 判断
---------------

local status, treesitter = pcall(require, "nvim-treesitter.configs")
if not status then
  vim.notify("没有找到 nvim-treesitter")
  return
end



---------------
-- 配置
---------------

--[[ 
  Language parser（语言解释器）：安装目录一般放在该插件的parser目录下
  手动安装：
  安装指定的Language parser：
  :TSInstall <language_to_install> 例如：:TSInstall java
  手动卸载：
  :TSUninstall <language_to_install>
  查看语言列表：
  :TSInstallInfo
]]--
treesitter.setup({
  -- 自动安装 language parser
  ensure_installed = { 
    "java","javascript","css","c",
    "cpp","lua","vim","html","python",
    "tsx","typescript","markdown","vue",
    "ruby","bash","c_sharp","comment","cuda",
    "dockerfile","dot","go","help","http","jsdoc",
    "json","json5","jsonc","jsonnet","markdown_inline",
    "org","php","rust","scheme","sql",
  },
  -- 启用代码高亮模块
  highlight = {
    enable = true,
    -- 关闭vim的正则语法高亮
    additional_vim_regex_highlighting = false,
  },
  -- 启用增量选择模块
  --[[ 通过不断的按Enter选择区域会从里层不断外扩，Backspace则让选择区域不断内收 ]]--
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<CR>",
      node_incremental = "<CR>",
      node_decremental = "<BS>",
      scope_incremental = "<TAB>",
    },
  },
  -- 启用代码缩进模块
  --[[ 如果要对整个文件进行缩进，则可以使用gg=G组合键，当然会将这个组合键放在keybindings.lua文件中，设置为快捷键 ]]--
  indent = {
    enable = true,
  },
  rainbow = {
  enable = true,

  --[[ disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for ]]--
  extended_mode = true, --[[ Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean ]]--
  max_file_lines = nil, --[[ Do not enable for files with more than n lines, int ]]--
  colors = {
    "#95ca60",
    "#ee6985",
    "#D6A760",
    "#7794f4",
    "#b38bf5",
    "#7cc7fe",
  }, --[[ table of hex strings ]]--
  },
})


  -- 开启 Folding 模块
  vim.opt.foldmethod ="expr"
  vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
  -- 默认不要折叠
  -- https://stackoverflow.com/questions/8316139/how-to-set-the-default-to-unfolded-when-you-open-a-file
  vim.opt.foldlevel = 99



---------------
-- 结束
---------------
