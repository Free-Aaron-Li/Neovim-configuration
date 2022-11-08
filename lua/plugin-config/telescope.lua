-------------
-- 引言
-------------

--[[
  在开发过程中，往往想要打开一个文件，却不记得完整的文件名，只知道部分文件名。这个时候模糊查询就显得十分重要。
  通过Telescope（望远镜）插件，随着输入内容实时在结果框显示文件预览，这样就十分方便。
  祝您好运！
]]--




---------------
-- 注意事项
---------------

--[[
  通过:checkhealth telescope查看依赖情况
  通常一般缺少BurnSushi/ripgrep和sharkdp/fd两个扩展
  解决方案：
  一、ripgrep
  1、命令行：
  > sudo add-apt-repository ppa:x4121/ripgrep
  > sudo apt-get update
  > sudo apt install ripgrep

  2、github下载deb包,并安装
  URL：https://github.com/BurntSushi/ripgrep
  
  二、fd
  通过npm直接全局安装
  命令行：
  > npm install -g fd-find
]]--



---------------
-- 判断
---------------

local status, telescope = pcall(require, "telescope")
if not status then
  vim.notify("没有找到 telescope!")
  return
end



---------------
-- 配置
---------------

--[[
  Telescope支持许多扩展，列表详情可以查看：https://link.juejin.cn/?target=https%3A%2F%2Fgithub.com%2Fnvim-telescope%2Ftelescope.nvim%2Fwiki%2FExtensions
]]--
telescope.setup({
  defaults = {
    -- 打开弹窗后进入的初始模式，默认为 insert，也可以是 normal
    initial_mode = "insert",
    -- 窗口内快捷键，通过调用keybindings.lua文件中的telescopeList变量进行配置。
    mappings = require("keybindings").telescopeList,
  },
  pickers = {
    -- 内置 pickers 配置
    find_files = {
      -- 查找文件换皮肤，支持的参数有： dropdown, cursor, ivy
      theme = "dropdown", 
    }
  },
  extensions = {
     -------- 扩展插件配置 --------
     ------------------------------
     --
     -- 列出系统环境变量
     pcall(telescope.load_extension, "env") 
  },
})



---------------
-- 结束
---------------
