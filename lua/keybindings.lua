---------------
-- 前言
---------------

--[[ 在Neovim中设置快捷键是十分有必要的！
 其中：
 vim.api.nvim_set_keymap() 全局快捷键
 vim.api.nvim_buf_set_keymap() Buffer 快捷键
 一般情况下，都定义为全局快捷键，一般Buffer快捷键是在某些异步回调函数中指定
 例如：插件A初始化结束，回调函数提供Buffer，这个时候就可以针对这个Buffer使用Buffer快捷键

 全局快捷键设置要求：
 vim.api.nvim_set_keymap('模式', '按键', '映射对象', '选项')
 edit ~/Documents/markdown文档/Neovim配置.md模式：n Normal模式  i Insert模式  v Visual模式  t Terminal模式  c Command模式
 按键：想要输入的快捷键按键项
 映射对象：可以为命令，例如：:q<cR> 表示退出，也可以是按键组合，例如4k，表示按4下K键
 选项：选项设置一般有：noremap，silent。noremap设置为false，那么就会出现重新映射，例如：映射A,B,C 其中A-->B，A-->C，那么A便会指向C。silent为true，表示不会输出多余的信息。
 祝您好运！
]]
--

---------------
-- Leader key表示常用前缀，通常设置为空格
-- 后面出现的leader key就表示空格
---------------

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

---------------
-- 保存本地变量map，之后全局快捷键vim.api.nvim_set_keymap变成了map，简化书写。
-- 默认选项为noremap=true,silent=true。
---------------

local map = vim.api.nvim_set_keymap
-- 复用 opt 参数
local opt = { noremap = true, silent = true }

---------------
-- 终极设置
---------------

map('n', '<leader>', ':', opt)
map('i', '<A-j>', '<Esc>', opt)
map('v', '<A-j>', '<Esc>', opt)
map('t', '<A-j>', ':tnoremap <Esc> <C-\\><C-n>:q!<CR>', opt)
-- 查看帮助文档
map('n', '<A-h>', ':edit ~/.config/nvim/README.md<CR>', opt)
-- 保存文件
map('n', 'ww', ':w<CR>', opt)
map('n', '<S-t>', ':NvimTreeOpen<CR>', opt)
---------------
-- 分屏快捷键设置
---------------

-- 取消 s 默认功能
map('n', 's', '', opt)
-- 分屏快捷键
-- sv代表垂直分屏（Split Vertically）
map('n', 'sv', ':vsp<CR>', opt)
-- sh代表水平分屏（Split Horizontally），为了避免与调整窗口大小冲突。修改为sb
map('n', 'sb', ':sp<CR>', opt)
-- 关闭当前窗口（Close）
map('n', 'sc', '<C-w>c', opt)
-- 关闭其他窗口（Others）
map('n', 'so', '<C-w>o', opt)
-- Alt + hjkl  窗口之间跳转
map('n', '<S-w>', '<C-w>k', opt)
map('n', '<S-a>', '<C-w>h', opt)
map('n', '<S-s>', '<C-w>j', opt)
map('n', '<S-d>', '<C-w>l', opt)

---------------
-- 调整窗口比例快捷键
---------------

-- 可以通过Ctrl+上下左右键或者sk sj s, s.进行上下左右窗口比例调整
-- 左右比例控制
map('n', '<C-Left>', ':vertical resize +2<CR>', opt)
map('n', '<C-Right>', ':vertical resize -2<CR>', opt)
-- 向左调整
map('n', 'sh', ':vertical resize +20<CR>', opt)
-- 向右调整
map('n', 'sl', ':vertical resize -20<CR>', opt)
-- 上下比例
map('n', '<C-Down>', ':resize -2<CR>', opt)
map('n', '<C-Up>', ':resize +2<CR>', opt)
-- 向下调整
map('n', 'sj', ':resize -10<CR>', opt)
-- 向上调整
map('n', 'sk', ':resize +10<CR>', opt)
-- 等比例
map('n', 's=', '<C-w>=', opt)

---------------
-- Terminal模式
---------------

-- Terminal相关
-- 在下方打开Terminal
map('n', '<leader>vt', ':sp | terminal<CR>', opt)
-- 在侧方打开Terminal
map('n', '<leader>t', ':vsp | terminal<CR>', opt)
-- 在Terminal模式中Esc关闭Terminal模式
-- map("t", "<Esc>", "<C-\\><C-n>", opt)
-- map("t", "<A-h>", [[ <C-\><C-N><C-w>h ]], opt)
-- map("t", "<A-j>", [[ <C-\><C-N><C-w>j ]], opt)
-- map("t", "<A-k>", [[ <C-\><C-N><C-w>k ]], opt)
-- map("t", "<A-l>", [[ <C-\><C-N><C-w>l ]], opt)

---------------
-- Visual模式
---------------

-- 在Visual模式下，可以通过J K上下移动文本，连续> <缩进文本。
-- visual模式下缩进代码
map('v', '<', '<gv', opt)
map('v', '>', '>gv', opt)
-- 上下移动选中文本
map('v', '<S-j>', ":move '>+1<CR>gv-gv", opt)
map('v', '<S-k>', ":move '<-2<CR>gv-gv", opt)
---------------
-- 浏览移动
---------------

-- Ctrl+j/k：设置移动四行；Ctrl+u/d（即up和down）移动九行。
-- 上下滚动浏览
map('n', '<C-j>', '4j', opt)
map('n', '<C-k>', '4k', opt)
-- ctrl u / ctrl + d  只移动9行，默认移动半屏
map('n', '<C-u>', '9k', opt)
map('n', '<C-d>', '9j', opt)

------------------------------
-- 全文代码缩进（格式化）
------------------------------

map('n', '<C-i>', 'gg=G', opt)

------------------------------
---------- 插件配置 ----------
------------------------------

local pluginKeys = {}

---------------
-- nvim-tree --
---------------
--
-- 通过 Shift+t 键打开关闭tree
map('n', '<CS-t>', ':NvimTreeToggle<CR>', opt)
-- 列表快捷键
pluginKeys.nvimTreeList = {
  -- 打开文件或文件夹
  { key = { '<CR>', 'o', '<2-LeftMouse>' }, action = 'edit' },
  -- 分屏打开文件
  -- 垂直分屏
  { key = 'v', action = 'vsplit' },
  -- 水平分屏
  { key = 'h', action = 'split' },
  -- 显示隐藏文件
  { key = 'i', action = 'toggle_custom' }, --[[ 对应 filters 中的 custom (node_modules)]] --
  { key = '.', action = 'toggle_dotfiles' }, --[[ Hide (dotfiles) ]] --
  -- 文件操作
  { key = '<F5>', action = 'refresh' }, --[[ 刷新 ]] --
  { key = 'a', action = 'create' },
  { key = 'd', action = 'remove' },
  { key = 'r', action = 'rename' },
  { key = 'x', action = 'cut' },
  { key = 'c', action = 'copy' },
  { key = 'p', action = 'paste' },
  --[[ WSL中使用Windos系统默认设置打开文件]]
  --
  --[[{ key = "s", action = "system_open" },]]
  --
}

----------------
-- bufferline --
----------------
--
-- 左右Tab切换
map('n', '<C-h>', ':BufferLineCyclePrev<CR>', opt)
map('n', '<C-l>', ':BufferLineCycleNext<CR>', opt)
-- 关闭
-- 调用"moll/vim-bbye"中快捷键，即关闭当前Tab
map('n', '<C-c>', ':Bdelete!<CR>', opt)
-- 减少快捷键个数
-- 关闭左侧标签页
-- map("n", "<leader>l", ":BufferLineCloseRight<CR>", opt)
-- 关闭右侧标签页
-- map("n", "<leader>h", ":BufferLineCloseLeft<CR>", opt)
-- 选择需要关闭的标签页
-- map("n", "<leader>bc", ":BufferLinePickClose<CR>", opt)

---------------
-- Telescope --
---------------
--
-- 查找文件
map('n', '<C-p>', ':Telescope find_files<CR>', opt)
-- 全局搜索
map('n', '<C-f>', ':Telescope live_grep<CR>', opt)
-- 查找最近文件
map('n', '<C-o>', ':Telescope oldfiles<CR>', opt)
-- 在Telescope列表中搜索
-- 插入模式快捷键
-- 这样插入模式按Ctrl+w/s便可在列表中上下切换，无需切换为Normal模式。
pluginKeys.telescopeList = {
  i = {
    -- 上下移动
    ['<A-j>'] = 'move_selection_next',
    ['<A-k>'] = 'move_selection_previous',
    ['<Down>'] = 'move_selection_next',
    ['<Up>'] = 'move_selection_previous',
    -- 历史记录
    ['<C-n>'] = 'cycle_history_next',
    ['<C-p>'] = 'cycle_history_prev',
    -- 关闭窗口
    ['<C-c>'] = 'close',
    -- 预览窗口上下滚动
    ['<C-u>'] = 'preview_scrolling_up',
    ['<C-d>'] = 'preview_scrolling_down',
  },
}

----------------
-- treesitter --
----------------
--
-- 代码块折叠
map('n', 'zz', ':foldclose<CR>', opt)
-- 代码块打开
map('n', 'z', ':foldopen<CR>', opt)

---------
-- LSP --
---------
--
-- lsp 回调函数快捷键设置
pluginKeys.mapLSP = function(mapbuf)
  -- rename
  -- Lspage替换
  -- mapbuf("n", "rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opt)
  mapbuf('n', 'rn', '<cmd>Lspsaga rename<CR>', opt)
  -- code action
  --Lspsaga替换
  -- mapbuf("n", "ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opt)
  mapbuf('n', 'ca', '<cmd>Lspsaga code_action<CR>', opt)
  -- go xx
  -- gd：跳转到定义
  -- Lspsaga替换
  -- mapbuf("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opt)
  mapbuf('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opt)
  -- gh：显示提示
  -- Lspsaga替换
  -- mapbuf("n", "gh", "<cmd>lua vim.lsp.buf.hover()<CR>", opt)
  mapbuf('n', 'gh', '<cmd>Lspsaga hover_doc<cr>', opt)
  -- gs:显示声明
  mapbuf('n', 'gs', '<cmd>lua vim.lsp.buf.declaration()<CR>', opt)
  -- gi:执行
  mapbuf('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opt)
  -- gr：显示参考
  --[[
  Lspsaga 替换 gr
  mapbuf("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opt)
  --]]
  mapbuf('n', 'gr', '<cmd>Lspsaga lsp_finder<CR>', opt)
  --[[
  Lspsaga 替换 gp, gj, gk
  mapbuf("n", "gp", "<cmd>lua vim.diagnostic.open_float()<CR>", opt)
  mapbuf("n", "gj", "<cmd>lua vim.diagnostic.goto_next()<CR>", opt)
  mapbuf("n", "gk", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opt)
  --]]
  -- diagnostic
  mapbuf('n', 'gp', '<cmd>Lspsaga show_line_diagnostics<CR>', opt)
  mapbuf('n', 'gj', '<cmd>Lspsaga diagnostic_jump_next<cr>', opt)
  mapbuf('n', 'gk', '<cmd>Lspsaga diagnostic_jump_prev<cr>', opt)
  --格式化
  mapbuf('n', 'gg', '<cmd>lua vim.lsp.buf.format { auync = true } <CR>', opt)
  -- TypeScript快捷键
  -- 删除用不到的import语句
  mapbuf('n', 'gs', ':TSLspOrganize<CR>', opt)
  mapbuf('n', 'gr', ':TSLspRenameFile<CR>', opt)
  mapbuf('n', 'gi', ':TSLspImportAll<CR>', opt)
  -- 没用到
  -- mapbuf('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opt)
  -- mapbuf("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opt)
  -- mapbuf('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opt)
  -- mapbuf('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opt)
  -- mapbuf('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opt)
  -- mapbuf('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opt)
end

--------------
-- nvim-cmp --
--------------
--
-- nvim-cmp 自动补全
pluginKeys.cmp = function(cmp)
  local feedkey = function(key, mode)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
  end
  local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
  end

  return {
    -- 出现补全
    ['<A-.>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    -- 取消补全
    ['<A-j>'] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    -- 上一个
    ['<C-k>'] = cmp.mapping.select_prev_item(),
    -- 下一个
    ['<C-j>'] = cmp.mapping.select_next_item(),
    -- 确认
    ['<CR>'] = cmp.mapping.confirm({
      select = true,
      behavior = cmp.ConfirmBehavior.Replace,
    }),
    -- 如果窗口内容太多，可以滚动
    ['<C-u>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    -- snippets 跳转
    ['<C-l>'] = cmp.mapping(function(_)
      if vim.fn['vsnip#available'](1) == 1 then
        feedkey('<Plug>(vsnip-expand-or-jump)', '')
      end
    end, { 'i', 's' }),
    ['<C-h>'] = cmp.mapping(function()
      if vim.fn['vsnip#jumpable'](-1) == 1 then
        feedkey('<Plug>(vsnip-jump-prev)', '')
      end
    end, { 'i', 's' }),

    -- super Tab
    -- ["<Tab>"] = cmp.mapping(function(fallback)
    --   if cmp.visible() then
    --     cmp.select_next_item()
    --   elseif vim.fn["vsnip#available"](1) == 1 then
    --     feedkey("<Plug>(vsnip-expand-or-jump)", "")
    --   elseif has_words_before() then
    --     cmp.complete()
    --   else
    --     fallback() --[[ The fallback function sends a already mapped key. In this case, it's probably `<Tab>`. ]] --
    --   end
    -- end, { "i", "s" }),
    --
    -- ["<S-Tab>"] = cmp.mapping(function()
    --   if cmp.visible() then
    --     cmp.select_prev_item()
    --   elseif vim.fn["vsnip#jumpable"](-1) == 1 then
    --     feedkey("<Plug>(vsnip-jump-prev)", "")
    --   end
    -- end, { "i", "s" }),
    -- end of super Tab
  }
end

-- 注释插件
pluginKeys.comment = {
  -- Normal 模式快捷键
  toggler = {
    line = 'gii', -- 行注释
    block = 'gnn', -- 块注释
  },
  -- visual 模式
  opleader = {
    line = 'ii',
    block = 'mm',
  },
}

--[[
  注意事项：
    “return pluginKeys”写在所有代码的最后，在次代码后不许存在代码！！
]]
--
return pluginKeys
------------------------------
------------ 结束 ------------
------------------------------
