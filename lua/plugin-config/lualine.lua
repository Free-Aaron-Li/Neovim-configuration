---------------
-- 引言
---------------

--[[
  原生的Neovim对于开发来说，信息量显得有点少。这个时候，lualine插件便可为开发提供很大的帮助。
  在lualine插件的扩展下，可以清晰明确的查看到编辑模式、光标所在行号，列号、当前文件大小、编码格式、git分支状态等等。
  相信在lualine的加持下，Neovim显得更像一个现代化的编辑器。
  祝您好运！
]]--




---------------
-- 判断
---------------

local status, lualine = pcall(require, "lualine")
if not status then
    vim.notify("没有找到 lualine!")
  return
end



---------------
-- 配置
---------------

--[[
  lualine的配置参数主要有options（选项），extensions（扩展）和sections（部分）三项。
  option：用于设置样式
  extensions：设置lualine支持的扩展，详细文档可以查看：https://link.juejin.cn/?target=https%3A%2F%2Fgithub.com%2Fnvim-lualine%2Flualine.nvim%23extensions 
  sections：用于设置不同分段所需显示的功能模块，分段总共有8个，分别为 A B C X Y Z
  具体分段演示图如下：
  +------------------------------------+
  | A | B | C                X | Y | Z |
  +------------------------------------+
  对应默认配置项如下：
   sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
   },
  在接下来，将修改C的配置选项。在文件名后增加lsp_progress进度显示（由arkav/lualine-lsp-progress插件提供）
]]--
lualine.setup({
  options = {
    -- 主题配色，可以设置为auto，也可设置为主题列表中某一个
    theme = "auto",
    -- 设置组件分隔符
    component_separators = { left = "|", right = "|" },
    --[[ 符号详细介绍，可以查看：https://github.com/ryanoasis/powerline-extra-symbols ]]--
    -- 设置分段分隔符
    section_separators = { left = " ", right = "" },
  },
  extensions = { "nvim-tree", "toggleterm" },
  sections = {
    lualine_c = {
      "filename",
      {
        "lsp_progress",
        spinner_symbols = { " ", " ", " ", " ", " ", " " },
      },
    },
    lualine_x = {
      "filesize",
      {
        "fileformat",
         symbols = {
           unix = '', -- e712
           dos = '', -- e70f
           mac = '', -- e711
         },
        -- symbols = {
        -- unix = "LF",
        -- dos = "CRLF",
        -- mac = "CR",
        -- },
      },
      "encoding",
      "filetype",
    },
  },
})



---------------
-- 结束
---------------
