---------------
-- 引言
---------------

--[[
  美化代码，产生竖线
  ]] --



local status, ident_blankline = pcall(require, "indent_blankline")
if not status then
  vim.notify("没有找到 indent_blankline")
  return
end

ident_blankline.setup({
  -- 空行占位
  space_char_blankline = " ",
  -- 用 treesitter 判断上下文
  show_current_context = true,
  show_current_context_start = true,
  context_patterns = {
    "class",
    "function",
    "method",
    "element",
    "^if",
    "^while",
    "^for",
    "^object",
    "^table",
    "block",
    "arguments",
  },
  -- 排除那些界面不需要竖线
  --[[ 
    这里需要注意的是该插件会在任何界面都添加这种竖线，但是在我们之前的首页 dashboard 中就不该加入这种竖线。
    这个时候我们就要在 filetype_exclude 中排除 "dashboard" 这个界面。上边代码中我已经排除了好多界面，
    但如果你还在哪个不该出现竖线的窗口中看到了竖线，要怎么办呢？

    方法为： 当光标在该界面内时输入 :echo &filetype 回车，
    这时下边状态栏会输出该文件的类型，把他加入到上边的 filetype_exclude 变量中排除就好了。
    ]] --
  filetype_exclude = {
    "dashboard",
    "packer",
    "terminal",
    "help",
    "log",
    "markdown",
    "TelescopePrompt",
    "lsp-installer",
    "lspinfo",
    "toggleterm",
  },
  -- 竖线样式
  -- char = '¦'
  -- char = '┆'
  -- char = '│'
  -- char = "⎸",
  char = "▏",
})
---------------
-- 结束
---------------
