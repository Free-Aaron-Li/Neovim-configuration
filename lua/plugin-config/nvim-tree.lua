---------------
-- 前言
---------------

--[[
 在终端中查询文件，往往是比较费时间的，因为并没有完整的可视化的查询方式，对此，nvim-tre插件提供的文件浏览便大大提高了开发效率
 在接下来，便是关于nvim-tree的具体配置
 祝您好运！
]]--




---------------
-- 判断
---------------

--[[
  程序逻辑：
  通过require调用nvim-tree模块，返回boolean类型的status，若nvim-tree插件并不存在，返回false，反之true。
  若status为false，输出语句“没有找到nvim-tree”
  防止Neovim崩溃。
]]--
local status, nvim_tree = pcall(require, "nvim-tree")
if not status then
    vim.notify("没有找到 nvim-tree!")
  return
end



--[[
  调用keybindings.lua中的nvimTreeList变量，通过在keybindings中设置快捷键控制nvim-tree
]]--

local list_keys = require('keybindings').nvimTreeList
nvim_tree.setup({
    --[[
      注意事项：
      nvim-tree初始化许多参数，可以通过命令:h nvim-tree-setup调用帮助文档查看
    ]]--
    -- 是否显示 git 状态图标
    git = {
        enable = true,
    },
    -- project plugin 需要这样设置
    update_cwd = true,
    update_focused_file = {
        enable = true,
        update_cwd = true,
    },
    -- 隐藏 .文件 和 node_modules 文件夹
    filters = {
        dotfiles = true,
        custom = { 'node_modules' },
    },
    -- 设置nvim-tree显示
    view = {
        -- 宽度
        width = 40,
        -- 也可以 'right'
        side = 'left',
        -- 隐藏根目录
        hide_root_folder = false,
        -- 自定义列表中快捷键
        mappings = {
            custom_only = false,
            list = list_keys,
        },
        -- 不显示行数
        number = false,
        relativenumber = false,
        -- 显示图标
        signcolumn = 'yes',
    },
    actions = {
        open_file = {
            -- 首次打开大小适配
            resize_window = true,
            -- 打开文件时关闭
            quit_on_open = true,
        },
    },
    -- project plugin扩展
    -- 使得nvim-tree支持切换目录
    update_cwd = true,
    update_focused_file = {
    enable = true,
    update_cwd = true,
  },
    -- wsl install -g wsl-open
    -- https://github.com/4U6U57/wsl-open/
    --[[
      若想在WSL（Windows Subsystem of Linux）中用Widows系统默认设置打开文件，需要使用Node.js全局安装wsl-open包，使用命令为 npm install -g wsl-open
      当然，Linux不需要使用功能
    ]]--
    -- system_open = {
    --  cmd = 'wsl-open', -- mac 直接设置为 open
    --},
})

-- 自动关闭
vim.cmd([[
  autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif
]])



---------------
-- 结束
---------------
