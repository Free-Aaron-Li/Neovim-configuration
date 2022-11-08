---------------
-- 引言
---------------

--[[
  关于lua的LSP Server配置文件
  祝你好运！
]]
--

-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#sumneko_lua
local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

local opts = {
  --[[ 
    settings 主要用来配置语言服务，一般会在nvim-lspconfig项目的服务器配置项中找到对应语言的示例配置。
    引用：nvim-lspconfig项目服务器配置项URL：https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
    ]]
  --
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = "LuaJIT",
        -- Setup your lua path
        path = runtime_path,
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { "vim" },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        -- library = vim.api.nvim_get_runtime_file('', true),
        checkThirdParty = false,
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
  flags = {
    debounce_text_changes = 150,
  },
  --[[
    on_attach为回调函数，当Language Server成功绑定一个buffer时会调用这个函数，所以通常我们会在这个函数里做一些比如快捷键绑定，
    自动命令，或者设置buffer的某些特性操作。
    ]]
  --
  on_attach = function(client, bufnr)
    -- 禁用格式化功能，交给专门插件插件处理
    client.server_capabilities.document_formatting = false
    client.server_capabilities.document_range_formatting = false

    local function buf_set_keymap(...)
      vim.api.nvim_buf_set_keymap(bufnr, ...)
    end

    --[[
      调用keybindings.lua文件的mapLSP方法。把定义的快捷键代码抽离出来，集中到keybindings.lua文件中。减少耦合度。
      ]]
    --
    require("keybindings").mapLSP(buf_set_keymap)
    -- 保存时自动格式化
    vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
  end,
}

---------------
-- 初始化Language Server
---------------

--[[ 
  查看目录等信息
  原理：
  on_setup函数接受server参数，在此函数中调用server:setup方法，并传入自定义的opts参数来初始化该语言服务。
  通常opts参数里有两个关键选项需要自定义：settings和on_attach。
  ]]
--
return {
  on_setup = function(server)
    server:setup(opts)
  end,
}

---------------
-- 结束
---------------
