---------------
-- 引言
---------------

--[[
  Neovim启动界面是不是感觉有点丑丑的，那么接下来介绍dashboard-nvim插件，绝对让Neovim启动界面酷酷的。^_^
  祝您好运！
]]
--

---------------
-- 判断
---------------

-- local status, dashboard = pcall(require, "dashboard")
-- if not status then
--  vim.notify("没有找到 dashboard!")
--  return
-- end
local status, dashboard = pcall(require, "dashboard")
if not status then
  vim.notify("没有找到 dashboard!")
  return
end

---------------
-- 配置
---------------

--[[
  dashboard.custom_footer用于自定义底部显示的文字
  dashboard.custom_header用于自定义顶部显示的ASCII图片。官方wiki（https://link.juejin.cn/?target=https%3A%2F%2Fgithub.com%2Fglepnir%2Fdashboard-nvim%2Fwiki%2FAscii-Header-Text）上有许多图片，可以看看。
  当然也可自定义：
  文字：https://link.juejin.cn/?target=https%3A%2F%2Fgithub.com%2Fglepnir%2Fdashboard-nvim%2Fwiki%2FAscii-Header-Text
  dashboard.custome_center列出常用功能，其基本格式为：
  dashboard.custom_center={
   ·{                                                                                                                                                                                      
    icon·=·"图标",                                                                                                                                                                        
    desc·=·"描述文字"····························",                                                                                                                                       
    action·=·"命令",                                                                                                                                                       
    },
  }
  图标可以在这个网站中查找到：https://www.nerdfonts.com/cheat-sheet
]]
--
dashboard.custom_footer = {
  "",
  " 学无止境 志在千里 ",
}

dashboard.custom_center = {
  {
    icon = "       ",
    desc = "最近文件     ",
    action = "Telescope oldfiles",
  },
  {
    icon = "       ",
    desc = "全局搜索     ",
    action = "Telescope live_grep",
  },
  {
    icon = "       ",
    desc = "文件查找     ",
    action = "Telescope find_files",
  },
  {
    icon = "       ",
    desc = "帮助文档     ",
    action = "edit ~/Documents/markdown文档/Neovim配置.md",
  },
}

dashboard.custom_header = {
  [[]],
  [[]],
  [[██╗    ██╗███████╗██╗      ██████╗ ██████╗ ███╗   ███╗███████╗]],
  [[██║    ██║██╔════╝██║     ██╔════╝██╔═══██╗████╗ ████║██╔════╝]],
  [[██║ █╗ ██║█████╗  ██║     ██║     ██║   ██║██╔████╔██║█████╗  ]],
  [[██║███╗██║██╔══╝  ██║     ██║     ██║   ██║██║╚██╔╝██║██╔══╝  ]],
  [[╚███╔███╔╝███████╗███████╗╚██████╗╚██████╔╝██║ ╚═╝ ██║███████╗]],
  [[ ╚══╝╚══╝ ╚══════╝╚══════╝ ╚═════╝ ╚═════╝ ╚═╝     ╚═╝╚══════╝]],
  [[                                                                ]],
  [[               ███╗   ██╗██╗   ██╗██╗███╗   ███╗                 ]],
  [[               ████╗  ██║██║   ██║██║████╗ ████║                 ]],
  [[               ██╔██╗ ██║██║   ██║██║██╔████╔██║                 ]],
  [[               ██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║                 ]],
  [[               ██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║                 ]],
  [[               ╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝                 ]],
  [[                                                                ]],
  [[]],
  [[]],
}

---------------
-- 结束
---------------
