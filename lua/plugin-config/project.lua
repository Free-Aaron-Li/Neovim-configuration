---------------
-- 引言
---------------

--[[
  通过project插件扩展，让nvim-tree插件更加完善，能够支持切换目录
  祝您好运！
]]--




---------------
-- 判断
---------------

local status, project = pcall(require, "project_nvim")
if not status then
    vim.notify("没有找到 project_nvim")
  return
end



---------------
-- 配置
---------------
-- nvim-tree 支持
vim.g.nvim_tree_respect_buf_cwd = 1

project.setup({
  --[[通过检测pattern中的参数，如果文件夹中有这些文件，就会被当做一个project文件夹，自动保存在配置文件里 ]]--
  detection_methods = { "pattern" },
  patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json", ".sln" },
})

local status, telescope = pcall(require, "telescope")
if not status then
  vim.notify("没有找到 telescope")
  return
end
pcall(telescope.load_extension, "projects")



---------------
-- 结束
---------------
