---------------
-- 引言
---------------

--[[
 Neovim无疑是极好的编辑器，相对来说，其色彩配比似乎差了一点。就此，更换一个好看的主题疑大大的增加了开发观感^_^
 主题，似乎我们经常遇到。比如，桌面换成动态壁纸主题，系统更换按键主题……，在这方面广大的题爱好者分享了许多的主题，毫无意外，Neovim作为知名终端编辑器，吸引了众多主题爱好者设计Neovim主题。在接下来，将对Neovim安装一款主题。
 祝您好运！
]]--




---------------
-- 命令
---------------

--[[
 Neovim本身内置一些主题，可以通过:colorscheme Tab键 查看
 同时，可以通过:echo $VIMRUNTIME 查询到runtime具体位置，在此目录下的colors中存放内置的主题。
]]--



---------------
-- 主题配置
---------------

-- 设置的主题名
-- 主题安装在plugins.lua文件中配置
local colorscheme = "tokyonight"
-- 对是否成功设置主题进行判断，防止主题未找到，Neovim崩溃！
-- lua解释：“..”用来连接两个字符串。
--[[
代码具体实现过程：在pcall函数中调用:colorscheme 设置的主题名 ，若找到函数输出true，反之false。如false，返回语句“'colorscheme'并未找到到！”
]]--
local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  vim.notify("colorscheme " .. colorscheme .. " 并未找到！")
  return
end
