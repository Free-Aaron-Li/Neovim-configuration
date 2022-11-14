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
  警告：nvim-lsp-installer已经被弃用，接下来将会使用Mason来作为管理LSP的插件
  当然，原nvim-lsp-installer插件的设置做保留，仅注释
]]
--

-- 安装LSP Servers
--[[
  注意：Mason与nvim-lsp-installer快捷键基本一致，所以不做更改。仅多出1~5TAB快捷键，用于区分服务类型。
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
-- 检查程序是否存在
---------------

local status, mason = pcall(require, "mason")
if not status then
  vim.notify("没有找到 mason")
  return
end

local status, mason_config = pcall(require, "mason-lspconfig")
if not status then
  vim.notify("没有找到 mason-lspconfig")
  return
end

local status, lspconfig = pcall(require, "lspconfig")
if not status then
  vim.notify("没有找到 lspconfig")
  return
end



---------------
-- 配置
---------------

--[[ nvim-lsp-installer
  首先创建一个servers字典变量，用来存放所有LSP Server配置文件
  通过require调用配置文件

]]
--
-- Mason默认设置
require('mason').setup({
  ui = {
    icons = {
      package_installed = '✓',
      package_pending = '➜',
      package_uninstalled = '✗',
    },
  },
})

-- mason-lspconfig uses the `lspconfig` server names in the APIs it exposes - not `mason.nvim` package names
-- https://github.com/williamboman/mason-lspconfig.nvim/blob/main/doc/server-mapping.md
require('mason-lspconfig').setup({
  -- 确保安装，根据需要填写
  ensure_installed = {
    'clangd',
    'cssls',
    'html',
    'jdtls',
    'jsonls',
    'lemminx',
    'prosemd_lsp',
    'pyright',
    'quick_lint_js',
    'sqlls',
    'sumneko_lua',
    'tsserver',
  },
})

-- nvim-lsp-installer
--local lspconfig = require('lspconfig')


-- 安装列表
-- { key: 语言 value: 配置文件 }
-- key 必须为下列网址列出的名称
-- https://github.com/williamboman/nvim-lsp-installer#available-lsps
local servers = {
  sumneko_lua = require('lsp.config.lua'), --[[ lua/lsp/config/lua.lua ]] --
  html = require('lsp.config.html'),
  cssls = require('lsp.config.css'),
  jsonls = require('lsp.config.json'),
  tsserver = require('lsp.config.ts'),
  clangd = require('lsp.config.c'),
  jdtls = require('lsp.config.java'),
}

--[[ nvim-lsp-installer
  自动安装 Language Servers
  原理：通过遍历servers字典，检查每个server是否已经安装。若没有，就调用install()方法安装。

for name, _ in pairs(servers) do
  local server_is_found, server = lsp_installer.get_server(name)
  if server_is_found then
    if not server:is_installed() then
      print('正在下载Server：' .. name)
      server:install()
    end
  end
end
]]--

--[[ nvim-lsp-installer
  lsp_installer回调函数，该函数会在每个LSP Server准备好时调用。
  原理：
  当执行该回调函数时，先查看servers字典中是否存在这个server的配置文件，若存在，便执行该配置文件，反之，不执行。
  执行配置文件，将查看是否存在on_setup函数，若不存在，默认执行无参数配置。

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
]]--


for name, config in pairs(servers) do
  if config ~= nil and type(config) == "table" then
    -- 自定义初始化配置文件必须实现on_setup 方法
    config.on_setup(lspconfig[name])
  else
    -- 使用默认参数
    lspconfig[name].setup({})
  end
end

require("lsp.ui")

---------------
-- 结束
---------------
