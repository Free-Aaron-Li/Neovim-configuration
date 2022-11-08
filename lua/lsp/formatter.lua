---------------
-- 引言
---------------

--[[
    Formatter.nvim插件支持很多常见编程语言。这里通过Formatter.nvim配置出常见语言的格式化。
    祝您好运！
]]
--

---------------
-- 判断
---------------

local status, formatter = pcall(require, "formatter")
if not status then
  vim.notify("没有找到 formatter!")
  return
end

---------------
-- 配置
---------------

formatter.setup({
  filetype = {
    lua = {
      function()
        return {
          exe = "stylua",
          -- 使用默认目录下的.stylua.toml参数
          args = {
            -- "--config-path "
            --   .. os.getenv("XDG_CONFIG_HOME")
            --   .. "/stylua/stylua.toml",
            "-",
          },
          stdin = true,
        }
      end,
    },
  },
})

-- format on save
vim.api.nvim_exec(
  [[
    augroup FormatAutogroup
    autocmd!
    autocmd BufWritePost *.lua FormatWrite
    augroup END
]] ,
  true
)

---------------
-- 结束
---------------
