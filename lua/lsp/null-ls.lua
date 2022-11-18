---------------
-- 引言
---------------

--[[
  null-ls是一款强大的代码格式化插件，通过Language Server给Neovim注入代码补全及格式化、提示、code actions等功能。
  祝您好运！
  ]] --




---------------
-- 判断
---------------

local status, null_ls = pcall(require, "null-ls")
if not status then
  vim.notify("没有找到 null-ls")
  return
end



---------------
-- 配置
---------------

local formatting = null_ls.builtins.formatting

null_ls.setup({
  debug = false,
  sources = {
    -- Formatting ---------------------
    --  brew install shfmt
    formatting.shfmt,
    -- StyLua
    formatting.stylua,
    -- frontend
    formatting.prettier.with({ -- 只比默认配置少了 markdown
      filetypes = {
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
        "vue",
        "css",
        "scss",
        "less",
        "html",
        "json",
        "yaml",
        "graphql",
        "java",
        "python",
        "sql",
      },
      prefer_local = "node_modules/.bin",
    }),
    -- formatting.fixjson,
    -- formatting.black.with({ extra_args = { "--fast" } }),
  },
  -- 保存自动格式化
  on_attach = function(client)
    if client.server_capabilities.document_formatting then
      vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
    end
  end,
})
---------------
-- 结束
---------------
