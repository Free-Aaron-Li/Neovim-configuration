if vim.g.neovide then

    vim.o.guifont = "JetBrainsMono Nerd Font:h13"
    vim.g.neovide_transparency = 1 -- 透明度
    vim.g.neovide_hide_mouse_when_typing = true -- 打字时隐藏鼠标
    vim.g.neovide_confirm_quit = true -- 退出需要确认 
    vim.g.neovide_fullscreen = true -- 是否全屏
    vim.g.neovide_remember_window_size = true -- 记住以前窗口的大小
    -- 使用super键位,比如<cmd>
    -- vim.g.neovide_input_use_logo = true
    -- 开启Alt和Meta按键
    -- vim.g.neovide_input_macos_alt_is_meta = true
    -- 触控板死亡地带
    -- vim.g.neovide_touch_deadzone = 6.0
    -- 触控板拖动超时
    -- vim.g.neovide_touch_drag_timeout = 0.17
    vim.g.neovide_cursor_vfx_mode = "railgun" -- 开启轨道动画
end
