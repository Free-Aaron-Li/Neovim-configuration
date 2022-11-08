---------------
-- 引言
---------------

--[[
  LSP（Language Server Protocol）语言服务协议。通过该协议实现将编程工具（IDE）解耦为Language Client和Language Server两部分。
  在此协议下，Client（例子：vim、VScode）专注于显示样式的实现，Server复制提供语言支持（例如：自动补全、跳转到定义、查找引用、悬停文档提示……）
  通过此协议，使得Neovim和VScode使用同一套Language Server，使得Neovim成为合格的IDE。
  祝您好运！
]]
--

---------------
-- 前提设置
---------------

-- 开启Neovim内置LSP
--[[ 
  1、配置客户端
    安装nvim-lspconfig插件。nvim-lspconfig提供一堆常见服务的配置方式。
  2、安装语言服务器
    安装nvim-lsp-installer插件。通过该插件管理、安装、更新Language Server。
]]
--

-- 安装LSP Servers
--[[
  通过:LspInstallInfo命令，打开nvim-lsp-installer图形界面
  快捷键：
  X（大写）：卸载该Language Server
  u：更新该Language Server
  U：更新所有Language Server
  c：检查该Language Server新版本
  C：检查所有Language Server新版本
  ESC：关闭窗口
  ?：显示帮助
]]
--

---------------
-- 配置
---------------

--[[
  首先创建一个servers字典变量，用来存放所有LSP Server配置文件
  通过require调用配置文件

]]
--
local lsp_installer = require("nvim-lsp-installer")

-- 安装列表
-- { key: 语言 value: 配置文件 }
-- key 必须为下列网址列出的名称
-- https://github.com/williamboman/nvim-lsp-installer#available-lsps
local servers = {
  sumneko_lua = require("lsp.config.lua"), --[[ lua/lsp/config/lua.lua ]] --
  html = require("lsp.config.html"),
  cssls = require("lsp.config.css"),
  jsonls = require("lsp.config.json"),
  tsserver = require("lsp.config.ts"),
  clangd = require("lsp.config.c"),
  jdtls = require("lsp.config.java"),
}
--[[
  自动安装 Language Servers
  原理：通过遍历servers字典，检查每个server是否已经安装。若没有，就调用install()方法安装。
]]
--
for name, _ in pairs(servers) do
  local server_is_found, server = lsp_installer.get_server(name)
  if server_is_found then
    if not server:is_installed() then
      print("正在下载Server：" .. name)
      server:install()
    end
  end
end

--[[
  lsp_installer回调函数，该函数会在每个LSP Server准备好时调用。
  原理：
  当执行该回调函数时，先查看servers字典中是否存在这个server的配置文件，若存在，便执行该配置文件，反之，不执行。
  执行配置文件，将查看是否存在on_setup函数，若不存在，默认执行无参数配置。
]]
--
lsp_installer.on_server_ready(function(server)
  local config = servers[server.name]
  if config == nil then
    return
  end
  if config.on_setup then
    config.on_setup(server)
  else
    server:setup({})
  end
end)

---------------
-- 结束
---------------
