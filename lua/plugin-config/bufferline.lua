---------------
-- 引言
---------------

--[[
  是否眼馋VScode的Tab页面，在此推荐bufferline，让Neovim变的更加漂亮，让开发更加得心应手。
  祝您好运！
]] --




---------------
-- 判断
---------------

local status, bufferline = pcall(require, "bufferline")
if not status then
  vim.notify("没有找到 bufferline!")
  return
end



---------------
-- 配置
---------------

--[[
 详细配置查看：https://github.com/akinsho/bufferline.nvim#configuration
]] --
bufferline.setup({
  options = {
    -- 关闭 Tab 的命令，这里使用 moll/vim-bbye 的 :Bdelete 命令
    close_command = "Bdelete! %d",
    right_mouse_command = "Bdelete! %d",
    -- 侧边栏配置
    -- 左侧让出 nvim-tree 的位置，显示文字 文件浏览器
    offsets = {
      {
        filetype = "NvimTree",
        text = "文件浏览器",
        highlight = "Directory",
        text_align = "left",
      },
    },
    -- 使用 nvim 内置 LSP
    diagnostics = "nvim_lsp",
    -- 显示 LSP 报错图标
    ---@diagnostic disable-next-line: unused-local
    diagnostics_indicator = function(count, level, diagnostics_dict, context)
      local s = " "
      for e, n in pairs(diagnostics_dict) do
        local sym = e == "error" and "" or (e == "warning" and " " or "")
        s = s .. n .. sym
      end
      return s
    end,
  },
})



---------------
-- 结束
---------------
