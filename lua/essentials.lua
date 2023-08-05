-- 基础设置
--
-- 补充：
-- vim.g.{name} 全局变量
-- vim.b.{name} 缓冲区变量
-- vim.w.{name} 窗口变量
-- vim.bo.{option} buffer-local 选项 vim.wo.{option} window-local 选项 options多选项： 一般情况下，options设置为：{noremap=true,silent=true}，其中noremap表示不会重新映射，
-- 例如：a->b,b->c，如果启用重新映射，则会a->c，->表示映射。 silent为true,表示不会输出多余的信息。
--
--映射
local option=vim.opt
local buffer=vim.b
local global=vim.g
local opt={noremap=true,silent=true}

-- 基础配置 --
--
-- 显示vim的模式提示
-- 后续通过增强状态栏插件实现，不再需要
option.showmode=false

-- 采用的字符编码集为utf-8
-- 编码
global.encoding = "UTF-8"
-- 文件编码
global.fileencoding = 'utf-8'
global.fileencodings={'utf-8','ucs-bom','chinese'}

-- jkhl 移动时光标周围保留8行
option.scrolloff = 8
option.sidescrolloff = 8

-- 使用相对行号
-- 显示行号
option.number = true
-- 显示相对行号
option.relativenumber = true

-- 高亮所在行
option.cursorline = true

-- 显示左侧图标指示列
option.signcolumn = "yes"

-- 右侧参考线，超过表示代码太长了，考虑换行
-- option.colorcolumn = "120"

-- 缩进4个空格等于一个Tab
global.tabstop = 4

-- >> << 时移动长度
option.shiftwidth = 4
option.shiftround=true

-- 空格替代tab
option.expandtab = true

-- 新行对齐当前行
option.autoindent = true
vim.bo.autoindent = true
option.smartindent = true

-- 搜索大小写不敏感，除非包含大写
option.ignorecase = true
option.smartcase = true

-- 搜索不要高亮
option.hlsearch = false

-- 边输入边搜索
option.incsearch = true

-- 命令行高
option.cmdheight = 2

-- 当文件被外部程序修改时，自动加载
option.autoread = true
vim.bo.autoread = true

-- 禁止折行
vim.wo.wrap = false

-- 光标在行首尾时<Left><Right>可以跳到下一行
option.whichwrap = '<,>,[,]'

-- 允许隐藏被修改过的buffer
option.hidden = true

-- 鼠标支持
option.mouse = "a"

-- 禁止创建备份文件
option.backup = false
option.writebackup = false
option.swapfile = false

-- 更新时间
option.updatetime = 300

-- 等待键盘快捷键连击时间
option.timeoutlen = 500

-- split window 从下边和右边出现
option.splitbelow = true
option.splitright = true

-- 自动补全不自动选中
global.completeopt = {"menu","menuone","noselect","noinsert"}

-- 样式
-- 背景
option.background = "dark"
-- 终端GUI背景
option.termguicolors = true

-- 不可见字符的显示
option.list = false
option.listchars = "space:·"

-- 补全增强
option.wildmenu = true

-- 不向菜单传递消息
option.shortmess = vim.o.shortmess .. 'c'

-- 补全最多显示数量
option.pumheight = 10

-- 永远显示 tabline
option.showtabline = 2

-- 撤销永久化
-- 撤销历史文件
option.undofile=true
-- 历史文件存放点
option.undodir=vim.fn.expand('$HOME/.local/share/nvim/undo')

-- 未知但有用功能
option.exrc=true
option.backspace={"indent","eol","start"}
option.title=true

-- 注释自动换行
option.wrap=true

-- 鼠标移动事件
-- 配置插件bufferline的“bufferline-hover-events”
global.mousemoveevent=true

-----------------------------------------------------------------------

-- 
-- buffer配置 --
--
buffer.fileencoding = 'utf-8'

-----------------------------------------------------------------------
--
-- 全局映射 --
--
global.mapleader=" "


-----------------------------------------------------------------------

--
-- 快捷键配置 --
--

-- 
-- 默认快捷键
-- 
-- gx：使用默认浏览器打开选中网址
-- gf：使用nvim/vim打开选中文件地址

local keymap=vim.keymap

-- 1. 基础配置
-- 
--
-- 打开要素配置文件
keymap.set("n","<leader>ce",":e $HOME/.config/nvim/lua/essentials.lua<CR>")
--
-- 运行配置文件
keymap.set("n","<leader>cs",":source<CR>")
--
-- 退出
keymap.set("n","<A-j>","<ESC>")
keymap.set("i","<A-j>","<ESC>")


-- 2. 跳转Tab
--
-- 
-- 2.1 左右跳转
keymap.set("n","<C-h>",":BufferLineCyclePrev<CR>",opt)
keymap.set("n","<C-l>",":BufferLineCycleNext<CR>",opt)
-- 
--
-- 2.2 关闭buffer
keymap.set("n","wq",":w<bar>:Bdelete!<CR>",opt)
-- 关闭左标签
keymap.set("n", "<leader>bl", ":BufferLineCloseRight<CR>", opt)
-- 关闭右标签
keymap.set("n", "<leader>bh", ":BufferLineCloseLeft<CR>", opt) 
-- 选择关闭的标签
keymap.set("n", "<leader>bc", ":BufferLinePickClose<CR>", opt)


-- 3. 窗口设置
--
--
-- 3.1 创建窗口*
-- 横向创建窗口
keymap.set("n","<leader>ws","<C-w>s",opt)
-- 纵向创建窗口
keymap.set("n","<leader>wv","<C-w>v",opt)
--
--
-- 3.2 关闭与离开窗口
-- 关闭当前窗口
keymap.set("n","<leader>wc","<C-w>c",opt)
-- 离开当前窗口
keymap.set("n","<leader>vq","<C-w>q",opt)
-- 关闭当前窗口外的所有窗口
keymap.set("n","<leader>wo","<C-w>o",opt)
--
--
-- 3.3 窗口游走
-- 
-- 3.3.1 四个方向游走*
keymap.set("n","<leader>wj","<C-w>j",opt)
keymap.set("n","<leader>wk","<C-w>k",opt)
keymap.set("n","<leader>wh","<C-w>h",opt)
keymap.set("n","<leader>wl","<C-w>l",opt)
--
-- 3.3.2 窗口中循环移动
keymap.set("n","<leader>wm","<C-w>w",opt)
--
-- 3.3.3 对角移动
-- 移动到最左上角窗口
keymap.set("n","<leader>wt","<C-w>t",opt)
-- 移动到最右下角窗口
keymap.set("n","<leader>wb","<C-w>b",opt)
-- 
-- 3.3.4 前访问窗口移动
keymap.set("n","<leader>wp","<C-w>p",opt)
--
--
-- 3.4 移动窗口
--
-- 3.4.1 移动窗口本身
-- 向右或向下交换窗口
keymap.set("n","<leader>wr","<C-w>r",opt)
-- 向左或向上交换窗口
keymap.set("n","<leader>wR","<C-w>R",opt)
-- 交换同列或同行的窗口
keymap.set("n","<leader>wx","<C-w>x",opt)
-- 
-- 3.4.2 移动窗口并改变其布局
-- 移动当前窗口至屏幕顶端，并占全部宽度
keymap.set("n","<leader>WK","<C-w>K",opt)
-- 移动当前窗口至屏幕底端，并占全部宽度
keymap.set("n","<leader>WJ","<C-w>J",opt)
-- 移动当前窗口至屏幕左端，并占全部宽度
keymap.set("n","<leader>WH","<C-w>H",opt)
-- 移动当前窗口至屏幕底端，并占全部宽度
keymap.set("n","<leader>WL","<C-w>L",opt)
-- 移动窗口至现有分页
keymap.set("n","<leader>WT","<C-w>T",opt)
--
-- 3.4.3 调整屏幕尺寸
-- 平均划分所有窗口尺寸
keymap.set("n","<leader>wa","<C-w>=",opt)
-- 将当前窗口的高度增加一行
keymap.set("n","<leader>w=","<C-w>+",opt)
-- 将当前窗口的高度减少一行
keymap.set("n","<leader>w-","<C-w>-",opt)
-- 将当前窗口的宽度增加一行
keymap.set("n","<leader>w.","<C-w>>",opt)
-- 将当前窗口的宽度减少一行
keymap.set("n","<leader>w,","<C-w><",opt)
-- 将当前窗口的宽度调至最大
keymap.set("n","<leader>w\\","<C-w>|",opt)

-- 4. 单词纠错
-- 需要插件“'kamykn/spelunker.vim”
-- 通过建议列表纠正单词
vim.cmd([[nmap wl ZL]])
-- 通过插入纠正单词
vim.cmd([[nmap wc Zc]])
-- 通过插入建议列表首项纠正单词
vim.cmd([[nmap wf Zf]])
-- 将“错误单词”加入字典
vim.cmd([[nmap wg Zg]])

-- 5. nvim-tree
--
-- 1. 打开文件或文件夹
-- <CR> / o
-- 2. 分屏打开文件
-- v(vsplit) / h(split)
-- 3. 显示隐藏文件
-- 对应 filters 中的 custom (node_modules)
-- i
-- 隐藏点文件（隐藏文件）
-- .
-- 4. 文件操作
-- <F5> 刷新
-- a    创建文件
-- d    删除文件
-- r    重命名文件
-- x    剪切文件
-- c    复制文件
-- p    粘贴文件
-- s    以系统默认方式打开文件

-- 6. markdown-preview
-- 打开markdown-preview
keymap.set("n", "<A-v>", ":MarkdownPreview<CR>", opt)
-- 关闭markdown-preview
keymap.set("n", "<A-c>", ":MarkdownPreviewStop<CR>", opt)


-----------------------------------------------------------------------

